/**
 * 每只一份装扮（重写版）——**服务端为准**。
 *
 * 为什么不用 localStorage：装扮页是原生用浏览器打开的（`startActivity(ACTION_VIEW, /dress)`），
 * 浏览器和桌宠 WebView 是两个 App，存储不互通。所以皮肤的真相在服务端：
 *   第 1 只 `cfg.skin`，第 2 只 `cfg.skin2`；页面只负责按 prefs 穿、改完 POST /api/skin。
 *
 * 颜色是 CSS 变量：第 1 只写全局（菜单/气泡边框跟它），第 2 只挂在 `#pet2` 上，互不串味。
 */

import { normalizeSkin, skinVars, skinCss } from '../pet-core.js';

/** 第 N 只现在该穿的皮：第 1 只 prefs.skin；第 2 只 prefs.skin2，没设就跟第 1 只一样。 */
export function skinFor(id, prefs) {
  const fallback = prefs?.skin || normalizeSkin(null);
  if (id === 1) return fallback;
  return prefs?.skin2 || fallback;
}

/** 第 1 只写全局，其它的挂在各自的 <g id="petN"> 上。 */
export function skinCssFor(pairs) {
  let css = '';
  const first = pairs.find(([id]) => id === 1);
  if (first) css += skinCss(first[1]);
  for (const [id, skin] of pairs) {
    if (id === 1) continue;
    const sel = '#pet' + id;
    css += `${sel}{${skinVars(skin, false)}}`
      + `html[data-theme="dark"] ${sel}{${skinVars(skin, true)}}`;
  }
  return css;
}

/** 页面内换皮：先本地穿上，再让服务端记住（服务端广播回来会再对齐一次）。 */
export function saveSkin(skin, pet) {
  try {
    fetch('/api/skin', {
      method: 'POST',
      headers: { 'content-type': 'application/json' },
      body: JSON.stringify({ skin, pet }),
    });
  } catch (e) {}
}
