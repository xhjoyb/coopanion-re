#!/usr/bin/env python3
# -*- coding: utf-8 -*-
r"""第七轮文档一致性回改：把 v3 工具链的落地结果同步到 `docs/00` / `docs/03` /
`docs/04` / `README.md`，并让「关键数字总表」自己算、不再手抄。

纪律（沿用 patch_docs02 / round2 / round6 的模式）：
  1. 每条 old 必须在全文出现且**仅出现 1 次**，否则整体中止、不写任何文件；
  2. 数字类替换走「期望次数」断言（同一数字可能在正文多处出现）；
  3. 文档行数在**本轮所有结构性修改之后**从内存里数出来再写回，避免「改完数字又变」。

分三段：
  P1  内容替换（结论 / 口径 / 索引行）
  P2  `docs/04 §13` 补齐缺失的工具行（round3/4/5、dump_static_values、round7 自己）
  P3  数字替换（字节数、耗时、文档行数；行数按 P1+P2 之后的实际值）

用法：工程根执行 `python3 src/patch_docs_round7.py`
"""

import os
import sys

ROOT = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))

D00 = 'docs/00-总目录与导读.md'
D03 = 'docs/03-Java与JS桥接协议.md'
D04 = 'docs/04-工具链与复现.md'
RM = 'README.md'

# v3 基线实测值（2026-10 重建，来源见 docs/04 附录）
SZ1 = 449149
SZ2 = 163100
SZCLS = 612228          # 124 个一类一文件的总字节（≠ 合并视图 449,149+163,100=612,249）
T1 = '0.080'
T2 = '0.064'


# ---------------------------------------------------------------- P1 内容替换

P1 = [
    # ---- docs/00 §8.3：五处缺陷表 → v3 结果表
    (D00,
     "### 8.3 工具链的 5 处已知缺陷 + 3 个 TODO\n"
     "\n"
     "| 工具 | 缺陷 | 影响 | 修法（已定位） |\n"
     "|---|---|---|---|\n"
     "| `dex2smali.py` | `22s` 格式寄存器高 8 位没右移 | 会输出 `v136` 这类不可能寄存器号 | `A=(code>>8)&0xff`、`B=(code>>12)&0xf` |\n"
     "| `dex2smali.py` | 少数 `invoke` 成员签名拼错（如 `setTextSize` 缺 `(F)V`） | 只影响签名文本 | 看类名+方法名即可，不必修 |\n"
     "| `dex2smali.py` | 不解析 `packed-switch` / `sparse-switch` 的 payload | case 值与目标地址的映射丢失（本包仅 `VoiceBridge.errName` 命中） | 输出 `:pswitch_data` 块；或按 `04 §5.7` 第 4 条手工核对 |\n"
     "| `read_static.py` | `field_ids` 索引错位 | 字段名错显（`MainActivity` 5 个错成 `packageName`，`EyesService` 6 个错成 `ARGB_8888`），**值本身正确** | 修 `foff+4` 与 `k` 基数 |\n"
     "| `axml.py` | 跳过 `0x0180` resource map | 属性名无 `android:` 前缀 | 解析 resource map 补命名空间 |\n",

     "### 8.3 工具链缺陷：v3 已修 4 处，剩 1 处不影响结论\n"
     "\n"
     "| 工具 | 缺陷 | v3 处理结果 |\n"
     "|---|---|---|\n"
     "| `dex2smali.py` | `22s` 寄存器高 8 位没右移 → 输出 `v136` 这类不可能寄存器号 | **已修**（`A=(unit>>8)&0xf`、`B=(unit>>12)&0xf`）：本包 5 处全部还原 |\n"
     "| `dex2smali.py` | 不解析 `packed-switch` / `sparse-switch` / `fill-array-data` 的 payload | **已修**：直接输出 `:pswitch_data_N` / `.packed-switch` / `.array-data` 与 case 标签，`VoiceBridge.errName` 的 9 个 case 可自动对上（`03 §12.3`） |\n"
     "| `read_static.py` | `field_ids` 索引错位 → 字段名错显 | **已修**：三个类 19 个字段名实测全对（`04 §6.4`）。注意**值一直是对的**，此前只是名字错 |\n"
     "| `axml.py` | 跳过 `0x0180` resource map → 属性无 `android:` 前缀 | **已修**：解析 resource map 自动补前缀，`android:versionCode=\"1271\"` 直接可读 |\n"
     "| `dex2smali.py` | 少数 `invoke` 成员签名拼错（如 `setTextSize` 缺 `(F)V`） | **不修**：只影响签名文本，读类名+方法名+实参寄存器即可，不影响任何结论 |\n"
     "\n"
     "> 口径：这是「工具升级」不是「结论变更」。旧基线留在 `src/java2_v2/`，\n"
     "> 逐行差异见 `log/dex2smali-v2-to-v3.diff`（104 行）。\n"
     ">\n"
     "> 剩下的 TODO 只有一件：**重打包实证**（改包 → 重签 → 冒烟）。本环境没有\n"
     "> `java` / `apksigner` / `zipalign`，得先补签名工具，见 `04 §12`。\n"),

    # ---- docs/00 §4.5 E2：耗时换成 v3 实测
    (D00,
     "| E2 | 反汇编**确定性可复现**：`classes.dex` 0.073 s、`classes2.dex` 0.072 s，输出与仓库文件**逐字节相同** | `04 §5.6` |",
     "| E2 | 反汇编**确定性可复现**：`classes.dex` " + T1 + " s、`classes2.dex` " + T2 + " s，输出与仓库文件**逐字节相同**（v3 基线） | `04 §5.6` |"),

    # ---- docs/00 §4.5 E6：三处缺陷 → v3 已修 4 处
    (D00,
     "| E6 | 工具链有三处已登记缺陷：`22s` 寄存器位域、少数 `invoke` 签名拼错、不解析 `debug_info`/注解；`axml.py` 跳过 `0x0180` resource map 导致属性无 `android:` 前缀 | `04 §5.7`、`§3` |",
     "| E6 | 工具链 v3 已修 4 处：`22s` 位域、switch/array payload、`field_ids` 字段名、`0x0180` resource map；仍不解析 `debug_info`/注解，少数 `invoke` 签名按文本核对即可 | `04 §5.7`、`§3`、`§12` |"),

    # ---- docs/00 §11：第 2 项收工
    (D00,
     "| 2 | 修 3 个工具缺陷（`22s` 位域 / 字段名 / resource map） | 2–3 h | 工具链可复用到其他包，输出无需人工纠错 |",
     "| ~~2~~ | ~~修工具缺陷~~ **已完成（v3）**：`22s` 位域 / switch+array payload / 字段名索引 / resource map 四处全修 | 实耗 ~1.5 h | 工具链可复用到其他包，输出无需人工纠错 |"),

    # ---- docs/00 §2：`*.py` 不再是 12 个
    (D00,
     "| `src/*.py` | 12 个工具（解析 / 反汇编 / 导出 / 文档回改），见 `docs/04 §13` | — | `docs/04` 全篇 |",
     "| `src/*.py` | 18 个脚本（功能 8 + 工具链补丁 3 + 文档回改 7），索引见 `docs/04 §13` | — | `docs/04` 全篇 |"),

    # ---- docs/03 §12.3：payload 已能自动解
    (D03,
     "`errName(int)` 是 **9 个 case 的 `packed-switch`**，payload 需手工解（见 `docs/04 §5.7` 第 4 条）。",
     "`errName(int)` 是 **9 个 case 的 `packed-switch`**。payload 原先要手工解，v3 工具已能直接输出\n"
     "`:pswitch_data_0` 与 case 标签（`docs/04 §5.7` 第 4 条、`§12`）；下面的映射由「自动解析 + 手工核对」双向印证。"),

    (D03,
     "> 解 payload 时要注意**方向**：`targets` 是相对 switch 指令的偏移，值越小地址越靠前。",
     "> 手工解 payload 时要注意**方向**：`targets` 是相对 switch 指令的偏移，值越小地址越靠前。"),

    # ---- README：工具缺陷口径
    (RM,
     "3. **工具链有三处已登记缺陷**（`22s` 寄存器位域、少数 `invoke` 签名、`axml.py` 不解析 resource map），\n"
     "   读输出时需带上下文核对；修法已写在 `docs/04 §12`。",
     "3. **工具链 v3 已修 4 处**（`22s` 寄存器位域、switch/array payload、`field_ids` 字段名、`axml.py` 的 resource map），\n"
     "   只剩「少数 `invoke` 签名文本拼错」不修（不影响读法）。旧基线留在 `src/java2_v2/`，\n"
     "   逐行差异见 `log/dex2smali-v2-to-v3.diff`，修法与影响面写在 `docs/04 §12`。"),

    # ---- README：工具数量
    (RM,
     "│   └── *.py      12 个工具（解析 / 反汇编 / 导出 / 文档回改）",
     "│   └── *.py      18 个脚本（功能 8 + 工具链补丁 3 + 文档回改 7）"),
]


# ------------------------------------------------- P2 补全 §13 工具索引（+5 行）

ROUND6_ROW_OLD = ("| `patch_docs_round6.py` | 152 | 第六轮回改：`docs/04` 工具链 v3 修复结果 11 处 | "
                  "`python3 src/patch_docs_round6.py`（工程根执行） |")

ROUND6_BLOCK_NEW = (
    "| `dump_static_values.py` | 142 | `static_values` 原始字节 → 可读值（`read_static.py` 的底层） | "
    "`python3 src/dump_static_values.py <dex> <类>` |\n"
    "| `patch_docs_round3.py` | 439 | 第四轮回改：`docs/03 §12` 五项取证的结论落盘 | "
    "`python3 src/patch_docs_round3.py` |\n"
    "| `patch_docs_round4.py` | 119 | 修正 round3 带进来的 6 处偏差（以 smali 原文为准） | "
    "`python3 src/patch_docs_round4.py` |\n"
    "| `patch_docs_round5.py` | 114 | 修正 `docs/02 §5` 的 EyesService 常量区 + 同步 `docs/03 §12.4`、`docs/00 §8.3` | "
    "`python3 src/patch_docs_round5.py` |\n"
    "| `patch_docs_round6.py` | 159 | 第六轮回改：`docs/04` 工具链 v3 修复结果 12 处 | "
    "`python3 src/patch_docs_round6.py`（工程根执行） |\n"
    "| `patch_docs_round7.py` | {n} | 第七轮回改：`docs/00` §4.5/§8.3/§11 + `docs/03 §12.3` + `docs/04` "
    "数字与索引 + `README.md` 边界 | `python3 src/patch_docs_round7.py`（工程根执行） |"
)


def read(p):
    with open(os.path.join(ROOT, p), encoding='utf-8') as f:
        return f.read()


def write(p, s):
    with open(os.path.join(ROOT, p), 'w', encoding='utf-8') as f:
        f.write(s)


def apply_unique(docs, pairs, tag):
    ok = 0
    for path, old, new in pairs:
        text = docs[path]
        n = text.count(old)
        if n != 1:
            print('ABORT [%s] %s: old 命中 %d 次（要求 1）' % (tag, path, n))
            print('  old head: %r' % old[:90])
            sys.exit(1)
        docs[path] = text.replace(old, new, 1)
        ok += 1
    print('%s: %d pairs' % (tag, ok))


def apply_counted(text, old, new, expect):
    n = text.count(old)
    if n != expect:
        print('ABORT 数字替换 %r 命中 %d 次（期望 %d）' % (old, n, expect))
        sys.exit(1)
    return text.replace(old, new)


def main():
    docs = {p: read(p) for p in (D00, D03, D04, RM)}

    # ---- P1
    apply_unique(docs, P1, 'P1 内容替换')

    # ---- P2：§13 补行（本脚本行数运行时取）
    n_self = sum(1 for _ in open(os.path.abspath(__file__), encoding='utf-8'))
    apply_unique(docs, [(D04, ROUND6_ROW_OLD, ROUND6_BLOCK_NEW.format(n=n_self))],
                 'P2 §13 索引补全')

    # ---- P3：数字（文档行数取 P1+P2 之后的实际值）
    # 01/02 本轮未改，直接读盘；03/04 用内存里的（已含 P1/P2 改动）
    n01 = read('docs/01-架构总览.md').count('\n')
    n02 = read('docs/02-Java层源码还原.md').count('\n')
    n03 = docs[D03].count('\n')
    n04 = docs[D04].count('\n')
    total = n01 + n02 + n03 + n04

    d4 = docs[D04]
    d4 = apply_counted(d4, '449,139', format(SZ1, ','), 3)
    d4 = apply_counted(d4, '162,714', format(SZ2, ','), 3)
    d4 = apply_counted(d4, '611,832', format(SZCLS, ','), 2)
    d4 = apply_counted(d4, '612,249', format(SZCLS, ','), 1)
    d4 = apply_counted(d4, '0.073 s / 0.072 s', T1 + ' s / ' + T2 + ' s', 1)
    d4 = apply_counted(d4, 'dex2smali.py（406 行）', 'dex2smali.py（486 行）', 1)
    docs[D04] = d4

    d0 = docs[D00]
    d0 = apply_counted(d0, '449,139', format(SZ1, ','), 2)
    d0 = apply_counted(d0, '162,714', format(SZ2, ','), 2)
    d0 = apply_counted(d0, '611,832', format(SZCLS, ','), 3)
    d0 = apply_counted(d0, '0.073 s（98,744 B）、0.072 s（37,212 B）',
                       T1 + ' s（98,744 B）、' + T2 + ' s（37,212 B）', 1)
    d0 = apply_counted(d0, '216 行', '%d 行' % n01, 2)
    d0 = apply_counted(d0, '835 行', '%d 行' % n02, 2)
    d0 = apply_counted(d0, '973 行', '%d 行' % n03, 2)
    d0 = apply_counted(d0, '639 行', '%d 行' % n04, 2)
    d0 = apply_counted(d0, '2,663 行', format(total, ',') + ' 行', 1)
    docs[D00] = d0
    print('P3 数字：smali %s / %s / %s；耗时 %s / %s；docs 01..04 = %d / %d / %d / %d = %d 行'
          % (format(SZ1, ','), format(SZ2, ','), format(SZCLS, ','), T1, T2, n01, n02, n03, n04, total))

    # ---- 写盘
    for p, s in docs.items():
        write(p, s)
        print('patched %s（%d 行）' % (p, s.count('\n')))


if __name__ == '__main__':
    main()