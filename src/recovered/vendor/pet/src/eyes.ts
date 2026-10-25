/**
 * Eyes: the pet's sight.
 *
 * Coopanion ships an Android accessibility service of its own (`com.palai.prootsmoke.EyesService`,
 * enabled by the person under 系统设置 → 无障碍). It listens on 127.0.0.1:17898 inside the same
 * device and answers three things: a JPEG of the current screen, the text that is on screen, and
 * who is in front. The Android side's older SenseBridge (127.0.0.1:17899) adds the app's label and
 * whether the screen is on and unlocked.
 *
 * Two ways in, both driven from here:
 *   - `eyes_look`  : the model asks to see; returns the frame as a blob so a model that reads
 *                    images gets the picture itself.
 *   - the watcher  : while `eyes.enabled` is on, polls the cheap side (who is in front, what text
 *                    is on screen) every `intervalSec`, and when the scene actually changes — or
 *                    stays put for `sameSceneSec` — pushes a `[画面]` event with the frame, which
 *                    wakes the pet so it can say something by itself.
 *
 * Nothing is uploaded from here: the frame goes to the model endpoint the person configured, the
 * same place every other message goes.
 */
import { get as httpGet } from 'node:http';
import { createHash } from 'node:crypto';
import type { BlobInput, Logger, WorldHost } from 'cortico/core/types.ts';
import { nowIso } from 'cortico/core/util.ts';

/** The accessibility service that owns the screen. */
export const EYES_PORT = 17898;
/** The Android side's older sense bridge (foreground app label, screen on/locked). */
export const SENSE_PORT = 17899;
/** This app, so the pet does not stare at its own window. */
export const SELF_PACKAGE = 'com.palai.prootsmoke';

export interface EyesConfig {
  enabled: boolean;
  port: number;
  intervalSec: number;
  minGapSec: number;
  sameSceneSec: number;
  attach: boolean;
  maxWidth: number;
  quality: number;
}

export interface EyesHealth {
  ok: boolean;
  error?: string;
  sdk?: number;
  canScreenshot?: boolean;
  pkg?: string;
  frameWidth?: number;
  frameHeight?: number;
  frameAgeMs?: number;
}

export interface ScreenState {
  appPkg: string;
  appLabel: string;
  screenOn: boolean;
  locked: boolean;
  battery?: number;
}

export interface UiItem {
  text: string;
  cls?: string;
  bounds?: string;
}

export interface UiSnapshot {
  ok: boolean;
  error?: string;
  pkg: string;
  items: UiItem[];
}

export interface Frame {
  bytes: Uint8Array;
  width: number;
  height: number;
  pkg: string;
  /** 这张画面是多久以前拍的（毫秒）；服务宁可不给，也不拿过时的画面冒充现在。 */
  ageMs: number;
}

export interface LookReport {
  /** What the model is told. */
  text: string;
  /** The frame, when one came back and the model can take it. */
  blob?: BlobInput;
  frame?: Frame;
}

interface RawResponse {
  status: number;
  body: Buffer;
  header: (name: string) => string;
}

/** One HTTP GET against a loopback port; JSON or bytes, no external traffic. */
function get(port: number, path: string, timeoutMs: number): Promise<RawResponse> {
  return new Promise((resolve, reject) => {
    const req = httpGet({ host: '127.0.0.1', port, path, timeout: timeoutMs }, (res) => {
      const chunks: Buffer[] = [];
      res.on('data', (chunk: Buffer) => chunks.push(chunk));
      res.on('end', () => {
        resolve({
          status: res.statusCode ?? 0,
          body: Buffer.concat(chunks),
          header: (name: string) => {
            const value = res.headers[name.toLowerCase()];
            return Array.isArray(value) ? (value[0] ?? '') : (value ?? '');
          },
        });
      });
    });
    req.on('timeout', () => req.destroy(new Error(`看屏幕超时（${timeoutMs}ms）`)));
    req.on('error', (err) => reject(err));
  });
}

async function getJson<T>(port: number, path: string, timeoutMs = 8000): Promise<T | null> {
  try {
    const res = await get(port, path, timeoutMs);
    if (res.status !== 200) return null;
    return JSON.parse(res.body.toString('utf8')) as T;
  } catch {
    return null;
  }
}

const flat = (value: unknown, max = 200): string => {
  if (typeof value !== 'string') return '';
  const text = value.replace(/\s+/g, ' ').trim();
  return text.length <= max ? text : `${text.slice(0, max)}…`;
};

/** Talks to the accessibility service; every call is independent and never throws. */
export class EyesClient {
  constructor(private readonly port: () => number) {}

  async health(): Promise<EyesHealth> {
    const body = await getJson<EyesHealth>(this.port(), '/health', 4000);
    if (!body) return { ok: false, error: '眼睛服务没在跑（无障碍可能没打开）' };
    return body;
  }

  async state(): Promise<ScreenState | null> {
    const body = await getJson<{ app?: { pkg?: string; label?: string }; screen?: { on?: boolean; locked?: boolean }; power?: { level?: number } }>(SENSE_PORT, '/state', 4000);
    if (!body) return null;
    return {
      appPkg: flat(body.app?.pkg, 120),
      appLabel: flat(body.app?.label, 60),
      screenOn: body.screen?.on !== false,
      locked: body.screen?.locked === true,
      battery: typeof body.power?.level === 'number' ? body.power.level : undefined,
    };
  }

  async ui(): Promise<UiSnapshot> {
    const body = await getJson<{ ok?: boolean; pkg?: string; items?: Array<{ t?: string; c?: string; b?: string }> }>(this.port(), '/ui', 6000);
    if (!body) return { ok: false, error: '读不到屏幕上的文字', pkg: '', items: [] };
    const items: UiItem[] = [];
    for (const raw of body.items ?? []) {
      const text = flat(raw?.t, 160);
      if (!text) continue;
      items.push({ text, cls: flat(raw?.c, 40), bounds: flat(raw?.b, 40) });
      if (items.length >= 120) break;
    }
    return { ok: body.ok !== false, pkg: flat(body.pkg, 120), items };
  }

  async frame(maxWidth: number, quality: number): Promise<Frame | null> {
    try {
      const res = await get(this.port(), `/screen.jpg?max=${Math.max(160, Math.min(2160, Math.round(maxWidth)))}&q=${Math.max(20, Math.min(95, Math.round(quality)))}`, 12000);
      if (res.status !== 200 || res.body.length === 0) return null;
      return {
        bytes: new Uint8Array(res.body),
        width: Number.parseInt(res.header('x-width'), 10) || 0,
        height: Number.parseInt(res.header('x-height'), 10) || 0,
        pkg: flat(res.header('x-pkg'), 120),
        ageMs: Number.parseInt(res.header('x-age-ms'), 10) || 0,
      };
    } catch {
      return null;
    }
  }

  async openSettings(): Promise<boolean> {
    const body = await getJson<{ ok?: boolean }>(this.port(), '/open_settings', 4000);
    return !!body?.ok;
  }
}

/** How the person's screen is described to the model. */
function describeFrame(appLabel: string, appPkg: string, frame: Frame | null, texts: readonly string[]): string {
  const where = appLabel && appPkg ? `${appLabel}（${appPkg}）` : appLabel || appPkg || '未知应用';
  const size = frame ? `，画面 ${frame.width}×${frame.height}` : '';
  const fresh = frame
    ? (frame.ageMs > 1200 ? `（画面是 ${(frame.ageMs / 1000).toFixed(1)} 秒前拍的）` : '（画面就是此刻的）')
    : '';
  const head = `[画面] 你现在看着：${where}${size}${fresh}。`;
  const shown = texts.slice(0, 40);
  const body = shown.length ? `屏幕上能读到的字：${shown.join(' ∣ ')}` : '屏幕上没有能读到的文字（多半是视频或图片）。';
  return `${head}${body}`;
}

interface WatcherDeps {
  host: () => WorldHost | null;
  log: () => Logger | null;
  cfg: () => EyesConfig;
  timezone: () => string;
  client: EyesClient;
  /** Called once when the eyes turn out to be unavailable, and again when they come back. */
  onAvailability: (available: boolean, detail: string) => void;
}

/** Polls the cheap side of the eyes and wakes the pet when there is something to look at. */
export class EyesWatcher {
  private timer: ReturnType<typeof setInterval> | null = null;
  private busy = false;
  private lastSignature = '';
  private lastPushAt = 0;
  private sceneSince = 0;
  private seenScene = false;
  private available: boolean | null = null;

  constructor(private readonly deps: WatcherDeps) {}

  start(): void {
    if (this.timer) return;
    const interval = Math.max(5, this.deps.cfg().intervalSec) * 1000;
    this.timer = setInterval(() => void this.tick(), interval);
    if (typeof this.timer.unref === 'function') this.timer.unref();
  }

  stop(): void {
    if (this.timer) clearInterval(this.timer);
    this.timer = null;
  }

  /** Everything the watcher knows, for the console's state view. */
  state(): Record<string, unknown> {
    return {
      enabled: this.deps.cfg().enabled,
      refreshMs: Math.max(5, this.deps.cfg().intervalSec) * 1000,
      minGapSec: this.deps.cfg().minGapSec,
      sameSceneSec: this.deps.cfg().sameSceneSec,
      attach: this.deps.cfg().attach,
      available: this.available,
      watching: this.timer !== null,
      lastPushAgoSec: this.lastPushAt ? Math.round((Date.now() - this.lastPushAt) / 1000) : null,
    };
  }

  private setAvailable(next: boolean, detail: string): void {
    if (this.available === next) return;
    this.available = next;
    this.deps.onAvailability(next, detail);
  }

  /** One look at the cheap side; pushes an event when the moment is right. */
  async tick(): Promise<void> {
    if (this.busy) return;
    const cfg = this.deps.cfg();
    if (!cfg.enabled) return;
    this.busy = true;
    try {
      const health = await this.deps.client.health();
      if (!health.ok) {
        this.setAvailable(false, health.error ?? '眼睛服务没在跑');
        return;
      }
      this.setAvailable(true, '看得到');
      const state = await this.deps.client.state();
      if (state) {
        if (!state.screenOn || state.locked) {
          this.resetScene();
          return;
        }
        if (state.appPkg === SELF_PACKAGE) {
          this.resetScene();
          return;
        }
      }
      const ui = await this.deps.client.ui();
      if (!ui.ok && ui.items.length === 0) return;
      const appPkg = ui.pkg || state?.appPkg || '';
      const appLabel = state && state.appPkg === appPkg ? state.appLabel : '';
      if (appPkg === SELF_PACKAGE) {
        this.resetScene();
        return;
      }
      const texts = ui.items.map((item) => item.text).filter((text) => text.length > 0);
      const signature = createHash('sha1')
        .update(`${appPkg}|${texts.slice(0, 30).join('¦')}`)
        .digest('hex');
      const now = Date.now();
      const changed = signature !== this.lastSignature;
      if (!this.seenScene) {
        // 第一眼只用来认清当前的画面，不吵人。
        this.seenScene = true;
        this.lastSignature = signature;
        this.sceneSince = now;
        return;
      }
      if (changed) {
        this.lastSignature = signature;
        this.sceneSince = now;
      }
      const gapOk = this.lastPushAt === 0 || now - this.lastPushAt >= Math.max(20, cfg.minGapSec) * 1000;
      if (!gapOk) return;
      const dueForChange = changed;
      const dueForStay = !changed && this.sceneSince > 0 && now - this.sceneSince >= Math.max(30, cfg.sameSceneSec) * 1000;
      if (!dueForChange && !dueForStay) return;
      const frame = cfg.attach ? await this.deps.client.frame(cfg.maxWidth, cfg.quality) : null;
      const text = `${describeFrame(appLabel, appPkg, frame, texts)}${frame ? '' : '（这次没取到画面，只有屏幕上的字。）'}`;
      const blobs: BlobInput[] | undefined = frame ? [{
        bytes: frame.bytes,
        mime: 'image/jpeg',
        name: 'screen.jpg',
        fallbackText: '（一张手机屏幕的截图）',
      }] : undefined;
      this.lastPushAt = Date.now();
      this.sceneSince = this.lastPushAt;
      const host = this.deps.host();
      if (!host) return;
      await host.pushEvent({
        type: 'desktop-pet.eyes',
        source: 'desktop-pet',
        senderKey: 'desktop-pet.eyes',
        ts: nowIso(this.deps.timezone()),
        text,
        ...(blobs ? { blobs } : {}),
      }, { trigger: 'flush' });
      this.deps.log()?.info('看了一眼屏幕', { app: appPkg, changed, attached: !!frame });
    } catch (err) {
      this.deps.log()?.warn(`看屏幕出错：${(err as Error)?.message ?? err}`);
    } finally {
      this.busy = false;
    }
  }

  private resetScene(): void {
    this.lastSignature = '';
    this.sceneSince = 0;
    this.seenScene = false;
  }
}

/** `eyes_look`: the model's on-demand look. */
export async function look(client: EyesClient, cfg: () => EyesConfig, opts: { detail?: string; attach?: boolean } = {}): Promise<LookReport> {
  const health = await client.health();
  if (!health.ok) {
    return {
      text: `[eyes_look 没看成] ${health.error ?? '眼睛没在跑'}。`
        + '这是手机系统里的开关：设置 → 无障碍 → 已安装的服务 → Coopanion 眼睛，打开它再试；'
        + '也可以用 eyes_open_settings 直接把那一页打开给对方。',
    };
  }
  if (health.canScreenshot === false) {
    return { text: `[eyes_look 没看成] 这台机器的系统版本不给后台截屏（Android ${health.sdk ?? '?'}）。` };
  }
  const detail = typeof opts.detail === 'string' ? opts.detail : 'both';
  const state = await client.state();
  const ui = detail === 'screen' ? { ok: true, pkg: '', items: [] } : await client.ui();
  const appPkg = ui.pkg || state?.appPkg || health.pkg || '';
  const appLabel = state && state.appPkg === appPkg ? state.appLabel : '';
  const texts = (ui.items ?? []).map((item) => item.text).filter((text) => text.length > 0);
  const wantFrame = detail !== 'text' && opts.attach !== false && cfg().attach;
  const frame = wantFrame ? await client.frame(cfg().maxWidth, cfg().quality) : null;
  if (!frame && detail !== 'text') {
    return {
      text: `${describeFrame(appLabel, appPkg, null, texts)}这次真没拍到画面（多半是刚好撞上系统的截屏频率限制）。`
        + '不要拿更早那张旧画面当作现在——可以等一下再 eyes_look 一次，或者直接告诉对方这会儿没看清。',
    };
  }
  return {
    text: describeFrame(appLabel, appPkg, frame, texts),
    ...(frame ? {
      frame,
      blob: { bytes: frame.bytes, mime: 'image/jpeg', name: 'screen.jpg', fallbackText: '（一张手机屏幕的截图）' } as BlobInput,
    } : {}),
  };
}
