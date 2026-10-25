# UPSTREAM — 上游锚点与「本份源码」身份

> **一句话**：本仓库的 `src/recovered/` 是 **APK 部署态的逐字节副本**（862/862 对账通过），
> 不是逆向还原、也不是上游 git 快照。因此它 **等于原厂发出去的那份代码**，
> 但 **不等于原厂 git 仓库** —— 构建必需件（`bin/`、`scripts/`、`tsconfig*`）**不在 APK 里**，只能从上游 clone。

本文回答三个问题：**这是谁的代码、是哪一版、还差哪个文件得去上游拿。**

---

## 1. 上游身份

| 项 | 值 | 来源 |
|---|---|---|
| 上游仓库 | `https://github.com/Pal-AI-Lab/Cortico.git` | `cortico/package.json` → `repository.url` |
| 许可证 | MIT | `cortico/LICENSE` |
| 版权人 | **Copyright (c) 2026 Phantivia** | `cortico/LICENSE:3` |
| 框架描述 | A TypeScript framework for event-driven, long-running persona bots | `package.json` → `description` |
| 包管理器 | `pnpm@11.5.0` | `package.json` → `packageManager` |
| Node 要求 | `>=22` | `package.json` → `engines.node` |

> ⚠️ `DEPS.md` 原先把上游写成 `Pal-AI-Lab/Coopanion`。**以本表为准**：`cortico/package.json` 里写的是
> `Pal-AI-Lab/Cortico`；`Coopanion` 是这层 Android 移植（APK 名）的名字，不是上游框架名。

## 2. 版本锚点（逐包）

这四个版本号是「本份源码 = 上游哪一代」的**唯一可核对坐标**，全部读自各包 `package.json`：

| 包名 | `name` | `version` | 路径 |
|---|---|---|---|
| 框架本体 | `cortico` | **0.1.5** | `src/recovered/cortico/package.json` |
| Android 壳 | `coop-android` | **0.1.6** | `src/recovered/coop-stage/package.json` |
| 协作 provider | `cortico-provider-coo` | **0.2.0** | `src/recovered/vendor/coo/package.json` |
| 电脑操作世界 | `cortico-world-cua` | **0.1.2** | `src/recovered/vendor/cua/package.json` |
| 桌宠世界 | `cortico-world-desktop-pet` | **0.1.4** | `src/recovered/vendor/pet/package.json` |

**为什么没有 commit sha**：本环境 `github.com:443` 不通（`api.github.com` 可达），无法在逆向阶段 `git ls-remote`
取 tag→sha 映射。补齐方式见 §6。在此之前，用 §3 的**树指纹**做等价性核对 —— 它比 tag 更严（逐文件 sha256）。

## 3. 树指纹（本份源码的唯一标识）

对 `src/recovered/` **全树**按相对路径排序，串联 `path\0sha256\n` 后再取 sha256：

```
files = 863
bytes = 16,350,953
TREE  = fd419624741071da4c7ce634ee784d4ab60c86c01e717e30dc3665f30248b6b9
```

复算方法（`.git`/`node_modules`/`__pycache__` 排除）：

```bash
python3 - <<'PY'
import os, hashlib
R, rows = 'src/recovered', []
for dp, dns, fs in os.walk(R):
    dns[:] = [d for d in dns if d not in ('node_modules', '.git', '__pycache__')]
    for f in fs:
        p = os.path.join(dp, f)
        h = hashlib.sha256(open(p, 'rb').read()).hexdigest()
        rows.append((os.path.relpath(p, R).replace(os.sep, '/'), h))
acc = hashlib.sha256()
for rel, h in sorted(rows):
    acc.update((rel + '\0' + h + '\n').encode())
print(len(rows), f'{acc.hexdigest()}')
PY
# → 863 fd419624741071da4c7ce634ee784d4ab60c86c01e717e30dc3665f30248b6b9
```

日后只要能访问上游，`git clone` 到对应 tag、删掉 `bin/ scripts/ tsconfig*` 与 `node_modules` 后算同一指纹，
**相等即证明同版**。这比「看版本号猜 tag」可靠。

## 4. 部署态 ⊂ 上游仓库：哪些文件 APK 里没有

这是本文最实用的一节。`cortico/package.json` 的 `scripts` 引用了若干文件，但它们在
**APK 里和 `src/recovered/` 里都不存在**（部署态只带「能跑的最小集」）：

| 缺失项 | 被谁引用 | 影响 |
|---|---|---|
| `bin/cortico.mjs` | `scripts.start` = `node bin/cortico.mjs` | `pnpm start` 跑不了；实际由 `coop-stage/run-core.mjs` + `boot.sh` 代跑 |
| `scripts/build-web.ts` | `scripts.build:web` = `tsx scripts/build-web.ts` | **`dist/web` 无法从本地源码重建**（核心阻塞） |
| `tsconfig.json` / `tsconfig.web.json` | `scripts.typecheck` / `typecheck:web` | 类型检查跑不了 |
| `tailwind.config.*` | `build:web` 的 `tailwindcss -i src/web/public/styles.css` | 样式重建跑不了 |
| `src/launcher.ts` | `scripts.bots` = `tsx src/launcher.ts --list` | bot 列举跑不了 |

**结论（重要）**：`src/recovered` 是 **可阅读、可修改、可运行**的源码树，但**不是可构建的仓库**。
「补齐 devDeps 版本锚」（P2）只能让 `node_modules` 可复现，**不能让 `dist/web` 从源码重建** ——
后者必须先拿到上游的 `scripts/` 与 `tsconfig*`。两件事不要混为一谈。

`vendor/pet` 是例外：它有 `scripts.build`，且 `node scripts/build-console.mjs` 的依赖在树内齐备（见 `DEPS.md §3.3`），
是唯一能本地重建 dist 的包。

## 5. 为什么没有 `patches/`

`DEPS.md` 三处（第 29 / 126 / 127 / 157 行）提到 `git apply patches/*.patch` 与「只留 patches + 自研清单」。
**实测结论：`patches/` 目录不存在，且不需要存在。**

依据：`tools/recon_upstream.py` 五组映射逐文件 sha256 对账 —

```
[OK] stage-root   both=57   same=57   diff=0 only_rec=0 only_run=0
[OK] cortico      both=226  same=226  diff=0 only_rec=0 only_run=0
[OK] vendor/coo   both=8    same=8    diff=0 only_rec=0 only_run=0
[OK] vendor/cua   both=30   same=30   diff=0 only_rec=0 only_run=0
[OK] vendor/pet   both=541  same=541  diff=0 only_rec=0 only_run=0
合计 862/862 相同
```

部署态与入仓源码**零差异**，也就不存在「本地改动」需要打成 patch。
`patches/` 是为「本地魔改过上游代码」准备的容器；本样本没改，所以它是空集而非遗漏。

> 若未来对 `src/recovered/` 做了修改并需要区分「原厂 / 我改的」，那时才需要建 `patches/`。
> 在此之前请勿创建空目录假装存在。

## 6. 补 commit sha 的操作步骤（待网络条件允许）

```bash
# 1) 取 tag 与 sha（本环境 github.com:443 不通，需代理 / SSH over 443 或换环境）
git ls-remote --tags https://github.com/Pal-AI-Lab/Cortico.git | grep -E '0\.1\.5|0\.1\.6'

# 2) clone 到临时目录，核对 §3 树指纹
git clone --depth 1 --branch <tag> https://github.com/Pal-AI-Lab/Cortico.git /tmp/up
#    删 bin/ scripts/ tsconfig* node_modules 后按 §3 复算，应与 fd419624… 相等

# 3) 把 bin/ scripts/ tsconfig* tailwind.config.* src/launcher.ts 拷入 src/recovered/cortico/
#    并在本文件补一行 tag + commit sha
```

## 7. 已知未对账项（诚实披露）

`coop-stage/` 实际有 **58** 个文件，但 `recon_upstream.py` 的 `STAGE_SUBSET` 只列了
`package.json` / `package-lock.json` / `run-core.mjs` / `app` / `home` 五项 → 覆盖 **57** 个。

| 文件 | 字节 | 状态 |
|---|---|---|
| `coop-stage/boot.sh` | 3,190 | **未纳入对账**（内容存在且已入仓，只是没被 sha256 比对） |

这也是「全树 863 文件」与「对账 862」相差 1 的原因。
`boot.sh` 恰是 P5 待办里提到 `:52 PKG-ABS` 硬编码的文件，**建议把 `boot.sh` 加入 `STAGE_SUBSET`**（一行改动），
让对账覆盖 863/863。本轮未改工具，先在此登记。

## 8. 快速自检

```bash
python3 tools/recon_upstream.py            # → 862/862，exit 0
python3 tools/recon_upstream.py --json     # 机器读
```

参见：`DEPS.md`（依赖三分法）、`PREBUILT.md`（二进制清单）、`BASELINE.md §P0`（对账验收记录）。
