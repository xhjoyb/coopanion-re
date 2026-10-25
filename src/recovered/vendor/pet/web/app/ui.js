/**
 * 界面层（重写版）：每只一份气泡、一个菜单、一排悬停按钮。
 *
 * 这里不碰物理、不碰协议：只决定「哪个气泡、哪块菜单、点了以后调谁」。
 * 菜单和按钮都锚在 `world.active`（最近被点/被说话的那只）头上。
 */

import { ICONS, mini, applyTheme } from '../pet-core.js';
import { Bubble } from './bubble.js';

const ROAM_ORDER = ['off', 'calm', 'free'];
const ROAM_LABEL = { off: '不乱动', calm: '多待着', free: '常走动' };
const ROAM_LEVEL = { off: '低', calm: '中', free: '高' };
const CHATTER_STEPS = [1, 2, 3, 5, 0];

export class Ui {
  /**
   * @param {{
   *   world: import('../pet-multi.js').PetWorld,
   *   prefs: any,
   *   net: import('./net.js').PetNet,
   *   talk: import('./talk.js').Talk,
   *   care: { feed: () => void } | null,
   *   sfx: any,
   *   host: any,
   *   setChatter: (min: number) => void,
   *   getChatter: () => number,
   *   onDeskToggled?: () => void,
   * }} deps
   */
  constructor(deps) {
    Object.assign(this, deps);
    this.host = deps.host || null;
    /** @type {Map<any, Bubble>} */
    this.bubbles = new Map();
    this.heard = new Bubble(null, { host: document.body, kind: 'heard' });
    this.heard.el.classList.add('heard');
    /** @type {Map<any, HTMLElement>} 每只宠物自己的菜单（第 1 只沿用页面里的 #menu） */
    this.menus = new Map();
    this.toolsEl = document.getElementById('tools');
    this.toolsUntil = 0;
    this.menuUnit = null;
    this.toolIds = '';
    this.hover = ['chat', 'voice'];
    this.bind();
    this.renderTools();
  }

  // ---------- 气泡 ----------

  /** 这只宠物的气泡（第 1 只也用它，不再特例）。 */
  bubbleFor(unit) {
    const key = unit || this.world.primary;
    let b = this.bubbles.get(key);
    if (!b) {
      b = new Bubble(key, { host: document.body });
      this.bubbles.set(key, b);
    }
    return b;
  }

  /** 别人说的话/提示，贴在当前那只旁边。 */
  heardSay(text, ms = 4200) {
    const unit = this.world.active || this.world.primary;
    this.heard.unit = unit;
    this.heard.flash(text, ms);
    return true;
  }

  get bubbleVisible() {
    for (const b of this.bubbles.values()) if (b.visible) return true;
    return this.heard.visible;
  }

  /** 有没有气泡开着（触摸区/交互判断用）。 */
  anyBubble() {
    const list = [];
    for (const b of this.bubbles.values()) if (b.visible) list.push(b.el);
    if (this.heard.visible) list.push(this.heard.el);
    // 每只自己的菜单也要进触摸区（不然点不到）
    for (const el of this.menus.values()) if (el && !el.hidden) list.push(el);
    return list;
  }

  // ---------- 菜单 ----------

  /** 动作表：菜单和悬停按钮共用一份。 */
  actions() {
    const prefs = this.prefs, net = this.net, world = this.world;
    const sendPrefs = (p) => net.send({ t: 'prefs', ...p });
    const count = () => world.count;
    return {
      chat: {
        icon: () => ICONS.chat,
        state: () => `打字跟第 ${(this.world.active || this.world.primary).id} 只说话(也可以双击它)`,
        run: () => this.talk.input(this.world.active || this.world.primary),
      },
      /** 加减合一：1 只时是「+」，有 2 只时变「−」。 */
      petToggle: {
        icon: () => (count() >= 2 ? ICONS.minus : ICONS.plus),
        state: () => (count() >= 2 ? `现在 ${count()} 只 · 点一下送走第 2 只` : '现在 1 只 · 点一下再来一只'),
        run: () => this.setCount(count() >= 2 ? 1 : 2),
      },
      chatter: {
        icon: () => ICONS.clock,
        state: () => `主动搭话:${this.getChatter() > 0 ? this.getChatter() + ' 分钟一次' : '关闭'} · 点一下换一档`,
        run: () => {
          const cur = Number(this.getChatter() || 0);
          let i = CHATTER_STEPS.findIndex((v) => v === cur);
          i = (i + 1) % CHATTER_STEPS.length;
          this.setChatter(CHATTER_STEPS[i]);
          this.bubbleFor(world.primary).say(CHATTER_STEPS[i] === 0 ? '好，我不主动吵你了～' : `那我每 ${CHATTER_STEPS[i]} 分钟找你一次～`, 4200);
        },
      },
      feed: {
        icon: () => ICONS.feed,
        state: () => `喂第 ${(this.world.active || this.world.primary).id} 只吃点东西`,
        run: () => this.care?.feed(this.world.active || this.world.primary),
      },
      roam: {
        keep: true,
        icon: () => ICONS[`roam_${prefs.roam}`] ?? ICONS.roam_calm,
        state: () => {
          const next = ROAM_ORDER[(ROAM_ORDER.indexOf(prefs.roam) + 1) % ROAM_ORDER.length];
          return `行为模式:${ROAM_LEVEL[prefs.roam] ?? ''} · ${ROAM_LABEL[prefs.roam] ?? ''} · 点一下换成「${ROAM_LABEL[next]}」`;
        },
        run: () => {
          const roam = ROAM_ORDER[(ROAM_ORDER.indexOf(prefs.roam) + 1) % ROAM_ORDER.length];
          prefs.roam = roam;
          world.setRoam(roam);
          sendPrefs({ roam });
        },
      },
      desk: {
        keep: true,
        icon: () => ICONS.steps,
        on: () => prefs.desk !== false,
        state: () => (prefs.desk === false ? '站上桌面图标:关 · 点一下打开' : '站上桌面图标:开 · 点一下关'),
        run: () => {
          prefs.desk = prefs.desk === false;
          try { localStorage.setItem('cortico.desk', prefs.desk ? 'on' : 'off'); } catch (e) {}
          if (!prefs.desk) for (const u of world.pets) u.clearFloor();
          this.onDeskToggled?.();
        },
      },
      theme: {
        keep: true,
        icon: () => (prefs.theme === 'dark' ? ICONS.moon : ICONS.sun),
        on: () => prefs.theme === 'dark',
        state: () => (prefs.theme === 'dark' ? '夜间模式:开(浅色身体) · 点一下换白天' : '夜间模式:关(白天,深色身体) · 点一下换夜间'),
        run: () => {
          const theme = prefs.theme === 'dark' ? 'light' : 'dark';
          prefs.theme = theme;
          applyTheme(theme);
          sendPrefs({ theme });
        },
      },
      sound: {
        keep: true,
        icon: () => (prefs.sound ? ICONS.sound : ICONS.soundOff),
        on: () => prefs.sound,
        state: () => (prefs.sound ? '音效:开 · 点一下静音' : '音效:关 · 点一下打开'),
        run: () => {
          prefs.sound = !prefs.sound;
          this.sfx?.set?.(prefs.sound);
          sendPrefs({ sound: prefs.sound });
        },
      },
      palette: {
        icon: () => ICONS.palette,
        state: () => `给第 ${(this.world.active || this.world.primary).id} 只快速换配色（不用开装扮页）`,
        run: () => this.quickPalette?.(),
      },
      dress: {
        icon: () => ICONS.shirt,
        state: () => `给第 ${(this.world.active || this.world.primary).id} 只换装（配色/帽子/眼镜/衣服，每只各一套）`,
        run: () => {
          const unit = this.world.active || this.world.primary;
          if (this.openDressFor) this.openDressFor(unit);
          else if (this.host?.openDress) this.host.openDress();
          else window.open('/dress', '_blank');
        },
      },
      hide: {
        icon: () => ICONS.eyeOff,
        available: () => !!this.host?.hide,
        state: () => '先把我藏起来(托盘里可以叫我回来)',
        run: () => this.host.hide(),
      },
    };
  }

  available(id) {
    const a = this.actions()[id];
    return !!a && (a.available?.() ?? true);
  }

  setCount(n) {
    const want = Math.max(1, Math.min(2, Number(n) || 1));
    this.world.ensure(want);
    this.prefs.count = this.world.count;
    try { localStorage.setItem('cortico.pet.count', String(this.prefs.count)); } catch (e) {}
    try { this.onCountChanged?.(); } catch (e) {}          // 新加的那只穿上现在的皮 + 告诉服务端
    this.refresh();
  }

  drawAction(b, id, unit) {
    const a = this.actions()[id];
    if (!a) return;
    const u = unit || b._unit || this.world.primary;
    const on = a.on?.(u);
    b.querySelector('.ic').innerHTML = a.icon() + (a.badge ? `<b class="badge">${a.badge()}</b>` : '');
    const label = a.state?.(u) ?? id;
    b.title = label;
    b.setAttribute('aria-label', label);
    if (on !== undefined) b.setAttribute('aria-pressed', String(on));
    b.classList.toggle('on', !!on);
  }

  /** 这一只自己的菜单元素（页面里只给了第 1 只一个 #menu，其余按需建）。 */
  menuFor(unit) {
    let el = this.menus.get(unit);
    if (el && document.body.contains(el)) return el;
    if (unit === this.world.primary) {
      el = document.getElementById('menu');
    } else {
      el = document.createElement('div');
      el.className = 'menu';
      el.id = 'menu' + unit.id;
      el.setAttribute('role', 'menu');
    }
    if (el) { el.hidden = true; if (!el.parentNode) document.body.appendChild(el); this.menus.set(unit, el); }
    return el;
  }

  openMenu(x, y) {
    const unit = this.world.active || this.world.primary;
    const menu = this.menuFor(unit);
    if (!menu) return;
    this.menuUnit = unit;
    menu.innerHTML = '';
    const head = Object.assign(document.createElement('div'), { className: 'm-head' });
    menu.appendChild(head);
    this.renderHead(false, unit);
    const grid = Object.assign(document.createElement('div'), { className: 'm-grid' });
    const acts = this.actions();
    for (const id of Object.keys(acts)) {
      if (!this.available(id)) continue;
      const a = acts[id];
      const b = document.createElement('button');
      b.type = 'button';
      b.setAttribute('role', 'menuitem');
      b.className = 'm-tile' + (a.cls ? ' ' + a.cls : '');
      b.dataset.action = id;
      b._unit = unit;
      b.innerHTML = '<span class="ic"></span>';
      this.drawAction(b, id, unit);
      b.addEventListener('click', () => {
        try { this.sfx?.tick?.(); } catch (e) {}
        if (!a.keep) this.closeMenu(unit);
        a.run?.(unit);
        if (a.keep) this.drawAction(b, id, unit);
      });
      grid.appendChild(b);
    }
    menu.appendChild(grid);
    menu.style.width = '';
    menu.hidden = false;
    this.host?.focus?.();
    menu.style.width = getComputedStyle(menu).width;
    const w = menu.offsetWidth, h = menu.offsetHeight;
    menu.style.left = `${Math.max(8, Math.min(innerWidth - w - 8, x))}px`;
    menu.style.top = `${Math.max(8, Math.min(innerHeight - h - 8, y - h))}px`;
  }

  /** 头像 + 名字 + 宿主借的运行控制（暂停/设置/退出）。 */
  renderHead(confirmQuit = false) {
    const menu = this.menu;
    const head = menu?.querySelector('.m-head');
    if (!head) return;
    const bot = this.prefs.bot || {};
    head.classList.toggle('confirm', confirmQuit);
    head.innerHTML = '<span class="m-avatar"></span><span class="m-name"></span><span class="m-acts"></span>';
    head.querySelector('.m-avatar').innerHTML = bot.avatar
      ? `<img alt="" src="/api/avatar?v=${encodeURIComponent(bot.avatar)}">`
      : `<svg viewBox="18 18 220 220" aria-hidden="true">${mini('neutral', this.world.primary.ct.skin)}</svg>`;
    const name = head.querySelector('.m-name');
    name.textContent = name.title = confirmQuit ? (bot.quitPrompt || '要走了吗？') : (bot.name || 'Coo');
    const acts = head.querySelector('.m-acts');
    const act = (html, label, fn, cls = 'm-act') => {
      const b = document.createElement('button');
      b.type = 'button';
      b.className = cls;
      b.title = label;
      b.setAttribute('aria-label', label);
      b.innerHTML = html;
      b.addEventListener('click', (e) => { e.stopPropagation(); try { this.sfx?.tick?.(); } catch (e2) {} fn(); });
      acts.appendChild(b);
    };
    if (!bot.controls) return;
    if (confirmQuit) {
      act(ICONS.power, bot.quitLabel || '退出', () => { this.closeMenu(); this.net.send({ t: 'control', action: 'quit' }); }, 'm-act danger');
      act('<span>取消</span>', '取消', () => this.renderHead(), 'm-act text');
      return;
    }
    const has = bot.buttons ?? { pause: true, settings: true, quit: true };
    if (has.pause) {
      act(bot.paused ? ICONS.play : ICONS.pause, bot.paused ? '继续(现在暂停着)' : '暂停',
        () => this.net.send({ t: 'control', action: bot.paused ? 'resume' : 'pause' }),
        `m-act run${bot.paused ? ' paused' : ''}`);
    }
    if (has.settings) act(ICONS.settings, '打开设置', () => { this.closeMenu(); this.net.send({ t: 'control', action: 'settings' }); });
    if (has.quit) act(ICONS.power, bot.quitLabel || '退出', () => this.renderHead(true), 'm-act power');
  }

  closeMenu(unit) {
    if (unit) { const el = this.menus.get(unit); if (el) el.hidden = true; return; }
    for (const el of this.menus.values()) el.hidden = true;
  }
  get menuOpen() { for (const el of this.menus.values()) if (!el.hidden) return true; return false; }

  /** 菜单/按钮的属性变了（换只、换档、换主题…）就地重画。 */
  refresh() {
    for (const el of this.menus.values()) {
      for (const b of el.querySelectorAll('.m-tile')) this.drawAction(b, b.dataset.action, b._unit);
    }
    this.renderTools();
  }

  // ---------- 悬停按钮 ----------

  renderTools() {
    const el = this.toolsEl;
    if (!el) return;
    const ids = (this.prefs.hoverButtons || this.hover).map((x) => (x === 'voice' ? 'chat' : x)).filter((id) => this.available(id)).slice(0, 6);
    if (ids.join(',') !== this.toolIds) {
      this.toolIds = ids.join(',');
      el.innerHTML = '';
      el.style.gridTemplateRows = `repeat(${Math.min(3, Math.max(1, ids.length))}, auto)`;
      for (const id of ids) {
        const b = document.createElement('button');
        b.type = 'button';
        b.className = 'tool';
        b.dataset.action = id;
        b.innerHTML = '<span class="ic"></span>';
        b.addEventListener('click', () => {
          try { this.sfx?.tick?.(); } catch (e) {}
          if (!this.actions()[id]?.keep) this.toolsUntil = 0;
          this.actions()[id]?.run();
          this.refresh();
        });
        el.appendChild(b);
      }
    }
    for (const b of el.children) this.drawAction(b, b.dataset.action);
  }

  /** 每帧：悬停按钮显示/隐藏 + 菜单贴着当前那只。 */
  step(dt, pointer, pressing) {
    const now = performance.now();
    const unit = this.world.active || this.world.primary;
    if (pointer && (this.world.hit(pointer) || this.overTools(pointer))) this.toolsUntil = now + 800;
    const canShow = now < this.toolsUntil && !pressing && !unit.ct.busy() && !this.menuOpen && this.toolIds !== '';
    if (this.toolsEl) this.toolsEl.hidden = !canShow;
    if (canShow) this.placeTools(unit);
    if (this.menuOpen) this.placeMenu(this.menuUnit || unit);
  }

  overTools(p) {
    const r = this.toolsEl?.getBoundingClientRect();
    if (!r || !r.width) return false;
    const pad = 6;
    return p.x >= r.left - pad && p.x <= r.right + pad && p.y >= r.top - pad && p.y <= r.bottom + pad;
  }

  placeTools(unit) {
    const el = this.toolsEl;
    if (!el) return;
    const c = unit.ct.toStage(128, 128 + unit.pet.low);
    const reach = 104 * unit.ct.bounds.S + 10;
    const w = el.offsetWidth, h = el.offsetHeight;
    const left = c.x + reach + w <= innerWidth - 8 ? c.x + reach : c.x - reach - w;
    el.style.left = `${Math.round(Math.max(8, Math.min(innerWidth - w - 8, left)))}px`;
    el.style.top = `${Math.round(Math.max(8, Math.min(innerHeight - h - 8, c.y - h / 2)))}px`;
  }

  placeMenu(unit) {
    const menu = this.menu;
    if (!menu) return;
    const a = unit.ct.anchor();
    const w = menu.offsetWidth, h = menu.offsetHeight;
    menu.style.left = `${Math.round(Math.max(8, Math.min(innerWidth - w - 8, a.x - w / 2)))}px`;
    menu.style.top = `${Math.round(Math.max(8, Math.min(innerHeight - h - 8, a.y - h - 10)))}px`;
  }

  /** 每帧给气泡定位（谁说话贴谁）。 */
  layout() {
    for (const [unit, b] of this.bubbles) {
      if (!b.visible) continue;
      b.place(unit.ct.anchor());
    }
    if (this.heard.visible) {
      const u = this.heard.unit || this.world.primary;
      const a = u.ct.anchor();
      this.heard.place({ x: a.x - 30, y: a.y + 8 });
    }
  }

  bind() {
    document.addEventListener('pointerdown', (e) => {
      if (!e.target.closest?.('.menu')) this.closeMenu();
    }, { capture: true });
    window.addEventListener('blur', () => this.closeMenu());
    document.addEventListener('keydown', (e) => {
      if (e.isComposing || e.keyCode === 229) return;
      if (e.key === 'Escape') { this.closeMenu(); this.talk.dismiss(); return; }
      if (this.talk.keySelect(e.key, e.isComposing)) e.preventDefault();
    });
  }
}
