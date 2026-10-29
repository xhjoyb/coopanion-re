/**
 * The pet page. Connects to the World over `/socket?role=pet`, runs the body from pet-core,
 * and turns World orders (say, ask, walk, act, listen, and the steps of an app's conversation)
 * into bubbles and motion. It reports back only what happened on screen: arrivals, answers,
 * touches, typed text, and 16 kHz microphone audio while voice input is on.
 *
 * In the pet window (`window.petHost` from the preload) the page is transparent and the
 * window ignores the mouse except over the figure, a bubble, the menu or the hover buttons.
 * Colors follow the World's `theme` through `data-theme` on the root element.
 */
import { applyTheme, createSfx, clamp, f, mini, normalizeSkin, skinCss, skinVars, PALETTES, EXPRESSIONS, HEAD_TOP, ICONS, FIGURES } from './pet-core.js';
import { PetWorld, MAX_PETS } from './pet-multi.js';
import { figureHost } from './figure-host.js';

const $ = (s) => document.querySelector(s);
const host = window.petHost || null;

// ---- 安卓：手机自带语音识别（原生桥 petVoiceNative）与"文字注入"通道 ----
// 桌面版没有 petVoiceNative，这里整块都不生效。
if (typeof petVoiceNative !== 'undefined' && !window.PetVoice) {
  window.PetVoice = {
    available() { try { return !!petVoiceNative.available(); } catch (e) { return false; } },
    start() { try { petVoiceNative.start(); } catch (e) {} },
    stop() { try { petVoiceNative.stop(); } catch (e) {} },
    cancel() { try { petVoiceNative.cancel(); } catch (e) {} },
  };
}
// 把一句话当成"用户说的"送进对话（和打字发送同一条通道）
window.__petType = function (text) {
  const v = String(text == null ? '' : text).replace(/\s+/g, ' ').trim();
  if (!v) return false;
  send({ t: 'text', text: v });
  return true;
};
// 安卓语音桥的回调（VoiceBridge.java 里 evaluateJavascript 调的就是它）
window.__petVoiceResult = function (kind, text, detail) {
  if (kind === 'final') return window.__petType(text);
  if (kind === 'error' && detail) { try { console.warn('[pet] voice:', detail); } catch (e) {} }
  return false;
};

document.body.classList.add(host ? 'desk' : 'tab');

const stage = $('#stage');
const bubble = $('#bubble'), heardEl = $('#heard'), trail = $('#trail'), menu = $('#menu');
const tools = $('#tools');
const skinStyle = document.createElement('style');
document.head.appendChild(skinStyle);

const prefs = {
  roam: 'calm', sound: true, theme: document.documentElement.dataset.theme, scale: 1, user: '伙伴', mic: false, micDevice: '', bot: null,
  /** Voice input: switched on, recognizer ready, why not, how to talk, and the mode in force. */
  voice: { enabled: false, ready: false, detail: null, hint: '', mode: 'hold' },
  /** The actions shown as buttons beside the pet on hover. */
  hoverButtons: ['chat', 'voice'],
  /** 键盘：目标抬升 / 当前抬升（CSS px，缓动）。 */
  kbTarget: 0, kbLift: 0, ime: false,
};
const sfx = createSfx();
if (host) sfx.unlock();
else ['pointerdown', 'keydown'].forEach((ev) => document.addEventListener(ev, () => sfx.unlock(), { capture: true }));

const floorGap = () => (host ? 30 : 48);   // 悬浮窗模式站高 30px：别让触摸区压住底部手势条
/** 键盘弹出时地面被顶起来（kbLift），桌宠就站到键盘上面（不再隐藏）。 */
const stageBounds = () => ({
  W: innerWidth,
  H: innerHeight,
  // 地面 = 舞台底 - 键盘抬升（锁安回去了：最低 120px、抬升不超过 60% 屏高）
  floorY: Math.max(120, innerHeight - floorGap() - (prefs.kbLift || 0)),
  S: .42 * prefs.scale,
});

/* ---------- 一个页面养 N 只：唯一的渲染循环、指针路由与并集上报（见 pet-multi.js） ---------- */
const world = new PetWorld({
  svg: $('#stageSvg'),
  host: document.body,
  sfx,
  roam: prefs.roam,
  bounds: stageBounds,
  dialogOpen: () => !!item || !!listen.phase,
  onEvent: (unit, kind, d) => {
    if (kind === 'touch') noteAttention(unit);
    return unit === world.primary ? onBody(kind, d) : onExtraEvent(unit, kind, d);
  },
  onSay: (unit, text, ms) => onUnitSay(unit, text, ms),
  uiBoxes: () => {
    const list = [bubble, heardEl, tools];
    try { for (const el of menus.values()) list.push(el); } catch (e) {}
    try { for (const u of world.pets) if (u.els.bubbleEl) list.push(u.els.bubbleEl); } catch (e) {}
    try { const bowl = document.getElementById('petBowl'); if (bowl) list.push(bowl); } catch (e) {}
    return list;
  },
});
world.ensure(1);
const ctl = world.primary.ct;          // 第 1 只：正式对话、菜单、喂食都跟着它
/** 每只最近一次被理的时间（点/拖都算）：被冷落久了的那只会吃醋。 */
const attention = { 1: Date.now(), 2: 0, 3: 0, 4: 0 };
function noteAttention(unit) { if (unit) attention[unit.id] = Date.now(); }

/** 第 1 只之外的宠物：它们说话用自己的气泡，动作不回传给 World。 */
/** 第 1 只之外的宠物被戳时：**偶尔**才应一句（每只 12 秒冷却，25% 概率），别每次都吵。 */
const pokeCool = new Map();
const POKE_COOL_MS = 12000;
const POKE_CHANCE = 0.25;
/** 要不要回话（纯逻辑，便于测试/调试）。命中就顺手记下冷却。 */
function pokeReply(unitId, now = Date.now(), rand = Math.random()) {
  const last = pokeCool.get(unitId) || 0;
  if (now - last < POKE_COOL_MS || rand > POKE_CHANCE) return false;
  pokeCool.set(unitId, now);
  return true;
}
window.__pokeReply = (unitId, now, rand) => pokeReply(unitId, now, rand);
function onExtraEvent(unit, kind, d) {
  if (kind !== 'touch') return;
  if (d && d.kind === 'poke') {
    unit.setMood('happy');
    if (!pokeReply(unit.id)) return;
    unit.say(EXTRA_LINES.poke[(Math.random() * EXTRA_LINES.poke.length) | 0], 2600);
  } else if (d && (d.kind === 'drop' || d.kind === 'throw')) {
    unit.setMood('surprised');
  }
}

/** 旁白：第 1 只的气泡留给正式对话；正式对话没在开场时才借它说一句。 */
function onUnitSay(unit, text, ms) {
  if (unit !== world.primary) return false;
  if (item || queue.length) return true;
  showBubble1(text, ms);
  return true;
}

/* ---------- 桌宠数量：菜单里加减，存在本地 ----------
 * 数量是页面自己的偏好：服务端每次推 prefs 快照都带 count（world.ts 里是 cfg.count ?? 1），
 * 换装保存皮肤也会触发一次广播 —— 以前这里照单全收，一次广播就把第 2 只送走了。
 * 现在的规则：只有「第一次快照 + 本地没有记录」才采纳服务端的数量；之后数量只由菜单改。 */
// 换新键：从这一版起"出厂默认只有第 1 只"，老版本存过的 2 只不再沿用
const PET_COUNT_KEY = 'cortico.pet.count.v2';
const PET_COUNT_KEY_OLD = 'cortico.pet.count';
let countSeenFromServer = false;
function petsCount() {
  const n = Number(prefs.count) | 0;
  return Math.max(1, Math.min(MAX_PETS, n > 0 ? n : 1));
}
function setPetCount(n) {
  prefs.count = world.ensure(Number(n) || 1);
  try { localStorage.setItem(PET_COUNT_KEY, String(prefs.count)); } catch (e) {}
  applySkins();
  try { send({ t: 'prefs', count: prefs.count }); } catch (e) {}   // 服务端也记一下
  try { refreshButtons(); } catch (e) {}          // 菜单里的「现在 N 只」跟着变
}
function loadPetCount() {
  if (Number(prefs.count) > 0) return;            // 服务端给了就用服务端的
  try {
    const v = Number(localStorage.getItem(PET_COUNT_KEY));
    if (v > 0) { prefs.count = Math.max(1, Math.min(MAX_PETS, v)); return; }
  } catch (e) {}
  prefs.count = 1;
}

/* ---------- 每只一份装扮（服务端为准） ----------
 * 服务端：第 1 只存 skin，第 2 只存 skin2（装扮页 ?pet=2 时 POST 带过来）。
 * 说明：装扮页是原生用浏览器打开的独立 App，localStorage 不互通，所以不能靠本地存储传。
 * 颜色是 CSS 变量：第 1 只写全局（菜单/气泡边框跟它），第 2 只挂在 #pet2 上，互不串味。 */
function skinOf(unit) {
  const fallback = prefs.skin || normalizeSkin(null);
  if (unit.id === 1) return fallback;
  return prefs.skin2 || fallback;
}
function skinCssFor(pairs) {
  let css = '';
  const first = pairs.find(([id]) => id === 1);
  if (first) css += skinCss(first[1]);
  for (const [id, skin] of pairs) {
    if (id === 1) continue;
    const sel = '#pet' + id;
    css += `${sel}{${skinVars(skin, false)}}html[data-theme="dark"] ${sel}{${skinVars(skin, true)}}`;
  }
  return css;
}
/** 第 1 只之外的形象：鲸鱼/狐狸的形象对象各自建一份（不能共用，它内部绑着自己的 <g>）。 */
const extraFigs = new Map();
async function applyExtraFigure(unit, skin) {
  const kind = skin?.figure || 'coo';
  const scheme = skin?.scheme || '';
  const cur = extraFigs.get(unit);
  if (kind === 'coo') { if (cur) { try { unit.setFigure(null); } catch (e) {} extraFigs.delete(unit); } return; }
  if (cur && cur.kind === kind) {
    // 同一种形象：只换了配色/服装也要真的切（以前这里直接 return → 换配色没反应）
    if (kind === 'whale' && scheme !== cur.scheme && cur.fig?.setScheme) {
      cur.scheme = scheme;
      try { await cur.fig.setScheme(scheme, { fade: .35, at: unit.ct.time }); } catch (e) {}
    }
    return;
  }
  let fig = null;
  try {
    if (kind === 'whale') {
      const m = await import('./whale/figure.js');
      fig = await m.createWhaleFigure(undefined, { scheme: skin.scheme });
    }
  } catch (e) { console.warn('[pet] 第 2 只形象加载失败', e); return; }
  if (!fig) return;
  extraFigs.set(unit, { kind, fig, scheme });
  try { unit.setFigure(fig); } catch (e) {}
}
/** 把所有宠物的装扮套上（重画 CSS 变量 + 皮肤 + 形象）。 */
let primaryFigKind = '', primaryFigScheme = '';
function applySkins() {
  const pairs = [];
  for (const u of world.pets) {
    const skin = skinOf(u);
    pairs.push([u.id, skin]);
    try { u.setSkin(skin); } catch (e) {}
    if (u === world.primary) {
      // 第 1 只：形象种类变了、或者鲸鱼换了配色/服装，都要真的重建/切换
      const kind = skin?.figure || 'coo';
      const scheme = skin?.scheme || '';
      if (kind !== primaryFigKind || scheme !== primaryFigScheme) {
        primaryFigKind = kind;
        primaryFigScheme = scheme;
        applyFigure(skin).catch((err) => console.error(err));
      }
    } else {
      void applyExtraFigure(u, skin);
    }
  }
  skinStyle.textContent = skinCssFor(pairs);
}
/** 装扮页保存之后只改这一只。 */
function applySkinFor(id, skin) {
  if (id === 1) prefs.skin = skin; else prefs.skin2 = skin;
  const unit = world.pets.find((u) => u.id === id);
  if (unit) {
    try { unit.setSkin(skin); } catch (e) {}
    if (unit === world.primary) {
      const kind = skin?.figure || 'coo';
      const scheme = skin?.scheme || '';
      if (kind !== primaryFigKind || scheme !== primaryFigScheme) {
        primaryFigKind = kind;
        primaryFigScheme = scheme;
        applyFigure(skin).catch((err) => console.error('[pet] 形象切换失败', err));
      }
    } else {
      void applyExtraFigure(unit, skin);
    }
  }
  skinStyle.textContent = skinCssFor(world.pets.map((u) => [u.id, skinOf(u)]));
}
/** 页面内快捷换配色：给「当前那只」换皮，立刻生效，同时存到服务端（下次开机还是它）。 */
/**
 * 世界给的 say 片段是对象：`{ text, actions, anchors }`（旧页面也是这么读的）。
 * 以前这里当成字符串，对象就被拼成 "[object Object]"。
 */
const beatText = (b) => (typeof b === 'string' ? b : String((b && b.text) ?? ''));

/** 在一只自己的气泡里把一段话一段话说出来（不占用第 1 只的对话框）。 */
function sayOnUnit(unit, beats) {
  const list = (Array.isArray(beats) ? beats : [beats]).filter((b) => beatText(b).trim());
  if (!list.length) return;
  let i = 0;
  const next = () => {
    if (i >= list.length || !world.pets.includes(unit)) return;
    const beat = list[i++];
    const text = beatText(beat).trim();
    for (const a of (beat && beat.actions) || []) acts.push(a);      // 边说边做动作
    const ms = Math.min(7000, 1400 + text.length * 90);
    try { unit.say(text, ms); } catch (e) {}
    try { sfx.pop(); } catch (e) {}
    if (i < list.length) setTimeout(next, ms + 120);
  };
  next();
}

/** 当前这份菜单属于哪一只（没有菜单时用当前对象，再退回第 1 只）。 */
function unitOfMenu() {
  const u = menuUnit;
  if (u && world.pets.includes(u)) return u;
  return world.active || world.primary;
}

function quickPalette(target) {
  const unit = target || unitOfMenu();
  const skin = skinOf(unit);
  const list = PALETTES.map((p) => `
    <button class="b-opt pal" type="button" data-pal="${p.id}" aria-pressed="${skin.palette === p.id}">
      <span class="dot" style="--a:${p.l[1]};--b:${p.d[1]}"></span>${p.label}
    </button>`).join('');
  bubble.className = 'bubble ask palette';
  bubble.innerHTML = `<button class="b-close" type="button" aria-label="关闭">×</button>`
    + `<p class="b-text">给第 ${unit.id} 只换配色</p>`
    + `<div class="b-opts pal-row">${list}</div>`;
  bubble.hidden = false;
  item = null;
  const done = () => { bubble.hidden = true; bubble.innerHTML = ''; };
  bubble.querySelector('.b-close').addEventListener('click', done);
  for (const b of bubble.querySelectorAll('.b-opt.pal')) {
    b.addEventListener('click', () => {
      const next = { ...skin, palette: b.dataset.pal };
      const targetId = unit.id;
      if (targetId === 1) prefs.skin = next; else prefs.skin2 = next;
      applySkins();
      try { sfx.sparkle?.(); } catch (e) {}
      try { send({ t: 'prefs', skin: next, skin2: next }); } catch (e) {}
      try { fetch('/api/skin', { method: 'POST', headers: { 'content-type': 'application/json' }, body: JSON.stringify({ skin: next, pet: targetId }) }); } catch (e) {}
      done();
      try { unit.say(`换成「${PALETTES.find((p) => p.id === b.dataset.pal)?.label || ''}」啦`, 3200); } catch (e) {}
    });
  }
}

/* ---------- 并集上报：原生触摸层只需要这一条（P1 验收点） ---------- */
/** 键盘上沿那条 3px 的墙：纯装饰 + 站的地沿；pointer-events:none，手指穿透。 */
const kbWall = document.createElement('div');
kbWall.id = 'kbWall';
kbWall.setAttribute('aria-hidden', 'true');
kbWall.style.cssText = [
  'position:fixed', 'left:0', 'right:0', 'height:3px', 'pointer-events:none', 'z-index:6',
  'opacity:0', 'transition:opacity .12s linear', 'border-radius:2px',
  'background:linear-gradient(90deg,rgba(255,255,255,0) 0%,rgba(210,235,255,.75) 22%,rgba(255,255,255,.9) 50%,rgba(210,235,255,.75) 78%,rgba(255,255,255,0) 100%)',
  'box-shadow:0 0 10px rgba(140,190,255,.55)',
].join(';');
document.body.appendChild(kbWall);

/** 原生每 100ms 就报一次当前键盘高度（物理 px）；这里幂等换算，绝不"只在变化时处理"。 */
window.__petKeyboard = (hPhys, seq) => {
  const dpr = window.devicePixelRatio || 1;
  const h = Math.max(0, Number(hPhys) || 0) / dpr;
  const next = h > 0 ? Math.min(innerHeight * 0.6, h + 26) : 0;   // 抬高一点：别贴着键盘边
  const prev = prefs.kbTarget || 0;
  prefs.kbTarget = next;
  // 抬起来：快速跟手缓动；**收下去：立刻落地**（缓动会让"下来之后的第一下"显得迟钝）
  if (next < prev) prefs.kbLift = next;
  prefs.ime = h > 0;
  prefs.kbSeq = Number(seq) || prefs.kbSeq || 0;
  return true;
};
window.__petIme = (up, via) => { prefs.ime = !!up; window.__imeVia = via || ''; return true; };

window.petApp = { world, desk: null, ui: null, talk: null, care: null, prefs };
/* ---------- 渲染器：形象画不出来时，只让那一只回退 Coo（不牵连另一只） ---------- */
figureHost.onGiveUp = (slot, info) => {
  const msg = (info && info.error) || '未知错误';
  const where = (info && info.where) || '';
  for (const u of world.pets) {
    if (u.els?.petG !== slot.parent) continue;      // 只处理这个槽对应的那一只
    try { u.ct.setFigure(null); } catch (e) {}
    if (u.id === 1) { primaryFigKind = 'coo'; primaryFigScheme = ''; }
    else extraFigs.delete(u);
    sayOnUnit(u, [{ text: `这个形象画不出来（${msg}${where ? ' @ ' + where : ''}），先换回 Coo 啦` }]);
  }
};

window.__petUnionRect = () => world.unionString();
window.__petCount = () => world.count;
window.__tryPetChat = () => tryPetChat(world.primary, world.pets[1]);
window.__cycleFigure = (id) => {
  const u = world.pets.find((p) => p.id === (Number(id) || 1)) || world.primary;
  return setFigureFor(u).figure;
};
window.__figureNow = (id) => {
  const u = world.pets.find((p) => p.id === (Number(id) || 1)) || world.primary;
  return { kind: u.ct.figure ? 'custom' : 'coo', skin: skinOf(u).figure || 'coo' };
};
/** 现场诊断用：每只的坐标/模式/地面（也方便用一条 evaluateJavascript 核对）。 */
window.__petDebug = () => world.pets.map((u) => ({
  id: u.id, x: Math.round(u.pet.x), fy: Math.round(u.pet.fy), mode: u.pet.mode,
  floorY: Math.round(world.bounds().floorY), ground: Math.round(u.ct.ground), W: Math.round(world.bounds().W), H: Math.round(world.bounds().H),
}));
window.__petBoxes = () => world.pets.map((p) => {
  const b = p.visualBox();
  return b ? [p.id, Math.round(b.l), Math.round(b.t), Math.round(b.r), Math.round(b.b)] : [p.id, 0, 0, 0, 0];
});

addEventListener('resize', () => world.tick(0));

/* ---------- connection ---------- */
let ws = null, backoff = 500, watching = false;
function send(msg) { if (ws && ws.readyState === 1) ws.send(JSON.stringify(msg)); }
function connect() {
  ws = new WebSocket(`ws://${location.host}/socket?role=pet&host=${host ? 'window' : 'tab'}`);
  ws.binaryType = 'arraybuffer';
  ws.onopen = () => { backoff = 500; send({ t: 'hello', screen: { w: innerWidth, h: innerHeight }, host: host ? 'window' : 'tab' }); };
  ws.onmessage = (e) => { try { onOrder(JSON.parse(e.data)); } catch (err) { console.error(err); } };
  ws.onclose = (e) => {
    ws = null;
    stopMic();
    // the World gave up on these steps when the page went; it asks again once the page is back
    dropDialogs();
    if (e.code === 4000) return; // replaced by a newer pet page
    setTimeout(connect, backoff);
    backoff = Math.min(8000, backoff * 2);
  };
}
connect();

/* ---------- the body: Coo, or the DeepSeek whale maid (web/whale, loaded the first time it is chosen) ---------- */
let whale = null, wanted = 'coo';
async function applyFigure(s) {
  wanted = s.figure;
  if (s.figure !== 'whale') { ctl.setFigure(null); return; }
  whale ??= import('./whale/figure.js').then((m) => m.createWhaleFigure(undefined, { scheme: s.scheme }));
  const fig = await whale;
  if (wanted !== 'whale') return;
  // a scheme picked while she is on screen fades in
  await fig.setScheme(s.scheme, { fade: ctl.figure === fig ? .45 : 0, at: ctl.time });
  ctl.setFigure(fig);
}

function applyPrefs(p) {
  if (p.skin) {
    prefs.skin = normalizeSkin(p.skin);
    applySkins();
  }
  if ('skin2' in p) {
    prefs.skin2 = p.skin2 ? normalizeSkin(p.skin2) : null;
    applySkins();
  }
  if (p.roam) { prefs.roam = p.roam; world.setRoam(p.roam); }
  if (typeof p.sound === 'boolean') { prefs.sound = p.sound; sfx.set(p.sound); }
  if (p.theme === 'dark' || p.theme === 'light') { prefs.theme = p.theme; applyTheme(p.theme); }
  if (typeof p.scale === 'number') { prefs.scale = p.scale; ctl.resize(); }
  if (typeof p.user === 'string') prefs.user = p.user;
  if (typeof p.micDevice === 'string' && p.micDevice !== prefs.micDevice) { prefs.micDevice = p.micDevice; stopMic(); }
  if (typeof p.count === 'number') {
    /* 服务端配置是唯一真相：控制台「桌宠数量」改完要立刻生效。
     * 原厂这里在本地没有记录时把数量强制改回 1，还 send petCount:1 回写服务端，
     * 导致「桌宠数量」配 2 只永远只出 1 只。 */
    const want = Math.max(1, Math.min(MAX_PETS, Math.round(p.count) || 1));
    countSeenFromServer = true;
    prefs.count = want;
    world.ensure(want);
    applySkins();
    try { localStorage.setItem(PET_COUNT_KEY, String(want)); } catch (e) {}
  }
  if (typeof p.mic === 'boolean') { prefs.mic = p.mic; p.mic && !watching ? startMic() : stopMic(); }
  if (p.voice && typeof p.voice === 'object') prefs.voice = { ...prefs.voice, ...p.voice };
  if (Array.isArray(p.hoverButtons)) prefs.hoverButtons = p.hoverButtons.filter((id) => typeof id === 'string' && id in ACTIONS);
  if (p.bot) { prefs.bot = p.bot; if (!menu.hidden && !menu.querySelector('.m-head.confirm')) renderMenuHead(); }
  if (typeof p.thinking === 'boolean') ctl.setThinking(p.thinking);
  refreshButtons();
}

function onOrder(m) {
  switch (m.t) {
    case 'init': case 'prefs': applyPrefs(m); break;
    case 'watching': watching = true; stopMic(); break;
    case 'say': {
      dropAsks();
      if (expectPetChat && Date.now() < expectPetChat) {
        expectPetChat = 0;
        routePetChat(m.beats);
        ctl.holdRoam(20);
        break;
      }
      const who = world.active || world.primary;
      if (who !== world.primary) { sayOnUnit(who, m.beats); ctl.holdRoam(20); break; }
      queue.push({ kind: 'say', id: m.id, beats: m.beats, i: -1 });
      ctl.holdRoam(20);
      break;
    }
    case 'ask': dropAsks(); queue.push({ kind: 'ask', id: m.id, question: m.question, options: m.options || [], own: m.own !== false }); ctl.holdRoam(20); break;
    case 'confirm': dropAsks(); queue.push({ kind: 'ask', confirm: true, id: m.id, question: m.question, options: m.options, own: false }); ctl.holdRoam(20); break;
    case 'walk': walk(m); break;
    case 'act': acts.push(...m.actions); ctl.holdRoam(20); break;
    case 'openApp': {
      // ★ 打开应用：交给宿主（Android 壳层 / Electron）。
      let _ok = false, _detail = '';
      try {
        if (host && typeof host.openApp === 'function') {
          _ok = !!host.openApp(m.name);
          _detail = _ok ? '已发起打开' : '没找到这个应用';
        } else { _detail = '当前环境不支持打开应用'; }
      } catch (e) { _detail = '打开失败: ' + e; }
      try { send({ t: 'openAppResult', id: m.id, ok: _ok, detail: _detail }); } catch (e) {}
      break;
    }
    case 'listen': onListen(m); break;
    case 'thinking': ctl.setThinking(!!m.on); break;
    case 'dialog': queue.push({ kind: 'dialog', id: m.id, d: m }); ctl.holdRoam(20); break;
    case 'dialog-update': updateDialog(m); break;
    case 'dialog-close': endDialog(m.id); break;
  }
}

/* ---------- body events → World ---------- */
const walkTargets = new Map();
function onBody(kind, d) {
  if (kind === 'arrived' || kind === 'interrupted') {
    if (!d.walkId || !walkTargets.has(d.walkId)) return;
    walkTargets.delete(d.walkId);
    send({ t: kind, walkId: d.walkId, x: d.x / innerWidth, by: d.by });
    if (actWait && actWait.walkId === d.walkId) actWait = null;
  } else if (kind === 'touch') {
    send({ t: 'touch', ...d });
    if (d.kind === 'grab') closeMenu();
  }
}

function walk(m) {
  const x = m.to === 'cursor' ? (pointerSeen ? lastPointer.x : innerWidth / 2) : clamp(Number(m.to), 0, 1) * innerWidth;
  walkTargets.set(m.id, true);
  ctl.holdRoam(20);
  if (!ctl.walkTo(x, !!m.run, m.id)) {
    walkTargets.delete(m.id);
    send({ t: 'interrupted', walkId: m.id, x: ctl.pet.x / innerWidth, by: ctl.pet.mode === 'drag' ? 'drag' : ctl.pet.mode });
  }
}

/* ---------- actions ---------- */
const DUR = { stand: 1.2, jump: 1.2, hop: .9, look: 2.7, turn: .4, nod: .8, shake: .8, spin: .8, sit: .8, sleep: .8, dizzy: 3.2 };
const acts = [];
let actUntil = 0, actWait = null;
function runAction(a) {
  if (EXPRESSIONS.includes(a)) {
    if (a === 'neutral') ctl.setExpr('neutral', .1);
    else ctl.setExpr(a);
    return .9;
  }
  if (a === 'walk' || a === 'run') {
    const id = 'act' + Math.random().toString(36).slice(2);
    const x = ctl.pet.x < innerWidth / 2 ? innerWidth * (.55 + Math.random() * .35) : innerWidth * (.1 + Math.random() * .35);
    if (ctl.walkTo(x, a === 'run', id)) { actWait = { walkId: id }; walkTargets.set(id, true); }
    return 12;
  }
  ctl.act(a);
  return DUR[a] ?? 1;
}
function stepActs() {
  const now = ctl.time;
  if (actWait || now < actUntil || !acts.length) return;
  if (ctl.busy()) return;
  actUntil = now + runAction(acts.shift());
  ctl.holdRoam(15);
}

/* ---------- say / ask ---------- */
const queue = [];
let item = null;
const PAUSE = /[,。!?…、,.!?]/, SILENT = /[\s,。!?…、,.!?「」:()]/;

/** A newer question replaces the bot's open one; a World's confirmation stays until answered. */
function dropAsks() {
  for (let i = queue.length - 1; i >= 0; i--) if (queue[i].kind === 'ask' && !queue[i].confirm) queue.splice(i, 1);
  if (item && item.kind === 'ask' && !item.answered && !item.confirm) closeBubble();
}

function openBubble(kind, html) {
  bubble.className = 'bubble ' + kind;
  bubble.innerHTML = html;
  bubble.hidden = false;
  void bubble.offsetWidth;
  bubble.classList.add('pop');
}
function closeBubble() {
  releaseKeys(item);
  if (item?.kind === 'dialog') talk.motion = null;
  bubble.hidden = true; bubble.innerHTML = '';
  item = null;
}

/**
 * While a question's options are up, the pet window takes the keyboard so 1–9 pick one right
 * away, and gives it back to the window that had it once the question is answered or gone.
 */
function grabKeys(it) {
  if (!host?.grabFocus || !it.options.length) return;
  it.grabbed = true;
  host.grabFocus();
}
function releaseKeys(it) {
  if (!it?.grabbed) return;
  it.grabbed = false;
  host.releaseFocus();
}

function startItem(it) {
  item = it;
  if (it.kind === 'dialog') { openDialog(it); return; }
  if (it.kind === 'ask') {
    openBubble('ask', '<button class="b-close" type="button" aria-label="关闭">×</button><p class="b-text"></p><div class="b-opts" hidden></div>');
    bubble.querySelector('.b-close').addEventListener('click', () => dismissAsk());
    it.text = it.question; it.shown = 0; it.acc = 0; it.optsShown = false;
    sfx.pop();
  }
}

function stepDialog(dt) {
  if (!item && queue.length && !ctl.busy()) startItem(queue.shift());
  const it = item;
  if (!it) return;
  if (it.kind === 'say') {
    if (it.i < 0 || it.beatDone) {
      if (it.beatDone && ctl.time < it.holdUntil) return;
      it.i++;
      it.beatDone = false;
      if (it.i >= it.beats.length) { closeBubble(); return; }
      const b = it.beats[it.i];
      let lead = 0;
      for (const a of b.actions || []) { acts.push(a); lead = .45; }
      it.shown = 0; it.acc = 0; it.fired = 0; it.startAt = ctl.time + lead;
      if (b.text) { openBubble('say', '<p class="b-text"></p>'); sfx.pop(); } else { bubble.hidden = true; }
      return;
    }
    const b = it.beats[it.i];
    if (ctl.time < it.startAt) return;
    if (!b.text) { it.beatDone = true; it.holdUntil = ctl.time + .8; return; }
    typeText(it, b.text, dt, b.anchors || []);
    if (it.shown >= b.text.length && !it.beatDone) {
      it.beatDone = true;
      const last = it.i === it.beats.length - 1;
      it.holdUntil = ctl.time + (last ? 1.6 + b.text.length * .07 : .9 + b.text.length * .03);
    }
    return;
  }
  if (it.kind === 'ask') {
    if (it.shown < it.text.length) { typeText(it, it.text, dt, []); return; }
    if (!it.optsShown) { it.optsShown = true; showOptions(it); }
  }
  if (it.kind === 'dialog') stepTalk(it, dt);
}

function typeText(it, text, dt, anchors) {
  const p = bubble.querySelector('.b-text');
  if (!p || it.shown >= text.length) return;
  it.acc += dt * 20;
  while (it.acc >= 1 && it.shown < text.length) {
    const ch = text[it.shown++];
    it.acc -= PAUSE.test(ch) ? 5 : 1;
    if (!SILENT.test(ch)) { sfx.babble(ch); ctl.talk(); }
    while (it.fired < anchors.length && anchors[it.fired].at <= it.shown) acts.push(...anchors[it.fired++].actions);
  }
  if (it.marks?.length) p.innerHTML = marked(text, it.shown, it.marks);
  else p.textContent = text.slice(0, it.shown);
}

/** The first `n` characters of `text`, escaped, with every one of `words` in it wrapped for the theme color. */
function marked(text, n, words) {
  const on = new Array(text.length).fill(false);
  for (const w of words) {
    if (!w) continue;
    for (let i = text.indexOf(w); i >= 0; i = text.indexOf(w, i + w.length)) on.fill(true, i, i + w.length);
  }
  let out = '', open = false;
  for (let i = 0; i < n; i++) {
    if (on[i] !== open) { out += on[i] ? '<b class="d-mark">' : '</b>'; open = on[i]; }
    out += esc(text[i]);
  }
  return open ? out + '</b>' : out;
}

function showOptions(it) {
  const box = bubble.querySelector('.b-opts');
  it.options.forEach((label, i) => {
    const b = document.createElement('button');
    b.type = 'button'; b.className = 'b-opt';
    b.innerHTML = i < 9 ? `<kbd>${i + 1}</kbd><span></span>` : '<span></span>';
    b.querySelector('span').textContent = label;
    b.style.animationDelay = (i * .07) + 's';
    b.addEventListener('click', () => answer(b, { index: i }));
    box.appendChild(b);
    setTimeout(() => sfx.blub(), i * 70);
  });
  if (it.own) {
    const form = document.createElement('form');
    form.className = 'b-own';
    form.innerHTML = '<input type="text" maxlength="200" autocomplete="off" placeholder="自己说点什么…" aria-label="自己写回答"><button type="submit">发送</button>';
    form.style.animationDelay = (it.options.length * .07) + 's';
    form.addEventListener('submit', (e) => {
      e.preventDefault();
      const input = form.querySelector('input'), v = input.value.trim();
      if (!v) { input.focus(); return; }
      answer(form, { text: v });
    });
    box.appendChild(form);
  }
  box.hidden = false;
  grabKeys(it);
}

function answer(node, a) {
  const it = item;
  if (!it || it.kind !== 'ask' || it.answered) return;
  it.answered = true;
  sfx.select();
  node.classList.add('chosen');
  bubble.querySelectorAll('.b-opt, .b-own').forEach((n) => { if (n !== node) n.classList.add('dim'); });
  send(it.confirm ? { t: 'confirmed', id: it.id, index: a.index } : { t: 'answer', askId: it.id, ...a });
  // the bubble stays a moment longer; the keyboard goes back now
  releaseKeys(it);
  ctl.setExpr('happy');
  setTimeout(() => { if (item === it) closeBubble(); }, 700);
}
function dismissAsk() {
  const it = item;
  if (!it || it.kind !== 'ask' || it.answered) return;
  it.answered = true;
  send(it.confirm ? { t: 'confirmed', id: it.id, index: null } : { t: 'answer', askId: it.id, dismissed: true });
  closeBubble();
}

/* ---------- an app's conversation: one step at a time in Coo's bubble ---------- */
/** How Coo moves while a step's choice cards are up, around the spot the bubble is pinned to. */
const talk = { motion: null, next: 0 };
/** Pixels Coo strays either side of the bubble while showing a motion. */
const TALK_RANGE = 240;
const esc = (s) => String(s ?? '').replace(/[&<>"']/g, (c) => ({ '&': '&amp;', '<': '&lt;', '>': '&gt;', '"': '&quot;', "'": '&#39;' })[c]);

function dropDialogs() {
  for (let i = queue.length - 1; i >= 0; i--) if (queue[i].kind === 'dialog') queue.splice(i, 1);
  if (item?.kind === 'dialog') closeBubble();
}

function openDialog(it) {
  const d = it.d;
  const dots = Array.isArray(d.step) ? Array.from({ length: d.step[1] }, (_, i) => `<i class="${i + 1 < d.step[0] ? 'past' : i + 1 === d.step[0] ? 'on' : ''}"></i>`).join('') : '';
  openBubble('talk', `${dots || d.closable ? `<div class="d-top"><span class="d-dots">${dots}</span>${d.closable ? '<button class="b-close" type="button" aria-label="跳过" title="跳过">×</button>' : ''}</div>` : ''}<p class="b-text"></p><div class="d-body" hidden></div>`);
  bubble.querySelector('.b-close')?.addEventListener('click', () => settleDialog(it, { closed: true }));
  for (const a of d.actions || []) acts.push(a);
  it.text = d.text || ''; it.shown = 0; it.acc = 0; it.bodyShown = false; it.readUntil = 0;
  it.marks = Array.isArray(d.marks) ? d.marks.filter((w) => typeof w === 'string') : [];
  sfx.pop();
}

function stepTalk(it, dt) {
  if (it.shown < it.text.length) { typeText(it, it.text, dt, []); return; }
  if (it.bodyShown) return;
  it.bodyShown = true;
  if (!it.d.input) { it.readUntil = ctl.time + 1.4 + it.text.length * .05; return; }
  showDialogInput(it);
}

/** A step with nothing to answer ends once its line has been read. */
function stepTalkRead() {
  const it = item;
  if (it?.kind === 'dialog' && it.readUntil && ctl.time > it.readUntil) settleDialog(it, { done: true });
}

function showDialogInput(it) {
  const body = bubble.querySelector('.d-body'), input = it.d.input;
  if (!body) return;
  if (input.kind === 'buttons') {
    if (input.keys) body.insertAdjacentHTML('beforeend', `<div class="d-keys"><kbd class="d-key${input.taps > 1 ? ' taps' : ''}">${esc(input.keys)}</kbd>${input.taps > 1 ? `<span class="d-taps">×${Number(input.taps)}</span>` : ''}</div>`);
    const row = Object.assign(document.createElement('div'), { className: 'd-row' });
    input.options.forEach((o, i) => row.appendChild(pill(o.label, o.primary, () => settleDialog(it, { index: i }))));
    body.appendChild(row);
  } else if (input.kind === 'choices') {
    const cards = Object.assign(document.createElement('div'), { className: 'd-cards' });
    const pick = (i, speak) => {
      it.value = i;
      cards.querySelectorAll('.d-card').forEach((c, k) => c.classList.toggle('on', k === i));
      const o = input.options[i];
      // the bubble stays put from here on, so the cards do not run off while Coo shows how it moves
      if (it.pinX === undefined) { const a = ctl.anchor(); it.pinX = a.x; it.pinY = a.y; }
      talk.motion = o?.motion ?? null; talk.next = 0;
      if (speak && o?.line) { it.text = o.line; it.shown = 0; it.acc = 0; }
    };
    input.options.forEach((o, i) => {
      const c = document.createElement('button');
      c.type = 'button'; c.className = 'd-card';
      c.style.animationDelay = (i * .07) + 's';
      const image = typeof o.image === 'string' && o.image.startsWith('data:image/') ? `<img class="d-cardimg" alt="" src="${esc(o.image)}">` : '';
      c.innerHTML = `${image || (o.icon && ICONS[o.icon] ? `<span class="d-cardic">${ICONS[o.icon]}</span>` : '')}<span class="d-cardlbl">${esc(o.label)}</span>${o.level ? `<b class="d-level">${esc(o.level)}</b>` : ''}`;
      c.addEventListener('click', () => { sfx.tick(); pick(i, true); });
      cards.appendChild(c);
      setTimeout(() => sfx.blub(), i * 70);
    });
    body.appendChild(cards);
    const row = Object.assign(document.createElement('div'), { className: 'd-row' });
    row.appendChild(pill(input.confirm, true, () => settleDialog(it, { index: it.value ?? 0 })));
    body.appendChild(row);
    pick(typeof input.value === 'number' ? input.value : 0, false);
  } else if (input.kind === 'text') {
    const form = Object.assign(document.createElement('form'), { className: 'd-field' });
    form.innerHTML = `<input type="${input.secret ? 'password' : 'text'}" autocomplete="off" spellcheck="false" maxlength="${Number(input.maxLength) || 200}">${input.secret ? `<button class="d-peek" type="button" aria-label="显示" title="显示">${ICONS.eye}</button>` : ''}<button class="d-send" type="submit"></button>`;
    const field = form.querySelector('input');
    field.placeholder = input.placeholder || '';
    field.value = input.value || '';
    if (Array.isArray(input.suggestions) && input.suggestions.length && !input.secret) {
      const list = document.createElement('datalist');
      list.id = `d-list-${it.id}`;
      for (const s of input.suggestions) list.appendChild(Object.assign(document.createElement('option'), { value: String(s) }));
      form.appendChild(list);
      field.setAttribute('list', list.id);
    }
    field.setAttribute('aria-label', it.text);
    form.querySelector('.d-send').textContent = input.submit;
    form.querySelector('.d-peek')?.addEventListener('click', (e) => {
      const show = field.type === 'password';
      field.type = show ? 'text' : 'password';
      e.currentTarget.innerHTML = show ? ICONS.eyeOff : ICONS.eye;
      field.focus();
    });
    form.addEventListener('submit', (e) => {
      e.preventDefault();
      const v = field.value.trim();
      if (!v) { form.classList.remove('shake'); void form.offsetWidth; form.classList.add('shake'); field.focus(); return; }
      settleDialog(it, { text: v });
    });
    body.appendChild(form);
    if (input.link || input.alt) {
      const row = Object.assign(document.createElement('div'), { className: 'd-links' });
      if (input.link) {
        const a = Object.assign(document.createElement('a'), { className: 'd-link', href: input.link.url, target: '_blank', rel: 'noopener' });
        a.innerHTML = `<span></span>${ICONS.external}`;
        a.querySelector('span').textContent = input.link.label;
        row.appendChild(a);
      }
      if (input.alt) {
        const b = Object.assign(document.createElement('button'), { type: 'button', className: 'd-alt', textContent: input.alt });
        b.addEventListener('click', () => settleDialog(it, { alt: true }));
        row.appendChild(b);
      }
      body.appendChild(row);
    }
    // the window takes the keyboard so the box can be typed in right away
    host?.focus?.();
    setTimeout(() => field.focus(), 30);
  } else if (input.kind === 'progress') {
    body.innerHTML = `<div class="d-bar${typeof it.progress === 'number' ? '' : ' wait'}"><i></i></div><div class="d-barlbl"><span></span><b></b></div>`;
    body.querySelector('.d-barlbl span').textContent = input.label || '';
    drawProgress(it);
  }
  body.hidden = false;
  body.querySelector('.d-send, .d-pill.primary')?.focus?.({ preventScroll: true });
}

function pill(label, primary, onClick) {
  const b = Object.assign(document.createElement('button'), { type: 'button', className: `d-pill${primary ? ' primary' : ''}`, textContent: label });
  b.addEventListener('click', onClick);
  return b;
}

function drawProgress(it) {
  const bar = bubble.querySelector('.d-bar');
  if (!bar) return;
  const p = it.progress;
  bar.classList.toggle('wait', typeof p !== 'number');
  bar.querySelector('i').style.width = typeof p === 'number' ? `${Math.round(clamp(p, 0, 1) * 100)}%` : '';
  bubble.querySelector('.d-barlbl b').textContent = typeof p === 'number' ? `${Math.floor(clamp(p, 0, 1) * 100)}%` : '';
}

function updateDialog(m) {
  const it = item?.kind === 'dialog' && item.id === m.id ? item : queue.find((q) => q.kind === 'dialog' && q.id === m.id);
  if (!it) return;
  if ('progress' in m) it.progress = m.progress;
  if (typeof m.text === 'string') {
    it.d = { ...it.d, text: m.text };
    if (it === item) { it.text = m.text; it.shown = 0; it.acc = 0; }
  }
  if (it === item) drawProgress(it);
}

function endDialog(id) {
  const i = queue.findIndex((q) => q.kind === 'dialog' && q.id === id);
  if (i >= 0) queue.splice(i, 1);
  if (item?.kind === 'dialog' && item.id === id) closeBubble();
}

function settleDialog(it, answer) {
  if (item !== it || it.answered) return;
  it.answered = true;
  send({ t: 'dialog', id: it.id, ...answer });
  if (answer.done) { closeBubble(); return; }
  sfx.select();
  bubble.querySelectorAll('button, input').forEach((n) => { n.disabled = true; });
  if ('index' in answer) bubble.querySelectorAll('.d-pill')[answer.index]?.classList.add('chosen');
  // the chosen button shows a moment; the app's next step waits in the queue meanwhile
  setTimeout(() => { if (item === it) closeBubble(); }, 260);
}

/** Coo shows the picked card's motion near the pinned bubble: standing still, strolling, or running about. */
function stepTalkMotion() {
  const it = item;
  if (it?.kind !== 'dialog') return;
  ctl.holdRoam(20);
  if (!talk.motion || it.pinX === undefined || ctl.busy() || ctl.time < talk.next || ctl.pet.mode !== 'idle') return;
  const home = it.pinX, R = Math.min(TALK_RANGE, innerWidth * .25);
  if (talk.motion === 'still') {
    if (Math.abs(ctl.pet.x - home) > 30) ctl.walkTo(home, false);
    talk.next = ctl.time + 1;
    return;
  }
  const run = talk.motion === 'run';
  if (run && Math.random() < .3) { ctl.act('hop'); talk.next = ctl.time + .5; return; }
  // to the other side of the bubble each time, so every move is plain to see
  const x = ctl.pet.x < home ? home + R * (.4 + Math.random() * .6) : home - R * (.4 + Math.random() * .6);
  if (ctl.walkTo(clamp(x, 40, innerWidth - 40), run)) talk.next = ctl.time + (run ? .1 : 1.2 + Math.random() * 1.2);
}

/* ---------- typed input: the hover button, or double-click ---------- */
function openInput(unit) {
  const u = unit && world.pets.includes(unit) ? unit : (world.active || world.primary);
  world.active = u;                      // 跟谁说话，回话就回谁
  closeMenu();
  if (item && item.kind === 'ask' && !item.answered) return;
  if (item) closeBubble();

  // 不是第 1 只：输入框就开在**它自己**的气泡里（不再借用第 1 只的 #bubble）
  if (u !== world.primary) {
    const el = u.els.bubbleEl;
    if (el) {
      el.className = 'bubble ask';
      el.innerHTML = `<button class="b-close" type="button" aria-label="关闭">×</button>`
        + `<p class="b-text">跟第 ${u.id} 只说话</p>`
        + `<form class="b-own"><input type="text" maxlength="500" autocomplete="off" placeholder="想说什么…" aria-label="打字说话"><button type="submit">发送</button></form>`;
      el.hidden = false;
      const form = el.querySelector('form'), input = form.querySelector('input');
      el.querySelector('.b-close').addEventListener('click', () => { el.hidden = true; el.innerHTML = ''; });
      form.addEventListener('submit', (e) => {
        e.preventDefault();
        const v = input.value.trim();
        if (!v) return;
        send({ t: 'text', text: v });
        sfx.select();
        try { u.ct.setExpr('happy'); } catch (err) {}
        el.hidden = true; el.innerHTML = '';
      });
      host?.focus?.();
      setTimeout(() => input.focus(), 30);
      return;
    }
  }

  item = { kind: 'input' };
  openBubble('ask', '<button class="b-close" type="button" aria-label="关闭">×</button><form class="b-own"><input type="text" maxlength="500" autocomplete="off" placeholder="想说什么…" aria-label="打字说话"><button type="submit">发送</button></form>');
  const form = bubble.querySelector('form'), input = form.querySelector('input');
  bubble.querySelector('.b-close').addEventListener('click', () => closeBubble());
  form.addEventListener('submit', (e) => {
    e.preventDefault();
    const v = input.value.trim();
    if (!v) return;
    send({ t: 'text', text: v });
    sfx.select();
    try { u.ct.setExpr('happy'); } catch (e) {}
    closeBubble();
  });
  host?.focus?.();
  setTimeout(() => input.focus(), 30);
}

/* ---------- listening ---------- */
/** `text` is settled, `interim` the sentence still being heard (Windows' recognizer reports it as it goes). */
const listen = { phase: null, text: '', interim: '', closeAt: 0 };
function onListen(m) {
  // the quick tap before a talk key is held: Coo perks up, and the hold that follows starts listening
  if (m.phase === 'ready') {
    if (listen.phase) return;
    sfx.tick();
    ctl.pet.sqv += .6;
    ctl.setExpr('surprised', .5);
    return;
  }
  if (m.phase === 'start') {
    if (!listen.phase) sfx.listenStart();
    listen.phase = 'hearing'; listen.closeAt = 0;
    ctl.setListening(true);
    showHeard(listen.text, true, undefined, listen.interim);
  } else if (m.phase === 'transcribing') {
    listen.phase = listen.phase || 'hearing';
    showHeard(listen.text, true, undefined, listen.interim);
  } else if (m.phase === 'partial') {
    listen.text = m.text || '';
    listen.interim = m.interim || '';
    showHeard(listen.text, true, undefined, listen.interim);
  } else if (m.phase === 'heard') {
    listen.text = m.text || ''; listen.interim = '';
    listen.phase = 'done';
    showHeard(listen.text, false, '听到了');
    sfx.listenEnd();
    ctl.setListening(false);
    ctl.pet.sqv += .9;
    listen.closeAt = ctl.time + 2.2;
  } else if (m.phase === 'none') {
    if (listen.phase === 'done') return;
    listen.phase = null; listen.text = ''; listen.interim = '';
    heardEl.hidden = true; trail.hidden = true;
    ctl.setListening(false);
  }
}
/** `text` is settled; `interim` is the sentence still being heard, greyed, and may still change. */
function showHeard(text, live, hint, interim = '') {
  heardEl.hidden = false; trail.hidden = false;
  heardEl.innerHTML = `<p class="b-text"><span class="fin"></span><span class="interim"></span>${live ? '<span class="caret" aria-hidden="true"></span>' : ''}</p><span class="b-hint"></span>`;
  heardEl.querySelector('.fin').textContent = text;
  // a space only before Latin text that follows Latin text or ASCII punctuation; Chinese sentences run on
  heardEl.querySelector('.interim').textContent = text && interim && /[A-Za-z0-9.,!?;:]$/.test(text) && /^[A-Za-z0-9]/.test(interim) ? ' ' + interim : interim;
  heardEl.querySelector('.b-hint').textContent = hint || (text || interim ? '还在听…' : '正在听…');
}
function stepListen() {
  if (listen.phase === 'done' && ctl.time > listen.closeAt) {
    listen.phase = null; listen.text = ''; listen.interim = '';
    heardEl.hidden = true; trail.hidden = true;
  }
}

/* ---------- microphone ---------- */
let mic = null;
async function startMic() {
  if (mic) return;
  if (window.PetVoice && window.PetVoice.available()) { mic = { native: true }; try { window.PetVoice.start(); } catch (e) {} send({ t: 'mic', state: 'on', detail: 'phone' }); return; }
  mic = { starting: true };
  try {
    const audio = { channelCount: 1, echoCancellation: true, noiseSuppression: true, autoGainControl: true };
    if (prefs.micDevice) audio.deviceId = { exact: prefs.micDevice };
    const stream = await navigator.mediaDevices.getUserMedia({ audio });
    const ctx = new AudioContext({ sampleRate: 16000 });
    await ctx.audioWorklet.addModule('/web/mic-worklet.js');
    const src = ctx.createMediaStreamSource(stream);
    const node = new AudioWorkletNode(ctx, 'pet-mic');
    node.port.onmessage = (e) => { if (ws && ws.readyState === 1) ws.send(e.data); };
    src.connect(node);
    if (!prefs.mic || !mic) { stream.getTracks().forEach((t) => t.stop()); ctx.close(); mic = null; return; }
    mic = { stream, ctx, node };
    send({ t: 'mic', state: 'on', detail: stream.getAudioTracks()[0]?.label || null });
    void reportDevices();
  } catch (err) {
    mic = null;
    send({ t: 'mic', state: err && err.name === 'NotAllowedError' ? 'denied' : 'error', detail: String(err && err.message || err) });
  }
}
/** Device labels are readable only after microphone access was granted. */
async function reportDevices() {
  const all = await navigator.mediaDevices.enumerateDevices();
  send({ t: 'devices', list: all.filter((d) => d.kind === 'audioinput' && d.deviceId !== 'default' && d.deviceId !== 'communications').map((d) => ({ id: d.deviceId, label: d.label })) });
}
navigator.mediaDevices?.addEventListener('devicechange', () => { if (mic && !mic.starting) void reportDevices(); });
function stopMic() {
  const m = mic;
  mic = null;
  if (m && m.native) { try { window.PetVoice && window.PetVoice.stop(); } catch (e) {} send({ t: 'mic', state: 'off', detail: 'phone' }); return; }
  if (!m || m.starting) return;
  m.stream.getTracks().forEach((t) => t.stop());
  m.ctx.close();
  send({ t: 'mic', state: 'off' });
}

/* ---------- actions: the menu's lower zone and the hover buttons draw from one list ---------- */
let menuUnit = null;
const ROAM_ORDER = ['off', 'calm', 'free'];
const ROAM = { off: '不乱动', calm: '多待着', free: '常走动' };
const ROAM_LEVEL = { off: '低', calm: '中', free: '高' };
/** The voice button's badge: listening all the time, or only on the talk key. */
const MIC_BADGE = { always: 'auto', hold: 'key', toggle: 'key' };
/** Most hover buttons shown beside the pet. */
const MAX_HOVER = 6;

/**
 * Every button the menu and the hover buttons can show, in the menu's order. `icon`, `state` and
 * `on` read the current prefs: `state` is the line that says what the button does and where it
 * stands, `on` lights a switch that is on (undefined for plain actions). `keep` leaves the menu
 * open after a click, so a switch shows its new state there.
 */
/** 形象循环：Coo ↔ 大肥鱼。 */
const FIG_CYCLE = ['coo', 'whale'];

/** 给某一只换形象：立刻生效 + 存到服务端它自己那一份（第 2 只存 skin2）。 */
function setFigureFor(unit) {
  const u = (unit && world.pets.includes(unit)) ? unit : (world.active || world.primary);
  const skin = { ...skinOf(u) };
  const cur = skin.figure || 'coo';
  skin.figure = FIG_CYCLE[(FIG_CYCLE.indexOf(cur) + 1) % FIG_CYCLE.length];
  if (u.id === 1) prefs.skin = skin; else prefs.skin2 = skin;
  try { applySkinFor(u.id, skin); } catch (e) { console.error('[pet] 换形象失败', e); }
  try {
    fetch('/api/skin', {
      method: 'POST',
      headers: { 'content-type': 'application/json' },
      body: JSON.stringify({ skin, pet: u.id }),
    }).catch(() => {});
  } catch (e) {}
  const label = Object.fromEntries(FIGURES);
  sayOnUnit(u, [{ text: `换好了：${label[skin.figure] || skin.figure}` }]);
  return skin;
}

const ACTIONS = {
  chat: {
    icon: () => ICONS.chat,
    state: (u) => `打字跟第 ${u.id} 只说话(也可以双击它)`,
    run: (u) => openInput(u),
  },
  /** 加减合一：只有 1 只是「+」，有 2 只时变「−」。 */
  petToggle: {
    icon: () => (world.count >= MAX_PETS ? ICONS.minus : ICONS.plus),
    state: () => (world.count >= MAX_PETS
      ? `现在 ${world.count} 只 · 点一下送走第 2 只`
      : `现在 ${world.count} 只 · 点一下再来一只`),
    run: () => {
      const next = world.count >= MAX_PETS ? 1 : 2;
      setPetCount(next);
      const u = world.pets[next - 1] || world.primary;
      if (next > 1) sayOnUnit(u, [{ text: '我也来啦～' }]);
    },
  },
  /** 每只自己的形象：Coo ↔ 大肥鱼，只作用在这一只。 */
  figure: {
    icon: () => ICONS.shirt, cls: 'dress',
    state: (u) => {
      const cur = skinOf(u).figure || 'coo';
      const next = FIG_CYCLE[(FIG_CYCLE.indexOf(cur) + 1) % FIG_CYCLE.length];
      const label = Object.fromEntries(FIGURES);
      return `第 ${u.id} 只的形象:${label[cur] || cur} · 点一下换成「${label[next] || next}」`;
    },
    run: (u) => setFigureFor(u),
  },
  chatter: {
    icon: () => ICONS.clock,
    state: () => `主动搭话:${(prefs.chatter ?? 0) > 0 ? (prefs.chatter + ' 分钟一次') : '关闭'} · 点一下换一档`,
    run: () => {
      const steps = [1, 2, 3, 5, 0];
      const cur = Number(prefs.chatter ?? 0);
      let i = steps.findIndex((v) => v === cur);
      i = (i + 1) % steps.length;
      setChatter(steps[i]);
      showBubble1(steps[i] === 0 ? '好，我不主动吵你了～' : '那我每 ' + steps[i] + ' 分钟找你一次～');
    },
  },
  feed: {
    icon: () => ICONS.feed,
    state: (u) => `喂第 ${u.id} 只吃点东西`,
    run: (u) => feedPet(u),
  },
  voice: {
    keep: true,
    icon: () => (prefs.voice.enabled ? ICONS.mic : ICONS.micOff),
    badge: () => (prefs.voice.enabled ? MIC_BADGE[prefs.voice.mode] ?? '' : ''),
    on: () => prefs.voice.enabled,
    state: () => (!prefs.voice.enabled ? '语音输入:关 · 点一下打开'
      : !prefs.voice.ready ? `语音输入:开,但${prefs.voice.detail || '识别服务没有就绪'} · 点一下关掉`
      : `语音输入:开(${prefs.voice.mode === 'always' ? '自动收音' : '按键收音'})· ${prefs.voice.hint || ''}`),
    run: () => toggleVoice(),
  },
  roam: {
    keep: true,
    icon: () => ICONS[`roam_${prefs.roam}`] ?? ICONS.roam_calm,
    state: () => {
      const next = ROAM_ORDER[(ROAM_ORDER.indexOf(prefs.roam) + 1) % ROAM_ORDER.length];
      return `行为模式:${ROAM_LEVEL[prefs.roam] ?? ''} · ${ROAM[prefs.roam] ?? ''} · 点一下换成「${ROAM[next]}」`;
    },
    run: () => cycleRoam(),
  },
  theme: {
    keep: true,
    icon: () => (prefs.theme === 'dark' ? ICONS.moon : ICONS.sun),
    on: () => prefs.theme === 'dark',
    state: () => (prefs.theme === 'dark' ? '夜间模式:开(浅色身体)· 点一下换白天' : '夜间模式:关(白天,深色身体)· 点一下换夜间'),
    run: () => toggleTheme(),
  },
  sound: {
    keep: true,
    icon: () => (prefs.sound ? ICONS.sound : ICONS.soundOff),
    on: () => prefs.sound,
    state: () => (prefs.sound ? '音效:开 · 点一下静音' : '音效:关 · 点一下打开'),
    run: () => send({ t: 'prefs', sound: !prefs.sound }),
  },
  kb: {
    keep: true,
    icon: () => ICONS.settings,
    state: () => { const via = window.__imeVia || ''; const hint = via.includes('a11y=off') ? '（别的 App 的键盘要开无障碍）' : ''; return `键盘:${prefs.ime ? '弹着' : '没弹'} · 抬升 ${Math.round(prefs.kbLift || 0)}px · 心跳 ${prefs.kbSeq || 0} · 依据:${via || '还没收到原生回报'}${hint}`; },
    run: () => { try { refreshButtons(); } catch (e) {} },
  },
  palette: {
    icon: () => ICONS.palette,
    state: (u) => `给第 ${u.id} 只快速换配色（不用开装扮页）`,
    run: (u) => quickPalette(u),
  },
  dress: {
    icon: () => ICONS.shirt, cls: 'dress',
    state: (u) => `给第 ${u.id} 只换装（配色/帽子/眼镜/衣服，每只各一套）`,
    // 装扮页读 cortico.dress.pet 决定改哪一只；宿主有自己的装扮页时交给它
    run: (unit) => {
      const id = (unit || world.active || world.primary).id;
      prefs.count = world.count;
      try { localStorage.setItem('cortico.pet.count', String(world.count)); } catch (e) {}
      try { localStorage.setItem('cortico.dress.pet', String(id)); } catch (e) {}
      if (prefs.bot?.buttons?.dress) send({ t: 'control', action: 'dress' });
      else if (host?.openDress) host.openDress();
      else window.open('/dress', '_blank');
    },
  },
  repair: {
    icon: () => ICONS.chat,
    state: () => '遇到问题？点这里描述并诊断(会消耗你配置的 AI token)',
    run: () => openRepair(),
  },
  hide: {
    icon: () => ICONS.eyeOff, available: () => !!host?.hide,
    state: () => '先把我藏起来(托盘里可以叫我回来)',
    run: () => host.hide(),
  },
};
const available = (id) => ACTIONS[id] && (ACTIONS[id].available?.() ?? true);

/** One action as a button: its icon, the badge, and whether a switch is on. */
/** 这份动作属于哪一只（按钮上记着 unit，重画时也不会串）。 */
function drawAction(b, id, unit) {
  const a = ACTIONS[id];
  const u = unit || b._unit || world.primary;
  const on = a.on?.(u);
  const badge = a.badge?.(u) ?? '';
  b.querySelector('.ic').innerHTML = a.icon(u) + (badge ? `<b class="badge">${badge}</b>` : '');
  b.classList.toggle('on', on === true);
  b.classList.toggle('off', on === false);
  b.title = a.state?.(u) ?? id;
  b.setAttribute('aria-label', b.title);
  if (on !== undefined) b.setAttribute('aria-pressed', String(on));
}

function cycleRoam() {
  const roam = ROAM_ORDER[(ROAM_ORDER.indexOf(prefs.roam) + 1) % ROAM_ORDER.length];
  applyPrefs({ roam });
  send({ t: 'prefs', roam });
}

function toggleTheme() {
  const theme = prefs.theme === 'dark' ? 'light' : 'dark';
  applyPrefs({ theme });
  send({ t: 'prefs', theme });
}

function toggleVoice() {
  const on = !prefs.voice.enabled;
  // shown at once; the World's next prefs confirm it
  prefs.voice = { ...prefs.voice, enabled: on };
  refreshButtons();
  send({ t: 'prefs', mic: on });
}

/* ---------- 喂食 + 铁盆：落下 → 她过来吃 → 盆可拖、可扣头上、双击取下 ---------- */
let bowlTimer = 0;
const bowlState = { onHead: false, raf: 0 };
function feedCrumb(x, y) {
  const c = document.createElement('div');
  c.textContent = '•';
  c.style.cssText = `position:fixed;left:${x + (Math.random() * 26 - 13)}px;top:${y - 34}px;`
    + 'font-size:11px;color:#f6e7c6;text-shadow:0 1px 1px rgba(0,0,0,.45);pointer-events:none;z-index:9;';
  document.body.appendChild(c);
  try { c.animate([{ transform: 'translateY(0)', opacity: 1 }, { transform: 'translateY(26px)', opacity: 0 }], { duration: 620, easing: 'ease-in' }); } catch (e) {}
  setTimeout(() => c.remove(), 700);
}
function petAnchor(unit) {
  // pet-core 的 logo 空间：脚底 y=256、身体中心 x=128；HEAD_TOP 是头顶的 logo y。
  // 脚底用这一只自己的地面（站上图标时会被抬起来），不是它的 pet.y。
  const u = unit || world.active || world.primary;
  const ct = (u && u.ct) || ctl;
  let hx = Math.round(innerWidth * 0.62), feet = innerHeight - 72, s = 1;
  try {
    const p = ct.pet || {}, b = world.bounds();
    if (typeof p.x === 'number' && p.x > 0 && p.x < innerWidth) hx = p.x;
    const ground = typeof ct.ground === 'number' ? ct.ground : b.floorY;
    if (typeof ground === 'number' && ground > 60 && ground <= innerHeight + 40) feet = ground;
    if (typeof b.S === 'number' && b.S > 0) s = b.S;
  } catch (e) {}
  const headTop = feet - (256 - HEAD_TOP) * s;
  return { hx, feet, headTop, s };
}
function petBox() {
  // 用影子的屏幕矩形反推她的中线与脚底（#shadow 是简单椭圆，rect 可信；
  // ctl.pet.x 是 logo 单位，不能当像素用）
  const el = document.getElementById('shadow') || document.getElementById('pet');
  if (!el) return null;
  let r = null;
  try { r = el.getBoundingClientRect(); } catch (e) {}
  if (!r || !r.width) return null;
  let sc = 1;
  try { const b = ctl.bounds || {}; if (typeof b.S === 'number' && b.S > 0) sc = b.S; } catch (e) {}
  const feet = r.bottom;
  return { hx: r.left + r.width / 2, feet, headTop: feet - (256 - HEAD_TOP) * sc };
}
function petRect() {
  try { return document.getElementById('pet').getBoundingClientRect(); } catch (e) { return null; }
}
let bowlSeq = 0;
function bowlSvg(empty) {
  // 素材：用户提供的实拍不锈钢盆（空盆 / 满盆），已去背去水印
  const src = empty ? '/web/props/bowl.png' : '/web/props/bowl_full.png';
  return '<img class="bowlImg" src="' + src + '" width="84" alt="" '
    + 'style="display:block;filter:drop-shadow(0 2px 3px rgba(0,0,0,.35))">';
}
function bowlFollowHead() {
  if (!bowlState.onHead) { bowlState.raf = 0; return; }
  const el = document.getElementById('petBowl');
  if (!el) { bowlState.onHead = false; bowlState.raf = 0; return; }
  let hx = null, top = null;
  try {
    const u = bowlState.unit || world.primary;
    const a = u.ct.anchor();
    hx = a.x; top = a.y;
  } catch (e) {}
  if (hx === null) {
    const b = petBox() || petAnchor();
    hx = b.hx; top = b.headTop;
  }
  el.style.transform = 'rotate(180deg)';                 // 盆口朝下盖住头顶
  el.style.left = `${Math.round(hx - 42)}px`;
  el.style.top = `${Math.round(top + 10)}px`;   // 往下压住呆毛（原来是 top-12，悬在头顶上方）
  bowlState.raf = requestAnimationFrame(bowlFollowHead);
}
function makeBowlDraggable(el) {
  let dragging = false, moved = false, downX = 0, downY = 0, lastTapT = 0, lastTapX = 0, lastTapY = 0;
  let offX = 0, offY = 0, lastX = 0, lastY = 0, lastT = 0;
  let vx = 0, vy = 0, raf = 0;                     // 速度 px/ms
  const stop = () => { if (raf) cancelAnimationFrame(raf); raf = 0; };
  // 她身上"可戴"的范围：多来源取位 + 放得很宽，擦边也算
  function withinHerBox() {
    const r = el.getBoundingClientRect();
    const cx = r.left + r.width / 2, cy = r.top + r.height / 2;
    const boxes = [];
    const b = petBox(); if (b) boxes.push({ hx: b.hx, top: b.headTop - 200, bot: b.feet + 100, half: 200 });
    try {
      const pet = document.getElementById('pet');
      const pr = pet && pet.getBoundingClientRect();
      if (pr && pr.width) boxes.push({ hx: pr.left + pr.width / 2, top: pr.top - 200, bot: pr.bottom + 100, half: 200 });
    } catch (e) {}
    boxes.push({ hx: innerWidth * 0.62, top: innerHeight - 620, bot: innerHeight, half: 240 });   // 兜底：屏幕下方那片
    for (const bx of boxes) {
      if (Math.abs(cx - bx.hx) < bx.half && cy > bx.top && cy < bx.bot) return true;
    }
    return false;
  }
  function wear() { bowlState.onHead = true; if (!bowlState.raf) bowlState.raf = requestAnimationFrame(bowlFollowHead); }
  function unWear() {
    bowlState.onHead = false; el.style.transform = 'none';
    if (bowlState.raf) { cancelAnimationFrame(bowlState.raf); bowlState.raf = 0; }
  }
  el.style.pointerEvents = 'auto';
  el.style.cursor = 'grab';
  el.style.touchAction = 'none';
  el.addEventListener('pointerdown', (e) => {
    if (e.button && e.button !== 0) return;
    e.stopPropagation(); e.preventDefault();
    if (bowlState.onHead) unWear();
    const r = el.getBoundingClientRect();
    dragging = true; moved = false; stop();
    downX = e.clientX; downY = e.clientY;
    offX = e.clientX - r.left; offY = e.clientY - r.top;
    lastX = e.clientX; lastY = e.clientY; lastT = performance.now();
    vx = vy = 0;
    el.style.cursor = 'grabbing';
    try { el.setPointerCapture(e.pointerId); } catch (err) {}
  });
  el.addEventListener('pointermove', (e) => {
    if (!dragging) return;
    e.stopPropagation();
    if (!moved && Math.hypot(e.clientX - downX, e.clientY - downY) < 6) return;   // 手指没动就不算拖
    moved = true;
    const now = performance.now(), dt = Math.max(8, now - lastT);
    vx = vx * 0.55 + ((e.clientX - lastX) / dt) * 0.45;
    vy = vy * 0.55 + ((e.clientY - lastY) / dt) * 0.45;
    lastX = e.clientX; lastY = e.clientY; lastT = now;
    const inside = withinHerBox();
    if (inside && !bowlState.onHead) wear();                 // 进范围 → 立刻戴上
    else if (!inside && bowlState.onHead) unWear();          // 拖出去 → 回到手上
    if (!bowlState.onHead) {
      el.style.left = `${Math.round(e.clientX - offX)}px`;
      el.style.top = `${Math.round(e.clientY - offY)}px`;
      el.style.transform = `rotate(${Math.max(-14, Math.min(14, (e.clientX - lastX) * 1.6)).toFixed(1)}deg)`;
    }
  });
  const release = (e) => {
    if (!dragging) return;
    dragging = false;
    el.style.cursor = 'grab';
    // 没拖过 = 点了一下：双点（350ms / 30px 内）就取下，用时间判定，不依赖 dblclick
    if (!moved) {
      const now = performance.now();
      if (now - lastTapT < 350 && Math.hypot(e.clientX - lastTapX, e.clientY - lastTapY) < 30) {
        lastTapT = 0;
        unWear(); stop(); el.remove();
        return;
      }
      lastTapT = now; lastTapX = e.clientX; lastTapY = e.clientY;
      if (bowlState.onHead) return;                           // 戴着就别动它
    }
    try { el.releasePointerCapture(e.pointerId); } catch (err) {}
    if (bowlState.onHead) return;                            // 已经戴上了
    // 惯性：和桌宠一样按时间衰减（每秒衰减到 ~0.55），滑得更远
    let px = parseFloat(el.style.left) || 0, py = parseFloat(el.style.top) || 0;
    el.style.transform = '';
    const t0 = performance.now();
    const glide = (now) => {
      const dt = Math.min(34, now - t0) || 16;
      const k = Math.pow(0.55, dt / 1000);                   // 每秒衰减
      px += vx * dt; py += vy * dt;
      vx *= k; vy *= k;
      px = Math.min(innerWidth - 26, Math.max(-26, px));
      py = Math.min(innerHeight - 8, Math.max(-8, py));
      el.style.left = `${Math.round(px)}px`;
      el.style.top = `${Math.round(py)}px`;
      if (Math.abs(vx) < 0.05 && Math.abs(vy) < 0.05) return;
      raf = requestAnimationFrame(glide);
    };
    raf = requestAnimationFrame(glide);
  };
  el.addEventListener('pointerup', release);
  el.addEventListener('pointercancel', release);
  el.addEventListener('dblclick', (e) => { e.stopPropagation(); unWear(); stop(); el.remove(); });
}
function feedPet(unit) {
  const u = unit || world.active || world.primary;
  if (bowlTimer) { clearTimeout(bowlTimer); bowlTimer = 0; }
  const old = document.getElementById('petBowl'); if (old) old.remove();
  bowlState.onHead = false;
  bowlState.unit = u;                       // 盆跟着"喂的那只"（扣头上时也是它）
  const a = petAnchor(u);
  const groundY = a.feet;
  const x = Math.min(innerWidth - 56, Math.max(56, Math.round(a.hx + 52)));
  const el = document.createElement('div');
  el.id = 'petBowl';
  el.innerHTML = bowlSvg(false);
  el.style.cssText = `position:fixed;left:${x - 42}px;top:${groundY - 38}px;z-index:9;`;
  document.body.appendChild(el);
  makeBowlDraggable(el);
  try { el.animate([{ transform: 'translateY(-16px) scale(1.06)' }, { transform: 'translateY(0) scale(1)' }, { transform: 'translateY(-4px)' }, { transform: 'translateY(0)' }], { duration: 460, easing: 'ease-out' }); } catch (e) {}
  try { send({ t: 'feed' }); } catch (e) {}
  try { u.ct.walkTo(x); } catch (e) {}
  bowlTimer = setTimeout(() => {
    try { u.ct.setExpr('happy'); } catch (e) {}
    let n = 0;
    const chew = setInterval(() => {
      n += 1;
      const im = el.querySelector('.bowlImg');
      if (im) im.style.transform = `scaleY(${Math.max(0.86, 1 - n * 0.02)})`;   // 吃饭的轻微起伏
      if (n % 2 === 0) feedCrumb(x, groundY);
      if (n >= 7) {
        clearInterval(chew);
        // 空盆：铁盆留着，可以拖走 / 扣头上 / 双击取下
        const im = el.querySelector('.bowlImg'); if (im) im.src = '/web/props/bowl.png';
        try { u.say('谢谢主人～'); } catch (e) {}
      }
    }, 240);
  }, 900);
}

/* ---------- menu: the bot and its run controls on top, the actions below; every entry is a round icon button ---------- */
/**
 * 每只宠物**自己的**菜单：`menus` 里一只一份，互不共用（第 1 只沿用页面里那个 #menu）。
 * 打开谁的菜单，里面的每一项就只作用于谁 —— 按钮上直接记着 unit。
 */
const menus = new Map();
function menuFor(unit) {
  let el = menus.get(unit);
  if (el && document.body.contains(el)) return el;
  if (unit === world.primary) {
    el = menu;                       // 页面自带的那个
  } else {
    el = document.createElement('div');
    el.className = 'menu';
    el.id = 'menu' + unit.id;
    el.setAttribute('role', 'menu');
    document.body.appendChild(el);
  }
  el.hidden = true;
  menus.set(unit, el);
  return el;
}
function openMenu(unit, x, y) {
  const u = (unit && world.pets.includes(unit)) ? unit : (world.active || world.primary);
  const el = menuFor(u);
  menuUnit = u;
  el.innerHTML = '';
  el.appendChild(Object.assign(document.createElement('div'), { className: 'm-head' }));
  renderMenuHead(false, u);
  const grid = Object.assign(document.createElement('div'), { className: 'm-grid' });
  for (const id of Object.keys(ACTIONS)) {
    const a = ACTIONS[id];
    if (!(a.available?.(u) ?? true)) continue;
    const b = document.createElement('button');
    b.type = 'button'; b.setAttribute('role', 'menuitem');
    b.className = `m-tile${a.cls ? ' ' + a.cls : ''}`;
    b.dataset.action = id;
    b._unit = u;
    b.innerHTML = '<span class="ic"></span>';
    drawAction(b, id, u);
    b.addEventListener('click', () => {
      sfx.tick();
      if (!a.keep) closeMenu(u);
      a.run?.(u);
      if (a.keep) drawAction(b, id, u);
    });
    grid.appendChild(b);
  }
  el.append(grid);
  el.style.width = '';
  el.hidden = false;
  host?.focus?.();
  el.style.width = getComputedStyle(el).width;
  const w = el.offsetWidth, h = el.offsetHeight;
  el.style.left = f(clamp(x, 8, innerWidth - w - 8)) + 'px';
  el.style.top = f(clamp(y - h, 8, innerHeight - h - 8)) + 'px';
}

/**
 * Avatar and name, then the run controls the embedding app lends, as in the console's rail foot:
 * pause/resume, settings and the power button (which asks first). Without a bot the name is Coo's.
 */
function renderMenuHead(confirmQuit = false, unit) {
  const u = unit || world.primary;
  const head = menuFor(u).querySelector('.m-head'), bot = prefs.bot || {};
  if (!head) return;
  head.classList.toggle('confirm', confirmQuit);
  head.innerHTML = '<span class="m-avatar"></span><span class="m-name"></span><span class="m-acts"></span>';
  head.querySelector('.m-avatar').innerHTML = bot.avatar
    ? `<img alt="" src="/api/avatar?v=${encodeURIComponent(bot.avatar)}">`
    : `<svg viewBox="18 18 220 220" aria-hidden="true">${mini('neutral', u.ct.skin)}</svg>`;
  const name = head.querySelector('.m-name');
  name.textContent = name.title = confirmQuit ? bot.quitPrompt : (bot.name || 'Coo');
  const acts = head.querySelector('.m-acts');
  const act = (iconHtml, label, fn, cls = 'm-act') => {
    const b = document.createElement('button');
    b.type = 'button'; b.className = cls; b.title = label; b.setAttribute('aria-label', label);
    b.innerHTML = iconHtml;
    b.addEventListener('click', (e) => { e.stopPropagation(); sfx.tick(); fn(); });
    acts.appendChild(b);
  };
  if (!bot.controls) return;
  if (confirmQuit) {
    act(ICONS.power, bot.quitLabel, () => { closeMenu(); send({ t: 'control', action: 'quit' }); }, 'm-act danger');
    act('<span>取消</span>', '取消', () => renderMenuHead(), 'm-act text');
    return;
  }
  // only the controls the embedding app lent; a server without `buttons` lends all three
  const has = bot.buttons ?? { pause: true, settings: true, quit: true };
  if (has.pause) act(bot.paused ? ICONS.play : ICONS.pause, bot.paused ? '继续(现在暂停着)' : '暂停', () => send({ t: 'control', action: bot.paused ? 'resume' : 'pause' }), `m-act run${bot.paused ? ' paused' : ''}`);
  if (has.settings) act(ICONS.settings, '打开设置', () => { closeMenu(); send({ t: 'control', action: 'settings' }); });
  if (has.quit) act(ICONS.power, bot.quitLabel, () => renderMenuHead(true), 'm-act power');
}
function closeMenu(unit) {
  if (unit) { const el = menus.get(unit); if (el) el.hidden = true; return; }
  for (const el of menus.values()) el.hidden = true;
  menu.hidden = true;
}

/** Redraws whatever shows an action: the open menu's tiles and the hover buttons. */
function refreshButtons() {
  for (const el of menus.values()) {
    for (const b of el.querySelectorAll('.m-tile')) drawAction(b, b.dataset.action, b._unit);
  }
  renderTools();
}

/* ---------- hover buttons: the actions chosen in settings (chat and voice by default), beside the pet ---------- */
/** Seconds the buttons stay after the pointer leaves both the pet and them. */
const TOOLS_LINGER = .8;
/** Milliseconds the voice button is held before what was heard goes out. */
const HOLD_TO_SEND = 500;
let toolsUntil = 0;
let toolIds = '';

function renderTools() {
  const ids = prefs.hoverButtons.filter(available).slice(0, MAX_HOVER);
  if (ids.join(',') !== toolIds) {
    toolIds = ids.join(',');
    endHold();
    tools.innerHTML = '';
    // up to three in a column, then a second column
    tools.style.gridTemplateRows = `repeat(${Math.min(3, Math.max(1, ids.length))}, auto)`;
    for (const id of ids) {
      const b = document.createElement('button');
      b.type = 'button'; b.className = 'tool'; b.dataset.action = id;
      b.innerHTML = '<span class="ic"></span>';
      if (id === 'voice') wireVoiceTool(b);
      else b.addEventListener('click', () => { sfx.tick(); if (!ACTIONS[id].keep) toolsUntil = 0; ACTIONS[id].run(); refreshButtons(); });
      tools.appendChild(b);
    }
  }
  for (const b of tools.children) drawAction(b, b.dataset.action);
  const mic = tools.querySelector('[data-action="voice"]');
  if (mic) mic.classList.toggle('waiting', prefs.voice.enabled && !prefs.voice.ready);
}

/** A press shorter than HOLD_TO_SEND switches voice input; a longer one sends what was heard so far. */
const hold = { timer: 0, sent: false, el: null };
function endHold() {
  clearTimeout(hold.timer);
  hold.timer = 0;
  hold.el?.classList.remove('holding');
}
function wireVoiceTool(b) {
  b.style.setProperty('--hold', HOLD_TO_SEND + 'ms');
  b.addEventListener('pointerdown', (e) => {
    if (e.button !== 0) return;
    hold.sent = false; hold.el = b;
    if (!prefs.voice.enabled || !prefs.voice.ready) return;
    b.classList.add('holding');
    hold.timer = setTimeout(() => {
      endHold();
      hold.sent = true;
      send({ t: 'commit' });
      sfx.select();
      b.classList.remove('sent'); void b.offsetWidth; b.classList.add('sent');
    }, HOLD_TO_SEND);
  });
  b.addEventListener('pointerup', (e) => {
    if (e.button !== 0) return;
    const sent = hold.sent;
    endHold();
    hold.sent = false;
    if (!sent) { toggleVoice(); sfx.tick(); }
  });
  b.addEventListener('pointerleave', () => { endHold(); hold.sent = true; });
  b.addEventListener('pointercancel', () => { endHold(); hold.sent = true; });
  // the pointer handlers act on mouse and touch; a click with no pointer is the keyboard
  b.addEventListener('click', (e) => { if (e.detail === 0) { toggleVoice(); sfx.tick(); } });
}

/** Where the cursor is, in page pixels, or null when it is off the page. */
const cursor = { at: null };
function overTools(p) {
  if (tools.hidden) return false;
  const r = tools.getBoundingClientRect();
  // the gaps between the buttons and a little margin count too
  return p.x >= r.left - 6 && p.x <= r.right + 6 && p.y >= r.top - 6 && p.y <= r.bottom + 6;
}
function stepTools() {
  // shown while the cursor is on the pet or on the buttons, and a moment after it leaves; decided
  // from where the cursor is now, not from the last move event, which may be stale
  const p = cursor.at;
  const unit = world.active || world.primary;      // 按钮跟着「当前那只」走
  if (p && (world.hit(p) || overTools(p))) toolsUntil = ctl.time + TOOLS_LINGER;
  tools.hidden = !(ctl.time < toolsUntil && !world.pressing && !unit.ct.busy() && menu.hidden && toolIds !== '');
  if (tools.hidden) endHold();
  tools.querySelector('[data-action="voice"]')?.classList.toggle('live', listen.phase === 'hearing');
}

/* ---------- pointer ---------- */
let pointerSeen = false;
const lastPointer = { x: 0, y: 0 };
let interactive = null;
function setInteractive(on) {
  if (!host || interactive === on) return;
  interactive = on;
  host.setInteractive(on);
}
const UI_SELECTOR = '.bubble:not([hidden]), .menu:not([hidden]), .tools:not([hidden])';
const overUi = (e) => e.target.closest && e.target.closest(UI_SELECTOR);
/** 指针有没有落在任何一只身上（含刚拖的那只）。 */
const overAnyPet = (p) => !!world.pressing || !!world.hit(p);

document.addEventListener('pointermove', (e) => {
  pointerSeen = true;
  lastPointer.x = e.clientX; lastPointer.y = e.clientY;
  const p = { x: e.clientX, y: e.clientY };
  cursor.at = p;
  stage.style.cursor = world.pointerMove(p);      // 谁被按住就只动那只
  setInteractive(overAnyPet(p) || !!overUi(e));
});
/**
 * The pet window also reports where the cursor is on its own, a few times a second: a click-through
 * window may miss the move that takes the cursor off the pet (onto the taskbar, another screen),
 * and the hover buttons would then stay.
 */
host?.onCursor?.((p) => {
  cursor.at = p;
  if (!p) { if (!world.pressing) setInteractive(false); return; }
  const el = document.elementFromPoint(p.x, p.y);
  setInteractive(overAnyPet(p) || !!el?.closest?.(UI_SELECTOR));
});
stage.addEventListener('pointerdown', (e) => {
  if (e.button !== 0) return;
  closeMenu();
  // 点谁谁应：命中的那只独占这次拖拽，别的只原地不动
  const unit = world.pointerDown({ x: e.clientX, y: e.clientY });
  if (unit) {
    noteAttention(unit);
    if (unit !== world.primary && !world.pressing) unit.setMood('happy');
    if (world.pressing) { stage.setPointerCapture(e.pointerId); e.preventDefault(); }
  }
});
const up = () => { world.pointerUp(); stage.style.cursor = ''; };
stage.addEventListener('pointerup', up);
stage.addEventListener('pointercancel', up);
document.addEventListener('pointerleave', () => { cursor.at = null; world.pointerLeave(); });
stage.addEventListener('dblclick', (e) => {
  const unit = world.hit({ x: e.clientX, y: e.clientY });
  if (!unit) return;
  if (unit === world.primary) openInput(unit);
  else unit.say(EXTRA_LINES.poke[(Math.random() * EXTRA_LINES.poke.length) | 0]);
});
document.addEventListener('contextmenu', (e) => {
  e.preventDefault();
  const unit = world.hit({ x: e.clientX, y: e.clientY });
  if (!unit) return;
  world.active = unit;
  openMenu(unit, e.clientX, e.clientY);      // 每只一份菜单，只作用于它
});
document.addEventListener('pointerdown', (e) => { if (!e.target.closest('.menu')) closeMenu(); }, { capture: true });
// clicks off the figure pass through the window to what is underneath; the window losing focus is how they show here
window.addEventListener('blur', closeMenu);
document.addEventListener('focusin', (e) => {
  if (e.target.matches?.('input, textarea')) host?.focus?.();
});
document.addEventListener('keydown', (e) => {
  // Escape and number keys belong to the input method while choosing a candidate.
  if (e.isComposing || e.keyCode === 229) return;
  if (e.key === 'Escape') {
    closeMenu();
    if (item && item.kind === 'ask') dismissAsk();
    else if (item && item.kind === 'input') closeBubble();
    return;
  }
  const typing = e.target.closest && e.target.closest('input');
  // the digit row or the number pad, whether or not Num Lock is on
  const digit = /^(?:Digit|Numpad)([1-9])$/.exec(e.code) || /^([1-9])$/.exec(e.key);
  if (item && item.kind === 'ask' && item.optsShown && !item.answered && !typing && digit && !e.ctrlKey && !e.altKey && !e.metaKey) {
    e.preventDefault();
    const b = bubble.querySelectorAll('.b-opt')[+digit[1] - 1];
    if (b) b.click();
  }
});

/* ---------- layout ---------- */
function place(el, a, extraUp, side) {
  const bw = el.offsetWidth, bh = el.offsetHeight;
  const cx = a.x + side * (bw / 2 + 10);
  const left = clamp(cx - bw / 2 + (side ? 0 : ctl.pet.facing * 26), 10, Math.max(10, innerWidth - bw - 10));
  const top = Math.max(8, a.y - bh - extraUp);
  el.style.left = f(left) + 'px';
  el.style.top = f(top) + 'px';
  el.style.setProperty('--tail', f(clamp(a.x - left, 22, bw - 22)) + 'px');
  return { left, top, bw, bh };
}
function placeTalk(it, a) {
  const bw = bubble.offsetWidth, bh = bubble.offsetHeight;
  const left = clamp(it.pinX - bw / 2, 10, Math.max(10, innerWidth - bw - 10));
  const top = Math.max(8, it.pinY - bh - 18);
  bubble.style.left = f(left) + 'px';
  bubble.style.top = f(top) + 'px';
  bubble.style.setProperty('--tail', f(clamp(a.x - left, 22, bw - 22)) + 'px');
  return { left, top, bw, bh };
}

/** Beside the body, on the right unless that runs off the screen. */
function placeTools() {
  const unit = world.active || world.primary;
  const c = unit.ct.toStage(128, 128 + unit.pet.low), reach = 104 * unit.ct.bounds.S + 10;
  const w = tools.offsetWidth, h = tools.offsetHeight;
  const left = c.x + reach + w <= innerWidth - 8 ? c.x + reach : c.x - reach - w;
  tools.style.left = f(clamp(left, 8, innerWidth - w - 8)) + 'px';
  tools.style.top = f(clamp(c.y - h / 2, 8, innerHeight - h - 8)) + 'px';
}
function layout() {
  if (!tools.hidden) placeTools();
  const a = ctl.anchor();
  let sayBox = null;
  // choice cards keep their bubble where it was; its tail follows Coo along the bottom edge
  if (!bubble.hidden && item?.kind === 'dialog' && item.pinX !== undefined) sayBox = placeTalk(item, a);
  else if (!bubble.hidden) sayBox = place(bubble, a, 18, 0);
  if (!heardEl.hidden) {
    const side = sayBox ? -ctl.pet.facing : 0;
    const r = place(heardEl, a, 46, side);
    const bx = r.left + r.bw / 2, by = r.top + r.bh;
    [...trail.children].forEach((d, i) => {
      const k = [.22, .5, .78][i], sz = [7, 10, 13][i];
      d.style.width = d.style.height = sz + 'px';
      d.style.left = f(a.x + (bx - a.x) * k - sz / 2) + 'px';
      d.style.top = f(a.y - 4 + (by + 4 - a.y + 4) * k - sz / 2) + 'px';
    });
  }
}

/* ---------- backdrop: a light gray halo when the body melts into what is behind it ---------- */
/** Seconds between looks at the screen around the body. */
const BACKDROP_EVERY = .8;
/** OKLab distance under which a backdrop pixel counts as the body's color. */
const SAME_COLOR = .15;
/** Share of such pixels around the body that turns the halo on (most of them), and the share it turns off below. */
const HALO_ON = .6, HALO_OFF = .45;
/** The halo's opacity when fully on. */
const HALO_STRENGTH = .5;
const petG = $('#pet'), haloFlood = $('#haloFlood');
// a window host too old to sample the screen keeps the halo on; a browser tab draws its own wall
const backdrop = { on: !!host && !host.sampleBackdrop, fixed: !!host && !host.sampleBackdrop, k: 0, busy: false, next: 0 };

const lin = (c) => (c <= .04045 ? c / 12.92 : ((c + .055) / 1.055) ** 2.4);
function oklab(r, g, b) {
  r = lin(r / 255); g = lin(g / 255); b = lin(b / 255);
  const l = Math.cbrt(.4122214708 * r + .5363325363 * g + .0514459929 * b);
  const m = Math.cbrt(.2119034982 * r + .6806995451 * g + .1073969566 * b);
  const s = Math.cbrt(.0883024619 * r + .2817188376 * g + .6299787005 * b);
  return [.2104542553 * l + .793617785 * m - .0040720468 * s, 1.9779984951 * l - 2.428592205 * m + .4505937099 * s, .0259040371 * l + .7827717662 * m - .808675766 * s];
}
/** The body's color as [r, g, b], from `--skin-ink` (#rgb or #rrggbb). */
function inkRgb() {
  let h = getComputedStyle(document.documentElement).getPropertyValue('--skin-ink').trim().replace('#', '');
  if (h.length === 3) h = [...h].map((c) => c + c).join('');
  const n = parseInt(h, 16);
  return /^[0-9a-f]{6}$/i.test(h) ? [n >> 16, (n >> 8) & 255, n & 255] : null;
}
/** The figure's box in page pixels, from its geometry: the halo filter would widen its client rect. */
function bodyRect() {
  const top = Math.min(20, HEAD_TOP[ctl.skin.head] ?? 12);
  const pts = [[20, top], [236, top], [20, 256], [236, 256]].map(([x, y]) => ctl.toStage(x, y));
  const xs = pts.map((p) => p.x), ys = pts.map((p) => p.y);
  const x = Math.min(...xs), y = Math.min(...ys);
  return { x, y, width: Math.max(...xs) - x, height: Math.max(...ys) - y };
}
const inflate = (r, d) => ({ x: r.x - d, y: r.y - d, width: r.width + 2 * d, height: r.height + 2 * d });
const rectOf = (el) => { const r = el.getBoundingClientRect(); return { x: r.x, y: r.y, width: r.width, height: r.height }; };

/** Samples a ring around the body (past the halo's reach, minus the page's own bubbles) and flips the halo. */
async function probeBackdrop() {
  const ink = inkRgb();
  if (!ink) return;
  const body = bodyRect(), S = ctl.bounds.S;
  const near = inflate(body, 4 + 34 * S), far = inflate(near, 8 + 40 * S);
  const x = Math.max(0, far.x), y = Math.max(0, far.y);
  const rect = { x, y, width: Math.min(innerWidth, far.x + far.width) - x, height: Math.min(innerHeight, far.y + far.height) - y };
  const skip = [near, ...[bubble, heardEl, menu, tools].filter((el) => !el.hidden).map(rectOf)];
  const px = await host.sampleBackdrop(rect, skip);
  // this platform cannot read the screen cheaply: the halo just stays
  if (px === null) { backdrop.on = true; backdrop.fixed = true; return; }
  const n = px.length / 3;
  if (n < 24) return;
  const [L, A, B] = oklab(...ink);
  let same = 0;
  for (let i = 0; i < px.length; i += 3) {
    const [l, a, b] = oklab(px[i], px[i + 1], px[i + 2]);
    if (Math.hypot(l - L, a - A, b - B) < SAME_COLOR) same++;
  }
  const share = same / n;
  backdrop.on = backdrop.on ? share >= HALO_OFF : share > HALO_ON;
}
function stepBackdrop(dt) {
  const now = performance.now() / 1000;
  if (host?.sampleBackdrop && !backdrop.fixed && !backdrop.busy && now >= backdrop.next && document.visibilityState === 'visible') {
    backdrop.busy = true;
    probeBackdrop().catch(() => {}).finally(() => { backdrop.busy = false; backdrop.next = performance.now() / 1000 + BACKDROP_EVERY; });
  }
  const k = backdrop.k + ((backdrop.on ? 1 : 0) - backdrop.k) * Math.min(1, dt * 6);
  backdrop.k = k < .005 ? 0 : k;
  if (backdrop.k) { haloFlood.setAttribute('flood-opacity', (backdrop.k * HALO_STRENGTH).toFixed(2)); petG.setAttribute('filter', 'url(#halo)'); }
  else petG.removeAttribute('filter');
}

/* ---------- loop ---------- */
let last = performance.now();
function frame(now) {
  const dt = Math.max(0, Math.min(.05, (now - last) / 1000)); last = now;   // 时钟跳变不喂给物理
  stepActs();
  stepDialog(dt);
  stepTalkRead();
  stepTalkMotion();
  stepListen();
  // 键盘：地面缓动到目标高度（被顶起来的感觉，而不是瞬间跳），墙跟着走
  if (!Number.isFinite(prefs.kbTarget)) prefs.kbTarget = 0;      // NaN 会永久卡住缓动
  if (!Number.isFinite(prefs.kbLift)) prefs.kbLift = 0;
  {
    // 正在输入时地面不动（输入框跟着宠物移动会让输入法丢字）
    const typingNow = !!(document.activeElement && document.activeElement.matches
      && document.activeElement.matches('input, textarea, [contenteditable="true"]'));
    const diff = typingNow ? 0 : (prefs.kbTarget || 0) - prefs.kbLift;
    // 跟手：指数逼近 + 最小速度（大跳变时 1200px/s），不留"慢慢挪"的迟钝感
    const step = Math.max(Math.abs(diff) * Math.min(1, dt * 30), Math.min(Math.abs(diff), 1200 * dt));
    prefs.kbLift += Math.sign(diff) * step;
    if (Math.abs((prefs.kbTarget || 0) - prefs.kbLift) < 0.5) prefs.kbLift = prefs.kbTarget || 0;
  }
  if (kbWall) {
    kbWall.style.top = `${Math.round(innerHeight - floorGap() - (prefs.kbLift || 0) - 3)}px`;
    kbWall.style.opacity = (prefs.kbLift || 0) > 4 ? '0.85' : '0';
  }
  world.tick(dt);            // N 只一起 step + render，顺手把并集矩形报给原生
  stepBackdrop(dt);
  stepTools();
  layout();
  requestAnimationFrame(frame);
}
loadPetCount();
world.ensure(petsCount());
applySkins();
world.tick(0);
requestAnimationFrame(frame);

/* ---------- repair pad: user reports a bug, agent diagnoses (read-only) ---------- */
function openRepair() {
  const pad = document.getElementById('repairpad');
  if (!pad) return;
  pad.hidden = false;
  const out = pad.querySelector('.rp-out'); out.hidden = true;
  pad.querySelector('.rp-text').value = '';
  closeMenu?.();
}
function bindRepair() {
  const pad = document.getElementById('repairpad');
  if (!pad) return;
  pad.querySelector('.rp-x')?.addEventListener('click', () => { pad.hidden = true; });
  const out = pad.querySelector('.rp-out');
  pad.querySelector('.rp-go')?.addEventListener('click', async () => {
    const text = pad.querySelector('.rp-text').value.trim();
    const file = pad.querySelector('.rp-img').files?.[0];
    out.hidden = false; out.textContent = '诊断中…';
    let image;
    if (file) image = await new Promise((r) => { const fr = new FileReader(); fr.onload = () => r(fr.result); fr.readAsDataURL(file); });
    try {
      const res = await fetch('/api/repair', { method: 'POST', headers: { 'content-type': 'application/json' }, body: JSON.stringify({ text, image }) });
      const j = await res.json();
      if (j.status === 'no_key') out.textContent = '⚠️ ' + j.summary;
      else if (j.status === 'failed') out.textContent = '⚠️ ' + j.summary;
      else { const steps = (j.steps || []).map((x) => '· ' + x).join('\n'); out.textContent = '🔎 ' + j.summary + (steps ? '\n' + steps : '') + (j.tokens ? '\n\n(本次约 ' + j.tokens + ' tokens)' : ''); }
    } catch (e) { out.textContent = '⚠️ 诊断失败:' + (e && e.message ? e.message : e); }
  });
}
try { bindRepair(); } catch { /* 面板不在时忽略 */ }

// ---- 输入兜底：安卓输入法上屏走 composition/input，不一定有 keydown ----
// 页面上任何输入框（气泡里的"打字说话"等）回车即发送；中文上屏后回车也走同一条路。
document.addEventListener('keydown', (e) => {
  if (e.key !== 'Enter' || e.shiftKey || e.isComposing) return;
  const el = e.target;
  if (!el || (el.tagName !== 'INPUT' && el.tagName !== 'TEXTAREA')) return;
  const v = String(el.value || '').trim();
  if (!v) return;
  e.preventDefault();
  window.__petType(v);
  el.value = '';
}, true);
document.addEventListener('compositionend', (e) => {
  const el = e.target;
  if (el && el.form && el.tagName === 'INPUT' && el.dataset.petIme !== '1') el.dataset.petIme = '1';
}, true);

/* ---------- 分身 App（com.palai.cooclone）的位置上报 ---------- */
try {
  if (typeof window.cooClone !== 'undefined' && window.cooClone && window.cooClone.petRect) {
    setInterval(function () {
      try {
        var el = document.getElementById('pet');
        if (!el) return;
        var r = el.getBoundingClientRect();
        if (r && r.width) { const d = window.devicePixelRatio || 1; window.cooClone.petRect(r.left * d, r.top * d, r.right * d, r.bottom * d); }
      } catch (e) {}
    }, 100);
  }
} catch (e) {}

/* ---------- 看门狗：换皮肤后万一第 1 只没渲染出来，自动救回来 ---------- */
const PET_REVIVE = { empty: 0, lastGood: null, warned: false };
setInterval(function () {
  try {
    const el = document.getElementById('pet');
    if (!el) return;
    const r = el.getBoundingClientRect();
    const ok = r && r.width > 4 && r.height > 4;
    if (ok) {
      PET_REVIVE.empty = 0;
      try { PET_REVIVE.lastGood = JSON.parse(JSON.stringify(ctl.skin || {})); } catch (e) {}
      PET_REVIVE.warned = false;
      return;
    }
    PET_REVIVE.empty += 1;
    if (PET_REVIVE.empty >= 2 && PET_REVIVE.lastGood) {      // 连续两次没渲染 → 回滚皮肤
      try { ctl.setSkin(PET_REVIVE.lastGood); } catch (e) {}
      if (!PET_REVIVE.warned) {
        PET_REVIVE.warned = true;
        try { if (typeof say === 'function') say('这个皮肤好像没法用，我先换回来啦～'); } catch (e) {}
      }
      PET_REVIVE.empty = 0;
    }
  } catch (e) {}
}, 1000);

/* ---------- 宠物之间：吃醋 / 冲撞 / 拌嘴（蓝图 §3；碰撞盒 = 每只脚下一小块） ---------- */
const EXTRA_LINES = {
  poke: ['嘿嘿', '别戳我啦', '再来一次？'],
  jealous: ['哼…不理我？', '就知道跟他说话', '喂…也理理我嘛', '我也要吃的！'],
  charge: ['嗷——撞你！', '让开让开！', '撞到了吧！'],
  happy: ['嘿嘿～', '气消了', '算你识相'],
};
/** 等 AI"两只对话"回包的时间窗（毫秒时间戳）；0 = 没在等。 */
let expectPetChat = 0;

/** 无障碍（眼睛）在跑吗？页面从原生回报里知道（`__petIme` 的 via 里带 a11y=…）。 */
function a11yOn() {
  const via = String(window.__imeVia || '');
  return /a11y=(on|\d)/.test(via);
}

/** 让两只通过 AI 互相说两句（内容全部由模型写，页面没有内置台词）。 */
function tryPetChat(actor, target) {
  if (!actor || !target) return false;
  if (!a11yOn()) return false;                       // 看不见对方就不硬聊
  expectPetChat = Date.now() + 25000;
  try { send({ t: 'petChat', from: actor.id, to: target.id }); } catch (e) { return false; }
  return true;
}

/** 把 AI 的一段对话分给两只：优先认 `[1]…[2]…` 标记，没有标记就按句子交替。 */
function routePetChat(beats) {
  const units = world.pets;
  const text = (Array.isArray(beats) ? beats : [beats]).map(beatText).join('\n');
  if (units.length < 2) { world.primary.say(beats); return; }
  const parts = [];
  const re = /\[\s*([12])\s*\]([^\n]*)/g;
  let m;
  while ((m = re.exec(text))) if (m[2].trim()) parts.push([Number(m[1]), m[2].trim()]);
  if (!parts.length) {
    text.split(/[\n。！？!?]+/).map((t) => t.trim()).filter(Boolean).slice(0, 4)
      .forEach((t, i) => parts.push([(i % 2) + 1, t]));
  }
  let at = 0;
  for (const [id, line] of parts) {
    const u = units.find((p) => p.id === id) || units[0];
    setTimeout(() => { try { u.say(line, Math.max(2400, line.length * 220)); } catch (e) {} }, at);
    at += Math.max(1600, line.length * 180);
  }
}

const clash = { at: 0, lastFrom: 0 };
/** 两只之间"互相搭话"的台词（谁先开口都行）。 */
const CHAT_LINES = [
  ['你今天也在偷懒呀', '才没有，我在值班'],
  ['主人先摸的是我', '胡说，明明是我'],
  ['要不要一起下去吃点东西', '好呀，谁先抢到盆算谁的'],
  ['别老挤我', '地方就这么大嘛'],
];
const aabb = (a, b) => !!a && !!b && a.l < b.r && a.r > b.l && a.t < b.b && a.b > b.t;

/** 一只朝另一只冲过去：命中后回调（谁撞谁由页面说，不靠窗口）。 */
function chargeAt(from, to, onHit) {
  if (!from || !to || from === to) return;
  if (from.ct.busy() || to.ct.busy()) return;
  from.setMood('angry');
  from.say(EXTRA_LINES.jealous[0]);
  setTimeout(() => {
    if (!world.pets.includes(from) || !world.pets.includes(to) || from.ct.busy()) return;
    from.say(EXTRA_LINES.charge[(Math.random() * EXTRA_LINES.charge.length) | 0], 1800);
    from.ct.walkTo(to.pet.x, true);
    // 冲撞判定：两脚的碰撞盒相交即命中（和墙同一套数据）
    const watch = setInterval(() => {
      if (!world.pets.includes(from) || !world.pets.includes(to)) { clearInterval(watch); return; }
      if (!aabb(from.box(), to.box())) return;
      clearInterval(watch);
      try { onHit?.(); } catch (e) {}
    }, 60);
    setTimeout(() => clearInterval(watch), 2400);
  }, 1100);
}

/** 每 10 秒：两只**互相**互动一次 —— 谁先开口是随机的，被撞的那只会回嘴。 */
setInterval(() => {
  const pets = world.pets;
  if (pets.length < 2) return;
  const now = Date.now();
  if (now - clash.at < 12000) return;
  clash.at = now;
  // 谁先开口：上一轮是谁，这轮就换另一个（这样"第 2 只理第 1 只、第 1 只不理他"的情况不会发生）
  const a = pets[0], b = pets[1];
  if (!a || !b) return;
  const actor = clash.lastFrom === a.id ? b : a;
  const target = actor === a ? b : a;
  clash.lastFrom = actor.id;
  const roll = Math.random();
  if (roll < 0.3) {
    // 冲撞：撞到之后被撞的那只**一定会**回应
    chargeAt(actor, target, () => {
      target.setMood('surprised');
      target.say(actor === a ? '哎哟！你干嘛啦～' : '撞我干嘛啦～');
      setTimeout(() => target.setMood('happy'), 2600);
      actor.setMood('happy');
      actor.say(EXTRA_LINES.happy[(Math.random() * EXTRA_LINES.happy.length) | 0]);
    });
  } else if (roll < 0.75) {
    // 30% 走 AI：台词由模型现写（页面不存内置台词）；无障碍开着才算"看得见对方"
    tryPetChat(actor, target);
  } else {
    // 吃醋/撒娇：一方抱怨，另一方一定接一句
    actor.say(EXTRA_LINES.jealous[(Math.random() * EXTRA_LINES.jealous.length) | 0], 3000);
    setTimeout(() => target.say(actor === a ? '我哪有～' : '知道啦知道啦', 3000), 1500);
  }
}, 8000);
/* ---------- 主动搭话：菜单里选时长（纯页面，不碰服务端） ---------- */
let chatterTimer = 0;
function setChatter(minutes) {
  const n = Number(minutes) || 0;
  prefs.chatter = n;
  try { localStorage.setItem('cortico.chatter.min', String(n)); } catch (e) {}
  if (chatterTimer) { clearInterval(chatterTimer); chatterTimer = 0; }
  if (n > 0) {
    chatterTimer = setInterval(function () {
      try { send({ t: 'text', text: '（现在主动跟主人搭一句话）' }); } catch (e) {}
    }, Math.max(20000, Math.round(n * 60000)));
  }
}
try {
  const saved = Number(localStorage.getItem('cortico.chatter.min'));
  if (saved > 0) setChatter(saved);
} catch (e) {}

/* ---------- 第 1 只气泡直写（不依赖 say 的作用域） ---------- */
function showBubble1(text, ms) {
  try {
    const b = document.getElementById('bubble');
    if (!b) return;
    const t = b.querySelector('.b-text') || b;      // 有文字节点就写它，否则整个气泡
    t.textContent = text;
    b.hidden = false;
    b.classList.add('show');
    clearTimeout(showBubble1.timer);
    showBubble1.timer = setTimeout(function () { try { b.hidden = true; b.classList.remove('show'); } catch (e) {} }, Number(ms) || 6000);
  } catch (e) {}
}
