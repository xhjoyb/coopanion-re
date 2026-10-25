# DEPS.md · 依赖与产物政策

> **原则**：仓库只存**手写的东西**。凡能用「包管理器 / 构建脚本 / 官方发布」原样再拿到的，一律不进仓库，改为「声明 + 校验 + 一条命令」。
>
> 判定口诀：**能 `rm` 掉、再用一条命令复原 → 不进仓库。**

---

## §1 三分法

| 类别 | 判定标准 | 处置 |
|---|---|---|
| **源码** | 人写的：`.ts` `.mjs` `.js` `.css`、图片/音频源、构建脚本、文档、配置、`patch`、`lock` | **进仓库** |
| **可下载依赖** | 能从 npm / 上游仓库 / 官方发布拿到的：`node_modules`、上游源码、native 预编译包 | **不进仓库**，靠 `lock` + 版本锚点 |
| **构建产物** | 由脚本生成的：`dist/`、`payload.asset`、`*.apk` | **不进仓库**，靠构建链重建 |

---

## §2 不纳入清单（实测体量）

| 对象 | 体量 | 类别 | 重现方式 | 校验 |
|---|---|---|---|---|
| `src/rootfs/…/coop-stage/node_modules/` | **119.2 MB / 95 包**（直接依赖 8 个） | 可下载依赖 | `npm ci`（现有 `package-lock.json` 37,020 B） | 见 §5 |
| `src/recovered/cortico/dist/web/` | 8 文件 / **917,106 B**（esbuild 打包产物） | 构建产物 | `pnpm --filter cortico build:web`（`tsx scripts/build-web.ts` + tailwindcli） | asset-manifest 对齐 |
| `src/recovered/vendor/pet/dist/` | 2 文件 / **11,766 B**（`console.js` 单行 9,793 字符，已压缩） | 构建产物 | `npm run build`（`node scripts/build-console.mjs`） | 同上 |
| `sherpa-onnx-linux-arm64`（`sherpa-onnx.node` + `libonnxruntime.so`） | 随 npm 包安装 | 可下载依赖 | npm 安装 `sherpa-onnx-node` 时自带 | 版本号锁在 lock |
| `assets/payload.asset` | **137,118,068 B** | 构建产物 | `python3 tools/build-payload.py`（确定性 gzip+tar） | 长度 + sha256 |
| `apk/*.apk`、`mcp_out/*.apk` | 各 ~137 MB | 构建产物 / 发行物 | `./gradlew assembleRelease` 或原厂发行物 | md5 `ed319932…e00b1` |
| 上游 `Pal-AI-Lab/Coopanion` 源码树 | 41 MB | 可下载依赖 | `git clone` 指定 tag（见 `UPSTREAM.md`，P0 产出） | tag + commit sha |

### 例外：唯一必须进仓库的二进制

`lib/arm64-v8a/` 下 5 个 `.so`（共 **388,758 B**）：`libproot.so`(264,105) / `libandroid-shmem.so`(66,681) / `libtalloc.so`(33,592) / `libprootloader.so`(18,136) / `libprootloader32.so`(6,244)。

理由：它们是这层 Android 移植**独有**的资产，公开源里没有现成 aarch64 产物，重建需要 NDK 工具链。体量小（380 KB），按「不可用一条命令复原」保留，并在 `PREBUILT.md` 记 sha256。

---

## §3 可复现性缺口（lock 状态）

| 包 | lock | 版本约束 |
|---|---|---|
| `coop-stage` | ✅ `package-lock.json` 37,020 B | — |
| `cortico` | ❌ **无** | `engines.node >=22`、`packageManager pnpm@11.5.0`、16 deps + 15 devDeps |
| `vendor/coo` | ❌ **无** | — |
| `vendor/cua` | ❌ **无** | — |
| `vendor/pet` | ❌ **无** | — |

**后果**：没有 lock 就没有 `--frozen-lockfile`，装出来的依赖版本会漂移，打出的 `payload.asset` 指纹与 `v12.71` 不一致，等价性验证永远过不了。

**补齐（P0 阶段）**：从上游 `pnpm-lock.yaml` + `pnpm-workspace.yaml`（顶层 `pnpm-workspace.yaml` 已在上游仓库确认存在）取得并提交；上游对不上时用 `pnpm install --lockfile-only` 生成后提交。

---

## §4 构建流水线（这些动作只在构建时发生）

```
1. 取上游源码            git clone <upstream> --branch <tag>     ← 不进仓库，靠 UPSTREAM.md 锚点
2. 应用本地改动          git apply patches/*.patch
3. 装依赖                pnpm install --frozen-lockfile          ← node_modules 由此生成
4. 建前端产物            pnpm --filter cortico build:web ; npm --prefix vendor/pet run build
5. 打 payload            python3 tools/build-payload.py          ← payload.asset 由此生成
6. 打 APK                ./gradlew assembleRelease               ← 需要 P1 资源 + P2 Java
7. 签名                  apksigner sign --v1-signing-enabled true --v2-signing-enabled true
```

每步的产物都要过 §5 校验，否则说明「重建不等于原包」。

---

## §5 校验表（构建后必须逐项对得上）

| 项 | 基线值 |
|---|---|
| `payload.asset` 长度 | 137,118,068 B |
| `payload.asset` 内条目数 | 5,096（lib 2,693 / app 2,323 / bin 57 / usr 7 / etc 6 / 其余 10） |
| `classes.dex` / `classes2.dex` | 98,744 B / 37,212 B |
| `resources.arsc` | 2,440 B |
| `res/` 条目 | 11 |
| `cortico/dist/web` | 9 文件，与 `asset-manifest.json` 一致 |
| `vendor/pet/dist/console.js` | 生成后 2 行 / 9,793 + 35 字符 |

---

## §6 与 `v12.71-baseline` 的关系

1. **已发布基线里混进了 10 个构建产物**（`cortico/dist/web` 8 + `vendor/pet/dist` 2，共 928,872 B），按本政策移除，改由构建链生成。
2. **`src/recovered/` 的 259 个 `.ts` 属上游代码**。P0 对账完成后按结果收缩：与上游 tag 逐字节相同的文件不再入库，只留 `patches/` + 自研文件清单。预计仓库从 18.8 MiB 降到 2 MB 量级。
3. 移除/收缩都是**可回退的**：`git checkout v12.71-baseline -- <path>` 即可取回。