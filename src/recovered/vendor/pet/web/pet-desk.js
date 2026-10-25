/**
 * P4：分层地面与碰撞墙（网页侧）。
 *
 * 数据从哪来：原生无障碍服务（EyesService 的 /ui）已经有每个可点节点的 `getBoundsInScreen`，
 * 由 world 每秒推过来 → 页面 `window.onDeskTargets({ pkg, items:[{label,l,t,r,b}] })`（物理 px）。
 * 作者要是改成原生直接推，接口同名，页面不用动。
 *
 * 一条原则：**地面和墙都是数据，不是 DOM。** 页面里没有任何多余元素去接手指，
 * 所以「墙薄且不挡点击」是结构保证的，不靠调 z-index。
 *
 * 坐标：无障碍给的是物理 px，这里除以 devicePixelRatio 换成 CSS px，和 stage/pet 同一套。
 */

/** 只认图标尺度的框（太小的点是字，太大的框是整个容器/文件夹）。 */
const MIN_W = 26, MAX_W = 260, MIN_H = 14, MAX_H = 300;
/** 目标顶至少比默认地面高这么多，才值得跳。 */
const MIN_LIFT = 36;
/** 站上去之后左右各留的边（这就是“墙”）。 */
const EDGE = 14;
/** 起跳前先走到图标正下方的容差。 */
const AIM = 22;
/** 跳失败/掉下来之后的冷却（ms），免得一直原地蹦。 */
const RETRY_MS = 5000;

const isLauncher = (pkg) => {
  const p = String(pkg || '').toLowerCase();
  if (!p) return false;
  return p === 'com.miui.home' || /launcher/.test(p) || /\.home$/.test(p) || /workspace/.test(p);
};

export class DeskFloor {
  /**
   * @param {import('./pet-multi.js').PetWorld} world
   * @param {{ enabled?: () => boolean }} [opts]
   */
  constructor(world, opts = {}) {
    this.world = world;
    this.enabled = opts.enabled || (() => true);
    /** @type {Array<{l:number,t:number,r:number,b:number,label:string}>} 图标框（CSS px） */
    this.targets = [];
    this.pkg = '';
    this.launcher = false;
    this.updatedAt = 0;
    /** 每只的状态：站着的图标 / 正在跳的图标 / 上次失败时间 */
    this.state = new Map();
    this._lastDebug = '';
  }

  _st(u) {
    let s = this.state.get(u);
    if (!s) {
      s = { on: null, jump: null, jumpAt: 0, cooledAt: 0, aim: null };
      this.state.set(u, s);
    }
    return s;
  }

  /** 原生推过来的桌面目标。也接受 JSON 字符串（原生 evaluateJavascript 那条路）。 */
  apply(msg) {
    let m = msg;
    if (typeof m === 'string') {
      try { m = JSON.parse(m); } catch (e) { return; }
    }
    if (!m || !Array.isArray(m.items)) return;
    const dpr = window.devicePixelRatio || 1;
    const H = this.world.bounds().H;
    const list = [];
    for (const it of m.items) {
      const l = Number(it.l) / dpr, t = Number(it.t) / dpr, r = Number(it.r) / dpr, b = Number(it.b) / dpr;
      if (![l, t, r, b].every(Number.isFinite)) continue;
      const w = r - l, h = b - t;
      if (w < MIN_W || w > MAX_W || h < MIN_H || h > MAX_H) continue;
      if (t < 24 || b > H - 2) continue;
      list.push({ l, t, r, b, label: String(it.label || '').slice(0, 20) });
    }
    this.targets = list;
    this.pkg = String(m.pkg || '');
    this.launcher = isLauncher(m.pkg);
    this.updatedAt = performance.now();
  }

  /** 每帧：选目标 → 走过去 → 跳 → 接住 → 贴边；目标没了就掉下来。 */
  tick(dt) {
    const world = this.world;
    if (!world || !world.pets.length) return;
    const defaultFloor = world.bounds().floorY;
    const active = this.enabled() && this.launcher && this.targets.length > 0;

    for (const u of world.pets) {
      const st = this._st(u);
      const pet = u.pet, ct = u.ct;

      // 被拎起来/被抛飞：身上那份地面先作废，落地时按默认地面算
      if (pet.mode === 'drag') {
        if (st.on || st.jump) { st.on = null; st.jump = null; u.clearFloor(); }
        continue;
      }

      // 1) 已经站在某个图标上：目标还在就贴住，没了就掉下去
      if (st.on) {
        const box = this.match(st.on);
        if (!box) { st.on = null; u.drop(); st.cooledAt = performance.now(); continue; }
        st.on = box;
        u.standOn(box);
        continue;
      }

      // 2) 正在往上跳：上升时别动，落回来穿过图标顶就接住
      if (st.jump) {
        const box = this.match(st.jump);
        if (!box) { st.jump = null; continue; }
        st.jump = box;
        const descending = pet.vy > 0;
        const atTop = pet.fy >= box.t - 2 && pet.fy <= box.t + 40;
        const overX = pet.x >= box.l - 12 && pet.x <= box.r + 12;
        if (descending && atTop && overX) {
          // 把地面抬到这个图标：pet-core 下一步就会落在它上沿
          u.standOn(box);
          st.on = box; st.jump = null;
          try { ct.setExpr('happy', 1.1); } catch (e) {}
          continue;
        }
        if (pet.mode !== 'air' && performance.now() - st.jumpAt > 300) { st.jump = null; st.cooledAt = performance.now(); }
        continue;
      }

      // 3) 空闲、脚下正上方有图标 → 走过去、然后跳
      if (!active) continue;
      if (u.floorY != null) { u.clearFloor(); }
      const m = pet.mode;
      if (m !== 'idle' && m !== 'look' && m !== 'sit') { st.aim = null; continue; }
      if (performance.now() < st.cooledAt) continue;

      if (st.aim) {
        const box = this.match(st.aim);
        if (!box) { st.aim = null; continue; }
        st.aim = box;
        const cx = (box.l + box.r) / 2;
        if (Math.abs(cx - pet.x) <= AIM) {
          // 站到正下方了：抬头看一眼再跳（跳高按重力算，刚好够）
          const lift = defaultFloor - box.t;
          if (lift >= MIN_LIFT && ct.jumpTo(lift)) {
            st.jump = box; st.jumpAt = performance.now(); st.aim = null;
            try { ct.setExpr('surprised', .6); } catch (e) {}
            u.say('上去看看～', 1600);
          } else {
            st.aim = null; st.cooledAt = performance.now() + RETRY_MS;
          }
        } else if (m === 'idle') {
          // 走过去（目标太远就慢慢走，别冲刺）
          ct.walkTo(cx);
        }
        continue;
      }

      // 4) 挑一个「离我最近、够高、在屏幕上半部分」的图标去试
      const cand = this.pick(u, defaultFloor);
      if (!cand) continue;
      st.aim = cand;
      st.cooledAt = performance.now() + 900;
      const cx = (cand.l + cand.r) / 2;
      if (Math.abs(cx - pet.x) > AIM) ct.walkTo(cx);
    }
  }

  /** 最近的、值得跳的图标。 */
  pick(u, defaultFloor) {
    const cx = u.pet.x;
    let best = null, bestD = 1e9;
    for (const t of this.targets) {
      const lift = defaultFloor - t.t;
      if (lift < MIN_LIFT) continue;                 // 比默认地面低/齐平的没意义
      if (t.r - t.l < MIN_W) continue;
      const c = (t.l + t.r) / 2;
      const d = Math.abs(c - cx) + lift * .15;       // 近的优先，太高的略减分
      if (d < bestD) { bestD = d; best = t; }
    }
    return best;
  }

  /** 同一个图标（刷新之间框可能差几个像素）。 */
  match(box) {
    if (!box) return null;
    const c = (box.l + box.r) / 2, cy = (box.t + box.b) / 2;
    let best = null, bestD = 1e9;
    for (const t of this.targets) {
      const d = Math.hypot((t.l + t.r) / 2 - c, (t.t + t.b) / 2 - cy);
      if (d < bestD) { bestD = d; best = t; }
    }
    return best && bestD <= Math.max(40, (box.r - box.l) * .5) ? best : null;
  }

  /** 现场诊断：`window.__desk()` 用它。 */
  debug() {
    return {
      pkg: this.pkg,
      launcher: this.launcher,
      targets: this.targets.length,
      ageMs: this.updatedAt ? Math.round(performance.now() - this.updatedAt) : null,
      pets: this.world.pets.map((u) => {
        const st = this._st(u);
        return {
          id: u.id,
          x: Math.round(u.pet.x),
          fy: Math.round(u.pet.fy),
          mode: u.pet.mode,
          on: st.on ? [Math.round(st.on.l), Math.round(st.on.t), Math.round(st.on.r), Math.round(st.on.b)] : null,
          jump: st.jump ? [Math.round(st.jump.l), Math.round(st.jump.t), Math.round(st.jump.r), Math.round(st.jump.b)] : null,
          ground: Math.round(u.ct.ground),
        };
      }),
    };
  }
}

export { isLauncher };
