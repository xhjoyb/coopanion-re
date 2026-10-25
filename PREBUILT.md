# PREBUILT — 预编译二进制与构建产物清单

> **判定标准**：只有「**不可用一条命令复原**」的二进制才入仓；能用 `npm ci` / `unzip` / `ln -s` 复现的，一律不入仓，只在此登记 sha256 以便核对。
> 本文是 `DEPS.md §2 例外` 的落地清单。

---

## 0. 总览

| 类别 | 体量 | 是否入仓 | 位置 |
|---|---|---|---|
| APK 侧 proot JNI 库（5 个 `.so`） | **388,758 B** | ✅ **已入仓** | `src/x/lib/arm64-v8a/` |
| `cortico/dist/`（Web 面板产物） | 917,106 B | ✅ 已入仓（随源码树） | `src/recovered/cortico/dist/` |
| `vendor/pet/dist/`（桌宠控制台产物） | 11,766 B | ✅ 已入仓 | `src/recovered/vendor/pet/dist/` |
| `payload.asset`（全部运行时代码） | 137,118,068 B | ❌ 不入仓 | `apk/Coopanion-v12.71.apk` 内 |
| 完整 proot rootfs（含 `/bin/node`） | — | ❌ 不入仓（只提取了 `/app` 段） | 同上 |
| node native addon（sherpa / esbuild / koffi） | ~119.2 MB（node_modules） | ❌ 不入仓 | `src/rootfs/app/coop-stage/node_modules/` |

---

## 1. 必须入仓：APK 侧 5 个 `.so`

**理由**：这层 Android 移植独有的 aarch64 资产，公开源无现成产物，重建需 NDK 工具链。
**状态**：已入仓于 `src/x/lib/arm64-v8a/`，**5/5 与 APK 内逐字节相同**（实测 sha256 对比）。

| 文件 | 字节 | sha256 |
|---|---|---|
| `libandroid-shmem.so` | 66,681 | `d581b07949628c1f7d88c0c947910e3aab953fc8c8c588af4a4f7d44e92ba3ac` |
| `libproot.so` | 264,105 | `6f58785578726cbdf89b4f69ed79f8523a610cf4ff16aece467f0c4b65d4f8a8` |
| `libprootloader.so` | 18,136 | `cbdef0e652c2b78af25d867e1719fdebbb0915e25aae2dd35b3b5c1835f6b551` |
| `libprootloader32.so` | 6,244 | `c429996fee730e1a4fe12625b22dab5a5bc2847a4cae274d36fd4a19cd8299a8` |
| `libtalloc.so` | 33,592 | `742b438c4d09e276985a61d44164c9de207b6d8cc268f3018cb3001961bcb309` |
| **合计** | **388,758** | — |

APK 内路径均为 `lib/arm64-v8a/<同名>`，`extractNativeLibs` 相关行为见 `docs/01`。

---

## 2. 构建产物：`cortico/dist/`（8 文件 / 917,106 B）

**状态**：随源码树入仓（`recon_upstream.py` 已对账 MATCH，即原厂发版时带来的产物，不是本地构建的）。

| 相对路径 | 字节 | sha256 |
|---|---|---|
| `web/asset-manifest.json` | 12,720 | `a6aacad7ddbd98a19fd11a1650f53968d08f003685fa26e2fd22d8baf3926864` |
| `web/main-VF7OQOQ5.js` | 757,331 | `a78b7c6a45acce73968db4b23601585a94bf7e582f8b2f35c2a8e61a46a10b4a` |
| `web/styles.css` | 104,536 | `ab76aeecc272c147f589aef53f65a754b5c8d23863bec4120db7309927cd33cb` |
| `web/chunks/chunk-FY3BTKY4.js` | 620 | `828ae02371c4e3ade86bbfdc45e385cd4402c974e03eab24848a92f9b6e75a0a` |
| `web/chunks/chunk-WE2EXA7X.js` | 15,011 | `3af3591161da29a1a0f79b29de04a42f7e0e1f9602679c17c0f7ac44a2e8276c` |
| `web/providers/llm-openai-responses-compat-ZPWUFL34.js` | 2,675 | `a3cf0f188e0b486177f750e53a68c3b007681e373dc50c10c5e7cc90aa548d51` |
| `web/providers/persona-cormini-L7R73XSJ.css` | 3,734 | `b76ef297368458d65bfa6127adf842d73a2166d337ed864edd5dcaa3af70aa4e` |
| `web/providers/persona-cormini-RBVEMMCE.js` | 20,479 | `037abba78a0518fb5b43c13437dc790dafaeb6185acec4388ff83401cb1e218a` |

> ⚠️ **这 8 个文件无法从本地源码重建**：`build:web` 脚本依赖 `scripts/build-web.ts`，该文件在 APK 里不存在（见 `UPSTREAM.md §4`）。
>
> 补：这 8 个文件「不可重建」的原因是**构建脚本缺失**，与依赖版本无关——20 个 devDeps 的精确锚点已在 `BUILDDEPS.md` 补齐，但 `scripts/build-web.ts` 不在 APK 内，所以仍然跑不起来（`BUILDDEPS.md §4.3`）。
> 它们目前是**唯一的权威产物**，改动请直接改这 8 个文件，或先补上游 `scripts/`。

## 3. 构建产物：`vendor/pet/dist/`（2 文件 / 11,766 B）

**状态**：已入仓。**这个是可本地重建的**（`vendor/pet` 的 `scripts.build` 与依赖在树内齐备，见 `DEPS.md §3.3`）。

| 文件 | 字节 | sha256 |
|---|---|---|
| `console.css` | 1,936 | `ef9e1c992b97ac88a699b14c1ff6150ae9f4dbba7d1fa83f8f193e67249a3356` |
| `console.js` | 9,830 | `85f2c5616f043afce7321a045dd3d5b35f48e1930f2195b743abe4c61dede19d` |

---

## 4. 不入仓：`payload.asset`

| 项 | 值 |
|---|---|
| APK 内路径 | `assets/payload.asset` |
| 字节 | **137,118,068** |
| sha256 | `39899fa081234c92244fde4b9dffc0fadaf644bfa10bd765b389304c0010ea50` |
| 内容 | 压缩的 proot rootfs（含 `/app/coop-stage/` 全部代码与 `node_modules`、`/bin/node` 等） |
| 提取结果 | `src/rootfs/app/` = **1,910 文件 / 137,479,592 B** |

**未入仓理由**：它是 APK 内的单文件压缩容器，`unzip apk` 即可取出，不入仓不丢东西。
**注意**：`src/rootfs` 只提取了 **`/app` 段**（顶层只有 `app/`），**不含 `/bin`、`/lib`、`/usr`**。
因此 `boot.sh` 末行 `exec /bin/node --import tsx run-core.mjs` 里的 `node` 二进制**不在本仓库**，
需要时从 `payload.asset` 解包获得。这不是缺口，是提取范围的刻意选择。

---

## 5. 不入仓：node native addon（可用 npm 复原）

以下均在 `src/rootfs/app/coop-stage/node_modules/` 内，属「可下载依赖」，**不入仓**。
列出 sha256 供 `tools/check_deps.py` 之外的深度核对用。

### 5.1 `sherpa-onnx-linux-arm64`（去重后 40,305,256 B，部署态存 2 份）

| 文件 | 单份字节 | 份数 | sha256 |
|---|---|---|---|
| `sherpa-onnx.node` | 804,112 | ×2 | `ae1459b87db45cdc756b45e1cb495466225f62d2dd63eb35bf225196bf20900a` |
| `libonnxruntime.so` | 34,606,912 | ×2 | `cfc800d4438f15e8d9017521326776ca7117d8783cb847ccccc2fc61ac4d540f` |
| `libsherpa-onnx-c-api.so` | 4,613,032 | ×2 | `d1b41ded09e00017b37375584792cf697dad8bf35ccd787706acdbc4c7afc912` |
| `libsherpa-onnx-cxx-api.so` | 281,200 | ×2 | `49fe5a314d4fc4f13d0a036d26cdea228fb6504547022013350855881bff5b59` |

两份位置：
- 顶层 `node_modules/sherpa-onnx-linux-arm64/`（7 文件，完整包）
- 嵌套 `node_modules/sherpa-onnx-node/node_modules/sherpa-onnx-linux-arm64/`（**仅 4 个 native**，无 `README`/`index.js`/`package.json`，需手工补）

版本锚：`sherpa-onnx-node@1.13.8` / `sherpa-onnx-linux-arm64@1.13.8`。

> `boot.sh` 的 `[B0] PKG-ABS` 自检硬编码了嵌套路径
> `/app/coop-stage/node_modules/sherpa-onnx-node/node_modules/sherpa-onnx-linux-arm64/sherpa-onnx.node`，
> 裁包时必须同步改（P5 遗留项）。

### 5.2 `esbuild`（10,289,264 B ×2 = 20,578,528 B）

| 文件 | 字节 | 说明 |
|---|---|---|
| `node_modules/esbuild/bin/esbuild` | 10,289,264 | 真二进制；`esbuild@0.28.2` |
| `node_modules/@esbuild/linux-arm64/bin/esbuild` | 10,289,264 | 同上，平台包副本 |

`--ignore-scripts` 安装后需单独执行 `node node_modules/esbuild/install.js` 补回。

### 5.3 `koffi`（`koffi@3.3.1`，2 个 ABI 变体）

| 文件 | 字节 | sha256 |
|---|---|---|
| `@koromix/koffi-linux-arm64/linux_arm64/koffi.node` | 1,172,200 | `3c0b44f62791e811fa9afa5c9bb2c6c8983d0e9cbff5ef3ea2e1f91bdb7ef4e3` |
| `@koromix/koffi-linux-arm64/musl_arm64/koffi.node` | 1,169,936 | `1b6849d657c31786530e876199ef7b06f825be20931950c78e77f7f5f561e120` |

`--ignore-scripts` 是必需的：跳过 `koffi` 的 `cnoke.cjs` 本机编译，直接用平台预编译产物。

---

## 6. 软链（不入仓，需手工 `ln -s` 重建）

| 路径 | 指向 | 状态 |
|---|---|---|
| `node_modules/.bin/mime` | `../mime/cli.js` | 有效 |
| `app/sherpa-native/librt.so.1` | `../../../lib/aarch64-linux-gnu/libc.so.6` | **断链**（`/lib` 未提取，属预期） |

`tools/check_deps.py` 的 95 个顶层条目里有 4 个本地软链，是其「包清单/版本/体积三层等价」判定的已知项。

---

## 7. 判定表：能不能一条命令复原

| 目标 | 命令 | 结果 |
|---|---|---|
| 5 个 proot `.so` | ❌ 无（需 NDK + 源码） | **入仓** |
| `cortico/dist` | ❌ `scripts/build-web.ts` 缺失（**非依赖问题**） | **入仓，不可重建** |
| `vendor/pet/dist` | ✅ `node scripts/build-console.mjs` | 已入仓，**已实测逐字节复现**（`esbuild@0.28.2`，见 `BUILDDEPS.md §4.2`） |
| `payload.asset` | ✅ `unzip apk assets/payload.asset` | 不入仓 |
| `node_modules`（95 条目） | ✅ `npm ci` + 补 5 包 + 4 软链 | 不入仓 |
| `sherpa` 嵌套 4 native | ⚠️ 半自动（需手工补嵌套那份） | 不入仓 |
| `bin/node` | ✅ 从 `payload.asset` 解包 | 不入仓 |

## 8. 自检

```bash
# 5 个 .so 与 APK 内是否一致（应 5/5 MATCH）
python3 - <<'PY'
import zipfile, hashlib, os
z = zipfile.ZipFile('apk/Coopanion-v12.71.apk')
for f in sorted(os.listdir('src/x/lib/arm64-v8a')):
    a = hashlib.sha256(open('src/x/lib/arm64-v8a/' + f, 'rb').read()).hexdigest()
    b = hashlib.sha256(z.read('lib/arm64-v8a/' + f)).hexdigest()
    print(('MATCH' if a == b else 'DIFF '), f)
PY

python3 tools/check_deps.py      # 依赖树三层等价性
```

参见：`DEPS.md`（三分法）、`UPSTREAM.md`（源码身份与缺失件）、`BASELINE.md §P0`（验收记录）。