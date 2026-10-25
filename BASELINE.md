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

合计 **1,101 文件 / 19,410,855 B（18.51 MiB）**。

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
# → 1101 files, 19410855 bytes

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

### 出包验收台账（每个逆向单元必出一个可安装包）

**规则（用户 2026-10-25 定）**：每完成一个逆向单元 → 构建 APK → 装机 → 用户实测。本地无 JDK / Android SDK，出包一律走 **MT MCP 重打包**（axml / smali 级编辑 + 内置签名）。MT 的 Home 是 `/storage/emulated/0/MT2/mcp`，其余路径被策略拒绝；`outputName` 必须给**绝对路径**（带子目录的相对路径会报 `INVALID_ARGUMENT: outputName`）。

| # | 版本名 | 改动 | 字节 | 签名证书 sha256 | 验收结论 |
|---|---|---|---|---|---|
| 1 | `12.71-p0` | **仅** `versionName` 标记（P0 无代码改动，本轮验证的是重打包链路本身） | 137,258,773 | `a40da80a…bf5dc` | 就地升级成功；冷启动 24 s+ 无崩溃、crash 缓冲空；`libproot.so` + `node` 均拉起；`coop-run.log` 到 `core已启动`、Web 面板 `127.0.0.1:17788` 与桌宠悬浮窗就绪 |
| 2 | `12.71-p2` | `doBoot()` 里 `[2] 启动 Coopanion Core ...` → 加 `[P2]` 标记（验证 Java 层可定位、可改写、可观测） | 137,258,773 | 同上 | 就地升级成功；冷启动 30 s、`pid` 稳定、`libproot.so` + `node` 起；`coop-run.log:279` 实测出现 `[2][P2] 启动 Coopanion Core ...`，控制台与桌宠均正常 |

产物：`/storage/emulated/0/MT2/mcp/Coopanion_v12.71/Coopanion-v12.71-p0-signed.apk`，sha256 `842cd2b76e60f60518e2c4775aa6f55e50dc050d940abd25553d7645c18e4c1a`（不入库，MT2/mcp 与 apk/ 均在 `.gitignore` 内）。
`12.71-p2` 同目录 `Coopanion-v12.71-p2-signed.apk`，sha256 `1fe2dc52982dc27765e0dc75c23c6d4f65c44d31b79ced6a6f0ed3b89827218e`（两份包体字节数相同，靠 sha256 与 `versionName` 区分）。

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

同时修正两处子项计数：`src/recovered/` 863 → **853**（差值是那 10 个 `dist`）、`src/x/` 21 → **20**（实为 `lib` 5 + `META-INF` 5 + `assets/probe` 3 + dex 与清单与 arsc 与 `axml.py` 与 2 份 `.classes.txt`）。

### 下一步

P0 已收口（源码 862/862 零漂移 + 依赖树 95/95 零差异）；**P2 第一批完成**（jadx 基线 14 文件 + `docs/02 §1.3/§1.4` 校正 8 处，出包 `12.71-p2` 装机验证）。
P2 下一批：`§2 SenseBridge` + `§3 PetWindowService` + `§4 PetHostBridge`（桥接与桌宠、三条 JS 通道）→ `§5 EyesService` / `§6 VoiceBridge` / `§7 NotifListener` → `§8` 三个小类。
之后 P3 预编译清单 → **P4**：`build-payload.py` 确定性 gzip+tar，复刻 `boot.sh` 的 `librt` 软链自愈与 native 拷贝；**P4 开工前需先闭合构建期依赖**（`cortico` 缺 20 个，见 `DEPS.md §3.3`）→ **P5** 等价性验证（含 sherpa native 真机加载与 `.ok` 自愈实验）。**每个单元收口后都按「出包验收台账」出包、装机、待用户实测。**