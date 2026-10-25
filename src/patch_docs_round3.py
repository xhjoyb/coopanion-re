#!/usr/bin/env python3
# -*- coding: utf-8 -*-
r"""第四轮文档一致性回改：把 `docs/03 §12` 五项取证的结论落盘。

纪律（沿用 src/patch_docs02.py / patch_docs_round2.py 的模式）：
  每条 old 必须在全文出现且仅出现 1 次，否则整体中止、不写任何文件。
  old 命中 0 次时额外打印「首行前 24 字符」的相似行 repr，便于定位缩进/空格差异。

本轮改动点（10 组）：
  docs/00  1) §8.2 五项未取证表 → 结论表
           2) §8.3 标题 3 处→5 处，表格补 switch payload 一行
           3) §11 表第 1 行标记完成
  docs/03  4) §12 五条 bullet → 12.1–12.5 细则
  docs/02  5) §5 captureOnce / jpeg 的真实签名与参数
           6) §5 imeHeightSmart 的三态语义
           7) §8.2 BASE_TOUCH 死字段（原写 = 240 是错的）
           8) §8.2 sync() 可见性 + 断链结论
           9) §8.4 clampH / imeHeight 的真实细节
          10) §10 未逐行还原表删掉已取证的两行
  docs/04 11) §5.7 补第 4 条：不解析 switch payload
"""
import sys


ROUNDS = {
    # ── docs/00 ────────────────────────────────────────────────────────────
    "docs/00-总目录与导读.md": [
        (
            "### 8.2 `docs/03 §12` 列出的 5 项未取证\n"
            "\n"
            "| # | 项 | 现状 |\n"
            "|---|---|---|\n"
            "| 1 | `PetWindowService$11$1`（首帧后 32 ms 的任务） | 只确认 `postDelayed(…, 32)`，未读 `run()` |\n"
            "| 2 | `PetWindow2` 的矩形链路（`$2` / `$Bridge`） | 已定位未逐行；页面侧调 `pet2Native.petRect(l,t,r,b)` |\n"
            "| 3 | `VoiceBridge` 的 `SpeechRecognizer` extras | 只确认 `Intent` 存在，语言/部分结果/静音超时未核对 |\n"
            "| 4 | `EyesService.captureOnce` | 与桥接无关，见 `02 §5` |\n"
            "| 5 | `PetKeyboardGuard` 高度计算（`hPhys` 来源） | 只还原 4 个入口，内部计算未逐行 |\n",
            "### 8.2 `docs/03 §12` 列出的 5 项未取证（**已全部取证**）\n"
            "\n"
            "第二轮逐行读完这 5 项，其中 **2 项推翻了此前的推测**。细则见 `03 §12.1–12.5`。\n"
            "\n"
            "| # | 项 | 取证结论 | 推翻旧推测 |\n"
            "|---|---|---|---|\n"
            "| 1 | `PetWindowService$11$1`（首帧后 32 ms 的任务） | **布局就绪后的二次 `loadUrl`**"
            "（`loadUrl('http://127.0.0.1:7797/pet')` + 打日志），**不是** `queryPetRect()`；`$11.onLayoutChange` 只在 "
            "`w > 0 && h <= 0` 时置 `loaded` 并 `postDelayed(32)`，监听器挂在 `showBox` 上 | ✅ |\n"
            "| 2 | `PetWindow2` 的矩形链路（`$2` / `$Bridge`） | **链路是断的，整个类是死代码**：页面判据是 "
            "`typeof n.petRect === 'function'`，原生暴露的却是 `rect(FFFF)`；`PetWindow2` 全库无外部类引用、"
            "`start()`/`stop()` 零调用，`petL/T/R/B` 恒 `-1` | ✅ |\n"
            "| 3 | `VoiceBridge` 的 `SpeechRecognizer` extras | 5 个全部拿到：`LANGUAGE_MODEL=free_form`、"
            "`LANGUAGE=zh-CN`、`PARTIAL_RESULTS=true`、`MAX_RESULTS=1`、`calling_package=<pkg>`；"
            "action = `RECOGNIZE_SPEECH` | — |\n"
            "| 4 | `EyesService.captureOnce` | 真实签名 `private byte[] captureOnce(int max, int q)`，"
            "`latch.await(9000ms)`；`jpeg()` 是 700 ms 缓存 / 1200 ms 最小间隔 / 3 次重试 / 2500 ms 旧图回退 | — |\n"
            "| 5 | `PetKeyboardGuard` 高度计算（`hPhys` 来源） | `hPhys` 是**页面侧形参名**"
            "（`pet-app.js` 的 `__petKeyboard = (hPhys, seq) =>`），Java 只传物理像素原值；"
            "Java 侧 `imeHeight()` 五级兜底，`clampH` 上限 `screenH * 0.75` | — |\n",
        ),
        (
            "### 8.3 工具链的 3 处已知缺陷 + 3 个 TODO",
            "### 8.3 工具链的 5 处已知缺陷 + 3 个 TODO",
        ),
        (
            "| `dex2smali.py` | 少数 `invoke` 成员签名拼错（如 `setTextSize` 缺 `(F)V`） | 只影响签名文本 | 看类名+方法名即可，不必修 |\n",
            "| `dex2smali.py` | 少数 `invoke` 成员签名拼错（如 `setTextSize` 缺 `(F)V`） | 只影响签名文本 | 看类名+方法名即可，不必修 |\n"
            "| `dex2smali.py` | 不解析 `packed-switch` / `sparse-switch` 的 payload | case 值与目标地址的映射丢失"
            "（本包仅 `VoiceBridge.errName` 命中） | 输出 `:pswitch_data` 块；或按 `04 §5.7` 第 4 条手工核对 |\n",
        ),
        (
            "| 1 | 补齐 `03 §12` 的 5 项未取证（都是读几十行 smali） | 2–3 h | 协议文档从「基本完整」到「无空白」 |\n",
            "| ~~1~~ | ~~补齐 `03 §12` 的 5 项未取证~~ **已完成**：5 项全部逐行取证，推翻 2 处旧推测，"
            "并顺带查出第 4 个工具缺陷（switch payload） | 实耗 ~2 h | `03 §12` 已无空白；`00 §8.2` 换成结论表 |\n",
        ),
    ],
}


# ── docs/03 §12 整节重写（内容长，单列以免字典过宽）────────────────────
DOCS03 = "docs/03-Java与JS桥接协议.md"
SEC12_OLD = (
    "## 12. 未取证 / 未还原\n"
    "\n"
    "- **`PetWindowService$11$1`（首帧后 32ms 的任务）**：只确认是 `postDelayed(..., 32)`，\n"
    "  未逐行读其 `run()`。推测是首次 `queryPetRect()` 或 `warmUpRenderer` 的第二步。\n"
    "- **`PetWindow2` 的矩形链路**：`PetWindow2$2`、`PetWindow2$Bridge` 已定位但未逐行还原，\n"
    "  推测与 `PetWindowService` 同构（`petRect` 方法名不同：页面侧调 `pet2Native.petRect(l,t,r,b)`）。\n"
    "- **`VoiceBridge` 的 `SpeechRecognizer` 启动参数**：`startListening` 的 `Intent` 只确认存在，\n"
    "  语言/部分结果/静音超时等 extras 未逐条核对。\n"
    "- **`EyesService.captureOnce`**：属无障碍截屏链路，与本文桥接无关，见 `docs/02` §5。\n"
    "- **`PetKeyboardGuard` 的全部静态方法**：只还原了 `install` / `setTouchLayer` /\n"
    "  `reportIme` / `reportKeyboard` 四个入口，内部的高度计算（`hPhys` 来源）未逐行还原。\n"
)

SEC12_NEW = r"""## 12. 未取证 / 未还原

> **本节已在第二轮清空**：原列 5 项全部逐行读完，其中 **2 项推翻了本节此前的「推测」**。
> 表格版摘要见 `docs/00 §8.2`，这里记细节与可复现命令。

### 12.1 `PetWindowService$11$1`：布局就绪后的二次 `loadUrl`

原推测「`queryPetRect()` 或 `warmUpRenderer` 第二步」**不成立**。`run()` 全文只有三句：

```java
web.loadUrl("http://127.0.0.1:7797/pet");
Log.i("PetWindow", "[PET] loadUrl(布局就绪后) -> http://127.0.0.1:7797/pet");
```

触发链在 `$11.onLayoutChange(View v, int l, int t, int r, int b, …)`：

```java
if (loaded) return;          // loaded 是 $11 的实例字段，只触发一次
int w = r - l, h = b - t;
if (w > 0 && h <= 0) {       // 只看「宽度有了、高度还是 0」这一帧
    loaded = true;
    ui.postDelayed(new $11$1(this$0), 32);
}
```

监听器挂在 **`showBox`** 上（`PetWindowService.smali:486-488` 的 `addOnLayoutChangeListener`），
不是 `touchBox`。同段后续还有 `$12`（`postDelayed(1000)`）与 `followTick`（`postDelayed(300)`）。

**完整加载时序**（把 5 处 `loadUrl` / `postDelayed` 串起来）：

| 步 | 动作 | 位置 |
|---|---|---|
| 1 | `showPetWindow()` 里配 WebView：`setJavaScriptEnabled` / `setDomStorageEnabled` / `setAllowFileAccess` / `setMixedContentMode(0)` / `setMediaPlaybackRequiresUserGesture(false)` / `setUseWideViewPort` / `setLoadWithOverviewMode` / 透明背景 / `setLayerType(0,null)` / 关双向滚动条 / `setOverScrollMode(2)` | `showPetWindow` |
| 2 | `warmUpRenderer(new $2(type))` | 同上 |
| 3 | 预热页 `loadUrl` | `:994` |
| 4 | `$4.onPageFinished` 打「预热页加载完成，再等 400ms 让合成器落定」→ `postDelayed(finish, 400)` | `$4` |
| 5 | `$2.run()` → `-$$Nest$mbuildAndAttachLayers(type)` → **正式 `loadUrl`** | `$2` / `buildAndAttachLayers` |
| 6 | `$11.onLayoutChange` → `postDelayed($11$1, 32)` → **二次 `loadUrl`** | `$11` / `$11$1` |

`onDestroy` 里的 `loadUrl("about:blank")`（`:1080`）是唯一另一处 `loadUrl`。

### 12.2 `PetWindow2`：矩形链路是断的，整个类是死代码

原推测「与 `PetWindowService` 同构」**两层都不成立**。

**(1) 桥名对不上。** 页面 `pet-multi.js:487`：

```js
for (const name of ['petRectNative', 'pet2Native', 'cooClone']) {
  const n = window[name];
  if (n && typeof n.petRect === 'function') { try { n.petRect(...args); } catch (e) {} }
}
```

原生 `PetWindow2$Bridge` 只有三个方法：`<init>()V`、`log(String)V`、**`rect(FFFF)V`**。
判据要 `petRect`、实现叫 `rect` ⇒ `typeof n.petRect === 'function'` 恒 `false` ⇒ **永不调用**。
（`petRectNative` 全库零命中；全包 `addJavascriptInterface` 只有 6 处，注册名只有
`petHostNative` / `petVoiceNative` / `pet2Native`。）

**(2) 类本身没接线。** `grep -rln 'Lcom/palai/prootsmoke/PetWindow2;' src/java2/classes`
排除自身与内部类后**零结果**；`start()` / `stop()` 全库零调用。⇒ `build()` 从不执行 ⇒
`pet2Native` 从不注册 ⇒ `petL/petT/petR/petB` 永远停在 `<clinit>` 的 `-1` ⇒
`sync()` 的 `petL >= 0` 前置条件永远不成立，`touchLp` 永远是 `build()` 里的 520×520。

**(3) 两个死字段。** `BASE_TOUCH` 与 `SHIM` 都只有 `.field` 声明行：
`BASE_TOUCH` 在 `<clinit>` 里**没有赋值**、全库**零引用**（`docs/02 §8.2` 曾误写 `= 240`）；
`SHIM` 同样零引用 —— 注入脚本其实是内联在 `$2.onPageFinished` 的 `const-string` 里。

`sync()`（唯一有实质逻辑的方法）完整语义：

```java
private static void sync() {
    if (touch == null || petL < 0 || petR <= petL) return;      // ← 恒真，永远在这里返回
    float scale = sp("coopanion").getFloat("pet_scale", 1.0f);
    if (scale < 0.2f || scale > 3.0f) scale = 1.0f;            // cmpg 0x3E4CCCCD / cmpl 3.0
    int size = Math.max(160, Math.round(scale * 520.0f));       // 0x44020000 = 520.0f
    int cx = (petL + petR) / 2, cy = (petT + petB) / 2;
    touchLp.width = touchLp.height = size;
    touchLp.x = Math.max(0, cx - size / 2);
    touchLp.y = Math.max(0, cy - size / 2);
    wm.updateViewLayout(touch, touchLp);
}
```

`tick`（`$1.run()`）= `sync()` + catch 打 `"tick: "` + `ui.postDelayed(tick, 120)`
⇒ **120 ms 跟随刷新**。

**触摸转发与 `PetWindowService` 不同构**：

| | `PetWindow2.forward()` | `PetWindowService` |
|---|---|---|
| 构造 | `MotionEvent.obtain(e)` 单指 | `obtain(J,J,I,I,PointerProperties[],PointerCoords[],…)` 逐 pointer 复制 |
| 坐标 | `(e.getX() + touchLp.x) / density` | `getRawX/getRawY`（`isTouchEvent ? getRawY : getY(i)`） |
| 除 density | **除** | **不除** |

`build()` 细节：SDK≥26 用 type `2038` 否则 `2002`；`addJavascriptInterface(new Bridge(),"pet2Native")`
+ `addJavascriptInterface(new HostBridge(),"petHostNative")` + `loadUrl("…/pet?pet=2")`；
`webLp = (-1,-1,type,-3)` + `gravity=8388659`；`touch = new $3(ctx)`（空 View，`onTouchEvent`
→ `forward()`）；`touchLp = (520,520,type,-3)` 同 gravity；末尾 `ui.post(tick)`。

`$2.onPageFinished` 注入的是一套 **11 个全空方法的 shim**（`setInteractive` / `focus` /
`grabFocus` / `releaseFocus` / `hide` / `openDress` / `setAlpha` / `getAlpha` / `openApp` /
`onCursor` / `sampleBackdrop`），并在 `typeof petHostNative === 'undefined'` 时返回 `'no-bridge'`、
已有 `window.petHost` 时返回 `'already'` —— 而 `petHostNative` 确实已注册，所以这段 shim
实际也不会生效。

### 12.3 `VoiceBridge`：`SpeechRecognizer` 的 5 个 extra

`intent()` 全部内容：

```java
Intent i = new Intent("android.speech.action.RECOGNIZE_SPEECH");
i.putExtra("android.speech.extra.LANGUAGE_MODEL", "free_form");
i.putExtra("android.speech.extra.LANGUAGE", "zh-CN");
i.putExtra("android.speech.extra.PARTIAL_RESULTS", true);
i.putExtra("android.speech.extra.MAX_RESULTS", 1);
i.putExtra("calling_package", ctx.getPackageName());
```

启动链：`start()` → `ui.post($2)` → `$2.run()`：`rec == null` 则 `build()`
（`createSpeechRecognizer(ctx)` + `setRecognitionListener($5)`）→ 置 `wanted = true` →
`rec.cancel()`（先取消上一次）→ `rec.startListening(intent())` → `deliver("start","","")`；
catch 打 `Log.w("PetVoice","start: "+e)` 并 `deliver("error","",msg)`。

`errName(int)` 是 **9 个 case 的 `packed-switch`**，payload 需手工解（见 `docs/04 §5.7` 第 4 条）。
映射结果：`1→没有麦克风权限`、`2→识别服务忙`、`3→没听清`、`4→没听到声音`、`5→客户端错误`、
`6→识别服务出错`、`7→录音出错`、`8→网络错误`、`9→网络超时`，default 拼 `"错误 "+n`。

### 12.4 `EyesService.captureOnce` 与 `jpeg` 的四段限流

```java
private byte[] captureOnce(int max, int q) {          // 注意：不是 void
    AtomicReference<byte[]> jpegRef = new …;
    AtomicReference<String> errRef  = new …;
    CountDownLatch latch = new CountDownLatch(1);
    Api30.capture(service, captureExecutor, max, q, jpegRef, errRef, latch);
    latch.await(9000, TimeUnit.MILLISECONDS);          // ← 9 秒硬超时
    byte[] b = jpegRef.get();
    if (b != null && b.length > 0) return b;
    lastError = errRef.get() != null ? errRef.get() : "截屏超时";
    return null;
}
```

`Api30.capture` = `takeScreenshot(0, executor, new $1(...))`；`$Api30$1` 的**三个分支**
（`onSuccess` / `onFailure` / catch）都会 `result.getHardwareBuffer().close()` +
`latch.countDown()`，不会泄漏 HardwareBuffer。`Api30.encode` =
`wrapHardwareBuffer(hb, colorSpace)` → `copy(ARGB_8888,false)` → recycle 原图 →
若 `w > max` 则 `createScaledBitmap(…, max, max(1, round(h*max/w)), true)` → 写回宽高 →
`ByteArrayOutputStream(0x40000)` → `compress(JPEG, q, out)` → `toByteArray()`；
失败抛 `IllegalStateException("拿不到画面")` / `("画面转换失败")`。

`jpeg(int max, int q)` 的四段策略（原文档写的 `MIN_CAPTURE_GAP` 常量**不存在**）：

| 段 | 阈值 | 行为 |
|---|---|---|
| 缓存 | 距今 **< 700 ms** | 直接返回 `lastJpeg` |
| 版本闸 | `SDK_INT < 30` | `lastError = "需要 Android 11 及以上才能后台截屏"`，返回 null |
| 重试 | 与 `lastRequestAt` 间隔 **< 1200 ms** | `Thread.sleep` 补足；最多 **3** 次 |
| 旧图回退 | 3 次全败且 `lastJpeg` 距今 **≤ 2500 ms** | 返回旧图，否则 null |

`sendScreen()` 的参数入口：`intParam("max", 720)` clamp 到 **[120, 2160]**、
`intParam("q", 62)` clamp 到 **[20, 95]**。

### 12.5 `PetKeyboardGuard`：`hPhys` 是页面侧的形参名

Java 侧**没有** `hPhys` 这个字段（`grep -rn 'hPhys' src/java2/classes` 零命中）。
它出现在 `src/recovered/vendor/pet/web/pet-app.js`：

```js
window.__petKeyboard = (hPhys, seq) => {
  const dpr = window.devicePixelRatio || 1;
  const h = Math.max(0, Number(hPhys) || 0) / dpr;                 // 物理 px → CSS px
  const next = h > 0 ? Math.min(innerHeight * 0.6, h + 26) : 0;    // +26 的抬升也在 JS 侧
  …
};
```

⇒ **Java 只传物理像素原值，除以 dpr 与 `+26` 抬高都在页面侧完成**。注释原文：
「原生每 100ms 就报一次当前键盘高度（物理 px）；这里幂等换算，绝不『只在变化时处理』」。

Java 侧的唯一源头是构造时一次取定的
`screenH = getResources().getDisplayMetrics().heightPixels`。
`imeHeight()` 五级兜底（每级都先写 `lastSource` 再过 `clampH`）：

| 级 | 判据 | `lastSource` | 值 |
|---|---|---|---|
| 1 | `EyesService.imeHeightSmart() > 0` | `a11y=N` | `clampH(N)` |
| 2 | `imeHeightSmart() == 0`（无障碍可用、键盘未弹） | `a11y~guess=N` | `clampH(screenH * 0.38)` |
| 3 | `root.getRootWindowInsets().getInsets(Type.ime()).bottom > 0` | `root.insets=N` | `clampH(N)` |
| 4 | `touchLayer.getRootWindowInsets()…bottom > 0` | `touch.insets=N` | `clampH(N)` |
| 5 | `root.getWindowVisibleDisplayFrame(rect)` 后 `screenH - rect.bottom > 0` | `frame=N` | `clampH(N)` |
| — | 全失败 | — | `0` |

`clampH(h)` = `h <= 0 ? 0 : Math.min(h, (int)(screenH * 0.75))`（`0x3fe80000` = 0.75）。
`a11yOrInsets()` 则不同：`EyesService.imeHeight() > 0` 才 `clampH`，否则**直接**
`return imeHeight()`（不再 clamp）。

`imeHeightSmart()` 的三态语义：**`>0` 高度 / `0` 无障碍可用但键盘未弹 / `-1` 无障碍不可用**
（`instance == null` 时返回 `0`）。

`evaluate()` = `isRunning() ? a11yOrInsets() : imeHeight()`；首次置 `reportedOnce` 并打
`"init a11y=on"` / `"init a11y=off 需要开启无障碍"`；`h != lastHeight` 时打
`"ime height N (src)"`；随后 `reportKeyboard(h)` + `reportIme(h > 0, lastSource)`。
`reportKeyboard` 注入 `window.__petKeyboard(H, seq)`（`seq` 自增）；`reportIme` 把
`detail.replace("'", " ")` 后注入 `window.__petIme(true/false,'detail')`。
"""


# ── docs/02 ────────────────────────────────────────────────────────────
DOCS02 = "docs/02-Java层源码还原.md"
DOCS02_PAIRS = [
    # 5) captureOnce / jpeg 的真实签名
    (
        "private void captureOnce(…);        // takeScreenshot(ScreenCaptureCallback)，带 MIN_CAPTURE_GAP 限流与缓存\n"
        "private byte[] jpeg(Bitmap b, int max, int q);  // 按 max 等比缩放后 JPEG 压缩\n",
        "private byte[] captureOnce(int max, int q);     // takeScreenshot(0, executor, cb) + CountDownLatch.await(9000ms)\n"
        "private byte[] jpeg(int max, int q);            // 700ms 缓存 / 1200ms 最小间隔 / 3 次重试 / 2500ms 旧图回退\n",
    ),
    # 6) imeHeightSmart 的三态
    (
        "`imeHeightSmart()` 是给桌宠用的：无障碍拿不到 `WindowInsets` 时，退化为「比较屏幕高度与可见窗口底边」估算键盘高度；\n"
        "`setImeListener` 让 `PetKeyboardGuard` 能拿到实时高度回调。\n",
        "`imeHeightSmart()` 是给桌宠用的**三态**接口：`>0` = 键盘高度、`0` = 无障碍可用但键盘未弹出、"
        "`-1` = 无障碍不可用\n"
        "（`instance == null` 时直接返回 `0`，其余转给 `imeHeightOf`）。`PetKeyboardGuard.imeHeight()` 按这三态分流：\n"
        "`>0` 采信；`==0` 退化为 `screenH * 0.38` 估算；`-1` 才继续走 `RootWindowInsets` → 触控层 insets →\n"
        "`getWindowVisibleDisplayFrame` 三级。`setImeListener` 让 `PetKeyboardGuard` 能拿到实时高度回调。\n",
    ),
    # 7) BASE_TOUCH 是死字段（原写 = 240 是错的）
    (
        "    private static final int    BASE_TOUCH = 240;      // 触摸框基准尺寸\n",
        "    private static final int    BASE_TOUCH;          // 死字段：<clinit> 无赋值、全库零引用（原文档误写 = 240）\n",
    ),
    # 8) sync() 可见性 + 断链结论
    (
        "    static void start(Context c) { … }   // 建 WebView + 触摸层\n"
        "    static void stop()  { … }\n"
        "    static void sync()  { ui.post(tick); }\n"
        "    static boolean forward(MotionEvent e) { … }\n"
        "}\n"
        "```\n"
        "\n"
        "页面侧对应 `pet-multi.js`（多宠），桥名探测顺序 `['petRectNative','pet2Native','cooClone']`。\n",
        "    public  static void start(Context c) { … }   // 建 WebView + 触摸层；**全库零调用**\n"
        "    public  static void stop()  { … }            // 同上，零调用\n"
        "    private static void sync()  { ui.post(tick); }\n"
        "    private static void build(Context c) { … }\n"
        "    private static boolean forward(MotionEvent e) { … }\n"
        "}\n"
        "```\n"
        "\n"
        "页面侧对应 `pet-multi.js`（多宠），桥名探测顺序 `['petRectNative','pet2Native','cooClone']`，\n"
        "判据是 `typeof n.petRect === 'function'` —— 与原生暴露的 `rect(FFFF)` **名字不匹配**。\n"
        "\n"
        "> **修订记录 v3**（`docs/03 §12.2` 取证后回改）：`BASE_TOUCH` / `SHIM` 都是死字段；\n"
        "> 更关键的是 **`PetWindow2` 全库无任何外部类引用、`start()`/`stop()` 零调用**，\n"
        "> `build()` 从不执行 ⇒ `pet2Native` 从不注册 ⇒ `petL/T/R/B` 恒 `-1` ⇒ `sync()` 的\n"
        "> `petL >= 0` 永远不成立。**整个类是未接线的实验实现，不要当成活代码读。**\n"
        "> `sync()` 的真实语义（读 `pet_scale` clamp 0.2–3.0、`size = max(160, round(scale*520))`、\n"
        "> 按中点重算 `touchLp`、`wm.updateViewLayout`）一次都不会执行；\n"
        "> `tick` 的 120 ms 周期同理。\n",
    ),
    # 9) clampH / imeHeight 的真实细节
    (
        "    private int  a11yOrInsets();          // 先问 EyesService（无障碍），拿不到再用 WindowInsets\n"
        "    private int  imeHeight();\n"
        "    private int  clampH(int h);           // 上限保护，避免把宠物顶飞\n",
        "    private int  a11yOrInsets();          // 先问 EyesService.imeHeight()，为 0 时直接返回它（不再 clampH）\n"
        "    private int  imeHeight();             // 五级兜底：a11y 高度 → a11y 估算(screenH*0.38) → root insets\n"
        "                                          //          → 触控层 insets → visibleDisplayFrame → 0\n"
        "    private int  clampH(int h);           // h<=0 → 0；否则 min(h, (int)(screenH * 0.75))\n",
    ),
    # 10) §10 删掉已取证的两行
    (
        "| `EyesService.captureOnce` | ~200 行 | 还原了流程与限流常量，`ScreenCaptureCallback` 内部 Bitmap 处理未逐行 |\n"
        "| `PetWindowService.buildAndAttachLayers` | ~180 行 | 还原了两层 LayoutParams 语义，具体 FLAG 组合按常量反推 |\n"
        "| `PetKeyboardGuard.evaluate` | ~120 行 | 只还原了「双路测高 + 上报」骨架 |\n",
        "| `PetWindowService.buildAndAttachLayers` | ~180 行 | 还原了两层 LayoutParams 语义，具体 FLAG 组合按常量反推 |\n"
        "\n"
        "**已从本表移除**（第二轮已逐行还原）：`EyesService.captureOnce` / `PetKeyboardGuard.evaluate`\n"
        "—— 见 `docs/03 §12.4` 与 `§12.5`。\n",
    ),
]

# ── docs/04 ────────────────────────────────────────────────────────────
DOCS04 = "docs/04-工具链与复现.md"
DOCS04_PAIRS = [
    (
        "3. **不解析 `debug_info` / `annotations`**，所以没有行号表、没有注解信息；`try/catch` 只打区间，不打异常类型。\n",
        "3. **不解析 `debug_info` / `annotations`**，所以没有行号表、没有注解信息；`try/catch` 只打区间，不打异常类型。\n"
        "4. **不解析 `packed-switch` / `sparse-switch` 的 payload**。指令本身被输出成裸\n"
        "   `packed-switch v2, :L50`，但 `:pswitch_data` 块与 9 个 case 目标标签全部丢失 ——\n"
        "   **case 值与目标地址的映射在 smali 里不可读**。本包唯一命中是 `VoiceBridge.errName(I)`\n"
        "   （`grep -rc 'pswitch_data' src/java2/classes | grep -v ':0' | wc -l` = **0**）。\n"
        "   核对办法：直接解 DEX 原始字节的 payload（`ident|size` + `first_key` + `size` 个\n"
        "   **相对该 switch 指令**的偏移），再与 smali 里 case 字符串的书写顺序比对\n"
        "   （`VoiceBridge` 的实际顺序是 case 9 在最前、case 1 在最后）。\n"
        "   这一手法与 `diag_units.py` 同源（`struct.unpack_from` 直读），可复用。\n",
    ),
]


def apply_pairs(path, pairs, bad):
    s = open(path, encoding="utf-8").read()
    for old, new in pairs:
        n = s.count(old)
        if n != 1:
            bad.append((path, n, old.split("\n")[0][:70]))
            if n == 0:
                head = old.split("\n")[0][:24]
                for i, line in enumerate(s.split("\n"), 1):
                    if head and head[:12] in line:
                        print("    候选 L%d: %r" % (i, line))
            continue
        s = s.replace(old, new, 1)
    return s


def main():
    bad = []
    texts = {}

    for path, pairs in ROUNDS.items():
        texts[path] = apply_pairs(path, pairs, bad)

    texts[DOCS03] = apply_pairs(DOCS03, [(SEC12_OLD, SEC12_NEW)], bad)
    texts[DOCS02] = apply_pairs(DOCS02, DOCS02_PAIRS, bad)
    texts[DOCS04] = apply_pairs(DOCS04, DOCS04_PAIRS, bad)

    if bad:
        print("ABORT — 以下 old 未唯一匹配：")
        for p, n, head in bad:
            print("  ", p, "count=", n, "|", head)
        sys.exit(1)

    for path, s in texts.items():
        open(path, "w", encoding="utf-8").write(s)

    total = sum(len(v) for v in ROUNDS.values()) + 1 + len(DOCS02_PAIRS) + len(DOCS04_PAIRS)
    print("OK — %d 处替换已写入" % total)
    for path, s in texts.items():
        print("  ", path, "lines=", s.count("\n"))


if __name__ == "__main__":
    main()