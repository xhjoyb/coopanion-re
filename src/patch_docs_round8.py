# -*- coding: utf-8 -*-
r"""第八轮回改：把「改包 → 重签」的本机实证（MT MCP）落盘。

改动面（12 处唯一匹配）：
  docs/04 §0 环境表 +1、§1 目录树 +2 行（mcp_out/）、§2 追加「重签实证」（主体）
  docs/04 §12 边界 +1、§13 索引 +1；脚本数 18 → 20
  docs/00 §2 +1 行、脚本数、§11 优先级第 3 项划掉、行数回填
  README  目录树 +1、脚本数、边界第 1 条补「已实测」

用法：工程根执行 `python3 src/patch_docs_round8.py`（已执行过；再跑会因 old 不匹配而中止，这是预期）
"""
import os, sys
ROOT = '/data/user/0/app.operit/files/workspaces/identities/identity-1792103375772-2c229dc7/dafeiyu/Coopanion_v12.71'
D00 = 'docs/00-总目录与导读.md'
D04 = 'docs/04-工具链与复现.md'
RM = 'README.md'

def rd(p):
    return open(os.path.join(ROOT, p), encoding='utf-8').read()

SEC2 = r'''### 重签实证（已落地，不再是推断）

环境里没有 `java` / `apksigner` / `zipalign` / `keytool`，但本机 `127.0.0.1:8786` 上跑着 **MT MCP v0.2.0**
（JSON-RPC over HTTP，57 个工具），**自带签名器**。于是「改包 → 重签 → 校验」可以在本机闭环，
不必把 137 MB 传到任何云端。客户端就是本工程的 `src/mt.py`（87 行，只用标准库）。

**① 先让 MT 独立复核原件**（顺带验证下面 §2 的结论不是自说自话）：

| 项 | MT MCP 返回 | 与自研工具 / 本节结论 |
|---|---|---|
| `counts` | `zipEntries 29 / dexEntries 2 / xmlEntries 2 / classes 124` | ✅ 完全一致 |
| `signature` | `schemes [V1,V2,V3]`、`hasDifferentCertificates=false`、证书 `sha256 2793fcff…0764` | ✅ 与「v1+v2+v3 共存、单证书」一致 |

**② 选一处可观测且零风险的改动**：

| 项 | 值 |
|---|---|
| 目标 | `AndroidManifest.xml` 的 `android:versionName` |
| 动作 | `12.71` → `12.71-mcp`（`mt_apk_edit_text` 的 `replace_match`，全文唯一匹配） |
| 版本戳 | `targetVersion` `33b9dda672474b5c` → `dc5f8afa22cf24fe` |
| 构建前检查 | `mt_apk_session_check(runBuildChecks=true)` → `buildCheckStatus=passed`、`changedZipEntries=["AndroidManifest.xml"]`、`changedClassCount=0` |
| 构建 | `mt_apk_build(sign=true)`，**2.1 s**，产物 **137,258,773 B**（+53,246 B） |
| 签名 | `signingPerformed=true`、`signSchemes=[V1,V2,V3]`、单证书 |

**③ 三重独立校验（均可复跑）**：

| # | 校验手段 | 结果 |
|---|---|---|
| 1 | 条目级对比（CRC32 + 压缩/原始大小 + 压缩方法） | 29 条全在；**25 条完全一致**；变化的只有 `AndroidManifest.xml` 与 `META-INF/MANIFEST.MF`；`assets/payload.asset` 的 CRC 前后同为 `0x8eaf26c6` |
| 2 | `MANIFEST.MF` 摘要跨包比对 | 两包都是 26 个条目段，**25 段 SHA-256 相同**，唯一不同的是 `AndroidManifest.xml` 段 |
| 3 | 自研 `axml.py` v3 解码两个 manifest 后 `diff` | 都是 63 行，**唯一差异就是 `versionName` 那一行** |

补充三条：

- `zipfile.testzip()` 返回 `None`（29/29 条目 CRC 实测通过，0.9 s）。
- v1 签名链自校验（纯标准库，不需要 RSA）：`MANIFEST.MF` 的 26 个条目摘要 **26/26 正确**；
  `.SF` 的 `SHA-256-Digest-Manifest` 与 `MANIFEST.MF` 实体 **MATCH**；`.SF` 内 `X-Android-APK-Signed: 2,3`。
- 两个包的 APK Signing Block 尺寸都是 **4,088 B**，id-value 对均为 v2 `0x7109871a` + v3 `0xf05368c0`
  + verity padding `0x42726577`。

**④ 三个必须记住的副作用**：

1. **签名密钥不是原厂的**。MT 用的是 **AOSP 平台测试密钥**：
   `C=US, ST=California, L=Mountain View, O=Android, OU=Android, CN=Android, emailAddress=android@android.com`，
   有效期 `2008-02-29 → 2035-07-17`，证书 SHA-256 `a40da80a…f5dc`；原件的证书是 `2793fcff…0764`。
   ⇒ **同包名、不同签名，不能覆盖安装**，必须先卸载原应用（并丢掉应用数据）。
2. **`META-INF` 里的文件名会变**：`COOPANIO.SF` / `COOPANIO.RSA` → `ANDROID.SF` / `ANDROID.RSA`
   （`ANDROID` 就是密钥别名）。
3. **`AndroidManifest.xml` 从 6,544 B 缩到 5,064 B**。这不是内容丢失（第 3 项校验已证明语义等价），
   是 MT 重编码 AXML 时把字符串池排得更紧。

**⑤ MT MCP 的四个坑（下次直接用，省半小时）**：

- `mt_apk_dex_read_class_outline` **必须传 `limit`**，否则 `INVALID_ARGUMENT: Missing limit`（且 `retrySameArguments=false`）。
- `mt_apk_read_text` 的正文在 **`data.textWindow.text`**，不在 `data.text`。
- `mt_apk_build` 的 `outputName` **不接受子目录**：只能是 Home 里的文件名或绝对路径。写 `dir/x.apk` 会报 `INVALID_ARGUMENT: Invalid outputName`。
- 文件策略默认 `{"/": deny}` + Home `/storage/emulated/0/MT2/mcp`。包一旦被 `mv` 出 Home，
  `mt_apk_workspace_open` 就找不到它（返回 `data=`）。所以「改完先留在 Home，校验完再移走」。

> 仍未做的只有最后一步：**装到真机冒烟**。本机没有 `adb` / `pm`，目标应用也未安装，
> 所以这里只能说「包结构与签名链自洽、改动点语义正确」，不能说「已安装可运行」。
'''
sec2 = SEC2
assert sec2.endswith('\n')

A1_OLD = '← 18 个脚本，见 §13 索引\n└── docs/'
A1_NEW = ('← 19 个脚本，见 §13 索引\n'
          '├── mcp_out/\n'
          '│   └── Coopanion-v12.71-mcp.apk    137,258,773 B   ← §2「重签实证」产物（MT MCP 改 versionName 后重签）\n'
          '└── docs/')

A2_OLD = '| `java` / `javac` | ❌ | 不存在 |\n'
A2_NEW = (A2_OLD +
          '| 签名 / 重签名 | ✅（走本机 MT MCP） | **MT MCP v0.2.0 @ `127.0.0.1:8786`**，自带签名器（AOSP 测试密钥），见 §2「重签实证」 |\n')

A3_OLD = ('实践含义：**改动后必须重签**，三套方案会被签名工具一次性重算，不需要手工补 v2/v3；'
          '而本包没有自校验代码（见 `docs/01 §6`），重签不会额外触发检测。\n')
A3_NEW = A3_OLD + '\n' + sec2

A4_OLD = '| 可编译工程 | 环境没有 JDK，只能出「smali + 可读 Java + 原样 TS」三件套 |\n'
A4_NEW = (A4_OLD +
          '| 「重签后能否安装」的真机冒烟 | 本机没有 `adb` / `pm`，目标应用也未安装；只能验证到「包结构与签名链自洽」（§2「重签实证」） |\n')

A5_OLD = '| `export_src.py` | 81 | rootfs → 可读源码树（863 文件） | `python3 src/export_src.py` |\n'
A5_NEW = (A5_OLD +
          '| `mt.py` | 87 | MT MCP 客户端（JSON-RPC over HTTP，兼容 SSE）；改包/重签链路的入口 | `python3 src/mt.py list` / `python3 src/mt.py schema mt_apk_build` |\n')

B1_OLD = '| `apk/Coopanion-v12.71.apk` | 唯一原件，**只读，全程不修改** | 137,205,527 B / 29 条目 | 一切取证的起点 |\n'
B1_NEW = (B1_OLD +
          '| `mcp_out/Coopanion-v12.71-mcp.apk` | **重签实证产物**（MT MCP 改 `versionName` 后重签，非交付版） | 137,258,773 B / 29 条目 | `docs/04 §2`「重签实证」 |\n')

B2_OLD = '| `src/*.py` | 18 个脚本（功能 8 + 工具链补丁 3 + 文档回改 7），索引见 `docs/04 §13` | — | `docs/04` 全篇 |'
B2_NEW = '| `src/*.py` | 19 个脚本（功能 9 + 工具链补丁 3 + 文档回改 7），索引见 `docs/04 §13` | — | `docs/04` 全篇 |'

B3_OLD = '| 3 | 做一次「改包 → 重签 → 冒烟」实证（例如改 `7797` 端口或标题） | 1 h | 验证 `04 §2` 的「无自校验、重签即可」结论 |'
B3_NEW = ('| ~~3~~ | ~~做一次「改包 → 重签 → 冒烟」实证~~ **已完成（改包 + 重签）**：本机 MT MCP 改 `versionName` 后重签，'
          '29 条目中 25 条字节级一致、自研解码器 diff 只差目标行、v1 签名链 26/26 自校验通过；'
          '**冒烟未做**（无 `adb`/`pm`，目标应用未安装） | 实耗 ~0.5 h | '
          '`04 §2` 的「无自校验、重签即可」从推断变为实证；同时查明 MT 用的是 AOSP 测试密钥，与原厂证书不同 → 不能覆盖安装 |')

C1_OLD = '│   └── *.py      18 个脚本（功能 8 + 工具链补丁 3 + 文档回改 7）\n└── docs/'
C1_NEW = ('│   └── *.py      19 个脚本（功能 9 + 工具链补丁 3 + 文档回改 7）\n'
          '├── mcp_out/      Coopanion-v12.71-mcp.apk     重签实证产物（见 docs/04 §2）\n'
          '└── docs/')

C2_OLD = '要编回 APK 只需改 smali 后重打包（本包无自校验，重签即可）。'
C2_NEW = (C2_OLD + '\n'
          '   **这条已实测**：用本机 MT MCP 改 `versionName` 后重签，29 个条目里 25 个字节级一致、业务负载零变化，\n'
          '   自研 `axml.py` 解码新旧 manifest 只差改动那一行，v1 签名链 26/26 摘要自校验通过（见 `docs/04 §2`）。\n'
          '   注意 MT 的签名密钥是 AOSP 测试密钥，与原厂证书不同 → **同包名不能覆盖安装，需先卸载**。')

docs = {p: rd(p) for p in (D00, D04, RM)}

def rep(path, old, new, tag):
    t = docs[path]
    n = t.count(old)
    if n != 1:
        print('ABORT [%s] %s: old 命中 %d 次（要求 1）' % (tag, path, n))
        print('  old head: %r' % old[:100])
        sys.exit(1)
    docs[path] = t.replace(old, new, 1)

rep(D04, A1_OLD, A1_NEW, 'A1 §1 目录树')
rep(D04, A2_OLD, A2_NEW, 'A2 §0 环境表')
rep(D04, A3_OLD, A3_NEW, 'A3 §2 重签实证')
rep(D04, A4_OLD, A4_NEW, 'A4 §12 边界')
rep(D04, A5_OLD, A5_NEW, 'A5 §13 索引')
print('docs/04: 5 处 OK')

rep(D00, B1_OLD, B1_NEW, 'B1 §2 产物表')
rep(D00, B2_OLD, B2_NEW, 'B2 §2 脚本数')
rep(D00, B3_OLD, B3_NEW, 'B3 §11 优先级')
print('docs/00: 3 处 OK')

rep(RM, C1_OLD, C1_NEW, 'C1 README 树')
rep(RM, C2_OLD, C2_NEW, 'C2 README 边界')
print('README: 2 处 OK')

# ---- 行数类：先算 docs/04 最终行数，再回填 docs/00
n01 = rd('docs/01-架构总览.md').count('\n')
n02 = rd('docs/02-Java层源码还原.md').count('\n')
n03 = rd('docs/03-Java与JS桥接协议.md').count('\n')
n04 = docs[D04].count('\n')
total = n01 + n02 + n03 + n04

d0 = docs[D00]
for old, new, exp in (
    ('| `docs/04` | 工具链与复现（怎么把上面全部重做一遍） | 676 行 | 复现/搬工具 |',
     '| `docs/04` | 工具链与复现（怎么把上面全部重做一遍） | %d 行 | 复现/搬工具 |' % n04, 1),
    ('| 文档 | 01 216 行 + 02 856 行 + 03 1182 行 + 04 676 行 = **2,930 行**（不含本文） |',
     '| 文档 | 01 216 行 + 02 856 行 + 03 1182 行 + 04 %d 行 = **%s 行**（不含本文） |' % (n04, format(total, ',')), 1),
):
    c = d0.count(old)
    if c != exp:
        print('ABORT 行数替换 %r 命中 %d 次（期望 %d）' % (old[:60], c, exp))
        sys.exit(1)
    d0 = d0.replace(old, new)
docs[D00] = d0
print('行数：01=%d 02=%d 03=%d 04=%d total=%d' % (n01, n02, n03, n04, total))

for p, s in docs.items():
    open(os.path.join(ROOT, p), 'w', encoding='utf-8').write(s)
    print('patched %s（%d 行）' % (p, s.count('\n')))
