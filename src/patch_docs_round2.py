#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""第三轮文档一致性回改：把 docs/04 里 4 处数字/口径错误、docs/02 里 1 处措辞不准确改掉。

纪律（沿用 src/patch_docs02.py 的模式）：
  每条 old 必须在全文出现且仅出现 1 次，否则整体中止、不写任何文件。
"""
import sys

ROUNDS = {
    "docs/04-工具链与复现.md": [
        # 1) du 的 920K 被当成字节数写进目录树
        (
            "│   │   ├── classes/                     920,0 KB   ← 124 个「一类一文件」，走读用这个",
            "│   │   ├── classes/                   611,832 B   ← 124 个「一类一文件」，走读用这个（`du` 报 920K 是块开销）",
        ),
        # 2) 类总数补上分 dex 来源 + 定义方法总数
        (
            "| 类总数 | **124** |",
            "| 类总数 | **124**（`classes.dex` 101 + `classes2.dex` 23） |\n"
            "| 定义方法总数 | **544**（124 个类的 `.method` 合计；其中 `-$$Nest$` 桥接 **55**） |",
        ),
        # 3) 桥接方法数 36 → 25（36 是行号区间 36–205，不是个数）
        (
            "| `PetWindowService` 方法数 | 45（含 36 个 `-$$Nest$` 桥接方法） |",
            "| `PetWindowService` 方法数 | 45（含 **25** 个 `-$$Nest$` 桥接方法，占全工程 55 个的 45%） |",
        ),
        # 4) 同一条命令的示例输出
        ("# 36", "# 25"),
        # 5) 正文复述
        (
            "36 个桥接方法，对应 `$1 … $17` 那批匿名类。",
            "25 个桥接方法（全工程 55 个，这个类占近一半），对应 `$1 … $17` 那批匿名类。",
        ),
        # 6) 数字来源表
        (
            "| 124 个类 / 920 KB | `ls src/java2/classes \\| wc -l`、`du -sh` |",
            "| 124 个类 / 611,832 B | `ls src/java2/classes \\| wc -l`、`os.path.getsize` 求和（`du -sh` 报 920K 是块开销） |",
        ),
        # 7) 扩展名分布只列了前 10 类（合计 853），补齐剩下 6 类 10 个
        (
            "扩展名分布：`png 466`（UI 资源，必须留）、`ts 259`、`json 34`、`js 24`、`md 22`、`jsonl 15`、无扩展名 13、`html 8`、`css 8`、`svg 4`。",
            "扩展名分布：`png 466`（UI 资源，必须留）、`ts 259`、`json 34`、`js 24`、`md 22`、`jsonl 15`、无扩展名 13、`html 8`、`css 8`、`svg 4`、\n"
            "`mjs 3`、`ps1 2`、`cjs 2`、`.example` / `.tsx` / `.sh` 各 1。\n"
            "（前 10 类合计 853，加后 6 类 10 个才是 863；用 `os.path.splitext` 统计可复现。）",
        ),
    ],
    "docs/02-Java层源码还原.md": [
        # 8) 520 的来源写窄了：构造实参就是 520，$15 只是同值兜底
        (
            "> **修订记录 v2**（`docs/03` 取证后回改）：`TOUCH_SIZE` 实为 **700** 且是死常量（实际尺寸 520 来自\n"
            "> `$15` 的下限 clamp）、`CHANNEL` 实为 `\"coopanion_pet\"`、",
            "> **修订记录 v2**（`docs/03` 取证后回改）：`TOUCH_SIZE` 实为 **700** 且是死常量（尺寸 520 直接写在\n"
            "> `buildAndAttachLayers` 的 `LayoutParams` 构造实参里——smali 417/418 的 `const/16 v6|v7, #520`；`$15` 只是同值下限兜底）、`CHANNEL` 实为 `\"coopanion_pet\"`、",
        ),
    ],
}


def main():
    bad = []
    texts = {}
    for path, pairs in ROUNDS.items():
        s = open(path, encoding="utf-8").read()
        for old, new in pairs:
            n = s.count(old)
            if n != 1:
                bad.append((path, n, old.split("\n")[0][:70]))
                continue
            s = s.replace(old, new, 1)
        texts[path] = s

    if bad:
        print("ABORT — 以下 old 未唯一匹配：")
        for p, n, head in bad:
            print(" ", p, "count=", n, "|", head)
        sys.exit(1)

    for path, s in texts.items():
        open(path, "w", encoding="utf-8").write(s)
    total = sum(len(v) for v in ROUNDS.values())
    print(f"OK — {total} 处替换已写入")
    for path, s in texts.items():
        print(" ", path, "lines=", s.count("\n"))


if __name__ == "__main__":
    main()
