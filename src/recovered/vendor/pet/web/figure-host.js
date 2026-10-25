/**
 * 自定义形象的渲染槽（渲染器 v2 · 唯一入口）
 *
 * 设计目标（都是过去真踩过的坑）：
 *   1) **每只宠物一个 `FigureSlot`**：绑定自己的 `<g>`，形象只能画进自己的槽；
 *      发现"这个形象已经属于别的槽"直接拒绝 —— 杜绝两只串着用（白方块/不同步的根因）；
 *   2) **帧协议只在一个地方拼**：`buildFigureFrame()`；字段写死 + 缺失补 0 + 冻结；
 *   3) **生命周期单一入口**：`mount()` 先释放旧的；`dispose()` 一定调到形象自己的 dispose；
 *   4) **错误隔离**：形象抛错不外泄；同一形象连续失败 2 次才放弃（交给页面回退）；
 *      **绝不清空 `<g>`**（清空 = 形象消失，历史 bug）；
 *   5) 与"尺寸/眨眼"状态完全无关：槽只接收帧对象，不碰 `pet.*`，天然不会打断眨眼计时。
 */

/** 帧协议字段（文档 + 自检共用）。 */
export const FRAME_FIELDS = Object.freeze([
  't', 'face', 'mode', 'modeT', 'look', 'legs', 'low', 'blink', 'eyeClose',
  'swing', 'tilt', 'lean', 'facing', 'sit', 'talk', 'drowse', 'acc', 'groupRot',
]);

const MAX_FAILS = 2;

/** 唯一的帧对象构造函数（形象只读）。 */
export function buildFigureFrame(p) {
  const f = {
    t: p.time, face: p.faceName, mode: p.mode, modeT: p.modeT,
    look: p.look, legs: p.legs, low: p.low, blink: p.blink, eyeClose: p.eyeClose,
    swing: p.swing, tilt: p.tilt, lean: p.lean, facing: p.facing,
    sit: p.sit, talk: p.talk, drowse: p.drowse, acc: p.skin, groupRot: p.groupRot,
  };
  for (const k of FRAME_FIELDS) {
    if (f[k] === undefined) f[k] = k === 'acc' ? {} : k === 'look' ? [0, 0] : k === 'legs' ? [] : 0;
  }
  return Object.freeze(f);
}

/** 从 err.stack 抠 `文件:行号`。 */
function whereOf(err) {
  const stack = String((err && err.stack) || '');
  for (const line of stack.split('\n')) {
    const m = line.match(/([A-Za-z0-9_.\-/]+\.(?:js|mjs|ts)):(\d+)/);
    if (m && !/figure-host\.js/.test(m[1])) return `${m[1].split('/').pop()}:${m[2]}`;
  }
  return '';
}

/** 形象 → 它所在的槽（拦住"一个形象挂两只"）。 */
const owner = new WeakMap();

export class FigureSlot {
  /** @param {Element} parent 这一只宠物自己的 `<g>` */
  constructor(parent, name = '') {
    this.parent = parent;
    this.name = name;
    this.fig = null;
    this.fails = 0;
    this.dead = false;
    this.onGiveUp = null;   // (info) => void
    this.onError = null;    // (info) => void
  }

  /** 挂上一个形象（同槽旧形象会被释放）。返回是否挂上。 */
  mount(fig) {
    if (fig === this.fig) return true;
    if (fig) {
      if (typeof fig.draw !== 'function') {
        console.warn(`[figures] ${this.name} 挂载失败：对象没有 draw()`);
        return false;
      }
      const other = owner.get(fig);
      if (other && other !== this) {
        console.warn(`[figures] ${this.name} 挂载失败：该形象已被另一只占用（拒绝串台）`);
        return false;
      }
    }
    this.dispose();
    this.fig = fig || null;
    this.fails = 0;
    this.dead = false;
    if (this.fig) owner.set(this.fig, this);
    return true;
  }

  /** 释放当前形象（会调到它自己的 dispose）。 */
  dispose() {
    const fig = this.fig;
    this.fig = null;
    this.fails = 0;
    this.dead = false;
    if (!fig) return;
    try {
      fig.dispose?.();
    } catch (err) {
      this.onError?.({ error: String((err && err.message) || err), where: whereOf(err), slot: this.name });
    } finally {
      owner.delete(fig);
    }
  }

  /** 画这一帧。返回 true=画了；false=没形象/已放弃/出错。 */
  draw(face, frame) {
    const fig = this.fig;
    if (!fig || this.dead) return false;
    if (!this.parent || !this.parent.isConnected) return false;   // 父节点不在文档里：不画也不报错
    try {
      fig.draw(this.parent, face, frame);
      this.fails = 0;
      return true;
    } catch (err) {
      this.fails += 1;
      const info = {
        error: String((err && err.message) || err),
        where: whereOf(err),
        tries: this.fails,
        slot: this.name,
      };
      try { console.error(`[figures] ${this.name} 绘制失败`, info.error, info.where || ''); } catch (e) {}
      this.onError?.(info);
      if (this.fails < MAX_FAILS) return false;                   // 先留一次机会（挂载瞬间抖动）
      this.dead = true;
      try {
        this.parent.dispatchEvent(new CustomEvent('figureerror', { bubbles: true, detail: info }));
      } catch (e) {}
      this.onGiveUp?.(info);
      return false;
    }
  }

  state() {
    return { name: this.name, mounted: !!this.fig, fails: this.fails, dead: this.dead };
  }
}

/** 页面级：建槽、统一挂回调、留诊断。 */
export class FigureHost {
  constructor() {
    this.slots = new Map();
    this.onGiveUp = null;   // (slot, info) => void
    this.onError = null;    // (slot, info) => void
  }

  /** 给一只宠物建槽（同一个 parent 只会有一个槽）。 */
  slotFor(parent, name) {
    let s = this.slots.get(parent);
    if (s) return s;
    s = new FigureSlot(parent, name);
    s.onGiveUp = (info) => { try { this.onGiveUp?.(s, info); } catch (e) {} };
    s.onError = (info) => { try { this.onError?.(s, info); } catch (e) {} };
    this.slots.set(parent, s);
    return s;
  }

  /** 诊断：所有槽的状态。 */
  states() {
    return [...this.slots.values()].map((s) => s.state());
  }
}

export const figureHost = new FigureHost();
export default figureHost;
