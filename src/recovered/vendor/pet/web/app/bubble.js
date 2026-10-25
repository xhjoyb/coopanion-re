/**
 * 气泡（重写版）：一只宠物一份，不共用元素、不互相偷文字。
 *
 * 支持的几种样子（样式全在 pet.css 里，沿用上游）：
 *   say     纯文字 + 打字机 + 到点自己收
 *   ask     问题 + 可点的选项（数字键 1-9 也能选）
 *   input   一行输入框（打字/语音上屏走这里）
 *   heard   别人说的话，虚线框，贴在旁边
 *
 * 定位由 main 的每帧 layout 调 `place(anchor)`：锚点是宠物头顶（stage CSS px）。
 */

const esc = (s) => String(s ?? '').replace(/[&<>"']/g, (c) => ({ '&': '&amp;', '<': '&lt;', '>': '&gt;', '"': '&quot;', "'": '&#39;' }[c]));

export class Bubble {
  /**
   * @param {import('../pet-multi.js').PetUnit | null} unit 说话的那只；null = 不属于任何宠物
   * @param {{ host?: HTMLElement, kind?: string, cps?: number }} [opts]
   */
  constructor(unit, opts = {}) {
    this.unit = unit || null;
    this.host = opts.host || document.body;
    this.kind = opts.kind || 'say';
    this.cps = opts.cps ?? 34;                 // 打字机速度（字/秒）
    this.el = document.createElement('div');
    this.el.className = 'bubble';
    this.el.hidden = true;
    this.el.setAttribute('role', 'status');
    this.el.setAttribute('aria-live', 'polite');
    this.host.appendChild(this.el);
    this.typing = null;
    this.hideAt = 0;
    this.onPick = null;
    this._timer = 0;
  }

  get visible() { return !this.el.hidden; }

  /** 打开气泡并写入内容（内容按需替换成 .b-text 等结构）。 */
  open(html, cls = '') {
    clearTimeout(this._timer);
    this.typing = null;
    this.el.className = 'bubble' + (cls ? ' ' + cls : '');
    this.el.innerHTML = html;
    this.el.hidden = false;
    void this.el.offsetWidth;
    this.el.classList.add('pop');
    return this;
  }

  hide() {
    clearTimeout(this._timer);
    this.typing = null;
    this.onPick = null;
    this.el.hidden = true;
    this.el.innerHTML = '';
    this.el.className = 'bubble';
  }

  /** 一句话：打字机显示，`ms` 之后自己收（0 = 一直留着，等 talk 收）。 */
  say(text, ms = 0) {
    const t = String(text ?? '').trim();
    if (!t) return false;
    this.open('<p class="b-text"></p><span class="caret"></span>', this.kind === 'quick' ? '' : '');
    this._body = this.el.querySelector('.b-text');
    this._caret = this.el.querySelector('.caret');
    this.typing = { text: t, at: 0, done: false };
    this.hideAt = ms > 0 ? performance.now() + ms : 0;
    return true;
  }

  /** 直接落全文（不打字，给 heard / 提示用）。 */
  flash(text, ms = 4200) {
    const t = String(text ?? '').trim();
    if (!t) return false;
    this.open('<p class="b-text"></p>');
    this.el.querySelector('.b-text').textContent = t;
    this.typing = null;
    this.hideAt = performance.now() + ms;
    return true;
  }

  /** 问题 + 选项。`pick(i|null, text|null)` 被调一次。 */
  ask(question, options = [], { own = false, ownLabel = '自己说', onPick } = {}) {
    const opts = options.map((o, i) => {
      const label = esc(typeof o === 'string' ? o : o?.label ?? '');
      const hint = typeof o === 'object' && o?.hint ? `<span class="b-hint">${esc(o.hint)}</span>` : '';
      const dot = typeof o === 'object' && Array.isArray(o?.color)
        ? `<span class="dot" style="--a:${esc(o.color[0])};--b:${esc(o.color[1] || o.color[0])}"></span>` : '';
      const cls = dot ? 'b-opt pal' : 'b-opt';
      return `<button class="${cls}" type="button" data-i="${i}"><kbd>${i + 1}</kbd>${dot}${label}${hint}</button>`;
    }).join('');
    const ownHtml = own
      ? `<div class="b-own"><input type="text" placeholder="${esc(ownLabel)}" aria-label="${esc(ownLabel)}"><button type="button">发送</button></div>`
      : '';
    this.open(
      `<button class="b-close" type="button" aria-label="关闭">×</button><p class="b-text"></p>`
      + `<div class="b-opts">${opts}${ownHtml}</div>`,
      'ask',
    );
    const body = this.el.querySelector('.b-text');
    body.textContent = String(question ?? '');
    this.onPick = (answer) => {
      this.onPick = null;
      try { onPick?.(answer); } catch (e) {}
    };
    let picked = false;
    const finish = (answer) => {
      if (picked) return;
      picked = true;
      const fn = this.onPick;
      this.onPick = null;
      try { fn?.(answer); } catch (e) {}
    };
    for (const b of this.el.querySelectorAll('.b-opt')) {
      b.addEventListener('click', () => {
        b.classList.add('chosen');
        finish({ index: Number(b.dataset.i), text: String(options[Number(b.dataset.i)]?.label ?? options[Number(b.dataset.i)] ?? '') });
      });
    }
    this.el.querySelector('.b-close')?.addEventListener('click', () => finish(null));
    const box = this.el.querySelector('.b-own');
    if (box) {
      const input = box.querySelector('input');
      const send = () => {
        const v = input.value.trim();
        if (!v) return;
        box.classList.add('chosen');
        finish({ index: null, text: v });
      };
      box.querySelector('button').addEventListener('click', send);
      input.addEventListener('keydown', (e) => {
        if (e.key === 'Enter' && !e.isComposing) { e.preventDefault(); send(); }
      });
    }
    this._askBox = box || null;
    return this;
  }

  /** 数字键 1-9 选选项（输入法组合中不抢）。 */
  keySelect(key, composing = false) {
    if (composing) return false;
    if (!this.visible || !this.onPick) return false;
    const n = /^([1-9])$/.exec(key);
    if (!n) return false;
    const b = this.el.querySelector(`.b-opt[data-i="${Number(n[1]) - 1}"]`);
    if (!b) return false;
    b.click();
    return true;
  }

  /** 一行输入（回车或点按钮提交）。 */
  input({ placeholder = '说点什么…', value = '', onSubmit } = {}) {
    this.open(
      `<button class="b-close" type="button" aria-label="关闭">×</button><p class="b-text"></p>`
      + `<div class="b-own"><input type="text" placeholder="${esc(placeholder)}" aria-label="输入"><button type="button">发送</button></div>`,
      'ask',
    );
    this.el.querySelector('.b-text').textContent = placeholder;
    const box = this.el.querySelector('.b-own');
    const input = box.querySelector('input');
    input.value = value;
    const send = () => {
      const v = input.value.trim();
      if (!v) return;
      this.hide();
      try { onSubmit?.(v); } catch (e) {}
    };
    box.querySelector('button').addEventListener('click', send);
    input.addEventListener('keydown', (e) => {
      if (e.key === 'Enter' && !e.isComposing) { e.preventDefault(); send(); }
      if (e.key === 'Escape') this.hide();
    });
    try { input.focus(); } catch (e) {}
    this._inputBox = input;
    return this;
  }

  get inputOpen() { return !!(this._inputBox && this.el.contains(this._inputBox) && !this.el.hidden); }

  /** 每帧推进打字机与自动收起。返回 true 表示这一帧有变化。 */
  step(dt) {
    let changed = false;
    if (this.typing && !this.typing.done) {
      const t = this.typing;
      t.at = Math.min(t.text.length, t.at + this.cps * dt);
      const shown = t.text.slice(0, Math.floor(t.at));
      if (this._body && this._body.textContent !== shown) { this._body.textContent = shown; changed = true; }
      if (t.at >= t.text.length) {
        t.done = true;
        this._caret?.remove();
        this._caret = null;
        this.typing = t;
      }
    }
    if (this.hideAt && performance.now() >= this.hideAt) {
      this.hideAt = 0;
      this.hide();
      changed = true;
    }
    return changed;
  }

  /** 每帧定位：贴在说话那只的头顶（锚点 = stage CSS px）。 */
  place(anchor) {
    if (!this.visible || !anchor) return;
    const w = this.el.offsetWidth, h = this.el.offsetHeight;
    const W = innerWidth;
    const left = Math.max(8, Math.min(W - w - 8, anchor.x - w / 2));
    const top = Math.max(8, anchor.y - h - 12);
    this.el.style.left = `${Math.round(left)}px`;
    this.el.style.top = `${Math.round(top)}px`;
    this.el.style.setProperty('--tail', `${Math.round(Math.max(20, Math.min(w - 20, anchor.x - left)))}px`);
  }

  dispose() { this.hide(); this.el.remove(); }
}
