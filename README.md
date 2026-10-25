# Coopanion v12.71 · 逆向工程与源码还原

> 目标包：`Coopanion-v12.71.apk`（`com.palai.prootsmoke`，versionCode 1271，137,205,527 B）
> 本文只做入口指引，**详细导读在 [`docs/00-总目录与导读.md`](docs/00-总目录与导读.md)**。

---

## 一句话

它不是一个普通 Android 应用，而是**「自带 aarch64 Linux 运行时的薄壳」**：

```text
Android App（Java 侧只有 124 个类：窗口 / 无障碍 / 通知 / 语音 / WebView）
   │  首次启动把 assets/payload.asset（gzip+tar，344.11 MiB）解到 files/rootfs-v8-*
   ▼
proot（libproot.so）拉起 rootfs 内的 Node（bin/node 123 MB，glibc 2.39）
   ▼
Cortico 控制台 :17788 · 眼睛 :17898 · 感知 :17899 · 桌宠页 :7797
```

- **无加固**：无桩 `Application`、无壳 so、无壳 assets、无 DEX 加密 / 方法抽取、无 VMP、无自校验 → **不需要脱壳**。
- **业务源码是原样 TypeScript**：`src/recovered/` 的 863 个文件就是原厂工程（259 个 `.ts`，未混淆、未编译）。
- **真正的难点是协议**：桌宠 = 两层悬浮窗 + WebView + Node 页面；Java ↔ JS 三条桥接通道，
  输入法用 1×1 隐藏 `EditText` + 包装 `InputConnection` 实现。

规模：Java **124 类 / 544 方法**（`classes.dex` 101 + `classes2.dex` 23），其中 `-$$Nest$` 桥接 55 个。

---

## 从哪读起

| 想知道什么 | 读哪 |
|---|---|
| 这 App 由哪些部分组成、怎么启动 | [`docs/01-架构总览.md`](docs/01-架构总览.md) |
| Java 每个类到底怎么实现的 | [`docs/02-Java层源码还原.md`](docs/02-Java层源码还原.md) |
| Java 和页面之间怎么通信（最硬） | [`docs/03-Java与JS桥接协议.md`](docs/03-Java与JS桥接协议.md) |
| 怎么把上面全部重做一遍 | [`docs/04-工具链与复现.md`](docs/04-工具链与复现.md) |
| 结论索引 / 数字总表 / 边界清单 | [`docs/00-总目录与导读.md`](docs/00-总目录与导读.md) |

---

## 目录

```text
Coopanion_v12.71/
├── apk/          Coopanion-v12.71.apk        原件，只读
├── log/          ziplist.txt / rootfs_list.txt（原始清单，可复现）
├── src/
│   ├── x/        APK 解包产物（20 文件 / 552,100 B，不含 payload.asset）
│   ├── java2/    smali：合并视图 2 份 + classes/ 124 个一类一文件
│   ├── js/       12 段注入脚本（inj_01 … inj_12，共 4,776 B）
│   ├── rootfs/   从 payload.asset 抽出的业务子树（1,910 文件 / 137,479,592 B）
│   ├── recovered/ 可读源码树（863 文件 / 16,350,953 B）
│   └── *.py      20 个脚本（功能 9 + 工具链补丁 3 + 文档回改 8）
├── mcp_out/      Coopanion-v12.71-mcp.apk     重签实证产物（见 docs/04 §2）
└── docs/         00 导读 · 01 架构 · 02 Java · 03 协议 · 04 工具链
```

---

## 30 秒自检（三条命令，输出必须一致）

```bash
cd Coopanion_v12.71

python3 src/dex2smali.py src/x/classes.dex | diff -q - src/java2/classes.dex.smali && echo identical
# → identical

unzip -p apk/Coopanion-v12.71.apk assets/payload.asset | tar -tz | wc -l
# → 5096

ls src/java2/classes | wc -l                              # → 124
grep -h '^\.method' src/java2/classes/*.smali | wc -l     # → 544
```

---

## 边界（先说清楚，避免期待错位）

1. **没有「可编译的 Java 工程」**。`docs/02` 是可读重建，不是能 `./gradlew build` 的工程；
   要编回 APK 只需改 smali 后重打包（本包无自校验，重签即可）。
   **这条已实测**：用本机 MT MCP 改 `versionName` 后重签，29 个条目里 25 个字节级一致、业务负载零变化，
   自研 `axml.py` 解码新旧 manifest 只差改动那一行，v1 签名链 26/26 摘要自校验通过（见 `docs/04 §2`）。
   注意 MT 的签名密钥是 AOSP 测试密钥，与原厂证书不同 → **同包名不能覆盖安装，需先卸载**。
   已在 Android 16（SDK 36）真机装起跑通：`versionName` 显示 `12.71-mcp`，启动后 `core已启动`、
   `桌宠悬浮窗已启动 -> 127.0.0.1:7797/pet`，崩溃缓冲为空。
2. **包内没有任何可用 API Key**。`home/providers/` 下 9 个 provider 的 `.env` 全是注释模板，
   默认 `activeProvider=deepseek`，首次使用必须自己填。
3. **工具链 v3 已修 4 处**（`22s` 寄存器位域、switch/array payload、`field_ids` 字段名、`axml.py` 的 resource map），
   只剩「少数 `invoke` 签名文本拼错」不修（不影响读法）。旧基线留在 `src/java2_v2/`，
   逐行差异见 `log/dex2smali-v2-to-v3.diff`，修法与影响面写在 `docs/04 §12`。

更完整的「未取证 / 未逐行 / 有意不做」清单见 `docs/00 §8`。
