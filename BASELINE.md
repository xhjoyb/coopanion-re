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

合计 **1,072 文件 / 19,742,777 B（18.83 MiB）**。

| 路径 | 文件数 | 说明 |
|---|---|---|
| `docs/` | 5 | 00 导读 302 行 · 01 架构 216 · 02 Java 856 · 03 桥接协议 1182 · 04 工具链 754 = **3,403 行** |
| `README.md` | 1 | 93 行，入口 |
| `BASELINE.md` | 1 | 本文件 |
| `log/` | 6 | `ziplist.txt`、`rootfs_list.txt`(568 KB)、`doc-round7/8.txt`、`dex2smali-v2-to-v3.diff`、`pip.log` |
| `src/recovered/` | **863** | 原厂 TypeScript 源码树（**259 个 `.ts`**，未混淆、未编译、中文注释完整），含 `package.json`/`tsconfig.json` |
| `src/java2/` | 132 | smali 精确视图：合并 2 份 + `classes/` **124 个一类一文件** = **544 个 `.method`** |
| `src/java2_v2/` | 2 | 旧工具链基线（v2，对照用） |
| `src/java/` | 3 | 早期反编译尝试产物 |
| `src/js/` | 12 | Java 内嵌注入脚本 12 段（4,776 B） |
| `src/x/` | 21 | APK 解包产物：`AndroidManifest.xml`、`classes.dex`(98,744 B)、`classes2.dex`(37,212 B)、`resources.arsc`(2,440 B)、5 个 `.so`、`assets/probe/*.js`、`META-INF/*` |
| `src/*.py` | 20 | 逆向脚本（功能 9 + 工具链补丁 3 + 文档回改 8） |
| `tools/push_repo.py` | 1 | Git Data API 推送器（本机 `git` CLI 挂死时的唯一通道） |

---

## 3. 未纳入仓库的产物（及重现方式）

| 产物 | 大小 | 不纳入原因 | 重现方式 |
|---|---|---|---|
| `apk/Coopanion-v12.71.apk` | 137 MB | 超 GitHub 单文件 100 MB 硬上限；且为原厂发行物 | 自行取得原包，`md5sum` 核对 `ed319932…e00b1` |
| `mcp_out/Coopanion-v12.71-mcp.apk` | 137 MB | 同上 | 见 `docs/04 §2`：MT MCP 改 `versionName` → 重签 |
| `src/rootfs/` | 1,910 文件 / 137,479,592 B | 体积 | `unzip -p apk/Coopanion-v12.71.apk assets/payload.asset \| tar -xz -C src/rootfs` |
| `src/rootfs/…/node_modules/` | 119.2 MB / 95 包 | 可下载依赖，非逆向产物 | `npm ci`（`package-lock.json` 已在仓库，37,020 B） |
| `src/recovered/cortico/dist/web/` | 9 文件 / 922.0 KB | 构建产物（esbuild bundle） | `pnpm --filter cortico build:web` |
| `src/recovered/vendor/pet/dist/` | 2 文件 / 19.5 KB | 构建产物（压缩 console） | `npm --prefix vendor/pet run build` |

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
2. **`res/` 未还原成工程树** —— 实测全包仅 11 个资源条目、`resources.arsc` 2,440 B、15 个符号（`ic_launcher`、`ic_launcher_round`、`AppTheme`、`PetTheme`、`app_name`、`eyes_*`）；
3. **`node_modules` 未独立抽出**（真跑起来不需要，用 `src/rootfs/` 那份运行时即可）。

---

## 5. 校验本基准（约 30 秒）

```bash
# 1) smali 视图与 dex 完全一致（自研反汇编器可复现）
python3 src/dex2smali.py src/x/classes.dex | diff -q - src/java2/classes.dex.smali && echo identical
# → identical

# 2) 原厂 TS 源码规模
find src/recovered -name '*.ts' | wc -l        # → 259
find src/recovered -type f | wc -l             # → 863

# 3) Java 规模
ls src/java2/classes | wc -l                   # → 124
grep -h '^\.method' src/java2/classes/*.smali | wc -l   # → 544

# 4) 文档规模
wc -l docs/*.md README.md | tail -1            # → 3403 total
```

---

## 6. 与基准对比

```bash
git fetch --tags
git diff v12.71-baseline --stat      # 相对基准的全部改动
git log v12.71-baseline..HEAD        # 基准之后的提交
```

**回退**：`git checkout v12.71-baseline` 即回到本基准的完整文件状态（不含 §3 三个大产物）。