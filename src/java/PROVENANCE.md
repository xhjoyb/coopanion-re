# src/java · Java 层复原产物

本目录是 `classes.dex` + `classes2.dex` 里 **124 个类** 的 Java 形态。

## 怎么来的

由本仓库的 CI 工作流 `.github/workflows/decompile.yml` 生成，**不是手抄**：

```bash
# workflow_dispatch（dex 输入默认 src/x/classes.dex src/x/classes2.dex）
jadx --no-res --decompilation-mode auto -d build/jadx <dex...>
```

产物推到 `jadx-out` 分支（`java/` 目录），再由维护侧取回到本目录。每次运行的 jadx 版本、
输入 dex、上游 commit 都写在 `jadx-out` 分支的 `PROVENANCE.md` 里。

**为什么要进主分支**：`src/x/classes*.dex` 就在本仓库中，所以这份产物是**可重复生成**的；
把它放进主分支是为了之后能直接对 `.java` 做审计与差异比对，而不用每次重跑 CI。

## 与 `src/java2/classes/*.smali` 的关系

- `src/java2/classes/`：**逐类 smali**（124 个文件，baksmali 产物），是字节码的直译，用于核对细节。
- `src/java/com/palai/prootsmoke/`：**jadx 反编译的 Java**（14 个文件，匿名类/内部类被内联进外层类），
  用于阅读与交叉校验。

jadx 反编译会把 `MainActivity$17$1` 这类匿名类内联成 `new Runnable() { ... }`，
因此 **14 个文件对应 124 个类**，不是丢类。

## 交叉校验结论

`docs/02-Java层源码还原.md` 是早期**人工重建**的版本，其中 §1.3 / §1.4（启动链）已用本目录的
`MainActivity.java` 逐句校正，改正 8 处（详见该文档「校正记录」表）。其余章节尚未逐条对照，
状态记在 `BASELINE.md §7 P2`。

> 注意：jadx 输出保留 `/* JADX INFO: ... */` 注释与混淆变量名（`z`、`str`、`i2`），
> 可读版本请看 `docs/02`；本目录的作用是**可编译/可比对的基线**。