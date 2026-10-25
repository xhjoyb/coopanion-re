/**
 * 照顾层（重写版）：喂食 + 铁盆。
 *
 * 铁盆 = 一个 fixed 的 div（图片 + 拖动手感），落地 → 第 1 只走过来吃 → 空盆留在桌上，
 * 可以拖走、可以扣头上（拖到身上就戴住）、双击取下。和旧版行为一致，只是从页面里拆出来。
 */

const BOWL_FULL = '/web/props/bowl_full.png';
const BOWL_EMPTY = '/web/props/bowl.png';
/** 拖到身上「戴上」的判定半径（CSS px）。 */
const HEAD_REACH = 210;

export class Care {
  /**
   * @param {{
   *   world: import('../pet-multi.js').PetWorld,
   *   primary: () => any,
   *   sfx?: any,
   *   onFeed?: () => void,
   *   hexi?: (t: string, ms?: number) => void,
   * }} deps
   */
  constructor(deps) {
    this.world = deps.world;
    this.primary = deps.primary;
    this.sfx = deps.sfx;
    this.onFeed = deps.onFeed || (() => {});
    this.hex = deps.hexi || (() => {});
    this.el = null;
    this.onHead = false;
    this.raf = 0;
    this.chewTimer = 0;
    this.eatTimer = 0;
    this.drag = null;
  }

  get hasBowl() { return !!this.el; }
  /** 现在这口盆属于哪一只（扣头上时也跟着它）。 */
  target() { return (this.unit && this.world.pets.includes(this.unit)) ? this.unit : this.primary(); }

  /** 喂一次：铁盆落下来，第 1 只过来吃，吃完留个空盆。 */
  feed(unit0) {
    this.clearBowl();
    const unit = unit0 || this.primary();
    this.unit = unit;
    const a = unit.ct.anchor();
    const groundY = this.world.bounds().floorY;
    const x = Math.min(innerWidth - 56, Math.max(56, Math.round(a.x + 56)));
    const el = document.createElement('div');
    el.id = 'petBowl';
    el.innerHTML = `<img class="bowlImg" src="${BOWL_FULL}" width="84" alt="" style="display:block;filter:drop-shadow(0 2px 3px rgba(0,0,0,.35))">`;
    el.style.cssText = `position:fixed;left:${x - 42}px;top:${groundY - 38}px;z-index:9;pointer-events:auto;`
      + 'cursor:grab;touch-action:none;';
    document.body.appendChild(el);
    this.el = el;
    this.bindBowl(el);
    try {
      el.animate(
        [{ transform: 'translateY(-16px) scale(1.06)' }, { transform: 'translateY(0) scale(1)' },
          { transform: 'translateY(-4px)' }, { transform: 'translateY(0)' }],
        { duration: 460, easing: 'ease-out' },
      );
    } catch (e) {}
    try { this.onFeed(); } catch (e) {}
    try { unit.ct.walkTo(x); } catch (e) {}
    this.sfx?.pop?.();

    this.eatTimer = setTimeout(() => {
      try { unit.ct.setExpr('happy'); } catch (e) {}
      let n = 0;
      this.chewTimer = setInterval(() => {
        n += 1;
        const im = this.el?.querySelector('.bowlImg');
        if (im) im.style.transform = `scaleY(${Math.max(0.86, 1 - n * 0.02)})`;
        if (n % 2 === 0) this.crumb(x, groundY);
        if (n >= 7) {
          clearInterval(this.chewTimer);
          this.chewTimer = 0;
          const img = this.el?.querySelector('.bowlImg');
          if (img) img.src = BOWL_EMPTY;                 // 空盆：铁盆还在，能拖能扣能双击取下
          this.hex('谢谢主人～', 4200);
        }
      }, 240);
    }, 900);
  }

  /** 碎屑：从盆口往下掉一点。 */
  crumb(x, y) {
    const c = document.createElement('div');
    c.textContent = '•';
    c.style.cssText = `position:fixed;left:${x + (Math.random() * 26 - 13)}px;top:${y - 34}px;`
      + 'font-size:11px;color:#f6e7c6;text-shadow:0 1px 1px rgba(0,0,0,.45);pointer-events:none;z-index:9;';
    document.body.appendChild(c);
    try {
      c.animate([{ transform: 'translateY(0)', opacity: 1 }, { transform: 'translateY(26px)', opacity: 0 }],
        { duration: 620, easing: 'ease-in' });
    } catch (e) {}
    setTimeout(() => c.remove(), 700);
  }

  /** 盆跟着第 1 只的头顶走（扣头上的时候）。 */
  followHead() {
    if (!this.onHead || !this.el) { this.raf = 0; return; }
    const a = this.target().ct.anchor();
    this.el.style.transform = 'rotate(180deg)';
    this.el.style.left = `${Math.round(a.x - 42)}px`;
    this.el.style.top = `${Math.round(a.y + 4)}px`;
    this.raf = requestAnimationFrame(() => this.followHead());
  }

  wear() {
    if (!this.el) return;
    this.onHead = true;
    if (!this.raf) this.raf = requestAnimationFrame(() => this.followHead());
  }

  unwear() {
    this.onHead = false;
    if (this.raf) { cancelAnimationFrame(this.raf); this.raf = 0; }
    if (this.el) this.el.style.transform = 'none';
  }

  /** 盆中心在不在她身上（够近就算戴上）。 */
  overBody(cx, cy) {
    const a = this.target().ct.anchor();
    return Math.abs(cx - a.x) < HEAD_REACH && cy > a.y - 60 && cy < a.y + 420;
  }

  bindBowl(el) {
    let lastTap = 0;
    let d = null;
    el.addEventListener('pointerdown', (e) => {
      if (e.button && e.button !== 0) return;
      e.stopPropagation();
      e.preventDefault();
      if (this.onHead) this.unwear();
      const r = el.getBoundingClientRect();
      d = {
        x: e.clientX, y: e.clientY, offX: e.clientX - r.left, offY: e.clientY - r.top,
        moved: false, lx: e.clientX, ly: e.clientY, lt: performance.now(), vx: 0, vy: 0,
      };
      el.style.cursor = 'grabbing';
      try { el.setPointerCapture(e.pointerId); } catch (err) {}
    });
    el.addEventListener('pointermove', (e) => {
      if (!d) return;
      e.stopPropagation();
      if (!d.moved && Math.hypot(e.clientX - d.x, e.clientY - d.y) < 6) return;
      d.moved = true;
      const now = performance.now(), dt = Math.max(8, now - d.lt);
      d.vx = d.vx * 0.55 + ((e.clientX - d.lx) / dt) * 0.45;
      d.vy = d.vy * 0.55 + ((e.clientY - d.ly) / dt) * 0.45;
      d.lx = e.clientX; d.ly = e.clientY; d.lt = now;
      const inside = this.overBody(e.clientX, e.clientY);
      if (inside && !this.onHead) this.wear();
      else if (!inside && this.onHead) this.unwear();
      if (!this.onHead) {
        el.style.left = `${Math.round(e.clientX - d.offX)}px`;
        el.style.top = `${Math.round(e.clientY - d.offY)}px`;
      }
    });
    const release = (e) => {
      if (!d) return;
      const wasMoved = d.moved;
      const vx = d.vx, vy = d.vy;
      d = null;
      el.style.cursor = 'grab';
      if (!wasMoved) {
        // 没拖过 = 点了一下；350ms 内第二下就把盆取走
        const now = performance.now();
        if (now - lastTap < 350) { lastTap = 0; this.removeBowl(); return; }
        lastTap = now;
        if (this.onHead) return;
      }
      try { el.releasePointerCapture?.(e.pointerId); } catch (err) {}
      if (this.onHead) return;
      this.glide(el, vx, vy);
    };
    el.addEventListener('pointerup', release);
    el.addEventListener('pointercancel', release);
    el.addEventListener('dblclick', (e) => { e.stopPropagation(); this.removeBowl(); });
  }

  /** 松手后的惯性滑行。 */
  glide(el, vx, vy) {
    let px = parseFloat(el.style.left) || 0, py = parseFloat(el.style.top) || 0;
    const t0 = performance.now();
    const step = (now) => {
      const dt = Math.min(34, now - t0) || 16;
      const k = Math.pow(0.55, dt / 1000);
      px += vx * dt; py += vy * dt;
      vx *= k; vy *= k;
      px = Math.min(innerWidth - 26, Math.max(-26, px));
      py = Math.min(innerHeight - 8, Math.max(-8, py));
      el.style.left = `${Math.round(px)}px`;
      el.style.top = `${Math.round(py)}px`;
      if (Math.abs(vx) < 0.05 && Math.abs(vy) < 0.05) return;
      requestAnimationFrame(step);
    };
    requestAnimationFrame(step);
  }

  removeBowl() {
    this.unwear();
    clearTimeout(this.eatTimer);
    clearInterval(this.chewTimer);
    this.eatTimer = 0; this.chewTimer = 0;
    this.el?.remove();
    this.el = null;
  }

  clearBowl() { this.removeBowl(); }

  /** 触摸区要并进来的元素（盆可以拖着走，别让触摸窗把它裁掉）。 */
  boxes() { return this.el ? [this.el] : []; }
}
