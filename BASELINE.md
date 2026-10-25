# 基准 · `v12.71-baseline`

> **锚点**：本仓库 tag `v12.71-baseline`（指向本仓库首个提交）。
> **仓库**：<https://github.com/xhjoyb/coopanion-re>（公开）
> **定基于**：2026-10-25（round9，真机冒烟通过之后）。
> **用途**：之后任何改动（smali / TS / 资源 / 文档）都以本基准为回退点。对比方式见 §6。

---

## 1. 目标样本指纹

| 项 | 值 |
|---|---|
| 文件 | `Coopanion-v12.71.apk`（**未纳入本仓库**，见 §3） |
| 字节 | `137,205,527` |
| MD5 | `ed319932e645eec9e080d86e409e00b1` |
| 包名 | `com.palai.prootsmoke` |
| versionName / versionCode | `12.71` / `1271` |
| minSdk / targetSdk / compileSdk | `24` / `35` / `35` |
| 加固 | **无**（无桩 `Application`、无壳 so、无壳 assets、无 DEX 加密/方法抽取、无 VMP、无自校验） |
| 架构 | `arm64-v8a`；`assets/payload.asset` = gzip+tar 344.11 MiB 的 aarch64 rootfs |

形态：**「自带 Linux 运行时的薄壳」**——Java 侧 124 类只管窗口/无障碍/通知/语音/WebView，业务本体是 rootfs 里 `bin/node` 跑的原样 TypeScript。

---

## 2. 本仓库纳入了什么

合计 **1,101 文件 / 19,431,450 B（18.52 MiB）**。

> 口径：`git ls-files -z | xargs -0 stat -c %s | awk '{s+=$1;n++} END{print n, s}'`（见 §5）。
> 旧版本此处写「1,072 文件 / 19,742,777 B」，与任何一次提交都对不上，已按实测重算，勘误说明见 §7。

| 路径 | 文件数 | 说明 |
|---|---|---|
| `docs/` | 5 | 00 导读 302 行 · 01 架构 216 · 02 Java 856 · 03 桥接协议 1182 · 04 工具链 754 = **3,403 行** |
| `README.md` | 1 | 入口 |
| `BASELINE.md` | 1 | 本文件 |
| `DEPS.md` | 1 | 依赖/产物取舍政策（能 `rm` 掉再用一条命令复原的一律不入库） |
| `.gitignore` | 1 | 排除 `node_modules`、`dist`、`apk/` 等 |
| `log/` | 6 | `ziplist.txt`、`rootfs_list.txt`(568 KB)、`doc-round7/8.txt`、`dex2smali-v2-to-v3.diff`、`pip.log` |
| `src/recovered/` | **853** | 原厂 TypeScript 源码树（**259 个 `.ts`**，未混淆、未编译、中文注释完整），含 `package.json`/`tsconfig.json`。基准时 863，减去被排除的 10 个 `dist` 产物 |
| `src/java2/` | 132 | smali 精确视图：合并 2 份 + `classes/` **124 个一类一文件** = **544 个 `.method`** |
| `src/java2_v2/` | 2 | 旧工具链基线（v2，对照用） |
| `src/java/` | 3 | 早期反编译尝试产物 |
| `src/js/` | 12 | Java 内嵌注入脚本 12 段（4,776 B） |
| `src/x/` | 20 | APK 解包产物：`AndroidManifest.xml`、`classes.dex`(98,744 B)、`classes2.dex`(37,212 B)、`resources.arsc`(2,440 B)、`lib/arm64-v8a/*.so` ×5、`assets/probe/*.js` ×3、`META-INF/` ×5、`axml.py`、两份 `.classes.txt` |
| **`src/android/`** | **15** | **P1 资源树**（§7）：`AndroidManifest.xml` 101 行 + `AndroidManifest.decoded.txt` 62 行留档 + 10 张 `mipmap-*` PNG + `values/strings.xml`、`values/themes.xml`、`xml/eyes_service.xml` = 298,642 B |
| `src/`（根下散落） | 28 | 20 个 `.py` 逆向脚本（功能 9 + 工具链补丁 3 + 文档回改 8）+ 8 个中间文本（`du.txt`、`static_values.txt/.err`、`log_strings1/2.txt`、`log_manifest.txt`、`js_pethost_strings1_53.js`、`js_pethost_strings2_29.js`） |
| `tools/` | **5** | `push_repo.py`（Git Data API 推送器，本机 `git` CLI 挂死时的唯一通道）+ `parse_arsc.py`（259 行，dense/sparse/offset16 三布局 arsc 解析）+ `check_res.py`（131 行，清单↔arsc↔磁盘三方对齐自检）+ **`recon_upstream.py`**（157 行，入仓源码 ↔ 部署态逐文件 sha256 对账）+ **`check_deps.py`**（210 行，依赖树「包清单 / 版本 / 体积」三层等价性校验） |

---

## 3. 未纳入仓库的产物（及重现方式）

| 产物 | 大小 | 不纳入原因 | 重现方式 |
|---|---|---|---|
| `apk/Coopanion-v12.71.apk` | 137 MB | 超 GitHub 单文件 100 MB 硬上限；且为原厂发行物 | 自行取得原包，`md5sum` 核对 `ed319932…e00b1` |
| `mcp_out/Coopanion-v12.71-mcp.apk` | 137 MB | 同上 | 见 `docs/04 §2`：MT MCP 改 `versionName` → 重签 |
| `src/rootfs/` | 1,910 文件 / 137,479,592 B | 体积 | `unzip -p apk/Coopanion-v12.71.apk assets/payload.asset \| tar -xz -C src/rootfs` |
| `src/rootfs/…/node_modules/` | 119.2 MB / 95 个顶层条目 | 可下载依赖，非逆向产物 | 两步 npm + 4 条 `ln -s`（`DEPS.md §3.2`；`package-lock.json` 已在仓库，37,020 B） |
| `src/recovered/cortico/dist/web/` | 8 文件 / 917,106 B | 构建产物（esbuild bundle） | `pnpm --filter cortico build:web` |
| `src/recovered/vendor/pet/dist/` | 2 文件 / 11,766 B | 构建产物（压缩 console） | `npm --prefix vendor/pet run build` |

> 依赖与产物的取舍规则集中在 **`DEPS.md`**：**能 `rm` 掉、再用一条命令复原的，一律不入库**。
>
> 因此 **本仓库是「可读 + 可复现文档 + 可复现工具」的完整集合，但不是「可一键编译」的工程**。

---

## 4. 基准时刻的实证状态

| 项 | 结果 |
|---|---|
| 重签包真机安装 | ✅ Android 16 / SDK 36，`versionName=12.71-mcp`、`versionCode=1271`、`arm64-v8a`、签名 v3 `d7f1f224` |
| 启动冒烟 | ✅ `pid` 存活 25 s+、前台 `MainActivity`、`logcat -b crash` 为空 |
| 业务链路 | ✅ `web面板已启动 :17788` → `core已启动` → `World: terminal / desktop-pet` → `桌宠悬浮窗已启动 -> http://127.0.0.1:7797/pet` |

已知的「没做」：

1. **Java 侧没有 `.java`、没有 Gradle 工程** —— 只有 smali（`src/java2/`）+ `docs/02` 的可读重建；
2. ~~**`res/` 未还原成工程树**~~ → **P1 已还原**：`src/android/`，15 文件 / 298,642 B，`tools/check_res.py` 三方对齐 `ok: true`。全包仅 11 个资源条目、`resources.arsc` 2,440 B、15 个符号——小到可以逐条人工核对，这也是 P1 能一次做净的前提。详见 §7；
3. **`node_modules` 未独立抽出**（真跑起来不需要，用 `src/rootfs/` 那份运行时即可）。

---

## 5. 校验本基准（约 30 秒）

```bash
# 1) smali 视图与 dex 完全一致（自研反汇编器可复现）
python3 src/dex2smali.py src/x/classes.dex | diff -q - src/java2/classes.dex.smali && echo identical
# → identical

# 2) 原厂 TS 源码规模
find src/recovered -name '*.ts' | wc -l        # → 259
git ls-files src/recovered | wc -l             # → 853（入仓数；磁盘 863，多出的 10 个是 .gitignore 排除的 dist 产物）

# 3) Java 规模
ls src/java2/classes | wc -l                   # → 124
grep -h '^\.method' src/java2/classes/*.smali | wc -l   # → 544

# 4) 文档规模
wc -l docs/*.md README.md | tail -1            # → 3403 total

# 5) P1 资源树三方对齐（清单 ↔ arsc ↔ 磁盘）
python3 tools/check_res.py                     # → ✅ 资源树与 arsc 完全对齐（exit 0）
python3 tools/check_res.py --json | python3 -c 'import json,sys; d=json.load(sys.stdin); print(d["ok"], d["arsc_files"], d["refs"])'
# → True 11 9

# 6) 仓库规模（§2 数字的口径）
git ls-files -z | xargs -0 stat -c %s | awk '{s+=$1;n++} END{printf "%d files, %d bytes\n", n, s}'
# → 1101 files, 19431450 bytes

# 7) 上游对账（入仓源码 ↔ APK 部署态，逐文件 sha256）
python3 tools/recon_upstream.py                  # → 862/862 相同，exit 0

# 8) 依赖树等价性（需先按 DEPS.md §3.2 复原出一份 node_modules）
python3 tools/check_deps.py <复原的 node_modules>  # → ✅ 0 差异，exit 0
```

---

## 6. 与基准对比

```bash
git fetch --tags
git diff v12.71-baseline --stat      # 相对基准的全部改动
git log v12.71-baseline..HEAD        # 基准之后的提交
```

**回退**：`git checkout v12.71-baseline` 即回到本基准的完整文件状态（不含 §3 三个大产物）。

---

## 7. 增量记录（基准之后）

### P1 · 资源层还原 → `src/android/`

目标：把 `res/` 从「APK 里的二进制」变成「可直接进 Android 工程的源树」，且与清单/arsc 三方自洽。

| 产物 | 说明 |
|---|---|
| `AndroidManifest.xml` | 101 行，可直接编译。两处等价化：① 资源引用 `0x7f……` → `@mipmap/@style/@string/@xml`；② 枚举位标志 `0x……` → 符号名 —— `0x5a0` → `keyboardHidden\|orientation\|screenLayout\|screenSize`、`0x7a0` 再加 `uiMode`、`0x2` → `launchMode="singleTask"`、`0x40000000` → `foregroundServiceType="specialUse"` |
| `AndroidManifest.decoded.txt` | 62 行。`src/axml.py` 对 `src/x/AndroidManifest.xml` 的原始反编译留档（保留原始资源 ID），与上面那份互为对照 |
| `res/mipmap-{mdpi,hdpi,xhdpi,xxhdpi,xxxhdpi}/ic_launcher{,_round}.png` | 10 张，**与 APK 内字节完全一致**（未重压，`sha256sum` 可复核）；合计 288,259 B，mdpi 5,289/6,283 → xxxhdpi 64,580/68,924 |
| `res/values/strings.xml` | 2 条中文逐字保留：`app_name`「Coopanion 自己的桌宠，让它在刷视频、看东西的时候能看见并吐槽。只在手机本地使用，不往外传。」、`eyes_service_description`「让桌宠看得见屏幕」 |
| `res/values/themes.xml` | `AppTheme` / `PetTheme`，parent 均为 `@android:style/Theme.DeviceDefault.Light.NoActionBar`（= framework `0x0103012c`，已反查确认，非先前猜测的 `Theme.Material` 系）。`windowNoTitle` / `windowActionBar` / `windowFullscreen` 三项由 framework attr 反查得名（`0x01010056` / `0x010102cd` / `0x0101020d`），值 `0xffffffff` / `0x0` → `true` / `false` |
| `res/xml/eyes_service.xml` | 无障碍服务配置：`accessibilityEventTypes` = `0x400020` → `typeWindowStateChanged\|typeWindowsChanged`、`feedbackGeneric` = `0x10`、`notificationTimeout=500`、`accessibilityFlags` = `0x41` → `flagDefault\|flagRetrieveInteractiveWindows`、`canRetrieveWindowContent` / `canTakeScreenshot` = `true` |

支撑工具（同时是本轮踩坑的产物）：

- **`tools/parse_arsc.py` 新增 `entry_offsets()`**，支持 **dense / sparse（`FLAG_SPARSE`）/ offset16（`FLAG_OFFSET16`）** 三种 `ResTable_type` 布局。framework 的 `resources.arsc`（7,690,504 B）用的正是 sparse —— 旧实现按 dense 读 `u32` 偏移，直接 `IndexError` 崩在这里。这是 P2/P3 复用资源解析的基础设施。
- **`tools/check_res.py`** 做三方对齐自检：清单与 XML 里的 `@type/name` 引用 ↔ arsc 符号表 ↔ `res/` 磁盘实况，任一方向多/少都报错。当前实测：

```
$ python3 tools/check_res.py
arsc：15 条配置 × 条目 / 7 个符号 / 11 个文件型条目
源树：4 个 XML / 9 处 @type/name 引用

✅ 资源树与 arsc 完全对齐
```

- 结构备忘：framework arsc 顶层 = 1 个字符串池（70,497 条）+ **7 个 `0x0200` package 块**（首个承载全部 23 个 type 名与 14,433 个 key 名，其余 6 个 `tso` 恒为 288、type 名读出来是 `?N` 占位），这是 aapt2 的 split 产物、属正常结构，不是错位。

### P0 · 依赖可复原性（运行时已闭合，构建期转 P4）

**原计划的判断被推翻**：上一轮定的任务是「补 `cortico` / `vendor/{coo,cua,pet}` 四个 lock」，实测为**伪需求** —— 三组 sha256 指纹证明四个子包的 `node_modules` 只是 stage 根的同源复制（`jpeg-js` 三处同为 `0c3f17f5…`、`ws` 两处同为 `21ae3727…`），而 `vendor/coo` 根本没有 dependencies。证据链写在 `DEPS.md §3.1`。

**验收标准随之重定义**（从「补齐 4 个 lock 文件」改成两条可断言命题）：

| 命题 | 方法 | 结果 |
|---|---|---|
| 入仓源码 = APK 部署态 | `tools/recon_upstream.py`：五组路径映射 + 逐文件 sha256 | **862/862 相同**，1.6 s，`EXIT=0` |
| 运行时依赖可一条命令复原 | 两步 npm + 4 条 `ln -s` + 2 个显式补丁（配方见 `DEPS.md §3.2`） | 95 个顶层条目，与部署态 **0 差异、0 备注**（`tools/check_deps.py`） |

可复核的关键事实：

- `package-lock.json` 入仓版与部署态那份 **sha256 同为 `ab11e9882cdeb2252a572103879a4390df13e6db660ba9472a05d8e7feff7600`**；lock 内 84 包 ⊂ 磁盘 95 条目（**缺 9、多 0**），即 lock 是部署态的严格子集。
- 那 9 个「lock 外」条目 = **4 个本地包软链**（`cortico`→`../build/cortico`、`cortico-provider-coo`→`../vendor/coo`、`cortico-world-cua`→`../vendor/cua`、`cortico-world-desktop-pet`→`../vendor/pet`）+ **5 个真实三方包**（`esbuild@0.28.2`、`koffi@3.3.1`、`sherpa-onnx-node@1.13.8`、`sherpa-onnx-linux-arm64@1.13.8`、`tsx@4.23.15`，合 93.2 MB）。
- **`tsx` 是运行时依赖而非构建工具**：`boot.sh` 末行 `exec /bin/node --import tsx run-core.mjs`，`run-core.mjs` 又直接 `await import('app/core/boot.ts')`，加载 `.ts` 全靠它的 loader。
- `esbuild/bin/esbuild` 在部署态是**真二进制**（10,289,264 B），与 `@esbuild/linux-arm64/bin/esbuild`、`esbuild/bin/esbuild` 三处 sha256 同为 `90bd2695…25fc2`，即 postinstall 从平台包拷来的；`--ignore-scripts` 会跳过，需 `node node_modules/esbuild/install.js` 补回。
- **子包的构建期依赖才是真缺口**：`cortico` 缺 20 个、`pet` 缺 5、`cua` 缺 3（`DEPS.md §3.3`）。`vendor/pet/dist` 的 dependencies 齐备，`cortico/dist/web` 则**重建不出来** —— 这是 P4 的前置阻塞，与「payload 指纹能否对上」直接相关。

新增工具：

| 工具 | 行数 | 作用 |
|---|---|---|
| `tools/recon_upstream.py` | 157 | 入仓 `src/recovered/` ↔ 部署态 `src/rootfs/app/coop-stage/` 逐文件 sha256 对账（五组映射、`diff`/`only_rootfs` 判失败、`only_recovered` 放行） |
| `tools/check_deps.py` | 210 | 依赖树等价性校验：包清单 / 版本 / 逐包体积三层，内建 `.l2s.*`、4 条本地软链、`esbuild`、`sherpa` 嵌套四类「已知合理差异」白名单 |

环境备忘录（proot，P4/P5 都会再遇到）：

- `--link2symlink` 把硬链接模拟成 `.l2s.<name>` 真文件 + 同名软链；**删悬空链必须用 `unlink`**（`rm` 报 `Operation not permitted`）。proot 里装出的 `node_modules` 只可用于等价性验证，**不能当交付物**。
- `sherpa-onnx.node` 需要 glibc 加载器 `ld-linux-aarch64.so.1`，而本机 proot 是 Alpine/musl（`ldd` 显示 musl 装载 + 大量 `Error relocating`）→ **native 加载验证只能在 P5 的真 payload 运行时里做**。`boot.sh` 里 `librt.so.1 → libc.so.6` 的自愈软链，正是为 glibc ≥ 2.34 环境准备的。

### P2 · Java 层复原（jadx 基线 + 启动链校正）

**产出**：124 个类 → `src/java/com/palai/prootsmoke/*.java`（14 个文件 / 246,289 B，匿名类被 jadx 内联进外层类）。
生成方式是 **CI**（`.github/workflows/decompile.yml`，`jadx --no-res`，产物推 `jadx-out` 分支再取回），
不是我手抄——`src/x/classes*.dex` 在仓库里，产物可重复生成，来源记在 `src/java/PROVENANCE.md`。

**为什么必须上 CI**：jadx 要 JVM，本机 proot 没有 JDK（`which javac java` 皆空）。这是本项目第一次用
GitHub Actions，工作流 20 秒跑完，`gh` token 的 `workflow` scope 足够，`api.github.com` 可达。

#### 校正：旧 `docs/02` 的启动链写错了 8 处

`docs/02-Java层源码还原.md` 是早期人工重建版，声称「逐字来自字节码」。用 jadx 基线逐句核对后，
`§1.3 boot()/doBoot()` 与 `§1.4`（原记为独立方法 `runCore`）共 8 处与字节码不符，已全部改正：

| # | 原版 | 实际 |
|---|---|---|
| 1 | `boot()` 里 `new Thread(this::doBoot)` | **同步调用**，`try/finally` 复位 `booting`，线程由调用方给 |
| 2 | payload 长度取失败就 `return` | 三级兜底 `openFd → 流式计数 → -1`，**从不 return** |
| 3 | `.ok` 标记在 `getFilesDir()` 下 | 在 **rootfs 目录内部**：`new File(dir, ".ok-v8-…")` |
| 4 | 清旧目录在解包之后 | 在**解包判定之前**，用 `!n.equals(name)` 比对 |
| 5 | CHK 通过才写标记 | **无条件** `createNewFile()` |
| 6 | `TMPDIR = getCacheDir()` | `TMPDIR = getFilesDir()/ptmp`，且先 `chmod 777` |
| 7 | `libproot.so` 取自 rootfs | 取自 `applicationInfo.nativeLibraryDir`，并 `-b <libDir>:/hostlib` |
| 8 | 有独立 `runCore()` 方法 | **没有**，全部内联在 `doBoot()`；重启判定在 `waitFor()` 之后 |

#### P2 期间发现的原厂隐患（候选修正点，未改）

第 5 条：`ok.createNewFile()` **无条件执行**。也就是解包后即使 5 个关键文件长度不符（`[CHK] x/5 OK`），
`.ok` 标记照样写下 → 下次启动直接跳过解包 → 语音组件永久坏掉且**不会自愈**。
合理修法是把 `createNewFile()` 挪进 `if (bad == 0)` 分支。改不改留给 P5 决定：改了属于行为变更，
需要真机跑一次「故意删掉 sherpa native → 重启 → 观察是否自动重解包」的对照实验。

#### 尚未逐条对照的部分

`docs/02` 其余章节（`§2 SenseBridge` / `§3 PetWindowService` / `§5 EyesService` / `§6 VoiceBridge` /
`§7 NotifListenerService` / `§8 PetActivity / PetWindow2 / WebRetry / PetKeyboardGuard`）仍是早期人工重建，
尚未用 `src/java/` 逐条核对，按批次推进。


#### 第二批：桥接与桌宠（`§2` / `§3` / `§4`）

**`§2 SenseBridge`（`:17899` 设备感知 HTTP 服务）校正 10 处**，主要错在把「方法级同步」写成双检锁、
把一个死参数写成 JSON 字段、把非 daemon 线程写成 daemon、虚构了一个 `Handler ui` 字段：

| # | 旧文档 | 实际 |
|---|---|---|
| 1 | `MAX_NOTIFS` | `NOTIF_CAP`（值同 64）+ `public static final int PORT = 17899` |
| 2 | `get()` 双检锁 | `static synchronized` 单检，`instance` volatile |
| 3 | 有 `Handler ui` | **没有**；真实字段 `running / server / thread` |
| 4 | `start()` 无守卫 | `if (running) return` + 存 `thread` |
| 5 | 连接线程 daemon | **非 daemon**，只有 loop 线程 daemon |
| 6 | JSON 有 `when` | **没有**，第 5 个 `long` 参数全类未使用（死参数） |
| 7 | 独立 `since()` | 内联在连接 lambda |
| 8 | `stop()` 未写 | 置标志 + close server，不 join |
| 9 | level 无兜底 | 取不到时 `level = -1` |
| 10 | 块同步 | `public synchronized` 方法 |

**`§3 PetWindowService` 逐项吻合，零偏差**（`docs/03` 那轮取证是准的）：`CHANNEL="coopanion_pet"`、
`TOUCH_SIZE=700` 死常量、`showLp=(-1,-1,type,66328,-3)`、`touchLp=(520,520,type,808,-3)`、
`PREF/KEY_ALPHA=coopanion/pet_alpha`、`imeProxy` 1×1 且 `imeOptions=0x2000006`、`followTick` 80 ms 自续期、
`warmUpRenderer` 1×1 隐藏 WebView（`type 2038/2002`、`flags 24`）预热后 `removeView`。

**`§4 PetHostBridge` 1 处校正 + 2 条补充**：

1. 旧文档称「无 `@JavascriptInterface` 注解」→ **注解在**，dex 里 9 个方法全带（smali 里直接可见 `.annotation runtime Landroid/webkit/JavascriptInterface;`）。
2. `focus` / `grabFocus` / `releaseFocus` 是**彻底空方法**，`setInteractive` 只 `Log.i` —— 即 **Service 版的「交互开关」是名义接口**，页面调 `petHostNative.setInteractive(false)` 在 Java 侧无任何效果。
3. 触摸层尺寸不由页面推，而是 `queryPetRect()` **主动问页面**（`evaluateJavascript`）→ `sizeTouchTo(x,y,w,h)` → `updateViewLayout`；Service 版**没有** `reportPetRect`（那是 `PetActivity` 的桥接才有）。



#### 第三批：眼睛 / 语音 / 通知（`§5` / `§6` / `§7`）

`§5 EyesService` 的常量与路由表**全对**（`PORT 17898`、`CAPTURE_ATTEMPTS 3`、`CAPTURE_WAIT_MS 9000`、
`FRAME_CACHE_MS 700`、`MAX_STALE_MS 2500`、`MIN_CAPTURE_GAP_MS 1200`；`/health` `/screen.jpg` `/ui`
`/open_settings` `/help` 五路由；四条错误串）——上一轮 `read_static.py` 的取证是准的。但语义层有 4 处错：

| # | 原版 | 实际 |
|---|---|---|
| 1 | `/health` 里有 `routes` | **没有**，`routes` 只在 `/help`（4 条，不含 `/help` 自身） |
| 2 | health 字段 6 个 | 还有 `frameBytes` / `error`；无帧时 `frameAgeMs = -1` |
| 3 | `-1` = 无障碍不可用 | **`-1` = 检测到 IME 窗口但高度 ≥ 屏高 90%**；「无障碍不可用」是 `0` |
| 4 | `==0` → 0.38 估算、`-1` → 三级 insets | **对调**：`<0` → `screenH*0.38`；`==0` → `RootWindowInsets` → 触摸 insets → `getWindowVisibleDisplayFrame` |

`§6 VoiceBridge` 3 处：①注入名是 **`petVoiceNative`**（`PetWindowService:265`），四个方法带 `@JavascriptInterface`；
②`cancel()` 的 `wanted=false` 在 post **内部**；③`start()` 有 `catch → deliver("error", …)`。
`errName` 的 `1..9` 字面量与 `SpeechRecognizer.ERROR_*` 一一对应，原文按常量名还原**正确**。

`§7 NotifListenerService` 2 处：①用 **`SenseBridge.peek()`** 不是 `get(this)`（桥未启动就丢弃，不创建实例）；
②还判 `getNotification() == null`，且 **title 与 text 双空直接 return**。

**本轮首次打通「实机功能级验证」**（前两批只能看日志）：root 把无障碍与通知监听打开后，
`curl 127.0.0.1:17898/help` 返回 `"service":"coopanion-eyes-p2"`（我们改的字面量），
`/health` 返回 `{"sdk":36,"canScreenshot":true,"frameAgeMs":-1,"frameBytes":0,"error":""}`（实证第 2 条校正）；
`curl 127.0.0.1:17899/notifications?since=0` 抓到 5 条真实通知
（`{"cursor":5,"items":[{"seq":1,"id":"n1","pkg":"com.luna.music","app":"汽水音乐",…}]}`）——
**JSON 里没有 `when`**，反过来实证了 §2 校正第 6 条。



#### 第四批：另外两种形态 + 辅助类（`§8` / `§9`），P2 收口

`§8.1 PetActivity` 偏差最多（6 处）：`REQ_FILE` 是 **20819** 不是 4001；**透明与否由
`intent.getBooleanExtra("transparent")` 决定**；`petHostNative` 与 `petHost` **各注册一个不同实例**；
有 `WebChromeClient`（只放行 `AUDIO_CAPTURE`、`onShowFileChooser` 走 `GET_CONTENT`+`image/*`）；
`onPageFinished` 有探针；还会**申请 `RECORD_AUDIO`**（requestCode 10088）。
`§8.2` 的 v3 修订把 `BASE_TOUCH` / `SHIM` 记成死字段是错的（`BASE_TOUCH = 520` 当触摸层边长、`SHIM` 在
`onPageFinished` 执行），但「整个类未接线」的结论仍成立。
`§8.3 WebRetry` **没有指数退避**：延迟由调用方给、下限 300 ms、上限 **40**、30 s 内未再失败就清零，
`ok()` 只清 `tries`。
`§8.4 PetKeyboardGuard` **每 150 ms 都 publish**（只有 `Log.i` 按高度变化节流），
`__petKeyboard(h, seq)` 是**两个参数**，另有死常量 `IME_RATIO = 0.12f`。
`§9` 三处：`AppLog` 落 **`<externalFilesDir>/coop-run.log`**（`coop-diag.txt` 是 `PetWindowService.diag()` 的另一份）；
`CrashApp` 写栈后串接原 handler；`RepairActivity` 是**网页修复页**（`:7797/repair`），不是「删 rootfs 重解包」。

**实测证据（比上一批更硬，两条都落在持久文件/独立 tag 上）**：

```
# ① PetActivity 真的能起，页面真的加载出来
[18:59:48.989] I/PetWindow: [PETACT][P5] ===== PetActivity onCreate =====
[18:59:49.062] I/PetWindow: [PETACT] onPageFinished: http://127.0.0.1:7797/pet?host=app
[18:59:49.065] I/PetWindow: [PETACT] probe -> "petEl=yes raf=function vp=360x792"

# ② PetKeyboardGuard 在桌宠窗口建立时被安装，随后立刻走 evaluate 的首次上报
I PetKb|P5: installed screenH=2378 a11y=false
I PetKb   : touch layer attached=true
I PetKb   : init a11y=off 需要开启无障碍

# ③ RepairActivity 打开的是网页修复页（不是本地删文件）
[19:00:35.724] I/PetWindow: [REPAIRACT] ===== RepairActivity onCreate =====
[19:00:35.733] I/PetWindow: [REPAIRACT] loadUrl -> http://127.0.0.1:7797/repair
```

顺带印证 `§9` 的 `AppLog` 路径：这些行**只在 `coop-run.log` 里有、logcat 里已被 `DIAG` 洪流冲掉**，
正说明 `AppLog` 是独立落盘、且与 `coop-diag.txt` 两份文件分工不同。


### 出包验收台账（每个逆向单元必出一个可安装包）

**规则（用户 2026-10-25 定）**：每完成一个逆向单元 → 构建 APK → 装机 → 用户实测。本地无 JDK / Android SDK，出包一律走 **MT MCP 重打包**（axml / smali 级编辑 + 内置签名）。MT 的 Home 是 `/storage/emulated/0/MT2/mcp`，其余路径被策略拒绝；`outputName` 必须给**绝对路径**（带子目录的相对路径会报 `INVALID_ARGUMENT: outputName`）。

> **纯分析型单元不出包**：P1（资源层）与 P3（payload 预编译清单）在 APK 侧零改动，出包只会得到「仅 `versionName` 不同」、其余逐字节等价的包，没有可验证对象；出包周期留给有实改动的 P4。P0 的包是为单独验证重打包链路本身而出的。

| # | 版本名 | 改动 | 字节 | 签名证书 sha256 | 验收结论 |
|---|---|---|---|---|---|
| 1 | `12.71-p0` | **仅** `versionName` 标记（P0 无代码改动，本轮验证的是重打包链路本身） | 137,258,773 | `a40da80a…bf5dc` | 就地升级成功；冷启动 24 s+ 无崩溃、crash 缓冲空；`libproot.so` + `node` 均拉起；`coop-run.log` 到 `core已启动`、Web 面板 `127.0.0.1:17788` 与桌宠悬浮窗就绪 |
| 2 | `12.71-p2` | `doBoot()` 里 `[2] 启动 Coopanion Core ...` → 加 `[P2]` 标记（验证 Java 层可定位、可改写、可观测） | 137,258,773 | 同上 | 就地升级成功；冷启动 30 s、`pid` 稳定、`libproot.so` + `node` 起；`coop-run.log:279` 实测出现 `[2][P2] 启动 Coopanion Core ...`，控制台与桌宠均正常 |
| 3 | `12.71-p3` | `PetWindowService.diag()` 的 `[DIAG] ` → `[DIAG][P2] `（本批核心类可定位、可改、可观测） | 137,258,773 | 同上 | 就地升级；冷启动 32 s、`pid` 稳定、`libproot.so`+`node` 活；**`logcat` 32 秒内命中 20 条 `[DIAG][P2] probe box=…`**；crash 缓冲空 |
| 4 | `12.71-p4` | `EyesService.helpJson()` 的 `coopanion-eyes` → `coopanion-eyes-p2` | 137,258,773 | 同上 | `curl :17898/help` 返回 `coopanion-eyes-p2`；`/health` 实测 `frameAgeMs:-1/frameBytes:0/error:""`；`curl :17899/notifications` 抓到 5 条真实通知且**无 `when` 字段**；crash 缓冲 0 |
| 5 | `12.71-p5` | `PetActivity.onCreate` 日志加 `[P5]`；`PetKeyboardGuard.install` 的 tag `PetKb` → `PetKb|P5` | 137,258,773 | 同上 | `coop-run.log` 见 `[PETACT][P5]` + `probe -> petEl=yes … vp=360x792`；logcat 见 `PetKb|P5: installed screenH=2378`；`RepairActivity` 实开 `:7797/repair`；crash 0 |

产物：`/storage/emulated/0/MT2/mcp/Coopanion_v12.71/Coopanion-v12.71-p0-signed.apk`，sha256 `842cd2b76e60f60518e2c4775aa6f55e50dc050d940abd25553d7645c18e4c1a`（不入库，MT2/mcp 与 apk/ 均在 `.gitignore` 内）。
`12.71-p2` 同目录 `Coopanion-v12.71-p2-signed.apk`，sha256 `1fe2dc52982dc27765e0dc75c23c6d4f65c44d31b79ced6a6f0ed3b89827218e`（两份包体字节数相同，靠 sha256 与 `versionName` 区分）。
`12.71-p3` 同目录 `Coopanion-v12.71-p3-signed.apk`，sha256 `9f685e18fa52e630789f67d438ea5a5a1e5f5bedecfad8eb5aef2547e2bce530`。
`12.71-p4` 同目录 `Coopanion-v12.71-p4-signed.apk`，sha256 `b6c9d5d3034968d507b8ec1f7cb27c0c97916ad72c1a803a4034a3b338cfa650`。
`12.71-p5` 同目录 `Coopanion-v12.71-p5-signed.apk`，sha256 `43435c6d17de7de4bf2d6500595f1d688d5a628e707d8c011adf44074a1d0d3b`。

首次出包踩到的四个坑，后续每个单元都会复用：

1. **签名换了**：原包证书 `2793fcff…b0764`，MT 签名证书 `a40da80a…bf5dc`。设备上此前的 `12.71-mcp` 与本包同为 MT 证书，所以 `pm install -r` 是**就地升级、数据保留**；若要装回官方原包，必须先卸载。
2. **`pm` 不能直连**：shell 是普通应用 uid（`u0_a409`），`pm list packages` 报 `Failed transaction (2147483646)`，一切包管理命令必须 `su -c`；安装前先 `cp` 到 `/data/local/tmp/` 再 `pm install`（SELinux 限制）。
3. **`am start` 的重定向要放进 `su` 内部**：`su -c "am start … >/dev/null 2>&1 &"` 可行；写成 `(su -c … &)` 外层重定向会因 uid 无权限直接失败。`am force-stop` 要**单独一次**执行并确认 `pidof` 为空，否则新旧进程混在一起，冒烟结论失真（本轮就撞到过一次）。
4. **覆盖安装会重置无障碍授权**：日志出现 `眼睛用不了：眼睛服务没在跑（无障碍可能没打开）`，属预期 —— 每次出包后需手动重开「Coopanion 眼睛」。

### 数字勘误

旧版 §2 写的「1,072 文件 / 19,742,777 B（18.83 MiB）」与任何一次提交都对不上。以 `git ls-tree -r -l` 实测：

| 时点 | 文件数 | 字节 |
|---|---|---|
| tag `v12.71-baseline` | 1,075 | 19,760,010 |
| 移除 10 个构建产物（`cortico/dist/web` 8 + `vendor/pet/dist` 2，928,872 B）+ 新增 `DEPS.md` | 1,066 | 18,839,530 |
| **+ P1（17 个文件：`src/android/` 15 + `tools/*.py` 2）** | **1,083** | **19,159,224** |
| **+ P0（2 个工具：`tools/recon_upstream.py`、`tools/check_deps.py`）** | **1,085** | **19,186,454** |
| **+ P2（jadx 基线 14 文件 + `decompile.yml` + `src/java/PROVENANCE.md`）** | **1,101** | **19,410,855** |
| **+ P2 第二批（`docs/02` §2 校正 10 处 + §3/§4 核对 + 台账新增 1 行）** | **1,101** | **19,417,222** |
| **+ P2 第三批（`docs/02` §5/§6/§7 校正 9 处 + 台账新增 1 行）** | **1,101** | **19,431,450** |
| **+ P2 第四批（`docs/02` §8/§9 校正 14 处 + 台账新增 1 行）** | **1,101** | **19,431,450** |

同时修正两处子项计数：`src/recovered/` 口径区分（**863 = 全树含 10 个 `dist` / 853 = 纯源码**，两数都对；本文件用 **863**）、`src/x/` 21 → **20**（实为 `lib` 5 + `META-INF` 5 + `assets/probe` 3 + dex 与清单与 arsc 与 `axml.py` 与 2 份 `.classes.txt`）。

### P3 · payload 预编译清单（已完成）

见 `docs/05-预编译清单与裁包评估.md`（新增，267 行）。四源交叉（自写块级 tar 扫描 + `tarfile` 二次扫 + gzip trailer 直读 + zip 条目元数据）全部一致；`mcp_out/` 下产出 `p3.tsv`（5,096 行 / 344,664 B）、`p3_tarlist.txt`（568,338 B）、`p3_report.txt`（216 行），按仓库纪律不入库。

**先更正上一轮的误判**：上一轮曾怀疑 `360,825,344 B / 344.11 MiB` 差 22,528 B，块级解析已证伪——差额来自 **22 个 GNU `LongLink`（typeflag `L`）扩展头**，每个占「512 头 + 512 名」= 1,024 B，复算 `360,802,816（条目累计）+ 22×1,024（= 22,528）+ 1,024（EOF 双零块）= 360,825,344`，与 gzip `ISIZE` 逐字节相等。`README.md:14`、`BASELINE.md:21`、`docs/00`（14 / 83 / 142）、`docs/04`（275 / 748）六处写的 `344.11 MiB` 与 `38.00%` **全部正确，不需要订正**；`38.00%` 的口径是 `137,118,068 / 360,825,344`（payload 字节 ÷ tar 长度），不是「压缩后 ÷ 解压后」。

容器事实：gzip 头 `1f8b 08 00 00000000 00 ff`（`FLG=0` 无 FNAME/FCOMMENT/FHCRC、`MTIME=0`、`XFL=0`、`OS=255`）、`compress_size=136,348,624`、`crc32=0xbb9152eb`、`post_gzip_eof_bytes=0`（单成员）；tar 为 POSIX ustar（`magic "ustar  \0"`），5,096 条目（4,053 文件 / 957 目录 / 86 软链 / 0 硬链），只有 `L` 头、无 `K`、无 pax `x`/`g`，结尾正好 2 个零块（`zero_start_pos=360,824,320`、`tail_nonzero=0`、无 anomaly）。

体积分布：`app 137,479,592 / 2,322 条`、`bin 124,939,524 / 56`、`lib 94,650,199 / 2,692`、`etc 123 / 5`，文件字节和 357,069,438。**`node_modules` 有六个根**，不是一个：`app/coop-stage` 121,128,639 B / 99 包、`lib` 54,622,799 B / 3 包（`pnpm` + `npm` + `corepack`）、`build/cortico` 与 `vendor/{cua,coo,pet}` 四个根全为 0 B 软链（合计 22 条接线，Node 解析路径会走到，P4 必须原样重建）。原生 ELF 18 个 / 122,980,048 B：`libonnxruntime.so` 三份同 hash `cfc800d4438f15e8` 各 34,606,912、`libsherpa-onnx-c-api.so` 两份 `d1b41ded09e00017`、`sherpa-onnx.node` 两份 `ae1459b87db45cdc`、`libsherpa-onnx-cxx-api.so` 两份 `49fe5a314d4fc4f1`；`koffi.node` 的 `linux_arm64`（1,172,200）与 `musl_arm64`（1,169,936）是两份不同 hash。tar 元数据：`uid/gid` 全 `(0,0)`，`mode 0o600×2247 / 0o644×1713 / 0o700×529 / 0o755×520 / 0o777×86 / 0o1777×1`，`uname/gname ('root','root')×5086 / ('','')×10`，`mtime` 89 种（min 0、max 1792164366）⇒ P4 要确定性重打包必须固定 `mtime`。

必需性分六类（A 硬必需 / B 构建期 / C 平台不可达 / D 字节重复 / E 从不调用 / F 保留），每条带代码坐标，明细见 `docs/05 §4`。可裁合计约 **112.5 MB 原始 / 约 75.6 MB 压缩后**：B `esbuild` + `@esbuild/linux-arm64` = 20,717,064（`cortico/package.json:54` devDep 与 `pet/scripts/build-console.mjs:10`，`dist/` 已预构建）；C `koffi` + `@koromix/koffi-linux-arm64` = 4,065,490（`cua/src/definition.ts:12` 在非 win/darwin 直接 throw，`pet/src/asr/hotkey.ts:119/131` 只在 win/darwin reader 内 import）；D 嵌套 sherpa native 副本 40,305,256 + `lib/aarch64-linux-gnu/libonnxruntime.so` 34,606,912；E `lib/node_modules/npm` 10,685,798（源码里 `'npm'` 只是扩展来源的 UI 枚举值，无 `spawn('npm')`）+ `home/…/runs/**` 41,977（`carryOverHome()` 明确 filter `/data/runs`）+ 包内 `docs/tests/licenses` 2,075,062；F 保留 `bare-*` 家族约 5.7 MB（依赖链指向扩展安装，收益不足）。整包重压已确认无效（`level=6 → 136,348,642`、`level=9 → 136,348,529`，ratio 0.994），收益只能来自删条目 ⇒ `payload.asset` 预计 136.35 → **60~62 MB**，整包 137.2 → **65~70 MB**（以 P4 实测为准）。**事后订正（P4-B 实测）**：四组全裁只省 **37,502,237 B**（累计删原始 111,875,725 B），`payload.asset` 实际到 **99,615,831 B**、整包 **100,034,325 B**，`60~62 MB` 与 `65~70 MB` 两个区间均不成立；错因是「删文件省的是压缩后体积，不是与整包压缩的差额」，详见 `docs/05 §5`。

P4 复刻的八条硬约束见 `docs/05 §6`（软链原样重建 / 22 个 `L` 头 / 2 个零块 / `mtime` 固定 / gzip 头固定 / `mode` 差异保留 / `boot.sh` 自愈逻辑 / 改长度会触发 rootfs 重建）。**本轮新增一条**：`boot.sh:52` 的 `PKG-ABS` 自检硬编码了嵌套路径 `sherpa-onnx-node/node_modules/sherpa-onnx-linux-arm64/sherpa-onnx.node`，P4 删嵌套副本后需同步改，否则会打印一条不阻断启动的 `FAIL`；保留顶层副本是安全的，因为 `addon-static-import.js` 对 `arm64-linux` **先** `require('../sherpa-onnx-linux-arm64/sherpa-onnx.node')`，命中后不再走 `addon.js` 的 `possible_paths`。

工具与耗时：`tools/p3_tarstruct.py`（3.465 s，块级状态机）、`tools/p3_longname.py`（4.180 s，长名清单 + trailer 直读）、`tools/p3_report.py`（3.590 s，216 行全表）。**性能纪律**：处理 344 MB 级流式数据禁止 `buf = buf[512:]` 逐块切片（O(n²) 拷贝），须「整块读入 + 下标扫描 + 只留尾部残余」。

### P4 前置 · 源码缺口盘点与两份政策文档（已完成）

用户将目标从「各阶段逆向进度」重新定义为「**拿到源码**」，据此把完成标准拆成三层并在每一层给出实测数字：

| 层 | 状态 | 关键依据 |
|---|---|---|
| **原样源码** | ✅ **齐了，且是原厂原样** | `rootfs/.../cortico/src` 存在 193 文件 / 1,832,204 B（181 `.ts`），对账 **862/862 sha256 相同** ⇒ `src/recovered` 不是还原，是**逐字节副本** |
| **可编译工程** | ⚠️ 差 2 块 | ① 无 Gradle 工程；② **构建必需件不在 APK 内**（`bin/cortico.mjs`、`scripts/build-web.ts`、`tsconfig*`、`tailwind.config.*`、`src/launcher.ts` 全 MISS）；③ ~~devDeps 无版本锚~~ **已补齐 28/28（`BUILDDEPS.md`，未解 0）** |
| **构建产物** | ✅ 当前不需重建 | `cortico/dist` 8 文件 / 917,106 B 与 `vendor/pet/dist` 2 文件 / 11,766 B **原样在包内**；`payload.asset` 136,348,624 B 在手，确定性重打包可做 |

**本轮最关键的认知修正（推翻 `DEPS.md §6` 两条旧计划）**：

1. **`patches/` 不存在也不需要存在**。`recon_upstream.py` 对账对象是**部署态**（APK 内实际运行的代码）而非上游 git，结果 862/862 全同 ⇒ 本样本未改上游代码，无补丁可打。详见 `UPSTREAM.md §5`。
2. **`cortico/dist` 必须保留入仓**。旧计划说「10 个构建产物按政策移除、改由构建链生成」——但 `build:web` 依赖的 `scripts/build-web.ts` **不在 APK 内**，移除即丢失唯一权威产物。详见 `PREBUILT.md §2 §7`。
3. **上游包名纠正**：`Pal-AI-Lab/Coopanion` → **`Pal-AI-Lab/Cortico`**（读自 `cortico/package.json → repository.url`），版权方 `Copyright (c) 2026 Phantivia`，MIT。

产出两份根级文档：

| 文件 | 行数 | 内容 |
|---|---|---|
| `UPSTREAM.md` | **150** | 上游身份 / 5 个包的版本锚点（`cortico 0.1.5`、`coop-android 0.1.6`、`coo 0.2.0`、`cua 0.1.2`、`pet 0.1.4`）/ **全树指纹** `fd419624741071da…b6b9`（863 文件 / 16,350,953 B）/ 「部署态没有但上游有」的 5 项缺失件 / 为何无 `patches/` / 补 commit sha 的步骤 |
| `PREBUILT.md` | **168** | 5 个 proot `.so` 逐文件 sha256（**实测 5/5 与 APK 逐字节相同**，入仓于 `src/x/lib/arm64-v8a/`）/ `payload.asset` sha256 `39899fa0…0ea50` / `cortico/dist` 8 文件与 `vendor/pet/dist` 2 文件逐文件 sha256 / sherpa·esbuild·koffi 的 sha256 与份数 / 2 条软链 / 「能不能一条命令复原」判定表 |

**四处一致性补正**：`DEPS.md` 6 处理引用落地（L29 上游名、L33 入仓路径 `src/x/lib/arm64-v8a/`、L35 补 5/5 实测、L127 无补丁、L156/L157 两条旧计划标为已推翻）；`docs/00` 产物地图补 4 行根级文档索引（原先 `DEPS.md`/`BASELINE.md` 完全没被索引）；`README.md` 读路表 +2 行、目录树 +4 行；`BASELINE.md` 本节记录的 `src/recovered` 口径矛盾（863 与 853）已改为「两口径并存，本文件用 863」。

**已知未对账项（新发现）**：`coop-stage/` 实有 **58** 文件，但 `recon_upstream.py` 的 `STAGE_SUBSET` 只列 5 项 ⇒ 覆盖 57，**`boot.sh`（3,190 B）未被 sha256 比对**。这也是「全树 863」与「对账 862」差 1 的原因。建议把 `boot.sh` 加入 `STAGE_SUBSET`（一行改动，未做，先登记在 `UPSTREAM.md §7`）。

**未做**：Gradle 工程（性价比最低，APK 侧已有 MT 重打包闭环，用户已明确「3 再说」）。

**补1 已入远端**：`UPSTREAM.md` + `PREBUILT.md` + 修五处一致性已提交推送，远端 `main = 07bab831`（本地提交 `c303519`，上传 6 个 blob，远端共 1,111 文件 / 19,496,610 B）。


### P4 前置 · 补2 构建期依赖版本锚（已完成）

`DEPS.md §3.3` 列的 **28 个构建期缺包**（`cortico` 20 / `pet` 5 / `cua` 3）已全部补上精确版本锚，**未解 0**。

| 证据强度 | 数量 | 获取方式 |
|---|---|---|
| artifact | 4 | 版本号印在产物里：`dist/web/styles.css` 首行 `/*! tailwindcss v4.3.3 */`；`main-VF7OQOQ5.js` 内 `version:"19.3.0"`（react / react-dom）；`@tailwindcss/cli` 随 `tailwindcss` 同步发版 |
| exact | 2 | `@types/tar-stream 3.1.4`、`electron 44.4.4` 本就精确 |
| deployed | 18 | 部署态 `node_modules` 实测（含 `esbuild 0.28.2`、`tsx 4.23.15`） |
| snapshot | 18 | 纯 dev 包无痕迹：以**构建时点** `2026-10-10T17:44:10Z`（取自 `dist` mtime）为截止，取已发布且满足范围的最高版 |

**复现实验（本轮最硬的一条）**：用锚定的 `esbuild@0.28.2` 跑树内 `scripts/build-console.mjs`，`vendor/pet/dist` 两个产物**逐字节复现**：

- `console.css` 1,936 B `ef9e1c992b97ac88a699b14c1ff6150ae9f4dbba7d1fa83f8f193e67249a3356` ✅
- `console.js` 9,830 B `85f2c5616f043afce7321a045dd3d5b35f48e1930f2195b743abe4c61dede19d` ✅

一次跑通、零参数调整 ⇒ 同时证明 ① `esbuild 0.28.2` 锚正确；② `src/recovered/vendor/pet` 源码无漂移；③ `pet/dist` 可重建从「预期」升级为「实测」。
唯一差异：重建多出两个 `.map`（脚本里 `sourcemap: true`），说明原厂**打包时删 `.map`**，不是关掉了 sourcemap（`console.js` 末尾 `//# sourceMappingURL=console.js.map` 为证）。

**三条方法学结论**：

1. **别用「今天的 latest」**。构建到今天已有包发新版：`@codemirror/view` 6.43.14→6.43.15、`jsdom` 30.1.2→30.1.3、`react` 更高；按 latest 装就是错的。
2. **别只对子树的账**。pnpm 把依赖扁平化到根树，`cortico/node_modules` 只有 4 项；只比子树会误判「缺 27 个」。必须合并根树 + 全部子树成 95 项全局映射再比。
3. **不伪造 lock**。树内无 `pnpm-workspace.yaml`，工作机制拓扑不可知；`pnpm install --lockfile-only` 只会把今天的 latest 写死。改交「锚点表 + 可复算工具」，逐行带 `method` / `published` 溯源。

**产出**：`tools/resolve_build_deps.py`（272 行，四级证据链 + registry 快照 + 缓存/离线/退出码）、`build-deps.anchor.json`（42 行，机器可读）、`BUILDDEPS.md`（305 行）。`.anchor-cache/` 已进 `.gitignore`。

**边界（必须与补2 一起记住）**：锚点齐了**仍然重建不出 `cortico/dist/web`** —— 缺的是 `scripts/build-web.ts` / `tsconfig*.json` / `bin/cortico.mjs`，与依赖版本无关。`payload.asset` 的 sha256 也不会因此对上。

**补２ 已入远端**：远端 `main = 4fbd4bd0`（1,114 文件 / 19,539,351 B）；本轮上传 9 个 blob。离线复算已验证：`--offline` 重跑 42 行锚点与入库 JSON 逐行一致（`identical=True`，退出码 0）。

**流程教训**：proot heredoc 传中文偶尔会把单个汉字传成 `U+FFFD`（本轮实际踩到一次）。因此每次写文件后必须做一次 `assert chr(0xfffd) not in text`，已内建到本次所有写入。

### P4-A 等价重打包（已完成 · 双层逐字节）

验收工具：`python3 tools/p4_verify.py`，38s，全 PASS（退出码 0）。

| 层 | bytes | sha256 | 结果 |
|---|---|---|---|
| L1 `payload.asset`（APK 内） | 137,118,068 | `39899fa0…` | 基准 |
| L2 裸 tar（解压后） | 360,825,344 | `be2293e6…` | 基准 |
| L3 tar（解包到树后重打） | 360,825,344 | `be2293e6…` | ✅ 与 L2 相同 |
| L4 `payload.asset`（重压，gzip -6） | 137,118,068 | `39899fa0…` | ✅ 与 L1 相同 |

**结论**：从 APK 抽 `payload.asset` → gunzip → 解包成 353.9 MB 树（5,118 条元数据）→ 按清单重打 tar → gzip -6 重压，**四层 sha256 完全相同**。即容器层已 100% 复刻，P4-B 的任何裁剪都能用这套工具产出「只差被裁文件」的新 payload，且可逐字节回溯。

**口径纠正（重要）**：原计划写的是「把现有 863 文件源码树重打成 tar 比 sha256」——**这条按字面不可能成立**：仓库只有 863 个源码文件，而 tar 内有 4,053 个文件（含 95 个 node_modules 包、busybox 51 个 applet、python stdlib、sherpa native 等）。P4-A 真正证明的是**容器复刻能力**（解包树 → 重打 → 逐字节一致），不是「863 文件能重建出整个 rootfs」。后者属 P5 范畴，需按 `BUILDDEPS.md` 装齐依赖后从源码重编。

**三个新发现**（已写回 `docs/05 §2.1 / §2.2 / §6`）：

1. **tar 是混合格式**：前 5,107 条 GNU（`ustar  \0`）+ 末尾 11 条 POSIX（`ustar\0`+`00`）。末尾 11 条全是 `vendor/pet/web/*`，`mtime=0` —— 主 rootfs 打完后用**另一个写入器**追加的 web UI 覆盖层（无零块分隔）。
2. **gzip 级别是 6，不是 9**：level 9 压出 136,591,114 B，比原厂小 526,954 B，不等价。
3. **`136,348,624` 是 APK 内 zip deflate 尺寸**，不是 gz 文件大小（137,118,068）。`docs/05 §2.1` 原表把这两个数混了，已拆成两行。

**产出**：`tools/p4_extract_payload.py`（抽裸 tar）、`tools/p4_repack.py`（extract/build，逐条写 magic + 重算 checksum）、`tools/p4_gzip.py`（固定头 + 指定级别）、`tools/p4_verify.py`（四层验收）。工作目录 `/tmp/p4work/`，**不入仓**。

**方法论教训**：先做「单条目写头探针」再整体重打。首轮直接整体重打，只在末尾 11 条上差了 checksum（漂移区仅 104,448 B，即 360,719,872–360,824,320）；先抽 4 类样本（文件/目录/软链/L 头）逐字节对头，才定位到「magic 混合」这一层。

### P4-B 裁包（已完成 · 待真机冒烟）

四组全开（B 构建期工具链 / C 平台不可达 / D 字节重复 / E 从不被调用），走 P4-A 验证过的同一条重打流水线，逐级实测：

| 阶段 | 累计删原始 | tar | payload.asset(gz6) | 本组实测省 |
|---|---:|---:|---:|---:|
| 基线 | 0 | 360,825,344 | 137,118,068 | — |
| B | 20,717,064 | 340,091,904 | 128,686,928 | 8,431,140 |
| +C | 24,782,554 | 335,943,680 | 127,714,726 | 972,202 |
| +D | 99,694,722 | 261,023,744 | 102,734,742 | 24,979,984 |
| +E | 111,875,725 | 247,073,280 | **99,615,831** | 3,118,911 |

**结果**：`payload.asset` 137,118,068 → **99,615,831**（−27.4%）；APK 137,205,527 → **100,034,325**（−27.1%）。

| 对象 | 字节 | sha256 |
|---|---:|---|
| `cut_bcde.tar` | 247,073,280 | `59e89556…` |
| `cut_bcde.asset` | 99,615,831 | `c03fd392…` |
| `Coopanion-v12.71-cut-BCDE-signed.apk` | 100,034,325 | `13fcc08e…` |

**结构校验**：2,576 条目 = 2,019 文件 + 467 目录 + 83 软链 + 9 长名头；悬空软链只剩 1 条且是原厂自带的 `app/sherpa-native/librt.so.1`（boot.sh 自愈）；因裁剪断掉的 2 条 koffi 工作区软链已连带删除；运行期要件（`bin/node`、`pnpm`、`tsx`、顶层 sherpa 四 native 含 `libonnxruntime.so`、`opencc-js`、`express`、`boot.sh`、`run-core.mjs`）逐项在位。

**APK 校验**：zip `testzip` OK、29 条目无缺失；内含 `assets/payload.asset` 的 sha256 与 `cut_bcde.asset` 完全一致；除 `META-INF/*`（重签产生）外仅 `assets/payload.asset` 变化。

**boot.sh 补丁**：D 组删掉嵌套 sherpa 后，`boot.sh` 里 `PKG-ABS` 自检的硬编码路径会失效，已改指顶层副本（3,190 → 3,160 B）。该补丁只进裁包产物；基准解包树用 P4-A 重跑覆盖还原，**P4-A 双层校验复跑仍 PASS**（`be2293e6…` / `39899fa0…`），基准未被污染。

**签名**：本机无 JDK / keytool / apksigner（proot 里全 MISSING，且无 openssl），改走 MT MCP：`mt_apk_workspace_open` → `mt_apk_session_create` → `mt_apk_copy_entry(local_to_edit_session)` → `mt_apk_session_check(passed)` → `mt_apk_build(sign=true)`，结果 V1+V2+V3。证书是 MT 默认测试证书（`a40da80a…`），**与原厂不同** ⇒ 不能覆盖安装，装机前须先卸载原应用。

**方法论教训（又一次「估算 vs 实测」）**：`docs/05 §5` 原表把「原始大小 − 该组独立压缩后大小」当收益（如嵌套 sherpa `40,305,256 − 13,511,959`），于是 D 组被多算一倍、「60~62 MB」目标不成立。真实收益是删掉文件的**压缩后体积**：D 组 74.9 MB 重复 native 只换来 25 MB。以后估体积收益一律以「同一条流水线逐级重打实测」为准，不要用单组独立 gzip 的数字做加减。

**已入远端**：`main = 4864f111`（本地提交 `69f1c0e`，上传 5 个 blob，远端共 1,120 文件 / 19,574,956 B）；随后一次纯文档修订只同步 `docs/00` 行数与本节措辞。`apk/` 按仓库纪律不入库，产物以 sha256 记录。

### 下一步

P0 已收口（源码 862/862 零漂移 + 依赖树 95/95 零差异）；P2 全部完成（四批共校正 34 处）；P3 已完成（`docs/05`）；**P4 前置全部完成**（补1 `UPSTREAM.md` + `PREBUILT.md` 已推远端，补2 构建期依赖版本锚 28/28 补完，见上两节）。

下一步 **真机冒烟**：产物已在 `apk/Coopanion-v12.71-cut-BCDE-signed.apk`（100,034,325 B）。证书与原厂不同，装机前须先卸载原应用；装上后重点看三件：App 能否起来、`boot.sh` 的 native 自检是否不再出 `PKG-ABS FAIL`、sherpa 语音链路是否可用。冒烟通过 → **P5** 等价性验证（sherpa native 真机加载 + `boot.sh` 自愈实验），并处理 `recon_upstream.py` 的 `STAGE_SUBSET` 遗留。**每个单元收口后都按「出包验收台账」出包、装机、待用户实测。**

Gradle 工程仍挂起（用户「3 再说」）。
