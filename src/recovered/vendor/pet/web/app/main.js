/**
 * 装配层（重写版）：把「世界 / 桌面 / 界面 / 对话 / 照顾 / 通道」接在一起。
 *
 * 规矩：
 *   - 这个文件里不写功能细节，只接线；每个功能一个模块。
 *   - 全页面只有一处 requestAnimationFrame 循环、一处 pointerdown/move/up。
 *   - 原生只认 window.__petUnionRect()（所有可见元素的并集）。
 */

import { createSfx, applyTheme, normalizeSkin, skinCss, PALETTES, HEAD_TOP } from '../pet-core.js';
import { PetWorld, MAX_PETS } from '../pet-multi.js';
import { DeskFloor } from '../pet-desk.js';
import { PetNet } from './net.js';
import { Talk } from './talk.js';
import { Ui } from './ui.js';
import { Care } from './care.js';
import { KeyboardFloor } from './keyboard.js';
import { skinFor, skinCssFor, saveSkin } from './skins.js';

const $ = (s) => document.querySelector(s);
const host = window.petHost || null;
document.body.classList.add(host ? 'desk' : 'tab');

const stage = $('#stage');
const menuEl = $('#menu');
const toolsEl = $('#tools');
const sfx = createSfx();
if (host) sfx.unlock();
else ['pointerdown', 'keydown'].forEach((ev) => document.addEventListener(ev, () => sfx.unlock(), { capture: true }));

/* ---------------- 偏好（本地 + 服务端） ---------------- */

const prefs = {
  roam: 'calm', sound: true, theme: document.documentElement.dataset.theme || 'dark', scale: 1,
  count: 1, chatter: 0, desk: true, hoverButtons: ['chat', 'voice'], bot: null, voice: null, user: '伙伴',
};
function loadPrefs() {
  try {
    const n = Number(localStorage.getItem('cortico.pet.count'));
    if (n > 0) prefs.count = Math.max(1, Math.min(MAX_PETS, n));
    prefs.desk = localStorage.getItem('cortico.desk') !== 'off';
    prefs.chatter = Number(localStorage.getItem('cortico.chatter.min')) || 0;
    prefs.sound = localStorage.getItem('cortico-pet.sound.v1') !== 'off';
    const skinRaw = localStorage.getItem('cortico.skin');
    if (skinRaw) prefs.skin = JSON.parse(skinRaw);
  } catch (e) {}
}
loadPrefs();

/* ---------------- 世界：N 只 + 指针 + 并集 ---------------- */

let ui = null, care = null, talk = null;
/** 键盘地面：原生量高度 → 这里抬地面 + 画 3px 的墙（手指穿透）。 */
const kb = new KeyboardFloor({ prefs, gap: () => (host ? 2 : 48) }).install();

const floorGap = () => (host ? 2 : 48);
/** 键盘弹出时地面被顶起来（raise），两只都站到键盘上面。 */
const stageBounds = () => ({
  W: innerWidth,
  H: innerHeight,
  // 地面 = 舞台底 - 键盘抬升（锁安回去了：最低 120px、抬升不超过 60% 屏高）
  floorY: Math.max(120, innerHeight - floorGap() - (kb ? kb.raise : 0)),
  S: .42 * prefs.scale,
});

/** 触摸区要盖住的东西：宠物本体（world 自己算）+ 气泡 + 菜单/按钮 + 铁盆。 */
const uiBoxes = () => {
  const list = [];
  try { if (ui) list.push(...ui.anyBubble()); } catch (e) {}
  if (menuEl && !menuEl.hidden) list.push(menuEl);
  if (toolsEl && !toolsEl.hidden) list.push(toolsEl);
  try { if (care) list.push(...care.boxes()); } catch (e) {}
  return list;
};

const net = new PetNet({
  hostMode: !!host,
  screen: () => ({ w: innerWidth, h: innerHeight }),
  onOrder: (m) => onOrder(m),
});

const world = new PetWorld({
  svg: $('#stageSvg'),
  host: document.body,
  sfx,
  roam: prefs.roam,
  bounds: stageBounds,
  uiBoxes,
  dialogOpen: () => !!(talk && talk.talking),
  onEvent: (unit, kind, d) => onUnitEvent(unit, kind, d),
  onSay: () => false,                       // 和气说话统一走 Talk
});
world.ensure(prefs.count);
const primary = () => world.primary;

/** 新加进来的那只也要穿上现在的皮。 */
function syncSkins() { applySkins(); }

/** 第 1 只的动作要回传给 World（到达/被打断/被摸）；其它的只做本地反应。 */
function onUnitEvent(unit, kind, d) {
  if (unit !== world.primary) {
    if (kind === 'touch' && d?.kind === 'poke') unit.mood = 'happy';
    return;
  }
  if (kind === 'arrived' || kind === 'interrupted') {
    if (!d?.walkId) return;
    net.send({ t: kind, walkId: d.walkId, x: d.x / innerWidth, by: d.by });
    if (walking && walking.id === d.walkId) walking = null;
  } else if (kind === 'touch') {
    net.send({ t: 'touch', ...d });
    if (d?.kind === 'grab') ui?.closeMenu();
    ui?.bubbleFor(unit).unit && void 0;
  }
}

/** 每只宠物自己的形象（figure 对象内部绑定 petG，不能几只共用一份）。 */
const figures = new Map();
async function applyFigure(unit, skin) {
  const kind = skin?.figure || 'coo';
  const cur = figures.get(unit);
  if (kind === 'coo') {
    if (cur) { try { unit.setFigure(null); } catch (e) {} figures.delete(unit); }
    return;
  }
  const scheme = skin?.scheme || '';
  if (cur && cur.kind === kind) {
    // 同一种形象但换了配色/服装：必须真的 setScheme（否则就是"换配色没反应"）
    if (kind === 'whale' && scheme !== cur.scheme && cur.fig?.setScheme) {
      cur.scheme = scheme;
      try { await cur.fig.setScheme(scheme, { fade: unit.ct.figure === cur.fig ? .35 : 0, at: unit.ct.time }); } catch (e) {}
    }
    return;
  }
  let fig = null;
  try {
    if (kind === 'whale') {
      const m = await import('../whale/figure.js');
      fig = await m.createWhaleFigure(undefined, { scheme: skin.scheme });
    }
  } catch (e) { console.error('[pet] 形象加载失败:', kind, e); return; }
  if (!fig) return;
  if ((prefs.skin?.figure || 'coo') !== kind) return;      // 加载期间又换了
  figures.set(unit, { kind, fig, scheme });
  try { unit.setFigure(fig); } catch (e) {}
}

/** 每只的装扮：服务端为准（第 1 只 prefs.skin，第 2 只 prefs.skin2）。 */
function skinOf(unit) { return skinFor(unit.id, prefs); }

/** 把每只的装扮套上（皮肤 + 颜色变量 + 形象），颜色按只作用域，互不串味。 */
function applySkins() {
  const pairs = [];
  for (const u of world.pets) {
    const skin = skinOf(u);
    pairs.push([u.id, skin]);
    try { u.setSkin(skin); } catch (e) {}
    void applyFigure(u, skin);
  }
  const style = document.getElementById('skin-style');
  if (style) style.textContent = skinCssFor(pairs);
}

/** 页面内快捷换配色：给「当前那只」挑一个配色，立刻生效 |
 *  (不用开装扮页——装扮页是浏览器里的另一个 App，回来还要绕服务端) */
function quickPalette() {
  const unit = world.active || world.primary;
  const base = skinOf(unit);
  const options = PALETTES.map((p) => ({ label: p.label, color: [p.l[1], p.d[1]], id: p.id }));
  ui.bubbleFor(unit).ask(`给第 ${unit.id} 只换配色`, options, {
    own: false,
    onPick: (ans) => {
      if (!ans || ans.index == null) return;
      const pal = options[ans.index];
      if (!pal) return;
      applySkinFor(unit.id, { ...base, palette: pal.id });
      try { sfx.sparkle?.(); } catch (e) {}
    },
  });
}

/** 页面内换皮：立刻穿上 + 让服务端记住（哪一只）。 */
function applySkinFor(id, skin) {
  if (id === 1) prefs.skin = skin; else prefs.skin2 = skin;
  applySkins();
  saveSkin(skin, id);
}

/* ---------------- 桌面（P4：图标 = 分层地面，墙是数据） ---------------- */

const desk = new DeskFloor(world, { enabled: () => prefs.desk !== false });
window.onDeskTargets = (json) => { try { desk.apply(json); } catch (e) {} };

/* ---------------- 界面 / 对话 / 照顾 ---------------- */

const chatterState = { timer: 0 };
function getChatter() { return Number(prefs.chatter) || 0; }
function setChatter(minutes) {
  const n = Number(minutes) || 0;
  prefs.chatter = n;
  try { localStorage.setItem('cortico.chatter.min', String(n)); } catch (e) {}
  if (chatterState.timer) { clearInterval(chatterState.timer); chatterState.timer = 0; }
  if (n > 0) {
    chatterState.timer = setInterval(() => {
      net.send({ t: 'text', text: '（现在主动跟主人搭一句话）' });
    }, Math.max(20000, Math.round(n * 60000)));
  }
}

care = new Care({
  world,
  primary,
  sfx,
  onFeed: () => net.send({ t: 'feed' }),
  hexi: (t, ms) => ui?.bubbleFor(primary()).say(t, ms),
});

talk = new Talk({
  world,
  primary,
  sfx,
  send: (msg) => net.send(msg),
  bubbleFor: (unit) => ui.bubbleFor(unit || primary()),
  onInput: (text) => net.send({ t: 'text', text }),
  onActions: (a) => { if (a) acts.push(a); },
});

const uiDeps = {
  world,
  openDressFor,
  prefs,
  net,
  talk,
  care,
  sfx,
  host,
  setChatter,
  getChatter,
  onDeskToggled: () => { if (prefs.desk === false) for (const u of world.pets) u.clearFloor(); },
  onCountChanged: () => { syncSkins(); net.send({ t: 'prefs', count: world.count }); },
  applySkinFor,
  quickPalette,
};
ui = new Ui(uiDeps);

try { if (prefs.chatter > 0) setChatter(prefs.chatter); } catch (e) {}

// 装扮页在浏览器里（另一个 App），没有跨窗口通道——它的改动经服务端 prefs 广播回来（上面 applyPrefs 处理）。

/** 打开装扮页之前记下「给哪一只换」：装扮页读 cortico.dress.pet。 */
function openDressFor(unit) {
  const id = (unit && unit.id) || 1;
  prefs.count = world.count;
  try { localStorage.setItem('cortico.pet.count', String(world.count)); } catch (e) {}
  try { localStorage.setItem('cortico.dress.pet', String(id)); } catch (e) {}
  if (prefs.bot?.buttons?.dress) { net.send({ t: 'control', action: 'dress' }); return; }
  if (host?.openDress) { host.openDress(); return; }
  window.open(`/dress?pet=${id}`, '_blank');
}

/* ---------------- 语音（原生桥在就用，没有就静默） ---------------- */

if (typeof petVoiceNative !== 'undefined' && !window.PetVoice) {
  window.PetVoice = {
    available() { try { return !!petVoiceNative.available(); } catch (e) { return false; } },
    start() { try { petVoiceNative.start(); } catch (e) {} },
    stop() { try { petVoiceNative.stop(); } catch (e) {} },
    cancel() { try { petVoiceNative.cancel(); } catch (e) {} },
  };
}
/** 把一句话当「用户说的」送进对话（打字、语音桥都走这里）。 */
window.__petType = (text) => {
  const v = String(text ?? '').replace(/\s+/g, ' ').trim();
  if (!v) return false;
  net.send({ t: 'text', text: v });
  return true;
};
window.__petVoiceResult = (kind, text, detail) => {
  if (kind === 'final') return window.__petType(text);
  if (kind === 'error' && detail) { try { console.warn('[pet] voice:', detail); } catch (e) {} }
  return false;
};

/* ---------------- 下行指令 ---------------- */

let walking = null;

function onOrder(m) {
  switch (m.t) {
    case 'init':
    case 'prefs':
      applyPrefs(m);
      break;
    case 'say':
      talk.dropAsks();
      talk.say(m.beats, { from: m.from });
      primary().ct.holdRoam(20);
      break;
    case 'ask':
      talk.ask(m);
      primary().ct.holdRoam(20);
      break;
    case 'confirm':
      talk.confirm(m);
      primary().ct.holdRoam(20);
      break;
    case 'walk': {
      const x = m.to === 'cursor' ? (lastPointer.x || innerWidth / 2) : Math.max(0, Math.min(1, Number(m.to))) * innerWidth;
      const u = primary();
      u.ct.holdRoam(20);
      walking = { id: m.id };
      if (!u.ct.walkTo(x, !!m.run, m.id)) {
        walking = null;
        net.send({ t: 'interrupted', walkId: m.id, x: u.pet.x / innerWidth, by: u.pet.mode });
      }
      break;
    }
    case 'act':
      acts.push(...(m.actions || []));
      primary().ct.holdRoam(20);
      break;
    case 'thinking':
      primary().ct.setThinking(!!m.on);
      break;
    case 'listen':
      onListen(m);
      break;
    case 'openApp': {
      let ok = false, detail = '';
      try {
        if (host && typeof host.openApp === 'function') {
          ok = !!host.openApp(m.name);
          detail = ok ? '已发起打开' : '没找到这个应用';
        } else detail = '当前环境不支持打开应用';
      } catch (e) { detail = '打开失败: ' + e; }
      net.send({ t: 'openAppResult', id: m.id, ok, detail });
      break;
    }
    case 'deskTargets':
      desk.apply(m);
      break;
    case 'dialog':
    case 'dialog-update':
    case 'dialog-close':
      // 应用会话卡片（.d-* 那套）还没搬过来：先记一笔，不装作演了。
      console.warn('[pet] dialog steps 还没搬进重写版：', m.id);
      break;
    default:
      break;
  }
}

let countFromServer = false;
function applyPrefs(p) {
  if (p.skin) { prefs.skin = normalizeSkin(p.skin); applySkins(); }
  if ('skin2' in p) { prefs.skin2 = p.skin2 ? normalizeSkin(p.skin2) : null; applySkins(); }
  if (p.roam) { prefs.roam = p.roam; world.setRoam(p.roam); }
  if (typeof p.sound === 'boolean') { prefs.sound = p.sound; sfx.set(p.sound); }
  if (p.theme === 'dark' || p.theme === 'light') { prefs.theme = p.theme; applyTheme(p.theme); }
  if (typeof p.scale === 'number') { prefs.scale = p.scale; world.tick(0); }
  if (typeof p.count === 'number' && !countFromServer) {
    // 服务端快照里永远带 count（默认 1），换装保存皮肤也会广播一次——照单全收会把第 2 只送走。
    countFromServer = true;
    let hasLocal = false;
    try { hasLocal = Number(localStorage.getItem('cortico.pet.count')) > 0; } catch (e) {}
    if (!hasLocal) {
      prefs.count = Math.max(1, Math.min(MAX_PETS, p.count));
      world.ensure(prefs.count);
      applySkins();
    }
  }
  if (typeof p.user === 'string') prefs.user = p.user;
  if (Array.isArray(p.hoverButtons)) prefs.hoverButtons = p.hoverButtons.filter((x) => typeof x === 'string');
  if (p.bot) { prefs.bot = p.bot; if (ui.menuOpen) ui.renderHead(); }
  if (typeof p.thinking === 'boolean') primary().ct.setThinking(p.thinking);
  ui.refresh();
}

/* ---------------- 行动队列（World 让做的一串动作） ---------------- */

const ACT_LONG = { look: 2.7, walk: 12, run: 12 };
const acts = [];
let actWait = null, actUntil = 0;

function runAction(a) {
  const u = primary();
  if (u.ct.act(a)) return ACT_LONG[a] ?? 1.2;
  return 1;
}

function stepActs(dt) {
  const now = primary().ct.time;
  if (actWait || now < actUntil || !acts.length) return;
  if (primary().ct.busy()) return;
  const a = acts.shift();
  actUntil = now + runAction(a);
  primary().ct.holdRoam(15);
}

/* ---------------- 听（语音/打字上屏的临时状态） ---------------- */

function onListen(m) {
  const phase = m.phase || 'off';
  const unit = primary();
  if (phase === 'off') { ui.heard.hide(); unit.ct.setListening(false); return; }
  unit.ct.setListening(phase === 'hearing');
  if (m.hint) ui.heardSay(m.hint, 3000);
}

/* ---------------- 指针：点谁谁应，按下的那只独占拖拽 ---------------- */

const lastPointer = { x: 0, y: 0 };
let pressing = false;
let interactive = null;

function setInteractive(on) {
  if (!host || interactive === on) return;
  interactive = on;
  host.setInteractive(on);
}
const UI_SELECTOR = '.bubble:not([hidden]), .menu:not([hidden]), .tools:not([hidden]), #petBowl';
const overUi = (e) => e.target.closest?.(UI_SELECTOR);

document.addEventListener('pointermove', (e) => {
  lastPointer.x = e.clientX;
  lastPointer.y = e.clientY;
  const p = { x: e.clientX, y: e.clientY };
  lastPointer.at = p;
  stage.style.cursor = world.pointerMove(p);
  setInteractive(!!world.pressing || overUi(e) || !!world.hit(p));
});

host?.onCursor?.((p) => {
  if (!p) { if (!world.pressing) setInteractive(false); lastPointer.at = null; return; }
  lastPointer.at = p;
  const el = document.elementFromPoint(p.x, p.y);
  setInteractive(!!world.pressing || !!world.hit(p) || !!el?.closest?.(UI_SELECTOR));
});

stage.addEventListener('pointerdown', (e) => {
  if (e.button !== 0) return;
  ui.closeMenu();
  const unit = world.pointerDown({ x: e.clientX, y: e.clientY });
  pressing = !!world.pressing;
  if (unit) {
    if (pressing) {
      try { stage.setPointerCapture(e.pointerId); } catch (err) {}
      e.preventDefault();
    }
  }
});
const up = () => { world.pointerUp(); pressing = false; stage.style.cursor = ''; };
stage.addEventListener('pointerup', up);
stage.addEventListener('pointercancel', up);
document.addEventListener('pointerleave', () => { lastPointer.at = null; world.pointerLeave(); });

stage.addEventListener('dblclick', (e) => {
  const unit = world.hit({ x: e.clientX, y: e.clientY });
  if (!unit) return;
  if (unit === world.primary) talk.input();
  else if (Math.random() < 0.25) unit.say('嘿嘿～', 2400);
});
document.addEventListener('contextmenu', (e) => {
  e.preventDefault();
  const unit = world.hit({ x: e.clientX, y: e.clientY });
  if (!unit) return;
  world.active = unit;
  ui.openMenu(e.clientX, e.clientY);
});
document.addEventListener('focusin', (e) => {
  if (e.target.matches?.('input, textarea')) host?.focus?.();
});

/* ---------------- 循环：一处 rAF ---------------- */

let last = performance.now();
function frame(now) {
  const dt = Math.max(0, Math.min(.05, (now - last) / 1000));
  last = now;
  stepActs(dt);
  kb.step(dt);
  desk.tick(dt);
  world.tick(dt);
  talk.step(dt);
  ui.step(dt, lastPointer.at, world.pressing);
  ui.layout();
  requestAnimationFrame(frame);
}

/* ---------------- 调试钩子（生产保留：一条 JS 就能核对现场） ---------------- */


window.__petUnionRect = () => world.unionString();
window.__petCount = () => world.count;
window.__petBoxes = () => world.pets.map((p) => {
  const b = p.visualBox();
  return b ? [p.id, Math.round(b.l), Math.round(b.t), Math.round(b.r), Math.round(b.b)] : [p.id, 0, 0, 0, 0];
});
window.__petDebug = () => world.pets.map((u) => ({
  id: u.id, x: Math.round(u.pet.x), fy: Math.round(u.pet.fy), mode: u.pet.mode,
  floorY: Math.round(world.bounds().floorY), ground: Math.round(u.ct.ground),
}));
window.__desk = () => desk.debug();
window.__kbState = () => (kb ? { up: kb.up, target: Math.round(kb.target), lift: Math.round(kb.lift), via: kb.via } : null);
window.__talk = () => (talk.item ? { kind: talk.item.kind, queued: talk.queue.length } : { kind: null, queued: talk.queue.length });
window.petApp = { world, desk, ui, talk, care, net, prefs };

/* ---------------- 启动 ---------------- */

applyTheme(prefs.theme);
// 浏览器里预览（?offline=1）：不连 World，免得把真正的桌宠页顶掉
if (new URLSearchParams(location.search).get('offline') !== '1') net.connect();
world.tick(0);
requestAnimationFrame(frame);

addEventListener('resize', () => { world.tick(0); });
