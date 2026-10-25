/**
 * 说话队列（重写版）：say 的多段、ask 的选项/自己说、confirm 的确认、input 的一行输入。
 *
 * 一次只演一件事；`say` 说完自己收，`ask` 等回答（超时/关闭都算放弃）。
 * 上行报给 World 的字段沿用旧协议（answer / confirmed），服务端不用改。
 */

/** 世界给的片段是对象 `{ text, actions, anchors }`；这里统一取文字。 */
const beatText = (b) => (typeof b === 'string' ? b : String((b && b.text) ?? ''));

export class Talk {
  /**
   * @param {{
   *   bubbleFor: (unit?: any) => import('./bubble.js').Bubble,
   *   primary: () => any,
   *   sfx?: any,
   *   send: (msg: any) => void,
   *   onBusyChange?: (busy: boolean) => void,
   *   onInput?: (text: string) => void,
   * }} deps
   */
  constructor(deps) {
    this.deps = deps;
    this.queue = [];
    this.item = null;
    this.holdUntil = 0;
  }

  get busy() { return !!this.item || this.queue.length > 0; }
  /** 正式对话在场时，旁白别抢气泡。 */
  get talking() { return !!this.item; }

  _changed() { try { this.deps.onBusyChange?.(this.busy); } catch (e) {} }

  /** 谁在说话：消息里带 `from` 就找那只，否则第 1 只。 */
  _unitFor(msg) {
    const world = this.deps.world;
    if (!world) return this.deps.primary();
    const from = msg && msg.from;
    if (from == null) return this.deps.primary();
    if (typeof from === 'number') return world.pets[from - 1] || this.deps.primary();
    return world.pets.find((u) => u.id === from || u.name === from) || this.deps.primary();
  }

  /** say：beats 是一段一段的话（世界给的是 `{ text, actions, anchors }`，也接受纯字符串）。 */
  say(beats, { from } = {}) {
    const list = (Array.isArray(beats) ? beats : [beats]).filter((b) => beatText(b).trim());
    if (!list.length) return;
    this.queue.push({ kind: 'say', beats: list, i: -1, from });
    this._changed();
  }

  /** ask：问题 + 选项（可带「自己说」输入框）。 */
  ask(msg) {
    this.dropAsks();
    this.queue.push({ kind: 'ask', id: msg.id, question: msg.question, options: msg.options || [], own: msg.own !== false, confirm: false });
    this._changed();
  }

  /** confirm：World 的确认框（不动输入法，不让人打字）。 */
  confirm(msg) {
    this.dropAsks();
    this.queue.push({ kind: 'ask', id: msg.id, question: msg.question, options: msg.options || [], own: false, confirm: true });
    this._changed();
  }

  /** input：双击/按钮打开的一行输入；给哪一只就回哪一只。 */
  input(unit) {
    if (unit && this.deps.world) this.deps.world.active = unit;
    this.queue.push({ kind: 'input', unit });
    this._changed();
  }

  /** 新的问题顶掉还没回答的旧问题（World 的确认框除外）。 */
  dropAsks() {
    for (let i = this.queue.length - 1; i >= 0; i--) {
      const q = this.queue[i];
      if (q.kind === 'ask' && !q.confirm) this.queue.splice(i, 1);
    }
    if (this.item && this.item.kind === 'ask' && !this.item.confirm && !this.item.answered) this._close();
  }

  /** 页面被顶掉时清空（不回答任何问题）。 */
  dropAll() {
    this.queue.length = 0;
    if (this.item) this._close();
  }

  _close() {
    const it = this.item;
    this.item = null;
    this.holdUntil = 0;
    if (it) { try { this.deps.bubbleFor(it.unit).hide(); } catch (e) {} }
    this._changed();
  }

  _start(it) {
    it.unit = it.unit || this._unitFor(it);
    const bubble = this.deps.bubbleFor(it.unit);
    this.item = it;
    this.holdUntil = 0;
    if (it.kind === 'say') { it.i = -1; this._nextBeat(it); }
    else if (it.kind === 'ask') this._openAsk(it, bubble);
    else if (it.kind === 'input') this._openInput(it, bubble);
  }

  _nextBeat(it) {
    const bubble = this.deps.bubbleFor(it.unit);
    it.i += 1;
    if (it.i >= it.beats.length) { this._close(); return; }
    const beat = it.beats[it.i];
    const text = beatText(beat).trim();
    for (const a of (beat && beat.actions) || []) this.deps.onActions?.(a);
    bubble.say(text, 0);
    // 一段话演完（打字机 + 停一下）再下一段
    const dur = text.length / bubble.cps * 1000 + 380 + Math.min(2600, text.length * 90);
    this.holdUntil = performance.now() + dur;
    try { this.deps.sfx?.pop?.(); } catch (e) {}
  }

  _openAsk(it, bubble) {
    bubble.ask(it.question, it.options, {
      own: it.own && !it.confirm,
      onPick: (answer) => this._answer(it, answer),
    });
    try { this.deps.sfx?.pop?.(); } catch (e) {}
  }

  _openInput(it, bubble) {
    bubble.input({
      placeholder: '说点什么…',
      onSubmit: (text) => {
        this.item = null;
        this._changed();
        try { this.deps.onInput?.(text); } catch (e) {}
      },
    });
  }

  _answer(it, answer) {
    if (!it || it.answered) return;
    it.answered = true;
    const send = this.deps.send;
    try {
      if (it.confirm) send({ t: 'confirmed', id: it.id, index: answer ? answer.index : null });
      else if (answer) send({ t: 'answer', askId: it.id, index: answer.index, text: answer.text });
      else send({ t: 'answer', askId: it.id, dismissed: true });
    } catch (e) {}
    try { this.deps.sfx?.select?.(); } catch (e) {}
    try { it.unit?.ct?.setExpr('happy'); } catch (e) {}
    // 气泡多留一会儿再收
    this.holdUntil = performance.now() + 620;
  }

  /** 每帧：气泡推进 + 到点收尾。 */
  step(dt) {
    const now = performance.now();
    if (!this.item && this.queue.length) this._start(this.queue.shift());
    const it = this.item;
    if (!it) return;
    const bubble = this.deps.bubbleFor(it.unit);
    bubble.step(dt);
    if (it.kind === 'say' && it.i >= 0 && now >= this.holdUntil) this._nextBeat(it);
    if (it.kind === 'ask' && it.answered && now >= this.holdUntil) this._close();
  }

  /** 数字键选选项；返回 true 表示吃掉了这个按键。 */
  keySelect(key, composing) {
    if (!this.item || this.item.kind !== 'ask') return false;
    return this.deps.bubbleFor(this.item.unit).keySelect(key, composing);
  }

  /** 关闭当前的问题/旁白（Esc）。 */
  dismiss() {
    const it = this.item;
    if (!it) return false;
    if (it.kind === 'ask' && !it.answered) this._answer(it, null);
    else this._close();
    return true;
  }
}
