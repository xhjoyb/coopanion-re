#!/usr/bin/env python3
# -*- coding: utf-8 -*-
r"""修正 round3 落盘时带进来的 6 处偏差（全部以 smali 原文为准）。

对照取证：
  - `VoiceBridge.intent()`：`MAX_RESULTS` 用 `const/4 v2,#1`，与 `PARTIAL_RESULTS` 共用同一个 1 —— 文档原写 3 是错的。
  - `VoiceBridge.start()`：`$2.run()` = build → wanted=true → rec.cancel() → startListening → deliver("start","","")。
  - `VoiceBridge.stop()`：`$3.run()` 只调 `stopListening()`，**不置** wanted（只有 `$4`/cancel 才置 false）。
  - `VoiceBridge.errName()`：packed-switch key 1..9 对应 SpeechRecognizer 标准错误码；default 是 `"错误 "+code`。
  - round3 在 `docs/03 §12.3` 把映射写反了（key 1 是「网络超时」不是「没有麦克风权限」），此处修正。

纪律同前：old 必须全文唯一匹配，否则整体中止不写盘。
"""
import sys


PAIRS = {
    "docs/02-Java层源码还原.md": [
        # 1) start / stop / cancel 的真实行为
        (
            "    void start() {\n"
            "        wanted = true;\n"
            "        ui.post(() -> {\n"
            "            if (rec == null) rec = build();\n"
            "            rec.startListening(intent());\n"
            "        });\n"
            "    }\n"
            "    void stop()   { wanted = false; ui.post(() -> { if (rec != null) rec.stopListening(); }); }\n"
            "    void cancel() { wanted = false; ui.post(() -> { if (rec != null) rec.cancel(); }); }\n",
            "    void start() {\n"
            "        ui.post(() -> {                        // $2\n"
            "            if (rec == null) rec = build();\n"
            "            wanted = true;\n"
            "            rec.cancel();                      // 先取消上一次\n"
            "            rec.startListening(intent());\n"
            "            deliver(\"start\", \"\", \"\");          // 通知页面「已开始」\n"
            "        });\n"
            "    }\n"
            "    void stop()   { ui.post(() -> { if (rec != null) rec.stopListening(); }); }  // $3：**不置** wanted\n"
            "    void cancel() { wanted = false; ui.post(() -> { if (rec != null) rec.cancel(); }); }  // $4\n",
        ),
        # 2) MAX_RESULTS：1，不是 3
        (
            "        i.putExtra(RecognizerIntent.EXTRA_MAX_RESULTS, 3);\n",
            "        i.putExtra(RecognizerIntent.EXTRA_MAX_RESULTS, 1);   // 与 PARTIAL_RESULTS 共用同一个 const/4 #1\n",
        ),
        # 3) errName 是 packed-switch
        (
            "    /** 错误码 → 人话（页面直接显示）。 */\n"
            "    private static String errName(int code) {\n",
            "    /** 错误码 → 人话（页面直接显示）。smali 里是 packed-switch（key 1..9），此处按常量名还原。 */\n"
            "    private static String errName(int code) {\n",
        ),
        # 4) default 分支是拼字符串
        (
            "            default:                                       return \"识别失败\";\n",
            "            default:                                       return \"错误 \" + code;\n",
        ),
    ],
    "docs/03-Java与JS桥接协议.md": [
        # 5) round3 把映射写反了
        (
            "映射结果：`1→没有麦克风权限`、`2→识别服务忙`、`3→没听清`、`4→没听到声音`、`5→客户端错误`、\n"
            "`6→识别服务出错`、`7→录音出错`、`8→网络错误`、`9→网络超时`，default 拼 `\"错误 \"+n`。\n",
            "映射结果（= `SpeechRecognizer` 标准错误码语义，与 payload 完全自洽）：\n"
            "`1→网络超时`（`ERROR_NETWORK_TIMEOUT`）、`2→网络错误`、`3→录音出错`、`4→识别服务出错`、\n"
            "`5→客户端错误`、`6→没听到声音`、`7→没听清`、`8→识别服务忙`、\n"
            "`9→没有麦克风权限`（`ERROR_INSUFFICIENT_PERMISSIONS`），default 拼 `\"错误 \"+n`。\n"
            "\n"
            "> 解 payload 时要注意**方向**：`targets` 是相对 switch 指令的偏移，值越小地址越靠前。\n"
            "> 实测 `key 9 → +23`（最先出现，对应第一个 `const-string`「没有麦克风权限」）、\n"
            "> `key 1 → +47`（最后出现，对应「网络超时」）—— 与 `ERROR_INSUFFICIENT_PERMISSIONS=9`、\n"
            "> `ERROR_NETWORK_TIMEOUT=1` 完全一致，可作双向印证。\n",
        ),
    ],
    "docs/04-工具链与复现.md": [
        # 6) round3 把「case 9 在最前」表述得不准确
        (
            "   核对办法：直接解 DEX 原始字节的 payload（`ident|size` + `first_key` + `size` 个\n"
            "   **相对该 switch 指令**的偏移），再与 smali 里 case 字符串的书写顺序比对\n"
            "   （`VoiceBridge` 的实际顺序是 case 9 在最前、case 1 在最后）。\n"
            "   这一手法与 `diag_units.py` 同源（`struct.unpack_from` 直读），可复用。\n",
            "   核对办法：直接解 DEX 原始字节的 payload（`ident|size` + `first_key` + `size` 个\n"
            "   **相对该 switch 指令**的偏移），再与 smali 里 9 个 `const-string` 的**地址顺序**比对。\n"
            "   `VoiceBridge.errName` 实测：`key 9 → +23`（最先出现，对应「没有麦克风权限」）、\n"
            "   `key 1 → +47`（最后出现，对应「网络超时」），与 `SpeechRecognizer` 常量值完全自洽。\n"
            "   这一手法与 `diag_units.py` 同源（`struct.unpack_from` 直读），可复用。\n",
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