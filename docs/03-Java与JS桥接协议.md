# 03 · Java ↔ JS 桥接协议

> 本文是 `Coopanion v12.71` 的**跨语言协议说明**，把 Android 原生层（`classes.dex` / `classes2.dex`）
> 与 Node 提供的桌宠页面（`vendor/pet/web/*.js`）之间的全部通信点逐条对齐。
> 所有结论都有 smali 行号或 TS/JS 行号支撑；推测已显式标注「推测」。
>
> 阅读顺序建议：§1 看有几个通道 → §6 看最核心的矩形协议 → §7 看最巧的输入法协议。

---

## 0. 全景

这个 App 的桌宠不是一个原生 View，而是**两层悬浮窗 + 一个 WebView 页面 + 一个 Node 本地服务**：

```
┌───────────────────────────── Android 进程 ─────────────────────────────┐
│                                                                        │
│  PetWindowService（前台服务）                                           │
│   ├─ showBox  ── 全屏、不可触摸、alpha=petAlpha ──┐                     │
│   ├─ touchBox ── 520×520 起、可触摸、可拖动 ──────┤ 都装着同一个 WebView │
│   └─ imeProxy ── 1×1 隐藏 EditText（骗输入法）    │                     │
│                                                   ↓                    │
│                                          WebView（127.0.0.1:7797/pet）  │
│                                                   ↕                    │
│                                     addJavascriptInterface × 2         │
│                                                   ↕                    │
│  ┌──────────────────────────────────────────────────────────────────┐  │
│  │ Node 进程（proot，bin/node 123MB，run-core.mjs）                  │  │
│  │  Cortico 控制台 :17788   EyesService :17898   SenseBridge :17899  │  │
│  │  桌宠页面服务 :7797  (/pet  /dress)                               │  │
│  └──────────────────────────────────────────────────────────────────┘  │
└────────────────────────────────────────────────────────────────────────┘
```

桥接一共**三条通道**，方向和作用完全不同：

| # | 方向 | 机制 | 用途 | 调用点数 |
|---|------|------|------|---------|
| 1 | Java → 页面 | `WebView.evaluateJavascript` | 注入 shim、探针、改 DOM、取包围盒 | 14 处（11 段脚本） |
| 2 | 页面 → Java | `addJavascriptInterface` | 窗口控制、开应用、语音、矩形推送 | 4 个注入名 |
| 3 | 页面 → 页面 | 页面自造 `window.__pet*` 全局函数 | 原生回调入口（由通道 1 调用） | 5 个函数 |

**关键观察：通道 2 里的 `petHost` 大部分方法是空转的。** 真正改变窗口行为的是通道 1 注入的脚本 +
Java 侧每 80ms 的轮询。下面逐条拆。

---

## 1. 注入点：`addJavascriptInterface`

全 dex 只有 **3 处** `addJavascriptInterface`，共注册 **4 个名字**：

| 注入名 | 实现类 | 宿主方法 | 页面侧消费 |
|--------|--------|----------|-----------|
| `petHostNative` | `PetWindowService$PetHostBridge` | `PetWindowService.buildAndAttachLayers` | 被 `PET_HOST_SHIM` 包装成 `window.petHost` |
| `petVoiceNative` | `VoiceBridge` | 同上 | `pet-app.js:18-25` 直接调 |
| `pet2Native` | `PetWindow2$Bridge` | `PetWindow2.build`（static） | `pet-multi.js:487` |
| `petHost` | `PetActivity$PetHostBridge` | `PetActivity` | 旧版全屏 Activity 形态 |

`PetActivity` 里的注册值得单独记一笔：

```java
// PetActivity（smali 观察）：同一个类，注册两次，两个名字
PetActivity$PetHostBridge bridge = new PetActivity$PetHostBridge(this);
web.addJavascriptInterface(bridge, "petHostNative");
web.addJavascriptInterface(new PetActivity$PetHostBridge(this), "petHost");
```

同一个实现类挂了两个名字，说明 `petHost` 是**旧版本遗留的全局名**，`petHostNative` 是后来改名。
页面侧 `pet-app.js:15` 只读 `window.petHost`（由 shim 建），而 `PetWindow2` 形态的页面读 `pet2Native`。

### 1.1 PetWindow2（第二种形态）的注入

`PetWindow2.build`（static，参数含 `Context`）里：

```java
web.addJavascriptInterface(new PetWindow2$Bridge(this), "pet2Native");
web.addJavascriptInterface(new PetWindow2$HostBridge(this), "petHostNative");
web.loadUrl("http://127.0.0.1:7797/pet?pet=2");   // 注意 ?pet=2 查询参数
```

`?pet=2` 是页面侧的分支开关——`pet-multi.js` 据此走「多宠物」渲染路径，而单宠物的
`PetWindowService` 加载的是不带参数的 `/pet`。

---

## 2. Java → 页面：`evaluateJavascript` 全表

全 dex 共 **14 处** `evaluateJavascript`，落在 10 个宿主类里：

| # | 宿主 | 时机 | 脚本 | 结果回调 |
|---|------|------|------|---------|
| 1 | `PetWindowService$5.onPageStarted` | 页面开载前 | `PET_HOST_SHIM`（1062 B） | null |
| 2 | `PetWindowService$5.onPageFinished` | 页面载完 | `PET_HOST_SHIM` + `startRepaintWatchdog` | null |
| 3 | `PetWindowService.queryPetRect` | 每 80ms | inj_07（并集包围盒） | `$15` |
| 4 | `PetWindowService.pushKeyToPage` | 收到退格 | inj_05 | null |
| 5 | `PetWindowService.pushTextToPage` | 输入法上屏 | inj_06 前缀 + `jsStr(text)` + 后缀 | null |
| 6 | `PetWindowService$13.run` | 重绘看门狗 | inj_04（`__repaintHack`） | null |
| 7 | `VoiceBridge$1.run` | 语音结果 | inj_10/11/12 拼装 | null |
| 8 | `PetWindowService$13` 内 `wv.invalidate()` 后 | 同上 | — | — |
| 9 | `PetKeyboardGuard.reportIme(Z, String)` | IME 高度变化 | `window.__petIme&&window.__petIme(<bool>,'<via>')` | null |
| 10 | `PetKeyboardGuard.reportKeyboard(int)` | 键盘高度变化 | `window.__petKeyboard&&window.__petKeyboard(<h>,<seq>)` | null |
| 11 | `MainActivity$20` | 控制台页健康检查 | inj_03 | `$20` |
| 12 | `PetActivity$2` | 页面载完 | inj_08（rAF 探针） | null |
| 13 | `PetWindow2$2.onPageFinished` | 页面载完 | inj_09（**空 stub** petHost） | null |
| 14 | `RepairActivity$3` / `RepairActivity$5` | 修复页 | inj_02（`__imeHack`）/ `__imeProbe()` | `$5` |

### 2.1 十二段注入脚本的身份

`src/js/inj_01..12.js` 是从两份 dex 的 `const-string` 里切出来的原始片段：

| 文件 | 字节 | 身份 | 性质 |
|------|------|------|------|
| inj_01 | 1062 | 完整 `window.petHost` 包装层（= `PET_HOST_SHIM`） | 独立可执行 |
| inj_02 | 443 | `__imeHack` 置位 + `focusin` 捕获 + `__imeProbe()` | 独立可执行 |
| inj_03 | 279 | 页面健康探针（`err` / `ok` / `empty`） | 独立可执行 |
| inj_04 | 405 | `__repaintHack`：对 `#pet,#bubble,#menu,...` 强制 `translateZ(0)` + reflow | 独立可执行 |
| inj_05 | 377 | 退格：`el.value.slice(0,-1)` + `dispatchEvent('input')` | 独立可执行 |
| inj_06 | 300 | 追加文本的**前缀半截** | **不可单独执行**（缺后缀） |
| inj_07 | 949 | `queryPetRect` 全文 | 独立可执行 |
| inj_08 | 280 | `#pet` 存在性 + rAF 心跳 + 视口自检 | 独立可执行 |
| inj_09 | 529 | 空 stub `petHost`（所有方法空体，`getAlpha`→1，`openApp`→false） | 独立可执行 |
| inj_10 | 74 | `__petVoiceResult(...)` **调用前缀** | **不可单独执行** |
| inj_11 | 34 | `__petIme(...)` **调用前缀** | **不可单独执行** |
| inj_12 | 44 | `__petKeyboard(...)` **调用前缀** | **不可单独执行** |

**inj_06 才是 `pushTextToPage` 的前半，后缀在方法体内硬编码**（见 §7.3）。
inj_10/11/12 同理，整句由 `VoiceBridge.deliver` / `PetKeyboardGuard.report*` 现场拼接。

---

## 3. `PET_HOST_SHIM`：被折叠进 `static_values` 的脚本

### 3.1 取证过程

`PetWindowService` 有 45 个方法，**没有 `<clinit>`**，而

```
.field private static final PET_HOST_SHIM:Ljava/lang/String;
```

在代码里也**没有任何引用**。原因是 javac 对 `static final String` 做了**常量折叠**：所有使用点
都被替换成字面量，字段本身变成死字段。

真实值只能从 DEX 的 `class_def_item.static_values_off` 指向的 `encoded_array` 里取。
为此写了 `src/read_static.py`：

```
$ python3 read_static.py x/classes.dex 'Lcom/palai/prootsmoke/PetWindowService;'
class_data_off=0x17dcf static_values_off=0xde6a
static_values count=8
  [0] CHANNEL        ('str', 'coopanion_pet')
  [1] KEY_ALPHA      ('str', 'pet_alpha')
  [2] NOTI_ID        ('int', 8801)
  [3] PET_HOST_SHIM  ('str', "(function(){ if (window.petHost) return 'already'; ...")
  [4] PET_URL        ('str', 'http://127.0.0.1:7797/pet')
  [5] PREF           ('str', 'coopanion')
  [6] TAG            ('str', 'PetWindow')
  [7] TOUCH_SIZE     ('int', 700)        ← 注意：700，不是 520
```

八个值按类型可唯一对应八个字段（6 String + 2 int，int 为 8801/700）。

**两个附带结论：**

1. **`TOUCH_SIZE = 700` 是死常量**。`grep TOUCH_SIZE` 只有字段声明一行；
   `buildAndAttachLayers` 里触摸层尺寸是 `const/16 v6, #520` / `v7,#520` **硬编码**，
   日志文案也写死 `"[PET] 触摸层已挂载 520x520"`。
   还原源码时应保留 `private static final int TOUCH_SIZE = 700;` 并注明「未被引用」。
2. `CHANNEL = "coopanion_pet"`，而 `PREF = "coopanion"` —— 通知渠道名与 SharedPreferences 名不同名。

### 3.2 注入时机：**两次**

`PetWindowService$5`（`WebViewClient`）里，`onPageStarted` 和 `onPageFinished` **各注入一次
同一段脚本**：

```java
// onPageStarted
web.evaluateJavascript(PET_HOST_SHIM, null);

// onPageFinished
Log.i("PetWindow", "[PET] onPageFinished " + url);
web.evaluateJavascript(PET_HOST_SHIM, null);
startRepaintWatchdog(web);
```

这是有意为之：`onPageStarted` 时页面自己的脚本还没跑，先占住 `window.petHost`，
页面里的 `const host = window.petHost || null`（`pet-app.js:15`）才能拿到真值；
`onPageFinished` 再补一次，兜住「页面重载/脚本重跑把 `petHost` 覆盖掉」的情况。

因为脚本开头就是幂等守卫：

```js
if (window.petHost) return 'already';
if (typeof petHostNative === 'undefined') return 'no-bridge';
```

三次调用都不会重复包装。三个返回值语义：

| 返回 | 含义 |
|------|------|
| `'already'` | 已注入过，跳过 |
| `'no-bridge'` | 原生对象不在（页面被非本 App 的 WebView 打开，例如桌面浏览器调试） |
| `'ok'` | 首次注入成功 |

### 3.3 脚本原文（`src/js/inj_01.js`，1062 B）

```js
(function(){
  if (window.petHost) return 'already';
  if (typeof petHostNative === 'undefined') return 'no-bridge';
  window.petHost = {
    setInteractive: function(on){ try{ petHostNative.setInteractive(!!on); }catch(e){} },
    focus:         function(){ try{ petHostNative.focus(); }catch(e){} },
    grabFocus:     function(){ try{ petHostNative.grabFocus(); }catch(e){} },
    releaseFocus:  function(){ try{ petHostNative.releaseFocus(); }catch(e){} },
    hide:          function(){ try{ petHostNative.hide(); }catch(e){} },
    openDress:     function(){ try{ petHostNative.openDress(); }catch(e){} },
    setAlpha:      function(f){ try{ petHostNative.setAlpha(f); }catch(e){} },
    getAlpha:      function(){ try{ return petHostNative.getAlpha(); }catch(e){ return 1; } },
    openApp:       function(n){ try{ return !!petHostNative.openApp(String(n)); }catch(e){ return false; } },
    onCursor:      function(cb){ (window.__petCursorSubs = window.__petCursorSubs||[]).push(cb); },
    sampleBackdrop:function(){ return null; }
  };
  document.body.classList.remove('tab');
  document.body.classList.add('desk');
  return 'ok';
})()
```

末尾两行是**模式开关**：页面在 `pet-app.js:40` 自己会写
`document.body.classList.add(host ? 'desk' : 'tab')`，shim 则强行改回 `desk`（桌面悬浮模式），
`pet.css` 里 `.desk` / `.tab` 分别对应两套布局与 `floorGap`（`host ? 30 : 48`）。

### 3.4 `inj_09`：`PetWindow2` 用的空壳

`PetWindow2$2.onPageFinished` 注入的是同一结构的**空实现**（529 B）：

```js
window.petHost = {
  setInteractive: function(){}, focus: function(){}, grabFocus: function(){},
  releaseFocus: function(){}, hide: function(){}, openDress: function(){},
  setAlpha: function(){}, getAlpha: function(){ return 1; },
  openApp: function(){ return false; },
  onCursor: function(){}, sampleBackdrop: function(){ return null; }
};
document.body.classList.remove('tab'); document.body.classList.add('desk');
```

即：在 `pet2Native` 形态下，页面**以为**自己有 host（走 desk 布局），但所有 host 调用都是空的。
这是为了让多宠物页面保持桌面布局，同时不重复绑定单宠物窗口的控制面。

---

## 4. `petHost` 方法表：11 个方法里 4 个空转

`PetWindowService$PetHostBridge`（smali 271 行）逐方法实测：

| 方法 | Java 侧真实行为 | 判定 |
|------|----------------|------|
| `focus()` | `return-void` | **空实现** |
| `grabFocus()` | `return-void` | **空实现** |
| `releaseFocus()` | `return-void` | **空实现** |
| `setInteractive(boolean)` | 只 `Log.i("PetWindow", "[PET] setInteractive=" + on)` | **空实现**（无状态变化） |
| `getAlpha()` | `-$$Nest$fgetpetAlpha` 读字段 | 真实 |
| `setAlpha(float)` | clamp 到 `[0,1]` → 写 `SharedPreferences("coopanion").putFloat("pet_alpha")` → `ui.post(PetHostBridge$1)` 改 `showLp.alpha` + `updateViewLayout` | 真实 |
| `hide()` | `ui.post(PetHostBridge$2)` | 真实 |
| `openDress()` | `ui.post(PetHostBridge$3)`，跳 `:7797/dress` | 真实 |
| `openApp(String)` | 见 §4.1 | 真实（重活） |

**为什么 `focus()` 是空的还能弹键盘？** 因为焦点根本不走桥方法：它走
`applyInputFocus(boolean)` + `imeProxy`（§7）。桥里的这三个焦点方法是从旧版
`PetActivity` 继承下来的接口壳，`PetWindowService` 形态没有实现。

`setInteractive` 空转也说明：**桌面模式的「触摸穿透」不是靠这个方法开关的**，而是靠
`showLp` 常驻 `FLAG_NOT_TOUCHABLE`、`touchLp` 常驻可触摸 + 每 80ms 贴身定位实现的。
页面里调 `host.setInteractive(false)` 在这条链路上**没有任何效果**（这点在自测时容易误判）。

### 4.1 `openApp(String)`：用打分做模糊匹配

这是整个桥里唯一有业务复杂度的函数（smali 55–219 行）：

```
query = arg.trim().toLowerCase()
if (query.isEmpty()) return false
pm.queryIntentActivities(Intent(ACTION_MAIN).addCategory(CATEGORY_LAUNCHER), 0)
遍历 List<ResolveInfo>：
    pkg   = activityInfo.packageName
    label = loadLabel(pm).toString()
    打分：
        pkg.equals(query)            → 1000
        label.equals(query)          → 900
        pkg.toLowerCase().contains(query)   → 700
        label.toLowerCase().contains(query) → 500
    取最高分；同分取先出现的
若有最高分 → startActivity(launchIntent)，return true
否则 return false
```

四档分值（1000/900/700/500）表示优先级：包名精确 > 应用名精确 > 包名包含 > 应用名包含。
这是给 LLM 用的接口——宠物说「打开微信」时不必知道包名。

> 注意：`QUERY_ALL_PACKAGES` 权限（Manifest）就是为了这个函数，
> `queryIntentActivities` 在 Android 11+ 不加该权限只能看到部分应用。

---

## 5. 窗口双层结构（矩形协议的前提）

`buildAndAttachLayers(int type)` 一次性建两层 + 一个代理输入框。三层参数都是硬编码常量。

### 5.1 显示层 `showBox` / `showLp`

```java
showBox = new FrameLayout(this);
showBox.setBackgroundColor(Color.TRANSPARENT);        // 0
showBox.addView(web, new FrameLayout.LayoutParams(MATCH_PARENT, MATCH_PARENT));

showLp = new WindowManager.LayoutParams(
    MATCH_PARENT, MATCH_PARENT, type,
    66328,                                            // 0x102D8
    PixelFormat.TRANSLUCENT);                         // -3
showLp.alpha    = petAlpha;                           // 来自 SharedPreferences
showLp.gravity  = 8388659;                            // 0x800033 = TOP|START
showLp.x = 0; showLp.y = 0;
wm.addView(showBox, showLp);
```

`flags = 0x102D8` 拆解：

| 位 | 常量 | 作用 |
|----|------|------|
| 0x00008 | `FLAG_NOT_FOCUSABLE` | 不抢焦点（否则会顶掉前台 App 的输入） |
| 0x00010 | `FLAG_NOT_TOUCHABLE` | **整层不接收触摸**（触摸交给下面的 touchBox） |
| 0x00040 | `FLAG_TOUCHABLE_WHEN_WAKING` | 唤醒中也可触摸 |
| 0x00080 | `FLAG_KEEP_SCREEN_ON` | 常亮 |
| 0x00200 | `FLAG_LAYOUT_NO_LIMITS` | 允许超出屏幕边界摆放 |
| 0x10000 | `FLAG_LAYOUT_INSET_DECOR` | 布局不受装饰（状态栏/导航栏）影响 |

> `docs/02` §3.1 早前只写了前三个 flag，此处更正为完整 6 个。

### 5.2 触摸层 `touchBox` / `touchLp`

```java
touchBox = new FrameLayout(this);
PetKeyboardGuard.setTouchLayer(touchBox);              // 静态登记，供键盘高度回调定位
touchBox.setBackgroundColor(0);
touchBox.setOnTouchListener($7);                       // 无条件 forwardToWeb + return true

touchLp = new WindowManager.LayoutParams(
    520, 520, type,
    808,                                               // 0x328
    PixelFormat.TRANSLUCENT);
touchLp.gravity       = 0x800033;                      // TOP|START
touchLp.x = 0; touchLp.y = 0;
touchLp.softInputMode = 16;                            // SOFT_INPUT_ADJUST_RESIZE
```

`flags = 0x328` 拆解：

| 位 | 常量 | 作用 |
|----|------|------|
| 0x008 | `FLAG_NOT_FOCUSABLE` | 平时不抢焦点（**需要打字时会被临时清掉**，§7.2） |
| 0x020 | `FLAG_NOT_TOUCH_MODAL` | 窗口外的触摸透传给下层的 App |
| 0x100 | `FLAG_LAYOUT_IN_SCREEN` | 按整屏坐标布局 |
| 0x200 | `FLAG_LAYOUT_NO_LIMITS` | 允许超出屏幕 |

`touchBox` 与 `imeProxy` 都 `setFocusable(false)` / `setFocusableInTouchMode(false)`。

### 5.3 代理输入框 `imeProxy`

```java
imeProxy = new PetWindowService$8(this, this);         // 继承 EditText，覆写 onCreateInputConnection
imeProxy.setBackgroundColor(0);
imeProxy.setTextColor(0);                              // 文字全透明
imeProxy.setCursorVisible(false);
imeProxy.setImeOptions(33554438);                      // 0x2000006 = IME_FLAG_NO_FULLSCREEN | IME_ACTION_DONE
imeProxy.setInputType(1);                              // TYPE_CLASS_TEXT
imeProxy.setSingleLine(true);
imeProxy.setFocusable(false);
imeProxy.setFocusableInTouchMode(false);
imeProxy.addTextChangedListener($9);
imeProxy.setOnKeyListener($10);
touchBox.addView(imeProxy, new FrameLayout.LayoutParams(1, 1));   // 1×1 像素
```

`0x2000006` 两个作用是配套的：

- `IME_FLAG_NO_FULLSCREEN`：横屏时**不要让输入法开全屏编辑**（否则用户会看到一个空的黑色编辑页，
  代理框里没有内容，体验是崩的）。
- `IME_ACTION_DONE`：软键盘回车的语义是「完成」而不是「下一项」。

### 5.4 首帧探测与兜底加载

```java
showBox.addOnLayoutChangeListener($11);                // 注意：挂在 showBox 上
ui.postDelayed($12, 1000);
ui.postDelayed(followTick, 300);
```

- `$11.onLayoutChange`：`loaded` 只触发一次；条件是 `w > 0 && h <= 0`（宽度有了、高度还是 0，
  即「WebView 已进窗口但内容未撑开」），命中后 `postDelayed($11$1, 32)`。
- `$12.run`：1 秒后检查 `web.getUrl()`，若为 `null` 则
  `loadUrl("http://127.0.0.1:7797/pet")` 并打日志 `[PET] loadUrl(兜底超时) -> ...`。
  这是 Node 服务（proot 内首次启动可能还在解压 rootfs）未就绪时的自救。
- `followTick`：**矩形协议的心跳**，见 §6。

---

## 6. 矩形链路：原生每 80ms 主动问一次

这是「桌面宠只让点宠物」的核心：全屏 WebView 不可触摸，触摸层只有 520×520（或更大），
它的位置/尺寸要**跟着宠物在页面里的实际位置**走。

### 6.1 心跳

```java
// PetWindowService$14.run —— followTick
queryPetRect();
ui.postDelayed(this, 80);          // 80ms 后自己再跑
```

由 `buildAndAttachLayers` 末尾 `postDelayed(followTick, 300)` 启动，此后**永不停止**（除非 `onDestroy`）。
整个链路与页面是否主动推送无关——这一点在 `pet-multi.js` 的注释里被原厂写得很清楚：

> 原生每 80~200ms 拿这个矩形去 `updateViewLayout`……如果逐像素跟着变，原生窗口就会一路挪
> ——看起来就是「一点点卡」

### 6.2 问法（`queryPetRect` → inj_07）

```js
(function(){
  try{
    var box='';
    try{ if(window.__petUnionRect) box = window.__petUnionRect()||''; }catch(e0){}
    if(!box){
      function r(id){
        var e = document.getElementById(id);  if(!e) return null;
        var st = window.getComputedStyle(e);
        if(st.display==='none'||st.visibility==='hidden'||e.hidden) return null;
        var b = e.getBoundingClientRect();
        if(b.width<1 && b.height<1) return null;
        return b;
      }
      var ids=['pet','pet2','pet3','pet4','bubble','bubble2','bubble3','bubble4','menu','tools'];
      var arr=[]; for(var i=0;i<ids.length;i++){ var q=r(ids[i]); if(q) arr.push(q); }
      if(arr.length){
        var l=1e9,t=1e9,rr=-1e9,b=-1e9;
        for(var k=0;k<arr.length;k++){ var q=arr[k];
          if(q.left<l)l=q.left; if(q.top<t)t=q.top;
          if(q.right>rr)rr=q.right; if(q.bottom>b)b=q.bottom; }
        box=l+','+t+','+rr+','+b;
      }
    }
    var ae=document.activeElement;
    var focused = !!(ae && (ae.tagName==='INPUT'||ae.tagName==='TEXTAREA'||ae.isContentEditable));
    return box+'|'+(focused?'1':'0');
  }catch(err){ return ''; }
})()
```

两个要点：

1. **优先用页面自己的 `window.__petUnionRect()`**（`pet-multi.js:445` 提供），Java 侧的
   兜底遍历只是保险。多宠物页面里 `__petUnionRect` 一定是存在的。
2. **同一趟还带回了 `focused`**。这个布尔值就是 §7 的输入法开关触发器，不是附带信息。

### 6.3 解析（`PetWindowService$15.onReceiveValue`）

```java
public void onReceiveValue(String value) {
    if (value == null || value.length() < 3) return;
    value = value.replace("\"", "");                       // evaluateJavascript 会给结果包一层引号
    int bar = value.lastIndexOf('|');
    if (bar < 0) return;
    String box      = value.substring(0, bar);
    boolean focused = value.substring(bar + 1).startsWith("1");

    long now = System.currentTimeMillis();
    if (now - lastProbeLog > 1000) {                       // diag 限流 1s
        lastProbeLog = now;
        diag("probe box=[" + box + "] focused=" + focused);
    }

    applyInputFocus(focused);                              // 见 §7.2 —— 在矩形处理之前

    if (box.length() < 5) return;
    String[] p = box.split(",");
    if (p.length < 4) return;

    float density = getResources().getDisplayMetrics().density;

    int l = (int)(Float.parseFloat(p[0]) * density);        // CSS px → 物理 px
    int t = (int)(Float.parseFloat(p[1]) * density);
    int r = (int)(Float.parseFloat(p[2]) * density);
    int b = (int)(Float.parseFloat(p[3]) * density);

    petX = (l + r) / 2f;                                   // 记录宠物中心（页面坐标）
    petY = (t + b) / 2f;

    int w = Math.max((r - l) + 80, 520);                   // 边距 80，最小 520
    int h = Math.max((b - t) + 80, 520);

    int x = (l + r) / 2 - w / 2;                           // 中心对齐
    int y = (t + b) / 2 - h / 2;

    sizeTouchTo(x, y, w, h);
}
```

`520` 的真实身份到此为止：**它不是固定窗口尺寸，而是尺寸下限 `Math.min` clamp**。
宠物越大（多宠物并集、气泡展开）触摸层就越大；`+80px` 是给手指留的余量。

### 6.4 落地（`sizeTouchTo` → `$17`）

```java
private void sizeTouchTo(int x, int y, int w, int h) {
    if (x == lastTouchX && y == lastTouchY && w == lastTouchW && h == lastTouchH) return;
    lastTouchX = x; lastTouchY = y; lastTouchW = w; lastTouchH = h;
    ui.post(new PetWindowService$17(this, x, y, w, h));
}

// $17.run
touchLp.x = fx; touchLp.y = fy; touchLp.width = fw; touchLp.height = fh;
wm.updateViewLayout(touchBox, touchLp);
```

四元组全等就跳过——这就是防止「一点点卡」的抖动抑制，与页面侧 `unionString()` 的
44px 外扩是同一目的的两道防线（页面侧先稳一轮，原生侧再稳一轮）。

### 6.5 页面侧 `unionString()` 的 44 / 6 双阈值（`pet-multi.js:445`）

```js
function unionString() {
  const box = unionRect();                       // 所有宠物 visualBox + 未 hidden 的 bubbleEl + uiBoxes()
  const flying = /* mode === 'air' || mode === 'drag' */;
  if (flying) {
    // 飞行/拖拽中：外扩 44px，且只允许变大不允许变小
    live.l = Math.min(live.l, box.l - 44);
    live.t = Math.min(live.t, box.t - 44);
    live.r = Math.max(live.r, box.r + 44);
    live.b = Math.max(live.b, box.b + 44);
  } else {
    // 静止后：6px 阈值内不更新，避免亚像素抖动传导到原生窗口
    if (Math.abs(box.l - live.l) > 6 || ... ) { live = box; }
  }
  return `${live.l},${live.t},${live.r},${live.b}`;
}
```

原厂注释直白解释了动机：拖拽时宠物位置每帧变化，若如实上报，原生窗口每 80ms 挪一次，
视觉上就是「跟着一起抖」。**外扩 44px + 单向扩张**让拖拽期间窗口稳定大于宠物，
松手后再收敛。

### 6.6 时序

```
t=300ms  followTick ──┐
                      ↓
        queryPetRect  → evaluateJavascript(inj_07)
                      ↓  (WebView 线程, 几 ms)
      inj_07: __petUnionRect() / 兜底遍历 + focused
                      ↓  evaluateJavascript 结果回调
        $15.onReceiveValue("l,t,r,b|1")
             ├─ applyInputFocus(true)   → §7.2
             └─ density 换算 → +80 / max 520 → sizeTouchTo
                      ↓ post
        $17.run → touchLp{ x,y,w,h } → wm.updateViewLayout(touchBox)
                      ↓  (80ms 后)
                  followTick 重跑
```

---

## 7. IME 链路：整份代码里最巧的一处

### 7.1 问题

`touchBox` 是 `FLAG_NOT_FOCUSABLE` 的悬浮窗，而悬浮窗里的 WebView **永远拿不到输入法焦点**：
`FLAG_NOT_FOCUSABLE` 的窗口不会成为 IME 目标。所以页面里的 `<input>` 被点中时，
系统软键盘根本不会弹出。

原厂解法：**在窗口里塞一个 1×1 的隐藏 `EditText` 当「输入法诱饵」，把键盘骗出来，
再把键盘上屏的内容转给网页**。页面自己不接收任何真实按键。

### 7.2 焦点开关：`applyInputFocus` / `$16`

`applyInputFocus(boolean on)` 由 §6.3 每 80ms 调一次（值来自页面 `document.activeElement`）：

```java
private void applyInputFocus(boolean on) {
    long now = System.currentTimeMillis();
    if (on != inputFocusOn && now - lastFocusLog > 300) {       // 日志限流 300ms
        lastFocusLog = now;
        diag("inputFocus=" + on + " -> NOT_FOCUSABLE " + (on ? "ON" : "OFF"));
    }
    if (on == inputFocusOn) return;                            // 状态没变，不做任何事
    inputFocusOn = on;
    ui.post(new PetWindowService$16(this, on));
}
```

> 日志文案容易读反：`inputFocus=true -> NOT_FOCUSABLE ON` 表示「正在解除 NOT_FOCUSABLE」。
> 文案里的 ON/OFF 指的是 `inputFocus`，不是 flag 本身。

`$16.run` 做了三件事：

```java
// ① 临时清/置 FLAG_NOT_FOCUSABLE
if (touchBox != null && touchLp != null) {
    if (on) touchLp.flags &= ~FLAG_NOT_FOCUSABLE;    // 清掉 → 窗口可以成为 IME 目标
    else    touchLp.flags |=  FLAG_NOT_FOCUSABLE;    // 加回 → 恢复不抢焦点
    wm.updateViewLayout(touchBox, touchLp);
}

// ② 弹键盘：两次尝试
if (on) {
    ui.postDelayed($16$1, 120);      // 首次：focusImeAndShow()
    ui.postDelayed($16$2, 450);      // 兜底：再试一次（某些 ROM 首次 showSoftInput 会失败）
}
// ③ 收键盘
else {
    InputMethodManager imm = getSystemService(INPUT_METHOD_SERVICE);
    if (imm != null) imm.hideSoftInputFromWindow(imeProxy.getWindowToken(), 0);
    imeProxy.clearFocus();
    imeProxy.setFocusable(false);
    imeProxy.setFocusableInTouchMode(false);
    if (touchBox != null) touchBox.clearFocus();
}
```

`focusImeAndShow()`（smali 545）：

```java
imeProxy.setFocusable(true);
imeProxy.setFocusableInTouchMode(true);
imeProxy.requestFocus();
InputMethodManager imm = (InputMethodManager) getSystemService("input_method");
if (imm != null) imm.showSoftInput(imeProxy, 1);           // SHOW_IMPLICIT
Log.i("PetWindow", "[PET] 已请求 IME（hasFocus=" + imeProxy.hasFocus() + "）");
```

**所以「弹键盘」的本质是：临时把这个悬浮窗变成可获焦窗口 + 让 1×1 的 EditText 抢焦点。**
整个过程对用户不可见（EditText 背景/文字/光标全透明，尺寸 1×1）。

### 7.3 上屏：`InputConnection` 包装

`imeProxy` 的真实类型是 `PetWindowService$8 extends EditText`，只覆写一个方法：

```java
@Override
public InputConnection onCreateInputConnection(EditorInfo outAttrs) {
    InputConnection base = super.onCreateInputConnection(outAttrs);
    if (base == null) return null;
    return new PetWindowService$ImeCommitConnection(base, new PetWindowService$8$1(this));
}
```

`ImeCommitConnection` 是 `InputConnection` 的**过滤器**（26 个方法里 24 个纯透传），
只在三个位置插入回调：

```java
@Override public boolean commitText(CharSequence text, int newCursorPosition) {
    if (text != null && text.length() > 0) {
        sink.onCommit(text.toString());          // ← ① 先转给页面
    }
    base.commitText(text, newCursorPosition);    // ← ② 本地也进一份（维持 composing 状态机）
    sink.onClearLocal();                         // ← ③ 立刻清空本地，避免重复
    return true;
}

@Override public boolean finishComposingText() {
    // 拼音「选词上屏」走这里，同样抽一次 onCommit
    Editable e = ...;
    if (e != null && e.length() > 0) sink.onCommit(e.toString());
    base.finishComposingText();
    sink.onClearLocal();
    return true;
}

@Override public boolean sendKeyEvent(KeyEvent ev) {
    if (ev != null && ev.getAction() == ACTION_DOWN && ev.getKeyCode() == KEYCODE_DEL) {
        sink.onDelete();                          // ← 退格单独一条通道
    }
    return base.sendKeyEvent(ev);
}
```

`Sink` 三个方法的实现（`PetWindowService$8$1`）：

| 回调 | 实现 |
|------|------|
| `onCommit(String s)` | `-$$Nest$mpushTextToPage(service, s)` |
| `onDelete()` | `-$$Nest$mpushKeyToPage(service, "Backspace")`（**参数被忽略，写死 "Backspace"**） |
| `onClearLocal()` | `service.imeProxy.setText("")` |

### 7.4 两个方向的注入脚本

`pushTextToPage(text)`（smali 745）是**三段拼接**：

```java
web.evaluateJavascript(
    "(function(){try{var ae=document.activeElement;var el=null;" +
    "if(ae && (ae.tagName==='INPUT'||ae.tagName==='TEXTAREA')) el=ae;" +
    "if(!el) el=document.querySelector('#bubble input,#bubble textarea,.d-body input,.d-body textarea,input:focus,textarea:focus');" +
    "if(!el) return 'no-target';" +
    "el.value=(el.value||'')+" + jsStr(text) + ";" +                       // ← 注入点
    "el.dispatchEvent(new Event('input',{bubbles:true}));return 'ok';" +
    "}catch(e){return 'err';}})()",
    null);
```

前面那截就是 `inj_06.js`（断在 `el.value=(el.value||'')+`），**后截在方法体里**——这就是
为什么 `inj_06` 单独执行会语法错误。

`pushKeyToPage(key)`（smali 732）：

```java
web.evaluateJavascript(
    "(function(){try{var ae=document.activeElement;var el=null;" +
    "if(ae && (ae.tagName==='INPUT'||ae.tagName==='TEXTAREA')) el=ae;" +
    "if(!el) el=document.querySelector('#bubble input,#bubble textarea,.d-body input,.d-body textarea');" +
    "if(!el) return 'no-target';" +
    "el.value=(el.value||'').slice(0,-1);" +                               // 固定退格，不认 key 参数
    "el.dispatchEvent(new Event('input',{bubbles:true}));return 'ok';" +
    "}catch(e){return 'err';}})()",
    null);
```

**注意选择器不一致**：`pushTextToPage` 的选择器多了 `,input:focus,textarea:focus`，
`pushKeyToPage` 没有。后果是：页面里若有**不在 `#bubble` / `.d-body` 内**的输入框（例如装扮页、
或新版页面结构变动），打字能进、退格会返回 `no-target`。这是真实缺陷，记在 §11。

### 7.5 `_isComposing` 与 `afterTextChanged`

`imeProxy` 的 `TextWatcher`（`$9`）：

```java
@Override public void afterTextChanged(Editable s) {
    if (s.length() == 0) return;
    if (PetWindowService._isComposing(s)) return;      // 还在组词（拼音未选词）→ 保留
    s.clear();                                        // 已上屏 → 清空
}
```

`_isComposing(Editable)`（smali 244）：

```java
Object[] spans = e.getSpans(0, e.length(), Object.class);
for (Object sp : spans) {
    if ((e.getSpanFlags(sp) & 256) != 0) return true;   // 256 = Spanned.SPAN_COMPOSING
}
return false;
```

这一对的作用是**兜住 `onClearLocal` 的时序漏洞**：`commitText` 已经清了一次，但输入法在某些
ROM 上会异步再写一次组合文本，`afterTextChanged` 负责把残留清掉——同时用 `_isComposing`
保护拼音的中间态（否则打「zhong」还没选词就被清空，用户永远打不出中文）。

`$10` 是第二个退格入口（某些输入法不走 `sendKeyEvent` 而直接发按键）：

```java
@Override public boolean onKey(View v, int keyCode, KeyEvent ev) {
    if (ev.getAction() == ACTION_DOWN && keyCode == 67) {     // KEYCODE_DEL
        PetWindowService.-$$Nest$mpushKeyToPage(svc, "Backspace");
        return true;                                          // 吞掉，不让本地 EditText 处理
    }
    return false;
}
```

**退格有两条并行通道**（`ImeCommitConnection.sendKeyEvent` 和 `$10.onKey`），二者都可能触发，
中间没有去重。某些输入法上会退两格——这是 §11 的第二条缺陷。

### 7.6 完整时序

```
用户点页面 <input>
   ↓  (页面内，无原生参与)
document.activeElement = input
   ↓  (≤80ms 后，followTick)
inj_07 返回 "l,t,r,b|1"
   ↓
$15 → applyInputFocus(true) → $16.run
   ├─ touchLp.flags &= ~0x8 → updateViewLayout
   └─ postDelayed ×2 (120ms / 450ms)
        ↓
   focusImeAndShow(): imeProxy.focusable=true → requestFocus → imm.showSoftInput(1)
        ↓
   系统弹出软键盘
        ↓
用户打字 → IME → InputConnection
   ├─ commitText(text) → sink.onCommit → pushTextToPage
   │        → evaluateJavascript(inj_06 + jsStr(text) + 后缀)
   │        → 页面 el.value += text; dispatchEvent('input')
   │        → 页面 send({t:'text'}) 给 World（pet-app.js 的 __petType 路径之外）
   ├─ finishComposingText() → 同上抽一次（拼音选词）
   └─ 退格 → sendKeyEvent(67) 或 $10.onKey → pushKeyToPage("Backspace") → inj_05
        ↓
用户点页面空白 → activeElement = body
   ↓  followTick
"l,t,r,b|0" → applyInputFocus(false) → flags |= 0x8 + hideSoftInput + clearFocus ×2
```

### 7.7 `solve` 之外的形态

`RepairActivity`（修复页）用的是另一套：`inj_02` 注入 `__imeHack` + 捕获阶段 `focusin`
监听置 `window.__wantIme=1`，再用 `__imeProbe()` 轮询 `document.activeElement` 是否输入控件。
即**旧版走的是「页面主动上报意图」，新版 `PetWindowService` 走「原生 80ms 轮询」**。
两套代码同时在包里，`RepairActivity` 那条只是近似实现。

---

## 8. 语音链路

`VoiceBridge`（`petVoiceNative`）是唯一「页面主动调原生」并拿到**异步回调**的通道。

```java
// VoiceBridge.deliver(String kind, String text, String detail)   smali 114-161
String js = "(function(){try{var f=window.__petVoiceResult;" +
            "if(typeof f==='function')f(" +
            jsStr(kind) + "," + jsStr(text) + "," + jsStr(detail) +
            ");}catch(e){}})()";
ui.post(new VoiceBridge$1(this, js));      // $1.run → web.evaluateJavascript(js, null)
```

页面侧（`pet-app.js:36`）：

```js
window.__petVoiceResult = function (kind, text, detail) {
  if (kind === 'final') { __petType(text); return; }     // → send({t:'text', text})
  if (kind === 'error') { console.warn('[pet] voice', detail); return false; }
  // 其余（partial）忽略
};
```

`pet-app.js:18-19` 的原厂注释把边界说得很清楚：

> 安卓：手机自带语音识别（原生桥 `petVoiceNative`）与「文字注入」通道
> 桌面版没有 `petVoiceNative`，这里整块都不生效

即：语音识别**全程在原生侧完成**（`SpeechRecognizer` / 系统识别服务），页面只收最终文本。
`prefs.voice = { enabled, ready, detail, hint, mode }` 是页面侧的状态镜像。

---

## 9. 字符串转义：`jsStr`

`pushTextToPage` 与 `VoiceBridge.deliver` 都必须把任意用户文本安全塞进 JS 字面量，
共用 `PetWindowService.jsStr(String)`（smali 672，`static`）：

```java
private static String jsStr(String s) {
    if (s == null) return "null";
    StringBuilder sb = new StringBuilder("\"");          // 开引号
    for (int i = 0; i < s.length(); i++) {
        char c = s.charAt(i);
        switch (c) {
            case '"':  sb.append("\\\""); break;
            case '\\': sb.append("\\\\"); break;
            case '\n': sb.append("\\n");  break;
            case '\r': sb.append("\\r");  break;
            default:
                if (c < 0x20) sb.append(String.format("\\u%04x", (int) c));
                else sb.append(c);
        }
    }
    sb.append("\"");                                     // 闭引号 —— 注意：开头已 append，结尾再补一个
    return sb.toString();
}
```

三点必须注意：

1. **不做 `</script>` 转义**。因为走的是 `evaluateJavascript` 而不是拼 HTML，不需要。
2. **不处理 U+2028 / U+2029**（JS 里是行终止符）。理论上会截断字符串，实际出现在昵称/弹幕里
   概率极低，属未修缺陷。
3. `PetKeyboardGuard.reportIme` 里对 `via` 参数**另做了一次手写转义**
   （`'` → 空格），没有复用 `jsStr`。这是第二处实现，见 `docs/02` §9。

---

## 10. 单位与坐标系

这是最容易读错的部分，四处单位互不相同：

| 层 | 单位 | 来源 |
|----|------|------|
| 页面 `getBoundingClientRect()` | **CSS px**（= dp） | WebView viewport 未缩放，1 CSS px = 1 dp |
| `$15` 换算 | `× DisplayMetrics.density`（float，如 2.75） | 得**物理 px** |
| `WindowManager.LayoutParams.x/y/width/height` | 物理 px | 直接用 |
| `showLp.alpha` / `petAlpha` | 0.0–1.0 | 无单位 |
| `__petKeyboard(hPhys, seq)` 的第一个参数 | 物理 px，页面侧再 `/ devicePixelRatio` | `pet-app.js:325` |

所以「CSS px → 物理 px」只有一次乘法，位置在 `$15`。页面里所有跟键盘高度相关的计算
（`kbLift`、`floorY`）都在 CSS px 域完成，干净地避开了二次换算。

`forwardToWeb` 里的坐标处理有个**已知不一致**（smali 584–672）：

```java
for (int i = 0; i < pointerCount; i++) {
    props[i].id       = e.getPointerId(i);
    props[i].toolType = e.getToolType(i);

    coords[i].x = (i == 0) ? e.getRawX() : e.getX(i);      // ← 第一根手指用屏幕坐标
    coords[i].y = (i == 0) ? e.getRawY() : e.getY(i);      //    其余用窗口局部坐标
    coords[i].pressure = e.getPressure(i);
    coords[i].size     = e.getSize(i);
}
MotionEvent ev = MotionEvent.obtain(downTime, eventTime, action, pointerCount,
        props, coords, metaState, buttonState, xPrecision, yPrecision,
        deviceId, edgeFlags, source, flags);
web.dispatchTouchEvent(ev);
ev.recycle();
```

第一根手指必须用 `getRawX/getRawY`（因为 `touchBox` 是 520×520 小窗，局部坐标对不上全屏
WebView），这个处理是对的；但**第二根及以后的手指用的是局部坐标**，与第一根不在同一坐标系。
双指缩放/双指点击时坐标会错位。这是真实 bug，见 §11。

---

## 11. 协议缺陷清单

| # | 缺陷 | 证据 | 影响 |
|---|------|------|------|
| 1 | `pushKeyToPage` 选择器缺 `,input:focus,textarea:focus` | smali 732 vs 745 | 非 `#bubble`/`.d-body` 内的输入框能打字不能退格 |
| 2 | 退格双通道无去重 | `ImeCommitConnection.sendKeyEvent` + `$10.onKey` | 部分输入法一次退两格 |
| 3 | `forwardToWeb` 多指坐标系混用 | smali 584–672 | 双指操作坐标错位 |
| 4 | `TOUCH_SIZE=700` 死常量，实参硬编码 520 | static_values + smali 417 | 只是代码异味，无功能影响 |
| 5 | `petHost.setInteractive` 空转 | `PetHostBridge` smali 270 | 页面里想切「交互/穿透」无效，只能靠窗口 flag |
| 6 | `jsStr` 不转义 U+2028/U+2029 | smali 672 | 极端文本会截断注入脚本 |
| 7 | `PetKeyboardGuard.reportIme` 自写转义，未复用 `jsStr` | `docs/02` §9 | 两套转义规则，维护风险 |
| 8 | `$15` 的 `box.length() < 5` 阈值偏松 | smali | `"0,0,0"` 这类畸形串会进 `split` 后返回（被 `p.length<4` 兜住） |
| 9 | `density` 用 `float→int` 截断而非四舍五入 | smali | 亚像素误差 ≤1px，无感 |

---

## 12. 未取证 / 未还原

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

`errName(int)` 是 **9 个 case 的 `packed-switch`**。payload 原先要手工解，v3 工具已能直接输出
`:pswitch_data_0` 与 case 标签（`docs/04 §5.7` 第 4 条、`§12`）；下面的映射由「自动解析 + 手工核对」双向印证。
映射结果（= `SpeechRecognizer` 标准错误码语义，与 payload 完全自洽）：
`1→网络超时`（`ERROR_NETWORK_TIMEOUT`）、`2→网络错误`、`3→录音出错`、`4→识别服务出错`、
`5→客户端错误`、`6→没听到声音`、`7→没听清`、`8→识别服务忙`、
`9→没有麦克风权限`（`ERROR_INSUFFICIENT_PERMISSIONS`），default 拼 `"错误 "+n`。

> 手工解 payload 时要注意**方向**：`targets` 是相对 switch 指令的偏移，值越小地址越靠前。
> 实测 `key 9 → +23`（最先出现，对应第一个 `const-string`「没有麦克风权限」）、
> `key 1 → +47`（最后出现，对应「网络超时」）—— 与 `ERROR_INSUFFICIENT_PERMISSIONS=9`、
> `ERROR_NETWORK_TIMEOUT=1` 完全一致，可作双向印证。

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

`jpeg(int max, int q)` 的四段策略（四个阈值都是 `static final` 常量，值取自 DEX `static_values`）：

| 段 | 阈值 | 行为 |
|---|---|---|
| 缓存 | 距今 **< 700 ms** | 直接返回 `lastJpeg` |
| 版本闸 | `SDK_INT < 30` | `lastError = "需要 Android 11 及以上才能后台截屏"`，返回 null |
| 重试 | 与 `lastRequestAt` 间隔 **< 1200 ms** | `Thread.sleep` 补足；最多 **3** 次 |
| 旧图回退 | 3 次全败且 `lastJpeg` 距今 **≤ 2500 ms** | 返回旧图，否则 null |

五个阈值都是 `static final` 常量（`EyesService` 没有 `<clinit>`，值在 DEX `static_values` 里）：
`FRAME_CACHE_MS=700` / `MIN_CAPTURE_GAP_MS=1200` / `CAPTURE_ATTEMPTS=3` /
`MAX_STALE_MS=2500` / `CAPTURE_WAIT_MS=9000`。读法：
`python3 src/read_static.py src/x/classes2.dex 'Lcom/palai/prootsmoke/EyesService;'`
（该工具有字段名索引 bug，输出名会错显，**按声明顺序**对应即可，值本身正确）。

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

---

## 附：复现本文所有结论的命令

```bash
cd Coopanion_v12.71/src

# 1) 取 static final 常量真实值（PET_HOST_SHIM / TOUCH_SIZE 等）
python3 read_static.py x/classes.dex 'Lcom/palai/prootsmoke/PetWindowService;'

# 2) 全部 addJavascriptInterface 注入点
grep -n 'addJavascriptInterface' java2/classes/*.smali

# 3) 全部 evaluateJavascript 调用点
grep -c 'evaluateJavascript' java2/classes/*.smali | grep -v ':0'

# 4) 某个类的逐方法列表（定位行号后 sed -n 'a,bp'）
grep -n '^\.method' java2/classes/com.palai.prootsmoke.PetWindowService.smali

# 5) 页面侧回调入口
grep -rn '__petUnionRect\|__petIme\|__petKeyboard\|__petVoiceResult' recovered/vendor/pet/web/
```

工具链说明见 `docs/04-工具链与复现.md`（待写）。
