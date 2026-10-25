/**
 * 与 World 的通道（重写版）。
 *
 * 一条 WebSocket：`ws://<页面源>/socket?role=pet&host=window|tab`。
 * 下行：init / prefs / say / ask / confirm / walk / act / listen / thinking / dialog* / deskTargets
 * 上行：hello / arrived / interrupted / touch / text / prefs / control / commit / openAppResult
 *
 * 这里只管「连、断、重连、收发」，不认识具体指令——分发给装配层（main.js）。
 */

const BACKOFF_MIN = 500, BACKOFF_MAX = 8000;

export class PetNet {
  /**
   * @param {{
   *   hostMode?: boolean,
   *   onOrder?: (msg: any) => void,
   *   onOpen?: () => void,
   *   onClose?: (code: number) => void,
   *   screen?: () => { w: number, h: number },
   * }} opts
   */
  constructor(opts = {}) {
    this.hostMode = !!opts.hostMode;
    this.onOrder = opts.onOrder || (() => {});
    this.onOpen = opts.onOpen || (() => {});
    this.onClose = opts.onClose || (() => {});
    this.screen = opts.screen || (() => ({ w: innerWidth, h: innerHeight }));
    this.ws = null;
    this.backoff = BACKOFF_MIN;
    this.closed = false;
  }

  get connected() { return !!this.ws && this.ws.readyState === 1; }

  connect() {
    this.closed = false;
    const url = `ws://${location.host}/socket?role=pet&host=${this.hostMode ? 'window' : 'tab'}`;
    let ws;
    try { ws = new WebSocket(url); } catch (e) { this.retry(); return; }
    ws.binaryType = 'arraybuffer';
    this.ws = ws;
    ws.onopen = () => {
      this.backoff = BACKOFF_MIN;
      const s = this.screen();
      this.send({ t: 'hello', screen: { w: s.w, h: s.h }, host: this.hostMode ? 'window' : 'tab' });
      try { this.onOpen(); } catch (e) {}
    };
    ws.onmessage = (e) => {
      let msg;
      try { msg = JSON.parse(e.data); } catch (err) { return; }
      if (!msg || typeof msg.t !== 'string') return;
      try { this.onOrder(msg); } catch (err) { console.error('[net] order', msg.t, err); }
    };
    ws.onclose = (e) => {
      this.ws = null;
      try { this.onClose(e.code); } catch (err) {}
      if (e.code === 4000) return;                    // 被新页面替换，不再重连
      this.retry();
    };
    ws.onerror = () => {};
  }

  retry() {
    if (this.closed) return;
    const wait = this.backoff;
    this.backoff = Math.min(BACKOFF_MAX, this.backoff * 2);
    setTimeout(() => { if (!this.closed) this.connect(); }, wait);
  }

  send(msg) {
    if (!this.connected) return false;
    try { this.ws.send(JSON.stringify(msg)); return true; } catch (e) { return false; }
  }

  close() {
    this.closed = true;
    try { this.ws?.close(); } catch (e) {}
    this.ws = null;
  }
}
