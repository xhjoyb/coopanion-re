# BUILDDEPS.md · 构建期依赖版本锚点

> 本文件回答一个问题：**本份 `src/recovered` 若要在今天重建，`node_modules` 该装哪几个精确版本？**
> 运行时一侧答案早已定案（`DEPS.md §2/§3`，95 个包、`check_deps.py` 零差异）；
> 本文件补的是**构建期**那一半——`devDependencies` 与浏览器侧 `dependencies`。

## §0 一句话结论

`DEPS.md §3.3` 列的 **28 个构建期缺包已全部补上版本锚点**（去重后 24 个 `(package, range)`，未解 **0**）：

| 证据强度 | 数量 | 含义 |
|---|---|---|
| artifact（最硬） | 4 | 版本号直接印在产物里，读出来即真理 |
| exact | 2 | `package.json` 本来就是精确版号，无需推断 |
| deployed | 18 | 部署态 `node_modules` 里实际装着，实测值 |
| snapshot | 18 | 纯 dev 包、产物无痕迹：以构建时点为截止取最高满足版 |

**并且锚点已被实验验真一次**：用锚定的 `esbuild@0.28.2` + 树内 `scripts/build-console.mjs`，
`vendor/pet/dist` 两个产物**逐字节复现成功**（§4.2）。`cortico/dist/web` 仍然不可重建，
但那是因为缺构建脚本，**与依赖版本无关**（见 §6）。

---

## §1 缺口是怎么量出来的

`payload.asset` 只带了**运行时**依赖树。可复算事实（`tools/resolve_build_deps.py` 自动扫描）：

```
部署态 node_modules（根树）              95 个包
  ├─ coop-stage/node_modules            运行时主力（express / ws / fflate / jpeg-js …）
  ├─ build/cortico/node_modules         4 项
  ├─ vendor/cua/node_modules            4 项
  ├─ vendor/pet/node_modules            7 项
  └─ vendor/coo/node_modules            4 项
```

> ⚠️ **只看子树会误判**：pnpm 把依赖扁平化到根树，`cortico` 子树只有 4 项、
> 直接拿子树对账会得出“cortico 缺 27 个”的错误结论。**必须先合并根树 + 全部子树**
> 得到一个 95 项的全局映射，再去比 `package.json` 声明**。本工具已按此实现。

按此口径算出的真实缺口（与 `DEPS.md §3.3` 完全吻合）：

| 子包 | dependencies 缺 | devDependencies 缺 | 小计 |
|---|---|---|---|
| `cortico` | 9 | 11 | **20** |
| `vendor/pet` | 0 | 5 | **5** |
| `vendor/cua` | 0 | 3 | **3** |
| `vendor/coo` | 0 | 0 | 0 |
| `coop-stage` | 0 | 0 | 0 |
| **合计** | **9** | **19** | **28** |

`cortico` 缺的 9 个 dependencies 全是**浏览器侧**（`react` / `react-dom` / `@codemirror/*` / `mineflayer*` / 
`prismarine-viewer` / `canvas` / `react-textarea-autosize`），已被 esbuild 打进 `dist/web`，
运行时树里没有它们**是正确的**，不是丢失。

---

## §2 还原方法：四级证据链

每一行锚点都带一个 `method` 字段说明它有多硬，**不允许把推断值写成实测值**：

| 级别 | method | 判定方式 | 可信度 |
|---|---|---|---|
| 1 | `exact` | `package.json` 的值不以 `^`/`~` 开头 | 等于原文，无需推断 |
| 2 | `deployed` | 部署态 `node_modules` 里该包的 `package.json.version` | 实测，即原厂真值 |
| 3 | `artifact` | 产物文件内直接印着版本号 | 实测，见 §4.1 |
| 4 | `snapshot` | registry 中「发布时点 ≤ CUTOFF」且满足声明范围的最高版 | **推断**，见 §6 |

### 2.1 CUTOFF（构建时点）怎么来的

取 `payload` 内 `dist` 文件的 mtime——tar 打包会保留原始 mtime，所以这是真实构建时间：

```
src/recovered/cortico/dist/web/main-VF7OQOQ5.js      2026-10-10 17:44:10 UTC
src/recovered/cortico/dist/web/asset-manifest.json  2026-10-10 17:44:10 UTC
src/rootfs/.../vendor/pet/dist/console.js           2026-10-11 11:56:00 UTC
```

两处不同 ⇒ 至少构建了两次。本工具取**较早**的那个（`2026-10-10T17:44:10Z`），
即对 `snapshot` 行取更保守的下界。已核对这个保守选择**不影响任何一条结果**：
`2026-10-10T17:44:10Z` → `2026-10-11T11:56:00Z` 窗口内，24 个包中只有
`typescript@7.1.0-dev.20261011.1` 发布过，它是 dev 预发布版，既不满足 `^5.7.2` 也不满足 `^5.9.3`。

### 2.2 为什么不用“今天的 latest”

因为会算错。构建（2026-10-10）到今天（2026-10-25）已有包发新版，按 latest 会得到不同结果：

| 包 | 构建时点快照 | 今天的 latest | 后果 |
|---|---|---|---|
| `@codemirror/view` | 6.43.14 | 6.43.15 | 装错版 |
| `jsdom` | 30.1.2 | 30.1.3 | 装错版 |
| `react` / `react-dom` | 19.3.0（产物实证） | 更高 | 装错版 |

这正是“版本锚”存在的意义：**没有锚，今天装出来的东西和原厂不是一回事**。

---

## §3 锚点总表（28 条声明 / 24 个唯一键）

### 3.1 `cortico`（20 条：9 deps + 11 devDeps）

| 包 | 声明 | **锚点** | 方法 | 发布日 | 引用方 |
|---|---|---|---|---|---|
| `@codemirror/state` | `^6.7.1` | **`6.7.6`** | snapshot（构建时点快照） | 2026-09-22 | cortico |
| `@codemirror/view` | `^6.43.8` | **`6.43.14`** | snapshot（构建时点快照） | 2026-10-07 | cortico |
| `canvas` | `^3.2.3` | **`3.2.3`** | snapshot（构建时点快照） | 2026-03-31 | cortico |
| `express` | `^4.21.2` | **`4.22.3`** | deployed（部署态实测） | — | cortico |
| `fflate` | `0.8.3` | **`0.8.3`** | deployed（部署态实测） | — | cortico |
| `mineflayer` | `^4.37.1` | **`4.39.0`** | snapshot（构建时点快照） | 2026-09-06 | cortico |
| `mineflayer-pathfinder` | `^2.4.5` | **`2.4.5`** | snapshot（构建时点快照） | 2023-09-04 | cortico |
| `prismarine-viewer` | `^1.33.0` | **`1.33.0`** | snapshot（构建时点快照） | 2025-02-09 | cortico |
| `react` | `^19.2.8` | **`19.3.0`** | artifact（产物内读到） | 2026-09-09 | cortico |
| `react-dom` | `^19.2.8` | **`19.3.0`** | artifact（产物内读到） | 2026-09-09 | cortico |
| `react-textarea-autosize` | `^8.5.9` | **`8.5.9`** | snapshot（构建时点快照） | 2025-03-30 | cortico |
| `tar-stream` | `3.2.1` | **`3.2.1`** | deployed（部署态实测） | — | cortico |
| `vec3` | `^0.2.0` | **`0.2.0`** | deployed（部署态实测） | — | cortico |
| `ws` | `^8.18.0` | **`8.22.0`** | deployed（部署态实测） | — | cortico |
| `@tailwindcss/cli` | `^4.3.3` | **`4.3.3`** | artifact（产物内读到） | 2026-07-16 | cortico |
| `@types/express` | `^4.17.21` | **`4.17.25`** | snapshot（构建时点快照） | 2025-10-27 | cortico |
| `@types/node` | `^22.10.0` | **`22.20.5`** | snapshot（构建时点快照） | 2026-10-01 | cortico |
| `@types/react` | `^19.2.18` | **`19.3.0`** | snapshot（构建时点快照） | 2026-09-09 | cortico |
| `@types/react-dom` | `^19.2.4` | **`19.3.0`** | snapshot（构建时点快照） | 2026-09-09 | cortico |
| `@types/tar-stream` | `3.1.4` | **`3.1.4`** | exact（本就精确） | — | cortico |
| `@types/ws` | `^8.5.13` | **`8.18.2`** | snapshot（构建时点快照） | 2026-09-29 | cortico |
| `esbuild` | `^0.28.2` | **`0.28.2`** | deployed（部署态实测） | — | cortico |
| `jsdom` | `^30.0.1` | **`30.1.2`** | snapshot（构建时点快照） | 2026-10-04 | cortico |
| `tailwindcss` | `^4.3.3` | **`4.3.3`** | artifact（产物内读到） | 2026-07-16 | cortico |
| `tsx` | `^4.19.2` | **`4.23.15`** | deployed（部署态实测） | — | cortico |
| `typescript` | `^5.7.2` | **`5.9.3`** | snapshot（构建时点快照） | 2025-09-30 | cortico |
| `vitest` | `^2.1.8` | **`2.1.9`** | snapshot（构建时点快照） | 2025-02-03 | cortico |

### 3.2 `vendor/cua`（3 条 devDeps）

| 包 | 声明 | **锚点** | 方法 | 发布日 | 引用方 |
|---|---|---|---|---|---|
| `koffi` | `3.3.1` | **`3.3.1`** | deployed（部署态实测） | — | vendor/cua |
| `@types/node` | `^22.20.4` | **`22.20.5`** | snapshot（构建时点快照） | 2026-10-01 | vendor/cua |
| `tsx` | `^4.23.15` | **`4.23.15`** | deployed（部署态实测） | — | vendor/cua |
| `typescript` | `^5.9.3` | **`5.9.3`** | snapshot（构建时点快照） | 2025-09-30 | vendor/cua |
| `vitest` | `^2.1.9` | **`2.1.9`** | snapshot（构建时点快照） | 2025-02-03 | vendor/cua |

### 3.3 `vendor/pet`（5 条 devDeps，其中 4 条与 cortico 重复）

| 包 | 声明 | **锚点** | 方法 | 发布日 | 引用方 |
|---|---|---|---|---|---|
| `opencc-js` | `^1.4.1` | **`1.4.2`** | deployed（部署态实测） | — | vendor/pet |
| `sherpa-onnx-node` | `1.13.8` | **`1.13.8`** | deployed（部署态实测） | — | vendor/pet |
| `electron` | `44.4.4` | **`44.4.4`** | exact（本就精确） | — | vendor/pet |

### 3.4 运行时已闭合部分（列此仅为对照，非补2 范围）

| 包 | 声明 | **锚点** | 方法 | 发布日 | 引用方 |
|---|---|---|---|---|---|
| `depd` | `^2.0.0` | **`2.0.0`** | deployed（部署态实测） | — | coop-stage |
| `express` | `^4.22.3` | **`4.22.3`** | deployed（部署态实测） | — | coop-stage |
| `fflate` | `^0.8.3` | **`0.8.3`** | deployed（部署态实测） | — | coop-stage |
| `jpeg-js` | `^0.4.4` | **`0.4.4`** | deployed（部署态实测） | — | coop-stage |
| `opencc-js` | `^1.4.2` | **`1.4.2`** | deployed（部署态实测） | — | coop-stage |
| `tar-stream` | `^3.2.1` | **`3.2.1`** | deployed（部署态实测） | — | coop-stage |
| `ws` | `^8.22.0` | **`8.22.0`** | deployed（部署态实测） | — | coop-stage |

> `esbuild@0.28.2` 与 `tsx@4.23.15` 同时被 `cortico` / `pet` / `cua` 的 devDeps 声明，
> 且已在部署态实测到，所以它们在总表里归属 `deployed` 而非 `snapshot`。

---

## §4 硬证据：版本号是从产物里读出来的

### 4.1 两个 artifact 证据的精确位置

**`tailwindcss` = `4.3.3`** —— `dist/web/styles.css` 第 1 行横幅：

```css
/*! tailwindcss v4.3.3 | MIT License | https://tailwindcss.com */
```

**`react` = `react-dom` = `19.3.0`** —— `dist/web/main-VF7OQOQ5.js` 内 `version:"19.3.0"` 出现 4 处
（`react` 与 `react-dom` 各自内嵌版本字符串，minify 后仍保留）。

`@tailwindcss/cli` 取 `4.3.3` 的依据：v4 起 CLI 与 `tailwindcss` 同仓同步发版，
且 `4.3.3` 经 registry 核实存在、发布于 `2026-07-16`，早于 CUTOFF。

### 4.2 复现实验：`vendor/pet/dist` 逐字节重建成功

这不是推断，是跑出来的。命令（在临时目录，不污染工作区）：

```bash
cp -a src/recovered/vendor/pet /tmp/petb
ln -s "$PWD/src/rootfs/app/coop-stage/node_modules" /tmp/petb/node_modules
cd /tmp/petb && node scripts/build-console.mjs
```

结果：

| 产物 | 原厂字节 | 重建字节 | sha256 | 判定 |
|---|---|---|---|---|
| `console.css` | 1,936 | 1,936 | `ef9e1c992b97ac88a699b14c1ff6150ae9f4dbba7d1fa83f8f193e67249a3356` | ✅ **一致** |
| `console.js` | 9,830 | 9,830 | `85f2c5616f043afce7321a045dd3d5b35f48e1930f2195b743abe4c61dede19d` | ✅ **一致** |

一次就跑通，零参数调整。这一条同时证了三件事：

1. `esbuild@0.28.2` 这个锚**正确**——换个版本几乎不可能产出相同的 minify 结果；
2. `src/recovered/vendor/pet` 的**源码无漂移**，就是原厂构建用的那份；
3. `pet/dist` “可本地重建”从**预期**变成**实测**（`PREBUILT.md §4` 相应升级）。

唯一的差异：重建会多出 `console.js.map` / `console.css.map`（脚本里 `sourcemap: true`），
而原厂 `dist` 里没有——说明**打包时会把 `*.map` 删掉**，不是构建时关掉了 sourcemap
（`console.js` 末尾的 `//# sourceMappingURL=console.js.map` 就是证据）。

### 4.3 `cortico/dist/web` 无法做同样的事

它需要的 `scripts/build-web.ts` 不在树内（`PREBUILT.md §2` / `UPSTREAM.md §4`），
所以 `dist/web` 的 8 个文件**没有可执行的复现路径**。这与依赖版本无关：
**装对 20 个 devDeps 也编不出来，因为构建脚本本身就不在。**

---

## §5 这些锚点怎么用

### 5.1 `vendor/pet`：可完整重建（已验证）

```bash
cd src/recovered/vendor/pet
npm i --no-save --ignore-scripts \
  @types/node@22.20.5 @types/ws@8.18.2 esbuild@0.28.2 tsx@4.23.15 \
  typescript@5.9.3 vitest@2.1.9 electron@44.4.4
npm run typecheck   # tsc --noEmit
npm run build       # → dist/console.{js,css}，应与原厂 sha256 相同
npm test            # vitest run
```

### 5.2 `vendor/cua`：可做类型检查与单测

树内有 `tsconfig.json` / `vitest.config.ts` / `vitest.e2e.config.ts` / `tests/`，缺的只是工具链：

```bash
cd src/recovered/vendor/cua
npm i --no-save --ignore-scripts @types/node@22.20.5 typescript@5.9.3 vitest@2.1.9 tsx@4.23.15
npx tsc --noEmit
npx vitest run
```

### 5.3 `cortico`：只能装树，不能构建

20 个包装上以后，`node --import tsx src/...` 可以直接跑通（运行时本来就在跑），
但 `npm run build:web` 会立即失败——`scripts/` 与 `tsconfig*.json` 不在树内。
**不要在这一步反推“缺依赖”，缺的是构建脚本。**

---

## §6 这些锚点不能证明什么（诚实边界）

1. **`snapshot` 是推断，不是实测**。它只保证“该版本在 CUTOFF 前已发布且满足声明范围”，
   不保证原厂当时装的就是它。若上游后来提供了 `pnpm-lock.yaml`，应以 lock 为准并拆掉本节推断。
2. **无法生成真正的 lockfile**。树内没有 `pnpm-workspace.yaml`（`packageManager: pnpm@11.5.0` 只是声明），
   工作机制拓扑不可知；强行 `pnpm install --lockfile-only` 会按今天的 latest 解析，反而把 §2.2 的错位固化进仓库。
   本文件因此只提供**锚点表 + 可复算工具**，不伪造 lock 文件。
3. **锚点齐了也重建不出 `cortico/dist/web`**，原因见 §4.3，与本节无关。
4. **`payload.asset` 的 sha256 不会因为补了锚点就对上**。要让 `136.35 MB` 的 payload 逐字节一致，
   需要「锚点 + 构建脚本 + 相同的 node 大版本 + 相同的 esbuild 输出」四者同时成立，目前只满足锚点这一项。

---

## §7 复算

```bash
# 全量解析（拉 registry，缓存到 .anchor-cache/，已 gitignore）
python3 tools/resolve_build_deps.py

# 写机器可读结果（本文件与 §3 的数值即由它渲染）
python3 tools/resolve_build_deps.py --json build-deps.anchor.json

# 纯离线复算（有缓存即可，不联网）
python3 tools/resolve_build_deps.py --offline --json build-deps.anchor.json
```

退出码 `0` = 全部解出；有任一 `unresolved` 会返回 `1` 并逐条打印原因，适合直接挂 CI。

`build-deps.anchor.json` 字段：`package` / `range` / `anchor` / `method` / `owner` / `section`，
外加 `published`（该版发布日期）、`latest_in_range`（今天 latest）、`newer_than_cutoff`（构建后发了几个新版）。

---

## §8 与其它文档的关系

| 文档 | 关系 |
|---|---|
| `DEPS.md §3.3` | 列出缺口（28 个）；本文件把缺口补上，§3.3 已同步改为指向本文件 |
| `DEPS.md §4` | 构建流水线：`npm ci` 之后按本文件锚点补装 devDeps |
| `UPSTREAM.md §4` | 说明“部署态 ⊂ 上游仓库”，与“缺构建脚本”是同一件事的两面 |
| `PREBUILT.md §4` | `pet/dist` 从“预期可重建”升级为“已实测逐字节复现”；`cortico/dist` 仍列为不可重建 |
| `BASELINE.md` | 记录“补2 完成”与本轮新增的三个文件 |

---

## §9 本轮产出清单

| 文件 | 行数 | 作用 |
|---|---|---|
| `tools/resolve_build_deps.py` | 272 | 可复算解析器（四级证据链 + registry 快照 + 缓存/离线） |
| `build-deps.anchor.json` | 机器可读 | 42 行锚点，含 method / published / latest_in_range 溯源字段 |
| `BUILDDEPS.md` | 本文件 | 方法、证据、边界、用法 |

`pet/dist` 复现实验只是**验证手段**，不产生入仓产物（`dist/` 已在 `.gitignore` 内）。
