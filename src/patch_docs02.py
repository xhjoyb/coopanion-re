#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""按取证结果修正 docs/02-Java层源码还原.md 的悬空引用与事实错误。
每条替换都要求 old 在全文中恰好出现 1 次，否则整体中止（不写盘）。"""
import sys

PATH = '02-Java层源码还原.md'
s = open(PATH, encoding='utf-8').read()

R = []

# ── 1. PET_HOST_SHIM 悬空引用（原指 §5.1，而 §5 是 EyesService）
R.append((
'    private static final String PET_HOST_SHIM = "…见 §5.1…";',
'    private static final String PET_HOST_SHIM = INJ_01;      // inj_01 全文（1062 B），编译期折叠进 static_values，见 docs/03 §3',
))

# ── 2. TOUCH_SIZE 真值 700，且是死常量
R.append((
'    private static final int TOUCH_SIZE = 520;   // 触摸层边长（px）',
'    private static final int TOUCH_SIZE = 700;   // 真值 700；**全类零引用（死常量）**，实际尺寸见本节的 flags 说明',
))

# ── 3. CHANNEL 真值
R.append((
'    private static final String CHANNEL = "coop-pet";',
'    private static final String CHANNEL = "coopanion_pet";',
))

# ── 4. 触摸层注释：520 只是初值
R.append((
'    // ── 触摸层：520×520 小窗，可拖动，只覆盖宠物本体附近',
'    // ── 触摸层：初始 520×520 小窗，之后随页面并集矩形实时缩放，只覆盖宠物本体附近',
))

# ── 5. petX / petY 只写不读
R.append((
'    private volatile float petX, petY;           // 触摸层左上角',
'    private volatile float petX, petY;           // 并集矩形中心（物理 px）；只写不读，调试残留',
))

# ── 6. followTick 真实职责
R.append((
'    private final Runnable followTick = …;       // 定频把 showLp 对齐到 touchLp',
'    private final Runnable followTick = …;       // 每 80ms 调一次 queryPetRect()，自续期不停',
))

# ── 7. 两层 flags：三 flag → 完整 6/4 flag，并补静态值取证说明
R.append((
'两层都以 `wm.addView(...)` 挂上；显示层 `FLAG_NOT_FOCUSABLE | FLAG_NOT_TOUCHABLE | FLAG_LAYOUT_NO_LIMITS`，\n'
'触摸层只留 `FLAG_NOT_FOCUSABLE`（可由手势拖动）。日志：`[PET] 显示层已挂载（全屏穿透）` / `[PET] 触摸层已挂载 520x520`。',
'> 上面 8 个 `static final` 的真值不是从 Java 代码推的，是从 DEX `class_def_item.static_values_off` 指向的\n'
'> `encoded_array` 里取的（脚本 `src/read_static.py`）：本类**没有 `<clinit>`**，这些常量已被 javac 折叠，\n'
'> 字段本身是死的，值只存在于静态值表。\n'
'\n'
'两层都以 `wm.addView(...)` 挂上。两个 `flags` 同样是 smali 里的整型常量，逐位拆开：\n'
'\n'
'| 层 | 构造实参 `(w, h, type, flags, format)` | `flags` | 逐位含义 |\n'
'|---|---|---|---|\n'
'| 显示层 `showLp` | `(-1, -1, type, 66328, -3)` | `0x102D8` | `0x8` NOT_FOCUSABLE · `0x10` NOT_TOUCHABLE · `0x40` TOUCHABLE_WHEN_WAKING · `0x80` KEEP_SCREEN_ON · `0x200` LAYOUT_NO_LIMITS · `0x10000` LAYOUT_INSET_DECOR |\n'
'| 触摸层 `touchLp` | `(520, 520, type, 808, -3)` | `0x328` | `0x8` NOT_FOCUSABLE · `0x20` NOT_TOUCH_MODAL · `0x100` LAYOUT_IN_SCREEN · `0x200` LAYOUT_NO_LIMITS |\n'
'\n'
'即**显示层全屏且完全穿透**（`NOT_TOUCHABLE`，事件直接落到底下的 App / 桌面）；\n'
'**触摸层并不是「只留 `FLAG_NOT_FOCUSABLE`」**——它另带 `NOT_TOUCH_MODAL`（窗外事件照常下传）与两个 LAYOUT flag。\n'
'`gravity` 两层都是 `0x800033`（`TOP|START`）、`x = y = 0`；触摸层额外 `softInputMode = 16`（`SOFT_INPUT_ADJUST_RESIZE`）。\n'
'日志：`[PET] 显示层已挂载（全屏穿透）` / `[PET] 触摸层已挂载 520x520`——`520` 是日志文案里的字面量，**不是** `TOUCH_SIZE`。\n'
'\n'
'> 完整推导（含 `PetKeyboardGuard.install(ctx, null, null)`、`imeProxy` 的 `0x2000006` 两个 IME flag）见 `docs/03 §5`。',
))

# ── 8. §5.2 → docs/03 §6.2
R.append((
'/** 向页面要一次并集包围盒（页面里的 window.__petUnionRect，见 §5.2）。 */',
'/** 向页面要一次并集包围盒（页面里的 window.__petUnionRect，见 `docs/03 §6.2`）。 */',
))

# ── 9. queryPetRect 回调不是 applyRect（本类无此方法）
R.append((
'        value -> { if (value != null && !"null".equals(value)) applyRect(value); });',
'        new PetWindowService$15(this));   // 回调是 $15.onReceiveValue，本类没有 applyRect 方法',
))

# ── 10. sizeTouchTo 签名是 (x, y, w, h)
R.append((
'/** "l,t,r,b|focused" → 调整触摸层位置与尺寸。 */\n'
'private void sizeTouchTo(int l, int t, int r, int b) { … }',
'/** 触摸层去抖落位：四个 int 与 lastTouchX/Y/W/H 全等就丢弃，否则 post($17) 改 touchLp。参数是 (x, y, w, h)。 */\n'
'private void sizeTouchTo(int x, int y, int w, int h) { … }',
))

# ── 11. __repaintHack 悬空引用
R.append((
'定期 `evaluateJavascript` 触发一次强制 `transform`，见 §5.2 的 `__repaintHack`。',
'定期 `evaluateJavascript` 触发一次强制 `transform`（`PetWindowService$13` + inj_04 `__repaintHack`，见 `docs/03 §2` 表中第 6 行）。',
))

# ── 12. ImeCommitConnection 是内嵌类
R.append((
'static final class ImeCommitConnection implements InputConnection {',
'static final class PetWindowService$ImeCommitConnection implements InputConnection {   // 内嵌类，非顶层类',
))

# ── 13. §5.3 → docs/03 §7.4
R.append((
'private void pushTextToPage(String text) {   // §5.3 inj_06：追加并派发 input 事件',
'private void pushTextToPage(String text) {   // `docs/03 §7.4` inj_06：追加并派发 input 事件',
))

# ── 14. applyInputFocus 的真实作用（原文错说「切换两层触摸能力 + 上报键盘高度」）
R.append((
'`applyInputFocus(boolean on)`：切换触摸层与显示层的触摸能力，并把键盘高度告知页面\n'
'（`window.__petKeyboard(h)`）；页面侧据此把宠物「站到键盘上方」（`prefs.kbLift`）。',
'`applyInputFocus(boolean on)`：**只动触摸层的一个 flag**——`on` 时 `touchLp.flags &= ~0x8`\n'
'（临时清掉 `FLAG_NOT_FOCUSABLE`，否则输入法不肯弹），`off` 时 `|= 0x8` 复位；两次都 `updateViewLayout(touchLp)`，\n'
'`off` 分支还会 `imm.hideSoftInputFromWindow(imeProxy.getWindowToken(), 0)` + `imeProxy.clearFocus()`。\n'
'\n'
'> 两个常见误读：① 它**不碰显示层**；② 它**不上报键盘高度**。键盘高度是另一条独立链路\n'
'> （`PetKeyboardGuard.reportIme` / `reportKeyboard` → 注入 `window.__petKeyboard(h)`，见 `docs/03 §2`）。\n'
'> 日志文案 `inputFocus=false -> NOT_FOCUSABLE ON` 里的 ON/OFF 指的是「`inputFocus` 关闭」，\n'
'> 不是「`NOT_FOCUSABLE` 被打开」——极易读反。',
))

# ── 15. focusImeAndShow 真实实现
R.append((
'private void focusImeAndShow() {\n'
'    imeProxy.requestFocus();\n'
'    InputMethodManager imm = (InputMethodManager) getSystemService(INPUT_METHOD_SERVICE);\n'
'    imm.showSoftInput(imeProxy, InputMethodManager.SHOW_IMPLICIT);\n'
'    applyInputFocus(true);\n'
'}',
'/** 由 $16$1 / $16$2 在 120ms / 450ms 各调一次（两次尝试，抗 ROM 差异）；它自己不调 applyInputFocus。 */\n'
'private void focusImeAndShow() {\n'
'    if (imeProxy == null) return;\n'
'    imeProxy.setFocusable(true);                 // 注意：与 buildAndAttachLayers 里的 setFocusable(false) 相对\n'
'    imeProxy.setFocusableInTouchMode(true);\n'
'    imeProxy.requestFocus();\n'
'    InputMethodManager imm = (InputMethodManager) getSystemService("input_method");\n'
'    if (imm != null) imm.showSoftInput(imeProxy, 1 /*SHOW_IMPLICIT*/);\n'
'    Log.i(TAG, "[PET] 已请求 IME（hasFocus=" + imeProxy.hasFocus() + "）");   // 这行日志是排障唯一入口\n'
'}',
))

# ── 16. Sink 三个方法落到哪里（原文只说「两个 JS 调用」）
R.append((
'Sink 落到两个 JS 调用：',
'Sink 的三个方法落到 `PetWindowService$8$1`：`onCommit(s)` → `pushTextToPage(s)`；'
'`onDelete()` → `pushKeyToPage("Backspace")`（**实参写死，调用方传什么都忽略**）；'
'`onClearLocal()` → `imeProxy.setText("")`。前两个落到下面两个 JS 调用：',
))

bad = []
for old, new in R:
    n = s.count(old)
    if n != 1:
        bad.append((n, old[:60]))
        continue
    s = s.replace(old, new)

if bad:
    print('ABORT — 以下 old 未唯一匹配：')
    for n, head in bad:
        print('  count=%d  %r' % (n, head))
    sys.exit(1)

open(PATH, 'w', encoding='utf-8').write(s)
print('OK — %d 处替换已写入' % len(R))
