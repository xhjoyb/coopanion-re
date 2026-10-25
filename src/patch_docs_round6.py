#!/usr/bin/env python3
# -*- coding: utf-8 -*-
r"""第六轮文档回改：把「工具链 v3」的修复结果落盘到 `docs/04`。

背景：v3 修了四处工具缺陷（22s 位域 / switch+array payload / read_static 字段名 / axml resource map），
并重建了 smali 基线（`src/java2/`，旧基线留 `src/java2_v2/`，差异证据 `log/dex2smali-v2-to-v3.diff`）。
文档里原先把它们登记成「已知缺陷」，本轮全部改成「已修 + 复核数据」。

纪律（沿用 patch_docs02 起的模式）：
  每条 old 必须在全文出现且仅出现 1 次，否则整体中止、不写任何文件。
"""
import io
import os
import sys

DOC = 'docs/04-工具链与复现.md'

PAIRS = [
    # ── §3：axml resource map ────────────────────────────────────────────
    (
        "**已知缺陷（必须知道，否则会误读输出）**：脚本把 `0x0180` resource map **直接跳过**，所以属性名只拿到字符串池里的裸名——\n"
        "输出是 `versionCode`，不是 `android:versionCode`；`name` 也没有 `android:` 前缀。\n"
        "写文档时要按语义补回命名空间（`docs/01 §2` 就是这么写的）。",
        "**属性命名空间（v3 起自动还原）**：脚本解析 `0x0180` resource map，按每个 attr 资源 id 的高字节补前缀——\n"
        "`0x01xxxxxx` 打 `android:`，其余非零 id（应用自身的 `0x7f……`）保留成 `0x7f010000:` 这类原值，\n"
        "id 为 0 的（`package`、`platformBuildVersionCode`）保持裸名。因此现在直接输出\n"
        "`android:versionCode=\"1271\"`、`android:name=\"android.permission.INTERNET\"`，`docs/01 §2` 不必再人工补。\n"
        "（v2 及更早版本把 map 整个跳过，输出的是裸名 `versionCode`。）",
    ),
    # ── §5.4：新增「数据块」说明 ─────────────────────────────────────────
    (
        "**未覆盖**：`22cs` / `35cs` / `3rms`（这三个只在优化过的 odex 里出现，普通 APK 不会有）、`4rcc`。\n"
        "本包的 124 个类没有一条指令落在这四个格式里（否则反汇编会打出 `?fmt` 而不是指令名）。",
        "**未覆盖**：`22cs` / `35cs` / `3rms`（这三个只在优化过的 odex 里出现，普通 APK 不会有）、`4rcc`。\n"
        "本包的 124 个类没有一条指令落在这四个格式里（否则反汇编会打出 `?fmt` 而不是指令名）。\n"
        "\n"
        "**数据块（v3 起）**：`packed-switch` / `sparse-switch` / `fill-array-data` 引用的 payload 不再丢——\n"
        "payload 位置输出 baksmali 风格的 `:pswitch_data_N` / `:sswitch_data_N` / `:array_N` 块\n"
        "（`.packed-switch` / `.sparse-switch` / `.array-data` 到 `.end …`），case 目标同时打上 `:pswitch_N` 等标签，\n"
        "**case 值 → 目标地址的映射在 smali 里直接可读**。target 偏移按 Dalvik 规范以「switch 指令地址」为基准。\n"
        "本包命中 1 处：`VoiceBridge.errName(I)`（9 个 case，key 1..9）。",
    ),
    # ── §5.6：数字更新 ───────────────────────────────────────────────────
    (
        "实测：**0.073 s / 0.072 s**，输出 449,139 B / 162,714 B，与仓库内文件**逐字节相同**。",
        "实测：**0.080 s / 0.064 s**，输出 449,149 B / 163,100 B，与仓库内文件**逐字节相同**。",
    ),
    # ── §5.7：标题 ───────────────────────────────────────────────────────
    (
        "### 5.7 已知缺陷（诚实登记，读代码时要带着）",
        "### 5.7 已知缺陷（v3 已修 2 条，其余如实登记）",
    ),
    # ── §5.7 第 1 条：22s 已修 ───────────────────────────────────────────
    (
        "1. **`22s` 格式的寄存器高 8 位没右移**。`22s` 的布局是 `op | A(8bit) | B(4bit) | lit16`，脚本把整个 `AA|BB` 当寄存器号，于是会出现 `rsub-int/lit16 v136,#700` 这种明显不可能的 `v136`——真实是 `v8, v8, #700`（`int v9 = v8 - 700` 之类）。**按上下文纠正即可，不影响语义判断**。",
        "1. ~~**`22s` 格式的寄存器高 8 位没右移**~~ **（v3 已修）**。`22s` 的布局是 `op | A(4bit) | B(4bit) | lit16`，\n"
        "   正确取法 `A = (unit >> 8) & 0xf`、`B = (unit >> 12) & 0xf`（旧版把整个高位字节当寄存器号）。\n"
        "   本包 5 处受影响指令全部还原成三操作数：`and-int/lit16 v3, v3, #255`（原 `v51`）、\n"
        "   `rsub-int/lit16 v8, v8, #700`（原 `v136`）、`rsub-int/lit16 v8, v8, #500`（原 `v136`）、\n"
        "   `and-int/lit16 v4, v4, #256`（原 `v68`）、`add-int/lit16 v8, v1, #-200`（原 `v24`，在 `EyesService.imeHeightOf`）。\n"
        "   已用 `diag_units.py` 对原始 unit 复核（`EyesService.imeHeightOf` 的 `0x18d0` → A=8、B=1）。",
    ),
    # ── §5.7 第 4 条：switch payload 已修 ───────────────────────────────
    (
        "4. **不解析 `packed-switch` / `sparse-switch` 的 payload**。指令本身被输出成裸\n"
        "   `packed-switch v2, :L50`，但 `:pswitch_data` 块与 9 个 case 目标标签全部丢失 ——\n"
        "   **case 值与目标地址的映射在 smali 里不可读**。本包唯一命中是 `VoiceBridge.errName(I)`\n"
        "   （`grep -rc 'pswitch_data' src/java2/classes | grep -v ':0' | wc -l` = **0**）。\n"
        "   核对办法：直接解 DEX 原始字节的 payload（`ident|size` + `first_key` + `size` 个\n"
        "   **相对该 switch 指令**的偏移），再与 smali 里 9 个 `const-string` 的**地址顺序**比对。\n"
        "   `VoiceBridge.errName` 实测：`key 9 → +23`（最先出现，对应「没有麦克风权限」）、\n"
        "   `key 1 → +47`（最后出现，对应「网络超时」），与 `SpeechRecognizer` 常量值完全自洽。\n"
        "   这一手法与 `diag_units.py` 同源（`struct.unpack_from` 直读），可复用。",
        "4. ~~**不解析 `packed-switch` / `sparse-switch` 的 payload**~~ **（v3 已修）**。现在直接输出\n"
        "   `:pswitch_data_0` + `.packed-switch 0x1` 的 9 行 target，并给每个目标打 `:pswitch_N` 标签。\n"
        "   `VoiceBridge.errName(I)` 的映射可一步读出，且与 `SpeechRecognizer` 常量值完全自洽：\n"
        "   `1 网络超时` / `2 网络错误` / `3 录音出错` / `4 识别服务出错` / `5 客户端错误` /\n"
        "   `6 没听到声音` / `7 没听清` / `8 识别服务忙` / `9 没有麦克风权限`。\n"
        "   与第二轮「手工解 payload」的结论一致（`key 9` 目标地址最小、`key 1` 最大），互为交叉验证。",
    ),
    # ── §6.4：read_static 字段名已修 ────────────────────────────────────
    (
        "### 6.4 已知缺陷（别被字段名骗）\n"
        "\n"
        "输出的字段名除 `[0] [3] [7]` 外全部错显成 `packageName` —— 是 `read_static.py` 里 `field_ids` 的索引/偏移没对齐（`foff = field_ids_off + names[k]*8`，`name_idx` 在 `+4`）。\n"
        "**值本身和顺序完全正确**，只有名字不可信。按类型 + 顺序 + 使用点可以唯一对应回 8 个字段（`docs/03 §3.1` 就是这么对的）。",
        "### 6.4 字段名（v3 已修，实测全对）\n"
        "\n"
        "`field_ids` 取 `name_idx` 用 `+4`、`static_fields` 的 `field_idx` 按 diff 累加，两处对齐后三个类的字段名全部正确：\n"
        "`PetWindowService` 8 个（`CHANNEL / KEY_ALPHA / NOTI_ID / PET_HOST_SHIM / PET_URL / PREF / TAG / TOUCH_SIZE`）、\n"
        "`EyesService` 6 个（`CAPTURE_ATTEMPTS / CAPTURE_WAIT_MS / FRAME_CACHE_MS / MAX_STALE_MS / MIN_CAPTURE_GAP_MS / PORT`）、\n"
        "`MainActivity` 5 个（`PET_MAX_RETRY / PET_RETRY_INTERVAL / REQ_MIC / REQ_OVERLAY / TAG`）。\n"
        "v2 及更早版本除 `[0] [3] [7]` 外全部错显成 `packageName`，但**值本身与顺序一直是对的**——\n"
        "本轮修复只改名字，不改取值，所以 `docs/02` / `docs/03` 里按「类型 + 顺序 + 使用点」对出来的结论不受影响。",
    ),
    # ── §12：TODO → 已完成 ───────────────────────────────────────────────
    (
        "### 若要继续加固这套工具（三处 TODO 已定位）\n"
        "\n"
        "1. `dex2smali.py` 的 `22s` 格式：`A = (code[i] >> 8) & 0xff`、`B = (code[i] >> 12) & 0xf`，当前把两者合在一起当寄存器。\n"
        "2. `read_static.py` 的字段名：`field_ids` 索引对齐（`foff + 4` 取 `name_idx`，但 `k` 的基数要用 `class_data` 里 static_fields 的起始索引）。\n"
        "3. `axml.py` 的属性命名空间：解析 `0x0180` resource map，把属性名映射回 `android:` / 自定义 ns。\n"
        "\n"
        "三处都不影响现有结论（都在文档里显式标注了影响范围），属于「下次要用再修」。",
        "### 工具加固进度（v3：四处全部完成）\n"
        "\n"
        "| # | 缺陷 | 状态 |\n"
        "|---|---|---|\n"
        "| 1 | `dex2smali.py` 的 `22s` 位域（`A = unit >> 8 & 0xf`、`B = unit >> 12 & 0xf`） | ✅ 已修，本包 5 处全部还原 |\n"
        "| 2 | `dex2smali.py` 不输出 switch / array payload | ✅ 已修，输出 `.packed-switch` / `.sparse-switch` / `.array-data` 块与 case 标签 |\n"
        "| 3 | `read_static.py` 的字段名错显 | ✅ 已修，三个类 19 个字段名全对（见 §6.4） |\n"
        "| 4 | `axml.py` 跳过 `0x0180` resource map | ✅ 已修，自动补 `android:`（见 §3） |\n"
        "\n"
        "口径提醒：这是「工具升级」，不是「结论变更」。受影响的 5 处指令、1 处 switch、以及全部 `android:` 前缀，\n"
        "都能在 `src/java2_v2/`（旧基线）与 `log/dex2smali-v2-to-v3.diff`（104 行）里逐行对照；\n"
        "`src/java2/` 已重建为 v3 基线（124 文件 / 612,249 B；合并视图 449,149 B + 163,100 B），\n"
        "`python3 src/dex2smali.py src/x/classes.dex | diff -q - src/java2/classes.dex.smali` 仍然 identical。\n"
        "\n"
        "另更正一条旧笔误：`22s` 的 A 位域不是 `(code>>8)&0xff`，而是 `(code>>8)&0xf`（4 bit 寄存器对）。",
    ),
    # ── §13：行数 + 新条目 ───────────────────────────────────────────────
    (
        "| `axml.py` | 101 | AXML → 文本 | `python3 src/axml.py src/x/AndroidManifest.xml` |",
        "| `axml.py` | 109 | AXML → 文本（v3：含 resource map，属性自带 `android:`） | `python3 src/axml.py src/x/AndroidManifest.xml` |",
    ),
    (
        "| `dex2smali.py` | 406 | 指令层反汇编（**已打补丁版**） | `python3 src/dex2smali.py <dex> > out.smali` |",
        "| `dex2smali.py` | 486 | 指令层反汇编（v3：22s 修正 + switch/array payload 数据块） | `python3 src/dex2smali.py <dex> > out.smali` |",
    ),
    (
        "| `read_static.py` | 140 | 取 `static_values`（常量真值） | `python3 src/read_static.py x/classes.dex 'Lcom/…;'` |",
        "| `read_static.py` | 142 | 取 `static_values`（常量真值，v3：字段名正确） | `python3 src/read_static.py x/classes.dex 'Lcom/…;'` |",
    ),
    (
        "| `patch_docs_round2.py` | 88 | 第三轮回改：`docs/04` 数字/口径 7 处 + `docs/02` 1 处（同一断言机制） | `python3 src/patch_docs_round2.py`（工程根执行） |",
        "| `patch_docs_round2.py` | 88 | 第三轮回改：`docs/04` 数字/口径 7 处 + `docs/02` 1 处（同一断言机制） | `python3 src/patch_docs_round2.py`（工程根执行） |\n"
        "| `patch_docs_round6.py` | 152 | 第六轮回改：`docs/04` 工具链 v3 修复结果 11 处 | `python3 src/patch_docs_round6.py`（工程根执行） |",
    ),
]


def main():
    path = DOC
    if not os.path.exists(path):
        sys.exit('missing %s' % path)
    text = io.open(path, encoding='utf-8').read()
    for idx, (old, new) in enumerate(PAIRS):
        n = text.count(old)
        if n != 1:
            sys.stderr.write('ABORT at pair #%d: count=%d\nold head: %r\n' % (idx, n, old[:60]))
            sys.exit(1)
    for idx, (old, new) in enumerate(PAIRS):
        text = text.replace(old, new)
    io.open(path, 'w', encoding='utf-8').write(text)
    print('patched %s: %d pairs' % (path, len(PAIRS)))


if __name__ == '__main__':
    main()
