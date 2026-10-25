#!/usr/bin/env python3
# -*- coding: utf-8 -*-
r"""修正 `docs/02 §5` 的 EyesService 常量区（数值全部错误）+ 同步 docs/03 §12.4、docs/00 §8.3。

取证命令：
  python3 src/read_static.py src/x/classes2.dex 'Lcom/palai/prootsmoke/EyesService;'
  → static_values count=6：
      [0] CAPTURE_ATTEMPTS   int  3
      [1] CAPTURE_WAIT_MS    long 9000
      [2] FRAME_CACHE_MS     long 700
      [3] MAX_STALE_MS       long 2500
      [4] MIN_CAPTURE_GAP_MS long 1200
      [5] PORT               int  17898
  （该工具有 field_ids 索引 bug，字段名会错显成 `ARGB_8888`，**值正确**，按声明顺序对应。）

原文档 6 个数字：CAPTURE_WAIT_MS=1200 / FRAME_CACHE_MS=900 / MAX_STALE_MS=6000 /
MIN_CAPTURE_GAP_MS=700 —— 与真实值**全不相符**；`SERVICE_NAME` 这个字段在类里**不存在**。
另外 round3 在 docs/03 §12.4 误称「MIN_CAPTURE_GAP 常量不存在」，也是错的，此处一并回改。
"""
import sys


PAIRS = {
    "docs/02-Java层源码还原.md": [
        # 1) 常量区：五个数值 + 删掉不存在的 SERVICE_NAME
        (
            "private static final int  PORT               = 17898;\n"
            "private static final int  CAPTURE_ATTEMPTS   = 3;      // 截屏重试次数\n"
            "private static final long CAPTURE_WAIT_MS    = 1200L;  // 单次等待\n"
            "private static final long FRAME_CACHE_MS     = 900L;   // 帧缓存\n"
            "private static final long MAX_STALE_MS       = 6000L;  // 超过就算「没有画面」\n"
            "private static final long MIN_CAPTURE_GAP_MS = 700L;   // 两次截屏最小间隔（系统限流）\n"
            "private static final String SERVICE_NAME     = \"coop-eyes\";\n"
            "```\n",
            "private static final int  PORT               = 17898;\n"
            "private static final int  CAPTURE_ATTEMPTS   = 3;      // 截屏重试次数\n"
            "private static final long CAPTURE_WAIT_MS    = 9000L;  // 单次 latch 等待（captureOnce 的硬超时）\n"
            "private static final long FRAME_CACHE_MS     = 700L;   // 帧缓存命中窗口\n"
            "private static final long MAX_STALE_MS       = 2500L;  // 旧图可回退的最大年龄，超过算「没有画面」\n"
            "private static final long MIN_CAPTURE_GAP_MS = 1200L;  // 两次截屏最小间隔（系统限流）\n"
            "```\n"
            "\n"
            "> **这 5 个数字的出处**（原文档的 1200/900/6000/700 全是错的）：类里**没有 `<clinit>`**，\n"
            "> 常量是编译期写进 DEX `static_values` 的，必须直接读：\n"
            "> `python3 src/read_static.py src/x/classes2.dex 'Lcom/palai/prootsmoke/EyesService;'`。\n"
            "> 该工具有 `field_ids` 索引 bug，字段名会错显（本次全成 `ARGB_8888`），**按声明顺序对应、值本身正确**。\n"
            "> `SERVICE_NAME` 字段**不存在** —— `/health` 里的 `\"coopanion-eyes\"` 是方法内联字面量。\n",
        ),
        # 2) jpeg() 注释改成常量名
        (
            "private byte[] jpeg(int max, int q);            // 700ms 缓存 / 1200ms 最小间隔 / 3 次重试 / 2500ms 旧图回退\n",
            "private byte[] jpeg(int max, int q);            // FRAME_CACHE_MS→MIN_CAPTURE_GAP_MS→CAPTURE_ATTEMPTS→MAX_STALE_MS\n",
        ),
    ],
    "docs/03-Java与JS桥接协议.md": [
        # 3) round3 误称常量不存在
        (
            "`jpeg(int max, int q)` 的四段策略（原文档写的 `MIN_CAPTURE_GAP` 常量**不存在**）：\n",
            "`jpeg(int max, int q)` 的四段策略（四个阈值都是 `static final` 常量，值取自 DEX `static_values`）：\n",
        ),
        # 4) 表格后补常量名与读法
        (
            "| 旧图回退 | 3 次全败且 `lastJpeg` 距今 **≤ 2500 ms** | 返回旧图，否则 null |\n"
            "\n"
            "`sendScreen()` 的参数入口：`intParam(\"max\", 720)` clamp 到 **[120, 2160]**、\n",
            "| 旧图回退 | 3 次全败且 `lastJpeg` 距今 **≤ 2500 ms** | 返回旧图，否则 null |\n"
            "\n"
            "五个阈值都是 `static final` 常量（`EyesService` 没有 `<clinit>`，值在 DEX `static_values` 里）：\n"
            "`FRAME_CACHE_MS=700` / `MIN_CAPTURE_GAP_MS=1200` / `CAPTURE_ATTEMPTS=3` /\n"
            "`MAX_STALE_MS=2500` / `CAPTURE_WAIT_MS=9000`。读法：\n"
            "`python3 src/read_static.py src/x/classes2.dex 'Lcom/palai/prootsmoke/EyesService;'`\n"
            "（该工具有字段名索引 bug，输出名会错显，**按声明顺序**对应即可，值本身正确）。\n"
            "\n"
            "`sendScreen()` 的参数入口：`intParam(\"max\", 720)` clamp 到 **[120, 2160]**、\n",
        ),
    ],
    "docs/00-总目录与导读.md": [
        # 5) read_static.py 缺陷行补本次新证据
        (
            "| `read_static.py` | `field_ids` 索引错位 | 5 个字段名错显 `packageName`（**值本身正确**） | 修 `foff+4` 与 `k` 基数 |\n",
            "| `read_static.py` | `field_ids` 索引错位 | 字段名错显（`MainActivity` 5 个错成 `packageName`，"
            "`EyesService` 6 个错成 `ARGB_8888`），**值本身正确** | 修 `foff+4` 与 `k` 基数 |\n",
        ),
    ],
}


def main():
    bad = []
    texts = {}
    for path, pairs in PAIRS.items():
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
            print("  ", p, "count=", n, "|", head)
        sys.exit(1)

    for path, s in texts.items():
        open(path, "w", encoding="utf-8").write(s)
    print("OK — %d 处修正已写入" % sum(len(v) for v in PAIRS.values()))
    for path, s in texts.items():
        print("  ", path, "lines=", s.count("\n"))


if __name__ == "__main__":
    main()