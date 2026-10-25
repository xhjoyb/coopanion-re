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
| `src/rootfs/…/coop-stage/node_modules/` | **119.2 MB / 95 个顶层条目**（= 91 个包 + 4 个本地软链；直接依赖 8 个） | 可下载依赖 | `npm ci` + 补装 5 个 lock 外真实包 + 4 条 `ln -s`（见 §3.1） | `tools/check_deps.py`（见 §3.2） |
| `src/recovered/cortico/dist/web/` | 8 文件 / **917,106 B**（esbuild 打包产物） | 构建产物 | `pnpm --filter cortico build:web`（`tsx scripts/build-web.ts` + tailwindcli） | asset-manifest 对齐 |
| `src/recovered/vendor/pet/dist/` | 2 文件 / **11,766 B**（`console.js` 单行 9,793 字符，已压缩） | 构建产物 | `npm run build`（`node scripts/build-console.mjs`） | 同上 |
| `sherpa-onnx-linux-arm64`（`sherpa-onnx.node` + 3 个 `.so`，40.3 MB） | 部署态存 **2 份**：顶层 1 份（7 文件）+ `sherpa-onnx-node/node_modules/` 下 1 份（仅 4 个 native，无 `README/index.js/package.json`） | 可下载依赖 | 随 `sherpa-onnx-node@1.13.8` 安装后手工补嵌套那 4 个 native（见 §3.1） | 版本 1.13.8 |
| `assets/payload.asset` | **137,118,068 B** | 构建产物 | `python3 tools/build-payload.py`（确定性 gzip+tar） | 长度 + sha256 |
| `apk/*.apk`、`mcp_out/*.apk` | 各 ~137 MB | 构建产物 / 发行物 | `./gradlew assembleRelease` 或原厂发行物 | md5 `ed319932…e00b1` |
| 上游 `Pal-AI-Lab/Cortico` 源码树 | 41 MB | 可下载依赖 | `git clone` 指定 tag（**已有锚点：版本号 + 树指纹，见 `UPSTREAM.md §1 §2 §3`**） | tag + commit sha（待补，见 `UPSTREAM.md §6`） |

### 例外：唯一必须进仓库的二进制

**`src/x/lib/arm64-v8a/`** 下 5 个 `.so`（APK 内路径为 `lib/arm64-v8a/`，共 **388,758 B**）：`libproot.so`(264,105) / `libandroid-shmem.so`(66,681) / `libtalloc.so`(33,592) / `libprootloader.so`(18,136) / `libprootloader32.so`(6,244)。

理由：它们是这层 Android 移植**独有**的资产，公开源里没有现成 aarch64 产物，重建需要 NDK 工具链。体量小（380 KB），按「不可用一条命令复原」保留。**实测 5/5 与 APK 内逐字节相同**；逐文件 sha256 见 `PREBUILT.md §1`。

---

## §3 可复现性现状（运行时已闭合，构建期已补版本锚）

先摆结论，因为它**推翻了本文件早前「补齐 4 个缺失 lock」的假设**：

| 层面 | 状态 | 依据 |
|---|---|---|
| **运行时依赖**（payload 真正加载的） | ✅ **已闭合，可 100% 复原** | 两条命令复原出 95 个顶层条目，与部署态**包清单 / 版本 / 体积全同**（`tools/check_deps.py` → `EXIT=0`，0 处差异） |
| **运行时的 lock** | ✅ **不缺，且是部署态的严格子集** | 入仓 `package-lock.json` 与部署态那份 sha256 同为 `ab11e9882cdeb2252a572103879a4390df13e6db660ba9472a05d8e7feff7600`；lock 内 84 包 vs 磁盘 95 条目 = **缺 9、多 0** |
| **构建期依赖**（重建 `dist/` 用） | ⚠️ **已补版本锚、仍无 lock** | 28 个缺包全部锁定（24 个唯一键），见 §3.3 / `BUILDDEPS.md` |

### 3.1 子包不需要独立 lock（已证伪「补 4 个 lock」）

`src/recovered/` 有 5 个 `package.json`、却只有 1 个 lock。四个子包（`cortico` / `vendor/{coo,cua,pet}`）之所以没有独立 lock，是因为**它们的 `node_modules` 只是 stage 根的同源复制**，不是各自独立安装的：

| 指纹 | 位置 | sha256 前 16 位 |
|---|---|---|
| `package-lock.json` | 入仓 ↔ 部署态 | `ab11e9882cdeb225`（全同） |
| `jpeg-js@0.4.4` | stage 根 / `vendor/cua` / `vendor/pet` 三处 | `0c3f17f5209104f4`（全同） |
| `ws@8.22.0` | stage 根 / `vendor/coo` 两处 | `21ae3727f788533f`（全同） |

另：`vendor/coo` 的 `package.json` **没有任何 dependencies**（只有 `scripts`），本就无需 lock；`cortico` 的 `packageManager` 声明是 `pnpm@11.5.0`，但部署态并不是 pnpm 布局（无 `.pnpm`、无 `node_modules/.modules.yaml`），而是扁平 npm 布局。

### 3.2 运行时依赖复原配方（实测等价）

```bash
cd <stage 根>          # 布局：package.json / package-lock.json / run-core.mjs / app/ / home/
                       #       + build/cortico + vendor/{coo,cua,pet} + node_modules/
                       # 仓库里 build/cortico = src/recovered/cortico，
                       # vendor/* = src/recovered/vendor/*；由 build-payload.py 拼成该布局（P4）

# ① lock 内 84 个包（2–4 s）
npm ci --ignore-scripts

# ② lock 外的 5 个真实包（16 s，必须一次装完）
npm i --no-save --ignore-scripts \
  esbuild@0.28.2 koffi@3.3.1 tsx@4.23.15 \
  sherpa-onnx-node@1.13.8 sherpa-onnx-linux-arm64@1.13.8

# ③ 补 esbuild 的真二进制（--ignore-scripts 跳过了它的 postinstall）
node node_modules/esbuild/install.js

# ④ 4 条本地包软链（npm 不会创建，目标路径是部署态 stage 根的相对布局）
cd node_modules
ln -sfn ../build/cortico   cortico
ln -sfn ../vendor/coo      cortico-provider-coo
ln -sfn ../vendor/cua      cortico-world-cua
ln -sfn ../vendor/pet      cortico-world-desktop-pet
cd ..

# ⑤ 补 sherpa 的嵌套 native（部署态存了第二份，只含 4 个二进制，不含 README/index.js/package.json）
d=node_modules/sherpa-onnx-node/node_modules/sherpa-onnx-linux-arm64
mkdir -p "$d"
cp -f node_modules/sherpa-onnx-linux-arm64/libonnxruntime.so \
      node_modules/sherpa-onnx-linux-arm64/libsherpa-onnx-c-api.so \
      node_modules/sherpa-onnx-linux-arm64/libsherpa-onnx-cxx-api.so \
      node_modules/sherpa-onnx-linux-arm64/sherpa-onnx.node "$d"/
```

**实测结果**：95 个顶层条目 / 70.9 MB，`tools/check_deps.py` 判定「包清单 / 版本 / 体积全部一致」，**0 处差异、0 条备注**。

几处反直觉、但必须照做的点：

1. **步骤顺序不能反**。`npm i --no-save <pkg>` 会按 `package.json` + 本次入参**剪掉**其余多余包；若先补装外包再跑 `npm ci`，或中间插一次单包 `npm i`，5 个外包会被清空（实测树从 91 掉回 85）。
2. **`--ignore-scripts` 是刻意保留的**。lock 内 84 个包 `hasInstallScript` 全为空；5 个外包里 `esbuild` 有 `postinstall`、`koffi` 有 `install`（`node ./cnoke.cjs … --release`，会尝试本机编译 native）。跳过 `koffi` 的 install 是**必需**的（`@koromix/koffi-linux-arm64` 自带预编译件，实测 `require('koffi')` 正常）；跳过 `esbuild` 的 postinstall 只影响 CLI 可执行文件，需按 ③ 显式补回。
3. **`tsx` 是运行时依赖，不是构建工具**。`boot.sh` 末行 `exec /bin/node --import tsx run-core.mjs`，而 `run-core.mjs` 结尾直接 `await import('app/core/boot.ts')` —— 加载 `.ts` 全靠 tsx 的 loader。它绝不能按「devDependencies 不入库」处理。
4. **proot 环境会污染依赖树**：`--link2symlink` 把硬链接模拟成 `.l2s.<name>` 真文件 + 同名软链，删除时 `rm` 会报 `Operation not permitted`（须用 `unlink`）。所以在 proot 里装出来的 `node_modules` **只能用于等价性验证，不能当交付物**；P4 若在 proot 内构建 payload，必须在打包 `tar` 时排除 `.l2s.*`，或改用真 Linux/CI。

### 3.3 构建期依赖：已补版本锚（P4 前置完成）

把 4 个子包的 `package.json` 声明与部署态运行时树逐项对账，缺失项全部落在「构建/测试」一侧：

| 子包 | dependencies | devDependencies | 缺失明细 |
|---|---|---|---|
| `cortico` | 14（缺 9） | 13（缺 11） | 缺的 9 个 dependencies 是**浏览器侧**（`react`/`react-dom`/`@codemirror/*`/`mineflayer`/`mineflayer-pathfinder`/`prismarine-viewer`/`canvas`/`react-textarea-autosize`），已被 esbuild 打进 `dist/web`，运行时树里没有它们**是正确的**；缺的 11 个 devDeps 是 `@tailwindcss/cli`、`tailwindcss`、`typescript`、`vitest`、`jsdom`、`@types/*` |
| `vendor/pet` | 4（**全齐**） | 7（缺 5） | 缺 `electron`、`typescript`、`vitest`、`@types/node`、`@types/ws` |
| `vendor/cua` | 2（**全齐**） | 4（缺 3） | 缺 `typescript`、`vitest`、`@types/node` |
| `vendor/coo` | 0 | 0 | — |

**含义（已更新）**：运行时依赖可一键复原；构建期那 28 个缺包已在 `BUILDDEPS.md` 里全部锚定。两个原先混在一起的事实现已拆开：

1. `vendor/pet/dist` —— **可重建，且已实测**：用锚定的 `esbuild@0.28.2` 跑树内 `scripts/build-console.mjs`，两个产物**逐字节复现**（`BUILDDEPS.md §4.2`）；
2. `cortico/dist/web`（8 文件 / 917,106 B）—— **仍不可重建**，但原因**不是缺依赖锚**，而是 `scripts/build-web.ts` / `tsconfig*.json` / `bin/cortico.mjs` 不在 APK 内（`UPSTREAM.md §4`）。装对 20 个 devDeps 也编不出来。

**已执行的处置**（原计划三条路都不适用，改走第四种）：上游 `pnpm-lock.yaml` 不在树内；`pnpm install --lockfile-only` 会按**今天**的 latest 解析（与 2026-10-10 的构建时点错位，实测 `@codemirror/view` 已从 6.43.14 发到 6.43.15、`jsdom` 30.1.2 → 30.1.3）；`asset-manifest.json` 里没有版本号。最终改用**四源证据链**：产物内打印的版本（最硬）→ 部署态实测 → `package.json` 原精确值 → 构建时点（`2026-10-10T17:44:10Z`，取自 `dist` 的 mtime）快照。结果：**28 个缺包全部解出，未解 0**，可复算：`python3 tools/resolve_build_deps.py`。

> ⚠️ 仍然 **没有伪造 lock 文件**：树内无 `pnpm-workspace.yaml`，工作机制拓扑不可知，强行生成的 lock 会把“今天的 latest”当真值写死。锚点表（`build-deps.anchor.json`）是更好的选择，因为它逐行带 `method` / `published` 溯源字段。**给锚点≠能让 `payload.asset` 的 sha256 对上**，那还需要构建脚本 + 相同 node 大版本 + 相同 esbuild 输出同时成立。

---

## §4 构建流水线（这些动作只在构建时发生）

```
1. 取上游源码            git clone <upstream> --branch <tag>     ← 不进仓库，靠 UPSTREAM.md 锚点
2. 应用本地改动          （无：实测 863/863 零差异，本样本未改上游代码 —— 见 UPSTREAM.md §5）
3. 装依赖                npm ci --ignore-scripts && npm i --no-save …   ← 运行时见 §3.2；devDeps 按 BUILDDEPS.md 锚点补装
4. 建前端产物            npm --prefix vendor/pet run build   ← ✅ 已实测可逐字节复现
                        pnpm --filter cortico build:web    ← ❌ 缺 scripts/build-web.ts + tsconfig*，本地不可执行
5. 打 payload            python3 tools/build-payload.py          ← payload.asset 由此生成
6. 打 APK                ./gradlew assembleRelease               ← 需要 P1 资源 + P2 Java
7. 签名                  apksigner sign --v1-signing-enabled true --v2-signing-enabled true
```

每步的产物都要过 §5 校验，否则说明「重建不等于原包」。

---

## §5 校验表（构建后必须逐项对得上）

| 项 | 基线值 |
|---|---|
| `node_modules` 依赖树 | 95 个顶层条目（91 包 + 4 软链），`tools/check_deps.py` 与部署态 **0 差异** |
| `payload.asset` 长度 | 137,118,068 B |
| `payload.asset` 内条目数 | 5,096（lib 2,693 / app 2,323 / bin 57 / usr 7 / etc 6 / 其余 10） |
| `classes.dex` / `classes2.dex` | 98,744 B / 37,212 B |
| `resources.arsc` | 2,440 B |
| `res/` 条目 | 11 |
| `cortico/dist/web` | 9 文件，与 `asset-manifest.json` 一致 |
| `vendor/pet/dist/console.js` | 生成后 2 行 / 9,793 + 35 字符 |

---

## §6 与 `v12.71-baseline` 的关系

1. ~~**已发布基线里混进了 10 个构建产物**（`cortico/dist/web` 8 + `vendor/pet/dist` 2，共 928,872 B），按本政策移除，改由构建链生成。~~ **已推翻（P4 前置实测）**：`cortico/dist` 的 `build:web` 依赖 `scripts/build-web.ts`，而该文件**不在 APK 内**（见 `UPSTREAM.md §4`）→ 移除即丢失唯一权威产物。**结论：10 个文件全部保留入仓**，sha256 见 `PREBUILT.md §2 §3`。
2. ~~**`src/recovered/` 的 259 个 `.ts` 属上游代码**。P0 对账完成后按结果收缩：与上游 tag 逐字节相同的文件不再入库，只留 `patches/` + 自研文件清单。~~ **已推翻**：P0 对账的对象是**部署态**（APK 内实际运行的代码），结果 863/863 全同 —— 全树 863 个文件**都是部署态的一部分**，不存在「与上游相同故可删」的冗余。且 `UPSTREAM.md §4` 证明这棵树**缺构建必需件**（`bin/ scripts/ tsconfig*`），删掉 src 只会让仓库更不完整。**结论：不入 `patches/`，不做收缩，仓库体积维持 18.8 MiB 量级。**
3. 移除/收缩都是**可回退的**：`git checkout v12.71-baseline -- <path>` 即可取回。
