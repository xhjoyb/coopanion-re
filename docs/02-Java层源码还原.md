# 02 · Java 层源码还原

> 说明：本文的 Java 代码由 `classes.dex` / `classes2.dex` 反汇编（`java2/classes/*.smali`）后人工重建。
> 方法签名、常量、调用关系、日志文案均**逐字来自字节码**；
> 结构体（lambda / 匿名类）已还原为可读形态；少数被 R8 内联打散的分支按语义合并，标注 `// 推断`。
> 完整字节码见 `src/java2/classes/`，合计 124 个类。

> **修订记录 v2**（`docs/03` 取证后回改）：`TOUCH_SIZE` 实为 **700** 且是死常量（尺寸 520 直接写在
> `buildAndAttachLayers` 的 `LayoutParams` 构造实参里——smali 417/418 的 `const/16 v6|v7, #520`；`$15` 只是同值下限兜底）、`CHANNEL` 实为 `"coopanion_pet"`、两层 `flags` 由 3 个补全为 **6 / 4** 个、
> `sizeTouchTo` 参数是 `(x, y, w, h)` 不是 `(l, t, r, b)`、`applyInputFocus` **不动显示层也不上报键盘高度**、
> `ImeCommitConnection` 是内嵌类 `PetWindowService$ImeCommitConnection`、`queryPetRect` 的回调是 `$15` 而非 `applyRect`。
> 另：本文原 `§5.1 / §5.2 / §5.3` 三处交叉引用全部悬空（本文 §5 实际是 `EyesService`），已改指 `docs/03`。

---

## 1. `MainActivity`（2305 行 smali，Android 侧主控）

### 1.1 字段

```java
public class MainActivity extends Activity {
    private static final String TAG = "ProotSmoke";
    private static final int    PET_MAX_RETRY      = 8;      // 桌宠端口等待重试次数
    private static final long   PET_RETRY_INTERVAL = 1200L;  // 每次间隔
    private static final int    REQ_OVERLAY = 1001;
    private static final int    REQ_MIC     = 1002;

    private final AtomicBoolean petWinOn = new AtomicBoolean(false);
    private volatile boolean booting   = false;
    private volatile boolean coreReady = false;

    private ScrollView logScroll;
    private TextView   statusTv, tv;
    private WebView    web;
    private String     pendingLink, pendingName;
    private int        petRetry;
    private File       root;
}
```

`log()` 把每行同时写到 `TextView` 与 `getExternalFilesDir(null)/coop-run.log`；
日志行超过阈值时按 `add-int/lit16 v5, v0, #273` / `if-le v5, #500` 的节流条件刷新（约 500 行上限）。

### 1.2 生命周期

```java
@Override protected void onCreate(Bundle b) {
    super.onCreate(b);
    // 1) 纯代码建 UI：竖向 LinearLayout → 状态栏文字 + 日志 ScrollView + WebView
    // 2) 建 coop-run.log，写首行
    // 3) web = new WebView(this); 开启 JS / DOM Storage / 允许 file 访问
    // 4) web.addJavascriptInterface(...)  // 控制台页面用
    // 5) 处理 Intent 带来的外链（pendingLink / pendingName）
    // 6) boot();   // 后台线程
}
```

`onRequestPermissionsResult`：`REQ_MIC` 通过后继续语音链路，否则日志提示「没有麦克风权限」。
`onActivityResult`：接收「选文件」回传（`PetActivity` 里的 `<input type=file>` 用同一套 `ValueCallback`）。

### 1.3 启动链 `boot()` → `doBoot()`

> **本节已用 jadx 基线逐句校正（2026-10-25，`src/java/com/palai/prootsmoke/MainActivity.java`）。**
> 原版本节有 8 处与字节码不符，逐条列在节末「校正记录」。

```java
// 真实实现：boot() 同步调 doBoot()，线程由调用方决定（没有再 new Thread）
public void boot() {
    if (this.booting) { log("[BOOT] 已在启动中，忽略重复调用"); return; }
    this.booting = true;
    try { doBoot(); } finally { this.booting = false; }
}

private void doBoot() {
    log("[BOOT] 日志文件 = " + (getExternalFilesDir(null) != null
            ? getExternalFilesDir(null).getAbsolutePath() : "?") + "/coop-run.log");
    String libDir = getApplicationInfo().nativeLibraryDir;

    // ① payload 长度是「指纹」的一半；三级兜底：openFd → 流式计数 → -1
    long payloadLen;
    try {
        AssetFileDescriptor fd = getAssets().openFd("payload.asset");
        payloadLen = fd.getLength();
        fd.close();
    } catch (Throwable t1) {
        try {
            InputStream in = getAssets().open("payload.asset");
            byte[] buf = new byte[65536];
            long n = 0; int r;
            while ((r = in.read(buf)) > 0) n += r;
            in.close();
            payloadLen = n;
        } catch (Throwable t2) { payloadLen = -1; }
    }

    int vc = 0;
    try { vc = getPackageManager().getPackageInfo(getPackageName(), 0).versionCode; }
    catch (Throwable ignored) { }

    String name = "rootfs-v8-" + vc + "-" + payloadLen;

    // ② 清理旧指纹目录 —— 发生在解包判定之前，不是之后
    File[] ls = getFilesDir().listFiles();
    if (ls != null) {
        for (File f : ls) {
            String n = f.getName();
            if (f.isDirectory() && n.startsWith("rootfs-v8-") && !n.equals(name)) {
                try { deleteRec(f); log("[0b] 清理旧 rootfs 目录: " + n); }
                catch (Throwable ignored) { }
            }
        }
    }

    File dir = new File(getFilesDir(), name);
    File ok  = new File(dir, ".ok-v8-" + vc + "-" + payloadLen);   // 标记在 rootfs 目录内部

    if (!ok.exists()) {
        log("[0] 检测到新指纹，解压到新目录 " + name + " ...");
        log("[1] 解压 rootfs (payload=" + payloadLen + "B, 耐心等 1-2 分钟) ...");
        long t0 = System.currentTimeMillis();
        dir.mkdirs();
        extractTarGz(getAssets().open("payload.asset"), dir);
        fixPerms(dir);

        int bad = 0;
        for (String[] c : CRITICAL) {                 // 5 条硬约束，见 docs/01 §3.1
            long got  = new File(dir, c[0]).length();
            long want = Long.parseLong(c[1]);
            if (got != want) {
                log("[CHK] MISMATCH " + c[0] + " got=" + got + " want=" + want);
                bad++;
            }
        }
        log("[CHK] critical files: " + (5 - bad) + "/5 OK"
                + (bad > 0 ? "  <-- !!! 解压有问题，语音会失败" : ""));
        ok.createNewFile();                          // ⚠ 无条件写标记，见校正记录第 5 条
        log("    完成 " + (System.currentTimeMillis() - t0) + "ms");
    } else {
        log("[1] rootfs 已解压（指纹一致）");
    }

    // ③ 之后紧接着就是 proot 启动（**内联在 doBoot 里**，没有独立的 runCore 方法）
    ...// 见 §1.4
}
```

### 1.4 proot 拉起与看护（`doBoot()` 后半段）

```java
File ptmp = new File(getFilesDir(), "ptmp");        // 不是 getCacheDir()
ptmp.mkdirs();
ptmp.setReadable(true, false);
ptmp.setWritable(true, false);
ptmp.setExecutable(true, false);                    // 777，proot 子进程要写这里
log("[2] 启动 Coopanion Core ...");

List<String> cmd = new ArrayList<>();
cmd.add(libDir + "/libproot.so");                  // proot 在 nativeLibraryDir，不在 rootfs 里
cmd.add("-0");
cmd.add("-r");  cmd.add(dir.getAbsolutePath());
cmd.add("--link2symlink");
cmd.add("-b");  cmd.add("/dev");
cmd.add("-b");  cmd.add("/proc");
cmd.add("-b");  cmd.add("/sys");
cmd.add("-b");  cmd.add(libDir + ":/hostlib");
cmd.add("-w");  cmd.add("/app/coop-stage");

if (new File(dir, "app/boot.sh").exists()) {
    cmd.add("/bin/sh"); cmd.add("/app/boot.sh");
} else {
    log("[1b] 未找到 boot.sh，直接用 run-core.mjs 兜底启动 ...");
    cmd.add("/bin/node");
    cmd.add("--experimental-transform-types");
    cmd.add("run-core.mjs");
}

ProcessBuilder pb = new ProcessBuilder(cmd);
pb.redirectErrorStream(true);
pb.directory(dir);
Map<String, String> env = pb.environment();
String tmp = ptmp.getAbsolutePath();
env.put("TMPDIR", tmp); env.put("TMP", tmp); env.put("TEMP", tmp); env.put("PROOT_TMP_DIR", tmp);
env.put("PROOT_LOADER",    libDir + "/libprootloader.so");
env.put("PROOT_LOADER_32", libDir + "/libprootloader32.so");
env.put("PROOT_NO_SECCOMP", "1");
env.put("HOME", "/root");
env.put("LANG", "en_US.UTF-8");
env.put("TZ",   "Asia/Shanghai");
env.put("CORTICO_SUPERVISED", "1");
env.remove("LD_PRELOAD");

Process p = pb.start();                             // 任何 Throwable → log("[EXC] " + th)
BufferedReader r = new BufferedReader(new InputStreamReader(p.getInputStream()));
String line; int i = 0;
while ((line = r.readLine()) != null) {
    log(line);
    if (line.contains("core已启动") && !coreReady) {
        coreReady = true;
        new Thread(new MainActivity$17(this)).start();  // 等 17788 就绪 → web.loadUrl("http://127.0.0.1:17788/")
    }
    if (++i > 500) break;                           // 单次读循环上限 500 行
}
int rc = p.waitFor();

File rr = new File(dir, "app/coop-stage/home/companion/data/.restart-request");
if (rr.exists()) {                                  // 扩展安装后自重启协议
    rr.delete();
    log("[!] 检测到重启请求：扩展已安装，正在重启内核以生效 ...");
    log("[!] 重启中，请稍等 10~30 秒，控制台页面会自动刷新。");
    coreReady = false;
    Thread.sleep(1000L);
    new Thread(new MainActivity$18(this)).start();  // 递归重跑 boot()
    return;
}
log("[4] core 进程结束 rc=" + rc);
```

`waitPortOpen` 的真实签名是 **`static boolean waitPortOpen(String host, int port, int timeoutMs)`**，
调用点 `waitPortOpen("127.0.0.1", 17788, 60000)`；`MainActivity$17` 在端口超时时打印 `[3] Web UI 端口超时未就绪`。

#### 校正记录（原版 → 字节码）

| # | 原版写法 | 实际字节码 |
|---|---|---|
| 1 | `boot()` 里 `new Thread(this::doBoot)` | **同步调用** `doBoot()`，用 `try/finally` 复位 `booting`；线程由调用方给 |
| 2 | payload 长度失败即 `return`（“资源缺失”） | 三级兜底 `openFd → 流式计数 → -1`，**从不 return** |
| 3 | `.ok` 标记放 `getFilesDir()` 下 | 放**rootfs 目录内部**：`new File(dir, ".ok-v8-…")` |
| 4 | 旧目录清理在解包之后 | 在**解包判定之前**，且用 `!n.equals(name)` 比对 |
| 5 | CHK 通过才 `createNewFile()` | **无条件**创建标记（解压不完整也会打标记 → 下次直接跳过） |
| 6 | `TMPDIR = getCacheDir()` | `TMPDIR = getFilesDir()/ptmp`，并先 `chmod 777` |
| 7 | `libproot.so` 在 `root` 下 | 在 `getApplicationInfo().nativeLibraryDir` 下，且 `-b <libDir>:/hostlib` |
| 8 | 独立方法 `runCore(File root)` | **没有这个方法**，全部内联在 `doBoot()`；重启判定在 `waitFor()` 之后、`[4]` 之前 |

第 5 条是原厂的一个真实隐患：**解包内容长度不符时仍然写 `.ok` 标记**，下次启动会直接跳过解包，语音组件永久坏掉且不自愈。
这条已作为候选修正点登记（`BASELINE.md §7 P2`），改与不改都需真机验证。

### 1.5 桌宠开关

```java
private static boolean waitPortOpen(int port, int tries, long gap) {
    for (int i = 0; i < tries; i++) {
        try (Socket s = new Socket()) { s.connect(new InetSocketAddress("127.0.0.1", port), 400); return true; }
        catch (IOException ignored) { try { Thread.sleep(gap); } catch (InterruptedException e) { return false; } }
    }
    return false;
}

private void startPetWindowWhenReady() {
    new Thread(() -> {
        if (!waitPortOpen(7797, PET_MAX_RETRY, PET_RETRY_INTERVAL)) { log("[PET] 端口 7797 未就绪"); return; }
        startPetWindow();
    }, "pet-wait").start();
}

private void togglePetWindow() {
    if (petWinOn.get()) { stopService(new Intent(this, PetWindowService.class)); petWinOn.set(false); syncPetSw(); return; }
    if (!canDrawOverlays()) { requestOverlay(); return; }   // 走 Settings.ACTION_MANAGE_OVERLAY_PERMISSION
    startPetWindow();
}
```

`pushAlphaToService(float)`：把设置页的透明度经 `Intent` extra 送给 `PetWindowService`
（action = `com.palai.prootsmoke.SET_ALPHA`，extra key = `pet_alpha`）；
`showAlphaDialog()` 滑杆范围 0.2–1.0；`syncPetSw()` 只刷新开关显示；`askMicOnce()` 走 `REQ_MIC`。

`showGuide()` / `openSenseSettings()` / `senseStatus()`：分别打开首次引导、无障碍设置页
（`Settings.ACTION_ACCESSIBILITY_SETTINGS`）、以及查询 `SenseBridge`/`EyesService` 的可用状态。

---

## 2. `SenseBridge`（702 行 smali，设备感知 HTTP 服务）

**单例**，监听 `127.0.0.1:17899`，把「前台应用 / 亮屏锁屏 / 电量 / 通知」暴露成 JSON 给 rootfs 里的 Node 轮询。

```java
public final class SenseBridge {
    private static final int NOTIF_CAP = 64;
    public static final int PORT = 17899;
    private static volatile SenseBridge instance;

    private final Context ctx;
    private volatile boolean running;
    private ServerSocket server;
    private Thread thread;
    private final List<JSONObject> notifs = new ArrayList<>();
    private long notifSeq = 0;

    public static synchronized SenseBridge get(Context c) {   // 单检（方法级 synchronized）
        if (instance == null) instance = new SenseBridge(c.getApplicationContext());
        return instance;
    }
    public static SenseBridge peek() { return instance; }

    public void start() {
        if (running) return;                              // 幂等守卫
        running = true;
        thread = new Thread(this::loop, "sense-bridge");
        thread.setDaemon(true);                           // loop 线程是 daemon
        thread.start();
    }

    private void loop() {
        try {
            server = new ServerSocket(PORT, 8, InetAddress.getByName("127.0.0.1"));
            while (running) {                             // 退出靠 running 标志
                Socket s = server.accept();
                new Thread(() -> handle(s), "sense-bridge-conn").start();  // 连接线程非 daemon
            }
        } catch (IOException e) { running = false; }       // stop() 关 server → accept 抛 IOException
                                                          // stop() 只置标志 + close，不 join 线程
    }

    /** 手写 HTTP/1.1：只支持 GET，读首行 + 头部到空行，路由三选一。 */
    private void handle(Socket s) {
        try (Socket sock = s) {
            BufferedReader in  = new BufferedReader(new InputStreamReader(sock.getInputStream(), "UTF-8"));
            OutputStream  out  = sock.getOutputStream();

            String req = in.readLine();
            if (req == null) return;
            String path = req.split(" ")[1];
            String line;
            while ((line = in.readLine()) != null && !line.isEmpty()) { /* 丢弃头部 */ }

            String body;
            int code = 200;
            if (path.startsWith("/health"))             body = healthJson();
            else if (path.startsWith("/state"))          body = stateJson();
            else if (path.startsWith("/notifications"))  body = notificationsJson(since(path));
            else { code = 404; body = "{}"; }

            byte[] b = body.getBytes("UTF-8");
            String head = "HTTP/1.1 " + code + " " + (code == 200 ? "OK" : "Not Found") + "\r\n"
                        + "Content-Type: application/json; charset=utf-8\r\n"
                        + "Content-Length: " + b.length + "\r\n"
                        + "Connection: close\r\n\r\n";
            out.write(head.getBytes("UTF-8"));
            out.write(b);
            out.flush();
        } catch (Throwable ignored) {}
    }

    // ⚠ 没有独立 since() 方法：解析逻辑内联在连接 lambda 里（下为等价渲染）
    private static long since(String path) {
        int i = path.indexOf("since=");
        if (i < 0) return 0;
        int j = i + 6; int k = j;
        while (k < path.length() && Character.isDigit(path.charAt(k))) k++;
        try { return Long.parseLong(path.substring(j, k)); } catch (Exception e) { return 0; }
    }
}
```

三个 JSON 构造器：

```java
private String healthJson() {
    // {"ok":true,"sources":{"usage":<bool>,"notif":<bool>,"accessibility":<bool>}}
}
private boolean hasUsageAccess() {
    AppOpsManager a = (AppOpsManager) ctx.getSystemService(Context.APP_OPS_SERVICE);
    return a.checkOpNoThrow("android:get_usage_stats", Process.myUid(), ctx.getPackageName())
            == AppOpsManager.MODE_ALLOWED;
}
private boolean isAccessibilityOn() {
    String s = Settings.Secure.getString(ctx.getContentResolver(), "enabled_accessibility_services");
    return s != null && s.contains(ctx.getPackageName());
}

private String stateJson() {
    // {"app":{"pkg":…,"label":…,"ts":…},"screen":{"on":…,"locked":…},"power":{"charging":…,"level":…}}
}
private String foregroundPackage() {
    UsageStatsManager usm = (UsageStatsManager) ctx.getSystemService("usagestats");
    long end = System.currentTimeMillis(), begin = end - 3600_000L;
    List<UsageStats> list = usm.queryUsageStats(UsageStatsManager.INTERVAL_DAILY /* 0 */, begin, end);
    long best = -1; String pkg = null;
    for (UsageStats u : list) if (u.getLastTimeUsed() > best) { best = u.getLastTimeUsed(); pkg = u.getPackageName(); }
    return pkg;
}
private String screenJson() {   // PowerManager.isInteractive() + KeyguardManager.isKeyguardLocked()
}
private String powerJson() {    // 注册 ACTION_BATTERY_CHANGED（registerReceiver(null, filter)）
    // level = Math.round(level * 100f / scale)，取不到时 level = -1（不是省字段）
    // charging = status==2(CHARGING) || status==5(FULL)
}

/** 通知环形缓冲：seq 自增、id = "n"+seq、上限 64 条（超出 remove(0)）。 */
public void addNotification(String pkg, String app, String title, String text, long when) {
    synchronized (notifs) {
        long seq = ++notifSeq;
        JSONObject o = new JSONObject();
        o.put("seq", seq).put("id", "n" + seq).put("pkg", pkg)
         .put("app", app).put("title", title).put("text", text);   // ⚠ 没有 "when"，when 是死参数
        notifs.add(o);
        while (notifs.size() > NOTIF_CAP) notifs.remove(0);
    }
}

private String notificationsJson(long since) {
    // {"cursor":<notifSeq>,"items":[{seq,id,pkg,app,title,text}]}；items 只含 optLong("seq",0) >= since
}
private static String nowIso() {
    return new SimpleDateFormat("yyyy-MM-dd'T'HH:mm:ssXXX", Locale.US).format(new Date());
}
```

> 消费端即 `recovered/vendor/pet/src/eyes.ts#state()`：它把 `app/screen/power` 解成 `ScreenState`。

#### §2 校正记录（原版 → 字节码，2026-10-25）

| # | 原版 | 实际 |
|---|---|---|
| 1 | `MAX_NOTIFS` | 常量名 **`NOTIF_CAP`**（值同 64）；另有 `public static final int PORT = 17899` |
| 2 | `get()` 双检锁 | **`static synchronized` 单检**，`instance` 是 `volatile` |
| 3 | 有 `Handler ui` 字段 | **没有**；真实字段为 `running / server / thread` |
| 4 | `start()` 无守卫 | 先 `if (running) return`，再 `running = true`，线程存进 `thread` |
| 5 | 连接线程 daemon | **连接线程非 daemon**（只有 `sense-bridge` loop 线程 daemon） |
| 6 | `addNotification` 写 `when` | **不写**；第 5 个参数 `long` 全类未使用（死参数）；JSON 只有 `seq/id/pkg/app/title/text`， 归一为 `""` |
| 7 | 有独立 `since()` | 解析内联在连接 lambda 里；没有该方法 |
| 8 | `stop()` 未描述 | 置 `running=false` + `server.close()`，**不 join**；accept 抛 `IOException` 后把 `running` 再置 false |
| 9 | `powerJson` level 无兜底 | 取不到时 **`level = -1`** |
| 10 | `addNotification` 块同步 | 实际是 `public synchronized` 方法；`notificationsJson` 只在取 items/cursor 时 `synchronized(this)` |



---

## 3. `PetWindowService`（1123 行 smali，桌面悬浮桌宠）

### 3.1 双窗口结构

```java
public class PetWindowService extends Service {
    private static final String TAG = "PetWindow";
    private static final String PET_URL   = "http://127.0.0.1:7797/pet";
    private static final String PREF      = "coopanion";
    private static final String KEY_ALPHA = "pet_alpha";
    private static final String PET_HOST_SHIM = INJ_01;      // inj_01 全文（1062 B），编译期折叠进 static_values，见 docs/03 §3
    private static final int TOUCH_SIZE = 700;   // 真值 700；**全类零引用（死常量）**，实际尺寸见本节的 flags 说明
    private static final int NOTI_ID    = 8801;
    private static final String CHANNEL = "coopanion_pet";

    private WindowManager wm;
    private Handler ui = new Handler(Looper.getMainLooper());

    // ── 显示层：全屏、不可触摸（FLAG_NOT_TOUCHABLE），只负责把宠物画出来
    private FrameLayout       showBox;  private WindowManager.LayoutParams showLp;
    // ── 触摸层：初始 520×520 小窗，之后随页面并集矩形实时缩放，只覆盖宠物本体附近
    private FrameLayout       touchBox; private WindowManager.LayoutParams touchLp;
    private WebView           web;
    private EditText          imeProxy;          // 隐藏输入框，骗出输入法

    private volatile float petX, petY;           // 并集矩形中心（物理 px）；只写不读，调试残留
    private float petAlpha = 1f;
    private volatile boolean inputFocusOn, firstLoadReloaded;
    private int screenW, screenH, lastTouchX, lastTouchY, lastTouchW, lastTouchH;
    private long lastFocusLog, lastProbeLog;
    private final Runnable followTick = …;       // 每 80ms 调一次 queryPetRect()，自续期不停
}
```

`buildAndAttachLayers(int type)` 是唯一建层入口，
`type = Build.VERSION.SDK_INT >= 26 ? 2038 /*TYPE_APPLICATION_OVERLAY*/ : 2002 /*TYPE_SYSTEM_ALERT*/`。

> 上面 8 个 `static final` 的真值不是从 Java 代码推的，是从 DEX `class_def_item.static_values_off` 指向的
> `encoded_array` 里取的（脚本 `src/read_static.py`）：本类**没有 `<clinit>`**，这些常量已被 javac 折叠，
> 字段本身是死的，值只存在于静态值表。

两层都以 `wm.addView(...)` 挂上。两个 `flags` 同样是 smali 里的整型常量，逐位拆开：

| 层 | 构造实参 `(w, h, type, flags, format)` | `flags` | 逐位含义 |
|---|---|---|---|
| 显示层 `showLp` | `(-1, -1, type, 66328, -3)` | `0x102D8` | `0x8` NOT_FOCUSABLE · `0x10` NOT_TOUCHABLE · `0x40` TOUCHABLE_WHEN_WAKING · `0x80` KEEP_SCREEN_ON · `0x200` LAYOUT_NO_LIMITS · `0x10000` LAYOUT_INSET_DECOR |
| 触摸层 `touchLp` | `(520, 520, type, 808, -3)` | `0x328` | `0x8` NOT_FOCUSABLE · `0x20` NOT_TOUCH_MODAL · `0x100` LAYOUT_IN_SCREEN · `0x200` LAYOUT_NO_LIMITS |

即**显示层全屏且完全穿透**（`NOT_TOUCHABLE`，事件直接落到底下的 App / 桌面）；
**触摸层并不是「只留 `FLAG_NOT_FOCUSABLE`」**——它另带 `NOT_TOUCH_MODAL`（窗外事件照常下传）与两个 LAYOUT flag。
`gravity` 两层都是 `0x800033`（`TOP|START`）、`x = y = 0`；触摸层额外 `softInputMode = 16`（`SOFT_INPUT_ADJUST_RESIZE`）。
日志：`[PET] 显示层已挂载（全屏穿透）` / `[PET] 触摸层已挂载 520x520`——`520` 是日志文案里的字面量，**不是** `TOUCH_SIZE`。

> 完整推导（含 `PetKeyboardGuard.install(ctx, null, null)`、`imeProxy` 的 `0x2000006` 两个 IME flag）见 `docs/03 §5`。

### 3.2 桌面宠「只让点宠物」

```java
/** 向页面要一次并集包围盒（页面里的 window.__petUnionRect，见 `docs/03 §6.2`）。 */
private void queryPetRect() {
    web.evaluateJavascript("(function(){try{var box='';try{if(window.__petUnionRect)box=window.__petUnionRect()||'';}catch(e0){}…})()",
        new PetWindowService$15(this));   // 回调是 $15.onReceiveValue，本类没有 applyRect 方法
}

/** 触摸层去抖落位：四个 int 与 lastTouchX/Y/W/H 全等就丢弃，否则 post($17) 改 touchLp。参数是 (x, y, w, h)。 */
private void sizeTouchTo(int x, int y, int w, int h) { … }

/** 触摸层收到的事件直接翻译成坐标转发给 WebView。 */
private boolean forwardToWeb(MotionEvent e) { … }
```

`startRepaintWatchdog(WebView)`：页面首帧后如果 WebView 一直不重绘（国产 ROM 常见），
定期 `evaluateJavascript` 触发一次强制 `transform`（`PetWindowService$13` + inj_04 `__repaintHack`，见 `docs/03 §2` 表中第 6 行）。
`warmUpRenderer(Runnable)`：先加载 `about:blank` 预热 Chromium 渲染进程，再 `loadUrl(PET_URL)`。

### 3.3 输入法注入（本项目最巧的一处）

悬浮窗里的 WebView 拿不到输入法焦点（`FLAG_NOT_FOCUSABLE`）。它的做法是：
**在窗口里放一个隐藏 `EditText` 把输入法骗出来，再把输入法上屏的内容转到网页输入框。**

```java
/** 由 $16$1 / $16$2 在 120ms / 450ms 各调一次（两次尝试，抗 ROM 差异）；它自己不调 applyInputFocus。 */
private void focusImeAndShow() {
    if (imeProxy == null) return;
    imeProxy.setFocusable(true);                 // 注意：与 buildAndAttachLayers 里的 setFocusable(false) 相对
    imeProxy.setFocusableInTouchMode(true);
    imeProxy.requestFocus();
    InputMethodManager imm = (InputMethodManager) getSystemService("input_method");
    if (imm != null) imm.showSoftInput(imeProxy, 1 /*SHOW_IMPLICIT*/);
    Log.i(TAG, "[PET] 已请求 IME（hasFocus=" + imeProxy.hasFocus() + "）");   // 这行日志是排障唯一入口
}

/** 隐藏 EditText 的 InputConnection 代理：只截「上屏」与「退格」，其余透传。 */
static final class PetWindowService$ImeCommitConnection implements InputConnection {   // 内嵌类，非顶层类
    interface Sink { void onCommit(String text); void onDelete(); void onClearLocal(); }
    private final InputConnection base;
    private final Sink sink;

    @Override public boolean commitText(CharSequence text, int newCursorPosition) {
        if (text != null && text.length() > 0) sink.onCommit(text.toString());
        boolean ok = base.commitText(text, newCursorPosition);
        sink.onClearLocal();                 // 清掉本地 EditText，避免重复
        return true;
    }
    @Override public boolean setComposingText(CharSequence text, int pos) {
        return base.setComposingText(text, pos);   // 拼音过程不转发
    }
    @Override public boolean finishComposingText() {
        CharSequence before = base.getTextBeforeCursor(4096, 0);
        if (before != null && before.length() > 0) sink.onCommit(before.toString());
        base.finishComposingText();
        sink.onClearLocal();
        return true;
    }
    @Override public boolean sendKeyEvent(KeyEvent ev) {
        if (ev != null && ev.getAction() == KeyEvent.ACTION_DOWN && ev.getKeyCode() == KeyEvent.KEYCODE_DEL)
            sink.onDelete();
        return base.sendKeyEvent(ev);
    }
    // 其余 20 余个方法一律 return base.xxx(...)（纯透传，见 smali 286 行）
}
```

Sink 的三个方法落到 `PetWindowService$8$1`：`onCommit(s)` → `pushTextToPage(s)`；`onDelete()` → `pushKeyToPage("Backspace")`（**实参写死，调用方传什么都忽略**）；`onClearLocal()` → `imeProxy.setText("")`。前两个落到下面两个 JS 调用：

```java
private void pushTextToPage(String text) {   // `docs/03 §7.4` inj_06：追加并派发 input 事件
    web.evaluateJavascript("(function(){try{var ae=document.activeElement;…el.value=(el.value||'')+" + jsStr(text) + ";…})()", null);
}
private void pushKeyToPage(String key) {     // 退格
    web.evaluateJavascript("(function(){…el.value=(el.value||'').slice(0,-1);el.dispatchEvent(new Event('input',{bubbles:true}));…})()", null);
}
private static String jsStr(String s) { /* JSON 转义：\ " \n \r */ }
```

`applyInputFocus(boolean on)`：**只动触摸层的一个 flag**——`on` 时 `touchLp.flags &= ~0x8`
（临时清掉 `FLAG_NOT_FOCUSABLE`，否则输入法不肯弹），`off` 时 `|= 0x8` 复位；两次都 `updateViewLayout(touchLp)`，
`off` 分支还会 `imm.hideSoftInputFromWindow(imeProxy.getWindowToken(), 0)` + `imeProxy.clearFocus()`。

> 两个常见误读：① 它**不碰显示层**；② 它**不上报键盘高度**。键盘高度是另一条独立链路
> （`PetKeyboardGuard.reportIme` / `reportKeyboard` → 注入 `window.__petKeyboard(h)`，见 `docs/03 §2`）。
> 日志文案 `inputFocus=false -> NOT_FOCUSABLE ON` 里的 ON/OFF 指的是「`inputFocus` 关闭」，
> 不是「`NOT_FOCUSABLE` 被打开」——极易读反。

### 3.4 诊断

`diag(String)`：`Log.i(TAG, "[DIAG] " + s)` 同时 append 到 `/sdcard/Download/coop-diag.txt`；
焦点变化有节流（`lastFocusLog` / `lastProbeLog`），避免刷屏。

---

## 4. `PetWindowService$PetHostBridge`（注入给页面的 `petHostNative`）

方法表（**9 个 public 方法，全部是 JS ⇄ Java 的契约**）：

```java
public final class PetHostBridge {
    // 注意：无 @JavascriptInterface 注解（R8 保留名），由 addJavascriptInterface(obj,"petHostNative") 暴露

    public void setInteractive(boolean on) { Log.i("PetWindow", "[PET] setInteractive=" + on); }
    public void focus()        { /* 空实现：焦点由 IME 链路接管 */ }
    public void grabFocus()    { /* 空 */ }
    public void releaseFocus() { /* 空 */ }
    public void hide()         { ui.post(new PetHostBridge$2(this)); }   // 隐藏悬浮窗
    public void openDress()    { ui.post(new PetHostBridge$3(this, ctx)); } // 打开装扮页
    public void setAlpha(float f) { … }
    public float getAlpha()    { return PetWindowService.this.petAlpha; }
    public boolean openApp(String name) { … }
}
```

`setAlpha`：`clamp(0f, 1f)` → 写 `SharedPreferences("coopanion").putFloat("pet_alpha", f)` → `ui.post` 里改 `showLp.alpha` 并 `wm.updateViewLayout`。

`openApp(String name)` 的真正逻辑（**不是**按包名精确匹配，而是模糊打分启动）：

```java
public boolean openApp(String raw) {
    if (raw == null) return false;
    String q = raw.trim().toLowerCase();
    if (q.isEmpty()) return false;
    PackageManager pm = getPackageManager();
    Intent main = new Intent(Intent.ACTION_MAIN).addCategory(Intent.CATEGORY_LAUNCHER);
    List<ResolveInfo> all = pm.queryIntentActivities(main, 0);
    int best = -1; String bestPkg = null;
    for (ResolveInfo ri : all) {
        if (ri == null || ri.activityInfo == null) continue;
        String pkg   = ri.activityInfo.packageName;
        CharSequence l = ri.loadLabel(pm);
        String label = (l == null ? "" : l.toString()).toLowerCase();
        String pkgL  = pkg.toLowerCase();
        int score;
        if (pkgL.equals(q))            score = 1000;              // 包名全等
        else if (label.equals(q))      score = 900;               // 应用名全等
        else if (label.contains(q))    score = 700 - (label.length() - q.length());  // 名字包含
        else if (pkgL.contains(q))     score = 500 - (pkgL.length()  - q.length());  // 包名包含
        else score = -1;
        if (score > best) { best = score; bestPkg = pkg; }
    }
    if (bestPkg == null || best < 0) { Log.i("PetWindow", "[PET] openApp 没找到: " + raw); return false; }
    Intent launch = pm.getLaunchIntentForPackage(bestPkg);
    if (launch == null) { Log.i("PetWindow", "[PET] openApp 无启动入口: " + bestPkg); return false; }
    launch.addFlags(Intent.FLAG_ACTIVITY_NEW_TASK);
    startActivity(launch);
    Log.i("PetWindow", "[PET] openApp 启动 " + raw + " -> " + bestPkg);
    return true;
}
```

> 例：模型说「打开微信」→ `openApp("微信")` → 命中 `com.tencent.mm` 的 label。

---

#### §3/§4 核对记录（2026-10-25）

`§3` 与字节码**逐项吻合**，未发现偏差。已核对项：

| 项 | 真值 | 结论 |
|---|---|---|
| `CHANNEL` | `"coopanion_pet"` | ✓ |
| `TOUCH_SIZE` | `700`，全类零引用（死常量） | ✓ |
| `showLp` | `(-1, -1, type, 66328, -3)` | ✓ |
| `touchLp` | `(520, 520, type, 808, -3)` | ✓ |
| `PREF` / `KEY_ALPHA` | `coopanion` / `pet_alpha` | ✓ |
| `imeProxy` | `EditText`，1×1，`textColor=0` / `cursorVisible=false` / `imeOptions=0x2000006` / `inputType=1` / `singleLine` / `focusable=false` | ✓ |
| `followTick` | `ui.postDelayed(this, 80L)` 自续期 | ✓ |
| `warmUpRenderer` | 1×1 隐藏 WebView（`type = 2038/2002`、`flags = 24`）预热完 `removeView` | ✓，但它是**第三个 WindowManager 窗口**，正文未点明 |

`§4` 一处校正：

| # | 原版 | 实际 |
|---|---|---|
| 1 | 「无 `@JavascriptInterface` 注解（R8 保留名）」 | **有注解**：dex 里 9 个方法全部带 `@JavascriptInterface`，不是靠 `addJavascriptInterface` 隐式暴露 |

另补充两条实测事实（原有正文未写）：

1. `PetHostBridge` 的 9 个方法顺序为 `focus / grabFocus / releaseFocus / setInteractive / setAlpha / getAlpha / openApp / hide / openDress`；
   其中 **`focus`、`grabFocus`、`releaseFocus` 是彻底空方法**，`setInteractive` 只 `Log.i` 不改任何行为。
   即 **Service 版的「交互开关」是名义接口**——页面调 `petHost.setInteractive(false)` 在 Java 侧无任何效果。
2. 触摸层尺寸真正由 **`queryPetRect()` 主动问页面**（`evaluateJavascript` 取并集矩形）→ `sizeTouchTo(x,y,w,h)` 调 `updateViewLayout` 驱动；
   Service 版**没有** `reportPetRect`（那是 `PetActivity` 的 `PetHostBridge` 才有）。

## 5. `EyesService`（1570 行 smali，无障碍「眼睛」）

`AccessibilityService`，常驻监听 `127.0.0.1:17898`。字段常量：

```java
private static final int  PORT               = 17898;
private static final int  CAPTURE_ATTEMPTS   = 3;      // 截屏重试次数
private static final long CAPTURE_WAIT_MS    = 9000L;  // 单次 latch 等待（captureOnce 的硬超时）
private static final long FRAME_CACHE_MS     = 700L;   // 帧缓存命中窗口
private static final long MAX_STALE_MS       = 2500L;  // 旧图可回退的最大年龄，超过算「没有画面」
private static final long MIN_CAPTURE_GAP_MS = 1200L;  // 两次截屏最小间隔（系统限流）
```

> **这 5 个数字的出处**（原文档的 1200/900/6000/700 全是错的）：类里**没有 `<clinit>`**，
> 常量是编译期写进 DEX `static_values` 的，必须直接读：
> `python3 src/read_static.py src/x/classes2.dex 'Lcom/palai/prootsmoke/EyesService;'`。
> 该工具有 `field_ids` 索引 bug，字段名会错显（本次全成 `ARGB_8888`），**按声明顺序对应、值本身正确**。
> `SERVICE_NAME` 字段**不存在** —— `/health` 里的 `"coopanion-eyes"` 是方法内联字面量。

路由（`handle()`，与 `SenseBridge` 同构的手写 HTTP）：

| 路径 | 返回 |
|---|---|
| `/health` | `{"ok":true,"service":"coopanion-eyes","sdk":..,"canScreenshot":..,"pkg":..,"frameWidth":..,"frameHeight":..,"frameAgeMs":..,"frameBytes":..,"error":..}`（**无 `routes` 字段**）；无帧时 `frameAgeMs = -1`、`frameBytes = 0` |
| `/screen.jpg?max=720&q=62` | JPEG 字节流，响应头带 `x-width` / `x-height` / `x-pkg` / `x-age-ms` |
| `/ui` | `{"ok":true,"pkg":"…","items":[{"t":文本,"c":类名,"b":"[l,t][r,b]"}]}` |
| `/open_settings` | 打开无障碍设置页，`{"ok":true}` |
| `/help` | 自述路由表 |

错误串（页面/模型看到的就是这些）：`NO_FRAME`、`截屏失败`、`截屏超时`、`需要 Android 11 及以上才能后台截屏`。

关键方法：

```java
private byte[] captureOnce(int max, int q);     // takeScreenshot(0, executor, cb) + CountDownLatch.await(9000ms)
private byte[] jpeg(int max, int q);            // FRAME_CACHE_MS→MIN_CAPTURE_GAP_MS→CAPTURE_ATTEMPTS→MAX_STALE_MS
private String uiJson(…);           // 遍历 getRootInActiveWindow()，static collect() 递归取 text
public  String healthJson(), helpJson();
public  void   openSettings();
public  void   onAccessibilityEvent(AccessibilityEvent e);   // 只用来刷新 pkg / UI 缓存
// IME 相关：imeHeight() / imeHeightSmart() / imeVisible() / imePackages() / notifyIme() / setImeListener()
```

`imeHeightSmart()` 是给桌宠用的**三态**接口，但三态含义与直觉相反（`imeHeightOf()` 末尾就是 `return z ? -1 : 0;`）：

| 返回值 | 真含义 |
|---|---|
| `> 0` | 量到了 IME 窗口高度（且 < 屏高 90%） |
| `-1` | **看到了 IME 窗口但它高度 ≥ 屏高 90%**（判为不可信 / 全屏 IME），`z = true` 但没记高度 |
| `0` | 无障碍**没跑**（`instance == null`）、`getWindows()` 为 null、抛异常，或压根没找到 IME 窗口 |

`PetKeyboardGuard.imeHeight()` 的分流（实测第 106–143 行）：
**`> 0` 采信**（`lastSource = "a11y=…"`）→ **`< 0` 用 `screenH * 0.38` 估算**（`"a11y~guess=…"`）→ **`== 0` 才继续走**
`root.getRootWindowInsets()` → 触控层 insets → `getWindowVisibleDisplayFrame` 三级。
另注：`imeHeight()`（不带 Smart）在 `instance == null` 或结果 `<= 0` 时**一律返回 0**，所以 `-1` 只可能从 `imeHeightSmart()` 出来。

---

## 6. `VoiceBridge`（334 行 smali）

```java
final class VoiceBridge {
    private static final String TAG = "PetVoice";
    private final Context ctx;
    private final WebView web;
    private final Handler ui = new Handler(Looper.getMainLooper());
    private SpeechRecognizer rec;
    private boolean wanted;

    boolean available() { return SpeechRecognizer.isRecognitionAvailable(ctx); }

    void start() {
        ui.post(() -> {                        // $2
            if (rec == null) rec = build();
            wanted = true;
            rec.cancel();                      // 先取消上一次
            rec.startListening(intent());
            deliver("start", "", "");          // 通知页面「已开始」
        });
    }
    void stop()   { ui.post(() -> { if (rec != null) rec.stopListening(); }); }  // $3：**不置** wanted
    void cancel() { ui.post(() -> { wanted = false; if (rec != null) rec.cancel(); }); }  // $4：wanted 在 post 内

    /** 用系统识别器：中文、自由说、要中间结果。 */
    private Intent intent() {
        Intent i = new Intent(RecognizerIntent.ACTION_RECOGNIZE_SPEECH);   // "android.speech.action.RECOGNIZE_SPEECH"
        i.putExtra(RecognizerIntent.EXTRA_LANGUAGE_MODEL, RecognizerIntent.LANGUAGE_MODEL_FREE_FORM);
        i.putExtra(RecognizerIntent.EXTRA_LANGUAGE, "zh-CN");
        i.putExtra(RecognizerIntent.EXTRA_MAX_RESULTS, 1);   // 与 PARTIAL_RESULTS 共用同一个 const/4 #1
        i.putExtra(RecognizerIntent.EXTRA_PARTIAL_RESULTS, true);
        i.putExtra("calling_package", ctx.getPackageName());
        return i;
    }

    /** 结果回页面：window.__petVoiceResult(kind, text, detail) */
    private void deliver(String kind, String text, String detail) {
        String js = "(function(){try{var f=window.__petVoiceResult;if(typeof f==='function')f("
                  + jsStr(kind) + "," + jsStr(text) + "," + jsStr(detail) + ");}catch(e){}})()";
        ui.post(() -> web.evaluateJavascript(js, null));
    }

    /** 错误码 → 人话（页面直接显示）。smali 里是 packed-switch（key 1..9），此处按常量名还原。 */
    private static String errName(int code) {
        switch (code) {
            case SpeechRecognizer.ERROR_AUDIO:             return "录音出错";
            case SpeechRecognizer.ERROR_CLIENT:            return "客户端错误";
            case SpeechRecognizer.ERROR_INSUFFICIENT_PERMISSIONS: return "没有麦克风权限";
            case SpeechRecognizer.ERROR_NETWORK:           return "网络错误";
            case SpeechRecognizer.ERROR_NETWORK_TIMEOUT:   return "网络超时";
            case SpeechRecognizer.ERROR_NO_MATCH:          return "没听清";
            case SpeechRecognizer.ERROR_RECOGNIZER_BUSY:   return "识别服务忙";
            case SpeechRecognizer.ERROR_SERVER:            return "识别服务出错";
            case SpeechRecognizer.ERROR_SPEECH_TIMEOUT:    return "没听到声音";
            default:                                       return "错误 " + code;
        }
    }
}
```

页面侧（`recovered/vendor/pet/web/pet-app.js:36`，原厂注释直接点名了本类）：

```js
// 安卓语音桥的回调（VoiceBridge.java 里 evaluateJavascript 调的就是它）
window.__petVoiceResult = function (kind, text, detail) {
  if (kind === 'final') return window.__petType(text);
  if (kind === 'error' && detail) { try { console.warn('[pet] voice:', detail); } catch (e) {} }
  return false;
};
```

---

## 7. `NotifListenerService`（159 行 smali）

```java
public class NotifListenerService extends NotificationListenerService {
    @Override public void onNotificationPosted(StatusBarNotification sbn) {
        if (sbn == null || sbn.getNotification() == null) return;
        Bundle ex = sbn.getNotification().extras;
        if (ex == null) return;
        CharSequence title = ex.getCharSequence(Notification.EXTRA_TITLE);      // android.title
        CharSequence text  = ex.getCharSequence(Notification.EXTRA_TEXT);       // android.text
        if (text == null) text = ex.getCharSequence(Notification.EXTRA_BIG_TEXT); // android.bigText
        if (title.isEmpty() && text.isEmpty()) return;    // 双空不记（原文档漏）
        String pkg = sbn.getPackageName();
        SenseBridge b = SenseBridge.peek();              // ⚠ 不是 get(this)
        if (b == null) return;                            //   桥未启动就直接丢
        b.addNotification(pkg, appLabel(pkg),
            title == null ? "" : title.toString(),
            text  == null ? "" : text.toString(),
            sbn.getPostTime());
    }

    /** 是否已被用户在系统里勾选（读 enabled_notification_listeners）。 */
    public static boolean isEnabled(Context c) {
        String s = Settings.Secure.getString(c.getContentResolver(), "enabled_notification_listeners");
        return s != null && s.contains(c.getPackageName());
    }
}
```

只读三个 extra（`title` / `text` / `bigText`）——**不解析消息内容、不抓应用数据**。

---

#### §5/§6/§7 校正记录（2026-10-25）

| # | 章节 | 原版 | 实际 |
|---|---|---|---|
| 1 | §5 | `/health` 返回里有 `routes` | **没有**；`routes` 只在 `/help`，且只有 4 条（不含 `/help` 自身） |
| 2 | §5 | health 字段 6 个 | 还有 `frameBytes`、`error`；无帧时 `frameAgeMs = -1`（**已实测** `{"frameAgeMs":-1,"frameBytes":0,"error":""}`） |
| 3 | §5 | `-1` = 无障碍不可用 | **`-1` = 看到 IME 窗口但高度 ≥ 屏高 90%**；「无障碍不可用」是 `0` |
| 4 | §5 | `==0` → 0.38 估算，`-1` → 走三级 insets | **正好对调**：`<0` → `screenH*0.38` 估算；`==0` → `RootWindowInsets` → 触摸层 insets → `getWindowVisibleDisplayFrame` |
| 5 | §6 | 未提注入名 | 注入名是 **`petVoiceNative`**（`PetWindowService:265`），`start/stop/cancel/available` 四个方法带 `@JavascriptInterface` |
| 6 | §6 | `cancel()` 里 `wanted=false` 在 post 外 | 在 **post 的 Runnable 内部** |
| 7 | §6 | `start()` 无异常分支 | 有 `catch → deliver("error","",message)` |
| 8 | §7 | `SenseBridge.get(this)` | **`SenseBridge.peek()`**：桥未启动直接丢弃，不创建实例 |
| 9 | §7 | 只判 `sbn == null` | 还判 `getNotification() == null`，且 **title 与 text 双空直接 return** |

> `errName` 确是 packed-switch 字面量 `1..9`，但数值与 `SpeechRecognizer.ERROR_*` 完全一一对应
> （1=NETWORK_TIMEOUT、2=NETWORK、3=AUDIO、4=SERVER、5=CLIENT、6=SPEECH_TIMEOUT、7=NO_MATCH、
> 8=RECOGNIZER_BUSY、9=INSUFFICIENT_PERMISSIONS），原文按常量名还原**是对的**。
>
> `/notifications` 实测返回 `{"cursor":5,"items":[{"seq":1,"id":"n1","pkg":…,"app":…,"title":…,"text":…}]}`
> —— **没有 `when` 字段**，与 §2 校正第 6 条互证。

## 8. 桌宠另外两种形态

### 8.1 `PetActivity`（全屏 App 形态）

```java
public class PetActivity extends Activity {
    private static final String PET_URL = "http://127.0.0.1:7797/pet?host=app";
    private static final int REQ_FILE = 4001;
    private WebView web;
    private FrameLayout root;
    private ValueCallback<Uri[]> filePathCallback;   // <input type=file> 桥

    @Override protected void onCreate(Bundle b) {
        super.onCreate(b);
        Log.i("PETACT", "===== PetActivity onCreate =====");
        getWindow().setBackgroundDrawable(new ColorDrawable(Color.TRANSPARENT));  // "transparent"
        // 透明全屏 WebView + 右上角「✕ 退出」按钮
        web.loadUrl(PET_URL);   // 日志：loadUrl -> http://127.0.0.1:7797/pet?host=app
    }
    @Override public void onBackPressed() { finish(); }   // 不吞返回键
    @Override protected void onActivityResult(int req, int res, Intent d) { … "onActivityResult ok=" … }
    @Override protected void onDestroy() { web.destroy(); super.onDestroy(); }
}
```

### 8.2 `PetWindow2`（第二只，`7797/pet?pet=2`）

`PetWindow2` 与 `PetWindowService` 的差别：**全静态**、只维护「一只额外宠物」的包围盒。

```java
final class PetWindow2 {
    private static final String TAG = "PetWin2";
    private static final String URL = "http://127.0.0.1:7797/pet?pet=2";
    private static final int    BASE_TOUCH;          // 死字段：<clinit> 无赋值、全库零引用（原文档误写 = 240）
    private static final String SHIM = "…pet2Native 注入脚本…";

    private static volatile boolean started;
    private static volatile int petL, petT, petR, petB;
    private static WebView  web;
    private static View     touch;
    private static WindowManager.LayoutParams webLp, touchLp;
    private static WindowManager wm;
    private static final Handler ui = new Handler(Looper.getMainLooper());
    private static final Runnable tick = …;            // 跟随刷新

    public  static void start(Context c) { … }   // 建 WebView + 触摸层；**全库零调用**
    public  static void stop()  { … }            // 同上，零调用
    private static void sync()  { ui.post(tick); }
    private static void build(Context c) { … }
    private static boolean forward(MotionEvent e) { … }
}
```

页面侧对应 `pet-multi.js`（多宠），桥名探测顺序 `['petRectNative','pet2Native','cooClone']`，
判据是 `typeof n.petRect === 'function'` —— 与原生暴露的 `rect(FFFF)` **名字不匹配**。

> **修订记录 v3**（`docs/03 §12.2` 取证后回改）：`BASE_TOUCH` / `SHIM` 都是死字段；
> 更关键的是 **`PetWindow2` 全库无任何外部类引用、`start()`/`stop()` 零调用**，
> `build()` 从不执行 ⇒ `pet2Native` 从不注册 ⇒ `petL/T/R/B` 恒 `-1` ⇒ `sync()` 的
> `petL >= 0` 永远不成立。**整个类是未接线的实验实现，不要当成活代码读。**
> `sync()` 的真实语义（读 `pet_scale` clamp 0.2–3.0、`size = max(160, round(scale*520))`、
> 按中点重算 `touchLp`、`wm.updateViewLayout`）一次都不会执行；
> `tick` 的 120 ms 周期同理。

### 8.3 `WebRetry`（加载失败重试）

```java
final class WebRetry {
    private static final String TAG = "PetWebRetry";
    private static final Handler UI = new Handler(Looper.getMainLooper());
    private static int  tries;
    private static long lastAt;

    /** 失败后指数退避重载；超过上限放弃。 */
    static void fail(WebView web, long delayMs) {
        tries++;
        Log.w(TAG, "load failed, retry #" + tries + " in " + delayMs + "ms");
        if (tries > MAX) { Log.w(TAG, "give up after " + tries); return; }
        UI.postDelayed(() -> web.reload(), delayMs);
    }
    static void ok() { tries = 0; lastAt = System.currentTimeMillis(); }
}
```

### 8.4 `PetKeyboardGuard`（575 行 smali，键盘高度守卫）

```java
final class PetKeyboardGuard {
    private final Context ctx;
    private View touchLayer;
    private final Handler ui;
    private final View root;

    static void install(Context c, View root, View touchLayer);
    static void setTouchLayer(View v);

    private int  a11yOrInsets();          // 先问 EyesService.imeHeight()，为 0 时直接返回它（不再 clampH）
    private int  imeHeight();             // 五级兜底：a11y 高度 → a11y 估算(screenH*0.38) → root insets
                                          //          → 触控层 insets → visibleDisplayFrame → 0
    private int  clampH(int h);           // h<=0 → 0；否则 min(h, (int)(screenH * 0.75))
    private void evaluate();              // 高度变化才 publish
    private void publish(int h, String src);
    private void reportKeyboard(int h);   // → window.__petKeyboard(h)
    private void reportIme(boolean on, String detail);
    private void onImeFromA11y(int h);
    private void retarget(View root, View touchLayer);
    private static WebView findWeb(View v);   // 递归找 WebView
}
```

---

## 9. 辅助类

| 类 | 作用 |
|---|---|
| `AppLog` | 统一落盘（`/sdcard/Download/coop-diag.txt`，前缀 `[DIAG] `），跨服务共享 |
| `CrashApp` | `Application` 子类：`Thread.setDefaultUncaughtExceptionHandler` 写崩溃栈后交给系统 |
| `RepairActivity` | 手动修复：删除 `rootfs-v8-*` 与 `.ok-*` 后回主界面重新解包 |
| `R` 系列 | 资源索引（`R$id` / `R$layout` / `R$string`…），无逻辑 |

---

## 10. 未逐行还原的部分（如实说明）

| 类 | 行数 | 状态 |
|---|---|---|
| `MainActivity` 的 UI 构建（`onCreate` 内 700+ 行 View 拼接） | — | 只还原了结构（状态栏/日志/WebView/开关），逐控件属性未逐条抄 |
| `PetWindowService.buildAndAttachLayers` | ~180 行 | 还原了两层 LayoutParams 语义，具体 FLAG 组合按常量反推 |

**已从本表移除**（第二轮已逐行还原）：`EyesService.captureOnce` / `PetKeyboardGuard.evaluate`
—— 见 `docs/03 §12.4` 与 `§12.5`。

以上均可在 `src/java2/classes/*.smali` 直接查证（文件按类命名，`# registers=` / `# virtual access=` 注释保留）。
