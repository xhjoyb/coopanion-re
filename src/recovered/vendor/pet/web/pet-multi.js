/**
 * 多只桌宠的运行时（重写蓝图 P1：单页面 + N 只 + 并集上报）。
 *
 * 一只宠物 = 一个 PetUnit：自己的 <g>、影子、粒子层、气泡、皮肤、表情/心情、地面高度、位置。
 * 一个 PetWorld 管三件事，全页面只有一份：
 *   1) 指针路由 —— 点谁谁应；按下的那只独占这次拖拽，别的只不会被拖走（旧「两块触摸区互抢」的根因）；
 *   2) 渲染循环 —— 每帧 step + render 所有实例，再统一排版各自的气泡；
 *   3) 并集上报 —— 把所有可见的宠物/气泡/菜单合成一个矩形交给原生触摸层（window.__petUnionRect）。
 *
 * 原生层只需要一个窗口 + 一块自适应触摸区，不需要知道有几只。
 *
 * 坐标约定：stage 是全屏 fixed 容器，所以 `clientX/Y`、`getBoundingClientRect()`、`toStage()` 是同一套
 * CSS 像素；上报给原生时由原生乘 density（/app 的触摸窗就是这么算的）。
 */

import { createPet, HEAD_TOP, clamp, f } from './pet-core.js';

const NS = 'http://www.w3.org/2000/svg';
export const MAX_PETS = 2;   // 用户只要两只：一个页面就养两只，别再加
/** 并集矩形外扩（CSS px）：给手指和视觉留一点余量。 */
export const RECT_PAD = 10;
/** 上报间隔（ms）：触摸窗 100~120ms 跟一次就够了。 */
const REPORT_EVERY = 100;
/** 点中判定外扩（CSS px）：比身体画出来的范围再宽一点，手指才有余地。 */
const HIT_PAD = 10;

const rect = (el) => {
  if (!el) return null;
  try {
    const r = el.getBoundingClientRect();
    return r.width > 0 && r.height > 0 ? { l: r.left, t: r.top, r: r.right, b: r.bottom } : null;
  } catch (e) { return null; }
};

let uid = 0;

/** 一只桌宠：DOM + 模拟 + 自己的气泡。 */
export class PetUnit {
  /**
   * @param {PetWorld} world
   * @param {number} index 0 起；第 0 只沿用页面上原有的 #pet/#shadow/#fx
   */
  constructor(world, index) {
    this.world = world;
    this.index = index;
    this.key = ++uid;
    this.id = index + 1;                                  // 1..4，DOM id: pet / pet2 / pet3 / pet4
    this.skin = null;
    this.mood = 'neutral';
    /** 分层地面（P4）：null 表示用默认地面。 */
    this.floorY = null;
    this.deskTarget = null;
    this._bubbleTimer = 0;
    this._vw = 0; this._vh = 0; this._vs = 0;
    this._box = null;

    const els = this._buildEls();
    this.els = els;
    this.ct = createPet(
      { petG: els.petG, shadowEl: els.shadowEl, fxG: els.fxG },
      {
        sfx: world.sfx,
        roam: world.roam,
        bounds: () => world.bounds(),
        onEvent: (kind, d) => world.emitEvent(this, kind, d),
        dialogOpen: () => world.dialogOpen(),
        hitTest: (p) => this.hits(p),
        floorY: () => this.floorY,
        enter: 'drop',
      },
    );
  }

  get pet() { return this.ct.pet; }
  get skinNow() { return this.ct.skin; }

  _buildEls() {
    const svg = this.world.svg;
    const adopt = this.index === 0
      ? { petG: document.getElementById('pet'), shadowEl: document.getElementById('shadow'), fxG: document.getElementById('fx') }
      : {};
    let petG = adopt.petG, shadowEl = adopt.shadowEl, fxG = adopt.fxG;
    const suffix = this.id > 1 ? String(this.id) : '';
    if (!petG) {
      petG = document.createElementNS(NS, 'g');
      petG.id = 'pet' + suffix;
      svg.appendChild(petG);
    }
    if (!shadowEl) {
      shadowEl = document.createElementNS(NS, 'ellipse');
      shadowEl.id = 'shadow' + suffix;
      shadowEl.setAttribute('class', 'shadow');
      shadowEl.setAttribute('fill', 'rgba(0,0,0,.26)');
      petG.parentNode ? petG.parentNode.insertBefore(shadowEl, petG) : svg.appendChild(shadowEl);
    }
    if (!fxG) {
      fxG = document.createElementNS(NS, 'g');
      fxG.id = 'fx' + suffix;
      petG.parentNode ? petG.parentNode.insertBefore(fxG, petG.nextSibling) : svg.appendChild(fxG);
    }
    // 气泡：第 1 只的说话气泡由页面（正式对话）管，这里只给额外几只各配一个轻气泡
    let bubbleEl = null;
    if (this.index > 0) {
      bubbleEl = document.createElement('div');
      bubbleEl.className = 'bubble quick';
      bubbleEl.id = 'bubble' + this.id;
      bubbleEl.hidden = true;
      bubbleEl.innerHTML = '<p class="b-text"></p>';
      this.world.host.appendChild(bubbleEl);
    }
    return { petG, shadowEl, fxG, bubbleEl };
  }

  /** 屏幕上的实际范围（视口 CSS px），按画面几何算，不受 halo 滤镜膨胀影响。 */
  visualBox() {
    const ct = this.ct;
    if (!ct) return null;
    const head = this.ct.skin?.head ?? 'none';
    const top = Math.min(20, HEAD_TOP[head] ?? 12);
    const pts = [[16, top], [240, top], [16, 258], [240, 258]].map(([x, y]) => ct.toStage(x, y));
    const xs = pts.map((p) => p.x), ys = pts.map((p) => p.y);
    return { l: Math.min(...xs), t: Math.min(...ys), r: Math.max(...xs), b: Math.max(...ys) };
  }

  /** 碰撞盒（P3 用）：脚下一条很薄的横向条，和墙同一套数据。 */
  box() {
    const v = this.visualBox();
    if (!v) return null;
    const w = (v.r - v.l) * .36, cx = (v.l + v.r) / 2;
    return { l: cx - w / 2, r: cx + w / 2, t: v.b - 14, b: v.b };
  }

  /** 点中判定：矩形 + 余量。头、脚、尾巴都能戳到（旧版只给身体中心一个圆，头脚全点不到）。 */
  hits(p) {
    const b = this.visualBox();
    if (!b) return false;
    return p.x >= b.l - HIT_PAD && p.x <= b.r + HIT_PAD && p.y >= b.t - HIT_PAD && p.y <= b.b + HIT_PAD;
  }

  step(dt) {
    const ct = this.ct, b = this.world.bounds();
    // 舞台尺寸或**地面高度**变了就要 resize：键盘顶起地面时脚底得跟着抬起来
    const ground = typeof this.floorY === 'number' ? this.floorY : b.floorY;
    if (this._vw !== b.W || this._vh !== b.H || this._vs !== b.S || this._vf !== ground) {
      this._vw = b.W; this._vh = b.H; this._vs = b.S; this._vf = ground;
      ct.resize();
    }
    // 分层地面由 pet-core 的 opts.floorY() 每帧读取（站着时脚底就在这一层，空中交给物理）
    ct.step(dt);
  }

  render() {
    this.ct.render();
    this._box = this.visualBox();
    this.layoutBubble();
  }

  /** 气泡跟着自己的头走（每只一份，不共用第 1 只的 --tail）。 */
  layoutBubble() {
    const el = this.els.bubbleEl;
    if (!el || el.hidden) return;
    const a = this.ct.anchor();
    const w = el.offsetWidth, h = el.offsetHeight;
    const W = this.world.bounds().W;
    const left = clamp(a.x - w / 2, 6, Math.max(6, W - w - 6));
    el.style.left = f(left) + 'px';
    el.style.top = f(Math.max(6, a.y - h - 10)) + 'px';
    el.style.setProperty('--tail', f(clamp(a.x - left, 20, Math.max(20, w - 20))) + 'px');
  }

  /** 说话。第 1 只交给页面（正式对话/旁白），额外的几只用自己的轻气泡。 */
  say(text, ms = 5200) {
    const t = String(text == null ? '' : text).trim();
    if (!t) return;
    if (this.world.onSay && this.world.onSay(this, t, ms)) return;
    this.showBubble(t, ms);
  }

  showBubble(text, ms = 5200) {
    const el = this.els.bubbleEl;
    if (!el) return;
    const body = el.querySelector('.b-text') || el;
    body.textContent = text;
    el.hidden = false;
    void el.offsetWidth;
    el.classList.add('pop');
    this.layoutBubble();
    clearTimeout(this._bubbleTimer);
    this._bubbleTimer = setTimeout(() => { el.hidden = true; el.classList.remove('pop'); }, ms);
  }

  hideBubble() {
    clearTimeout(this._bubbleTimer);
    const el = this.els.bubbleEl;
    if (el) { el.hidden = true; el.classList.remove('pop'); }
  }

  setSkin(skin) { try { this.ct.setSkin(skin); } catch (e) {} }
  setRoam(r) { this.world.roam = r; try { this.ct.setRoam(r); } catch (e) {} }
  setFigure(fig) { try { this.ct.setFigure(fig); } catch (e) {} }
  setMood(m) {
    this.mood = m;
    const expr = { neutral: 'neutral', happy: 'happy', angry: 'angry', sad: 'sad', surprised: 'surprised', dizzy: 'dizzy', shy: 'shy', love: 'love' }[m];
    if (expr) { try { this.ct.setExpr(expr); } catch (e) {} }
  }
  setFloor(y) { this.floorY = y; }
  clearFloor() { this.floorY = null; this.deskTarget = null; }

  /** 站到某个桌面目标上（P4：无障碍给的图标矩形，CSS px）。 */
  standOn(target) {
    if (!target) { this.clearFloor(); return; }
    this.deskTarget = { l: target.l, t: target.t, r: target.r, b: target.b };
    this.floorY = target.t;
    this.holdOn();
  }

  /** 贴边：站在图标上时横向不许走出去（墙只有一条线，挡住身体、不挡手指）。 */
  holdOn() {
    const tg = this.deskTarget;
    if (!tg) return;
    const pad = Math.min(16, Math.max(6, (tg.r - tg.l) * .18));
    const lo = tg.l + pad, hi = tg.r - pad;
    if (hi <= lo) return;
    if (this.pet.x < lo) { this.pet.x = lo; this.pet.target = lo; }
    if (this.pet.x > hi) { this.pet.x = hi; this.pet.target = hi; }
  }

  /** 脚下的地面没了：掉回默认地面。 */
  drop() { this.clearFloor(); try { this.ct.fall(); } catch (e) {} }

  dispose() {
    this.hideBubble();
    const { petG, shadowEl, fxG, bubbleEl } = this.els;
    try { petG?.remove(); } catch (e) {}
    try { shadowEl?.remove(); } catch (e) {}
    try { fxG?.remove(); } catch (e) {}
    try { bubbleEl?.remove(); } catch (e) {}
  }
}

/** 一个页面里的全部桌宠：唯一的指针入口、唯一的循环、唯一的并集上报。 */
export class PetWorld {
  /**
   * @param {object} o
   * @param {SVGElement} o.svg  页面里的 #stageSvg
   * @param {HTMLElement} o.host 放气泡的容器（一般 document.body）
   * @param {() => ({W:number,H:number,floorY:number,S:number})} o.bounds
   * @param {object} o.sfx pet-core 的音效
   * @param {(unit:PetUnit, kind:string, d:any) => void} [o.onEvent]
   * @param {(unit:PetUnit, text:string, ms:number) => boolean} [o.onSay] 返回 true 表示“这话我接了”
   * @param {() => HTMLElement[]} [o.uiBoxes] 额外要并进触摸区的 UI（菜单、按钮条…）
   * @param {() => boolean} [o.dialogOpen]
   */
  constructor(o) {
    this.svg = o.svg;
    this.host = o.host || document.body;
    this.bounds = o.bounds;
    this.sfx = o.sfx;
    this.roam = o.roam || 'calm';
    this.dialogOpen = o.dialogOpen || (() => false);
    this.onEvent = o.onEvent || (() => {});
    this.onSay = o.onSay || null;
    this.uiBoxes = o.uiBoxes || (() => []);
    /** @type {PetUnit[]} */
    this.pets = [];
    /** 当前“对象”：最近被点/被说话的那只，菜单和旁白都找它。 */
    this.active = null;
    /** 正被按住的那只：这次拖拽只属于它。 */
    this.down = null;
    this.lastUnion = null;
    this._reported = 0;
    this._pushed = null;
    /** 额外的几只别跑得离第 1 只太远（触摸区是一整块并集，隔太开会挡住桌面）。 */
    this.band = o.band ?? 240;
    this._bandAt = 0;
  }

  get primary() { return this.pets[0]; }
  get count() { return this.pets.length; }
  get pressing() { return !!this.down && this.down.ct.pressing; }

  /** 保证有 n 只（1~MAX_PETS）。少的补上、多的从尾部送走。 */
  ensure(n) {
    const want = clamp(Math.round(Number(n) || 1), 1, MAX_PETS);
    while (this.pets.length < want) {
      let unit;
      try { unit = new PetUnit(this, this.pets.length); } catch (err) {
        console.error('[pet-world] 创建第 ' + (this.pets.length + 1) + ' 只失败', err);
        break;
      }
      // 错开站位：右、左、右、左
      const W = this.bounds().W || 1;
      const frac = [.72, .3, .52, .86][unit.index % 4];
      unit.ct.resize();
      unit.pet.x = Math.round(W * frac);
      unit.pet.target = unit.pet.x;
      unit.ct.render();
      this.pets.push(unit);
    }
    while (this.pets.length > want) this.pets.pop().dispose();
    this.active ??= this.primary;
    if (!this.pets.includes(this.active)) this.active = this.primary;
    return this.pets.length;
  }

  /** 每帧：先所有实例 step，再 render（同一帧里算出的矩形才是最新的）。 */
  tick(dt) {
    for (const p of this.pets) { try { p.step(dt); } catch (e) {} }
    this.collide();
    for (const p of this.pets) { try { p.render(); } catch (e) {} }
    this.keepTogether();
    this.publish();
  }

  /**
   * 碰撞体积：脚下一小块 AABB，两只重叠时沿水平各退一半。
   * 只**在接触的第一帧解一次**，之后 700ms 冷却（每帧都推会互相打架，看起来就是抖/卡）。
   */
  collide() {
    const n = this.pets.length;
    if (n < 2 || this.solid === false) return;
    const now = performance.now();
    this._touchAt = this._touchAt || new Map();
    const bnd = this.bounds();
    const clampX = (x) => Math.min(bnd.W - 40, Math.max(40, x));
    for (let i = 0; i < n; i++) {
      for (let j = i + 1; j < n; j++) {
        const a = this.pets[i], b = this.pets[j];
        if (a.pet.mode === 'drag' || b.pet.mode === 'drag') continue;
        const ba = a.box(), bb = b.box();
        if (!ba || !bb) continue;
        const ox = Math.min(ba.r, bb.r) - Math.max(ba.l, bb.l);
        const oy = Math.min(ba.b, bb.b) - Math.max(ba.t, bb.t);
        const key = a.id + ':' + b.id;
        if (ox <= 0 || oy <= 0) { this._touchAt.delete(key); continue; }   // 分开了：清冷却
        if ((this._touchAt.get(key) || 0) > now) continue;                 // 冷却中：不再推
        this._touchAt.set(key, now + 700);
        const dir = (ba.l + ba.r) / 2 <= (bb.l + bb.r) / 2 ? -1 : 1;
        const push = ox / 2 + 1;
        a.pet.x = clampX(a.pet.x + dir * push);
        b.pet.x = clampX(b.pet.x - dir * push);
        a.pet.target = a.pet.x; b.pet.target = b.pet.x;
        try { a.ct.setExpr('surprised', .4); b.ct.setExpr('surprised', .4); } catch (e) {}
      }
    }
  }

  /** 额外的几只离得太远时，慢慢挪回第 1 只附近（并集越小，越不挡桌面）。 */
  keepTogether() {
    if (this.pets.length < 2 || !this.band) return;
    const now = performance.now();
    if (now - this._bandAt < 2000) return;
    this._bandAt = now;
    const lead = this.primary;
    for (const u of this.pets) {
      if (u === lead) continue;
      const m = u.pet.mode;
      if (m !== 'idle' && m !== 'sit' && m !== 'sleep' && m !== 'look') continue;
      const far = u.pet.x - lead.pet.x;
      if (Math.abs(far) <= this.band) continue;
      const tx = lead.pet.x + Math.sign(far) * this.band * (0.55 + Math.random() * 0.35);
      try { u.ct.walkTo(tx); } catch (e) {}
    }
  }

  emitEvent(unit, kind, d) { try { this.onEvent(unit, kind, d); } catch (e) {} }

  /** 行为模式（不乱动/多待着/常走动）对每一只都生效。 */
  setRoam(r) { for (const p of this.pets) p.setRoam(r); }

  // ---- 指针：点谁谁应，按下的那只独占 ----

  /** 命中检测：从最上面（最后画的）往下找。 */
  hit(p) {
    for (let i = this.pets.length - 1; i >= 0; i--) {
      const u = this.pets[i];
      if (u.hits(p)) return u;
    }
    return null;
  }

  /** @returns {PetUnit|null} 点到了哪只（点空返回 null）。 */
  pointerDown(p) {
    const u = this.hit(p);
    if (!u) { this.down = null; return null; }
    this.active = u;
    if (!u.ct.pointerDown(p)) { this.down = null; return u; }
    this.down = u;
    return u;
  }

  pointerMove(p) {
    if (this.down) return this.down.ct.pointerMove(p);
    const u = this.hit(p);
    return u ? u.ct.pointerMove(p) : '';
  }

  pointerUp() {
    const u = this.down;
    this.down = null;
    if (u) u.ct.pointerUp();
  }

  pointerCancel() { this.pointerUp(); }

  pointerLeave() {
    if (this.down) return;
    for (const p of this.pets) { try { p.ct.pointerLeave(); } catch (e) {} }
  }

  // ---- 并集上报 ----

  /** 所有可见元素（宠物 + 气泡 + UI）的并集矩形，视口 CSS px。 */
  unionRect() {
    let l = 1e9, t = 1e9, r = -1e9, b = -1e9, any = false;
    const add = (x) => {
      if (!x) return;
      any = true;
      if (x.l < l) l = x.l;
      if (x.t < t) t = x.t;
      if (x.r > r) r = x.r;
      if (x.b > b) b = x.b;
    };
    for (const p of this.pets) {
      if (p.ct.pet.mode === 'air' && p.ct.pet.fy < 0) continue;   // 掉进来之前还没进场
      add(p.visualBox());
      if (p.els.bubbleEl && !p.els.bubbleEl.hidden) add(rect(p.els.bubbleEl));
    }
    for (const el of this.uiBoxes()) {
      // 固定定位的元素 offsetParent 恒为 null，不能拿它判可见性；空矩形已经覆盖 display:none
      if (el && !el.hidden) add(rect(el));
    }
    if (!any) return null;
    return { l: Math.round(l - RECT_PAD), t: Math.round(t - RECT_PAD), r: Math.round(r + RECT_PAD), b: Math.round(b + RECT_PAD) };
  }

  /** 给原生定时读取的字符串："l,t,r,b"（CSS px）。每次现算，保证跟当前画面一致。 */
  /**
   * 报给原生的并集矩形（字符串）。
   *
   * 关键：**飞行/拖拽中要稳定**。原生每 80~200ms 拿这个矩形去 updateViewLayout，
   * 抛出去/落下来时宠物飞得快，如果逐像素跟着变，原生窗口就会一路挪 —— 看起来就是"一点点卡"。
   * 做法：运动中把框**放大 44px**并只允许扩张不允许收缩；静止后才有 6px 的抖动余量。
   */
  unionString() {
    const b = this.unionRect();
    if (!b) { this._stableBox = null; this.lastUnion = null; return ''; }
    let moving = false;
    for (const p of this.pets) {
      const m = p.ct?.pet?.mode;
      if (m === 'air' || m === 'drag') { moving = true; break; }
    }
    const pad = moving ? 44 : 0;
    const want = { l: b.l - pad, t: b.t - pad, r: b.r + pad, b: b.b + pad };
    const s = this._stableBox;
    if (!s) this._stableBox = want;
    else if (moving) {
      // 飞行中：旧框能盖住就不动；盖不住才扩
      if (!(want.l >= s.l && want.t >= s.t && want.r <= s.r && want.b <= s.b)) {
        this._stableBox = {
          l: Math.min(s.l, want.l), t: Math.min(s.t, want.t),
          r: Math.max(s.r, want.r), b: Math.max(s.b, want.b),
        };
      }
    } else if (Math.abs(want.l - s.l) >= 6 || Math.abs(want.t - s.t) >= 6
      || Math.abs(want.r - s.r) >= 6 || Math.abs(want.b - s.b) >= 6) {
      this._stableBox = want;
    }
    const box = this._stableBox;
    this.lastUnion = box;
    return `${Math.round(box.l)},${Math.round(box.t)},${Math.round(box.r)},${Math.round(box.b)}`;
  }

  /** 页面 → 原生主动上报（有 JavascriptInterface 的壳子会用到；本 App 是原生定时来问）。 */
  publish(force = false) {
    const now = performance.now();
    if (!force && now - this._reported < REPORT_EVERY) return;
    this._reported = now;
    const box = this.unionRect();
    this.lastUnion = box;
    if (!box) return;
    const d = window.devicePixelRatio || 1;
    const args = [box.l * d, box.t * d, box.r * d, box.b * d];
    const sig = args.join(',');
    if (sig === this._pushed) return;
    this._pushed = sig;
    for (const name of ['petRectNative', 'pet2Native', 'cooClone']) {
      const n = window[name];
      if (n && typeof n.petRect === 'function') { try { n.petRect(...args); } catch (e) {} }
    }
  }
}
