#!/usr/bin/env python3
"""依赖树等价性校验：复原出的 node_modules ↔ APK 部署态的 node_modules。

用途（P0/P4/P5 的回归防线）：
    先按 DEPS.md §2 的两步命令复原一份 node_modules，再用本工具与部署态比对，
    确认「一条命令复原」得到的依赖树与 APK 里跑的完全等价。

对比维度（三层，从强到弱）：
    1. 包清单   —— 每个顶层条目（含 @scope/name）是否两侧都有
    2. 版本     —— 每个包的 package.json version 是否一致
    3. 体积     —— 每个包的 文件数 / 字节数 是否一致（能抓到 postinstall 差异）

已知合理差异（不算失败，工具会单列）：
    - 软链：`cortico` / `cortico-provider-coo` / `cortico-world-cua` /
      `cortico-world-desktop-pet` 是部署时手工 `ln -s` 到仓库内本地包的，
      npm 不会创建，复原脚本需自己补 4 条 `ln -s`。
    - `esbuild/bin/esbuild`：部署态是 postinstall 从 `@esbuild/linux-arm64`
      拷来的真二进制（10,289,264 B），跳过 scripts 复原时仍是 9,350 B 的
      JS shim。补跑 `node node_modules/esbuild/install.js` 即等价。
    - `sherpa-onnx-node/node_modules/sherpa-onnx-linux-arm64`：部署态多一份
      嵌套副本（约 40 MB），npm 重装会把它提升到顶层；`addon.js` 的
      `../sherpa-onnx-linux-arm64` 兜底路径使两种布局等价。

用法：
    python3 tools/check_deps.py <复原的 node_modules> [<部署态 node_modules>]
    python3 tools/check_deps.py --json ...
默认部署态 = src/rootfs/app/coop-stage/node_modules（git-ignored 的本地抽取）。
退出码：0 = 等价；1 = 有差异；2 = 输入缺失。
"""
import json
import os
import sys

DEFAULT_REF = os.path.join(
    os.path.dirname(os.path.dirname(os.path.abspath(__file__))),
    "src", "rootfs", "app", "coop-stage", "node_modules",
)

KNOWN_LINKS = {
    "cortico",
    "cortico-provider-coo",
    "cortico-world-cua",
    "cortico-world-desktop-pet",
}


def scan(root):
    """扫描 node_modules 顶层，返回 {name: {'kind','version','files','bytes','link'}}。

    @scope/name 展开为独立条目；软链记为 kind='link' 并记录目标。
    嵌套的 node_modules 不计入顶层条目（体积统计里自然含进所属包）。
    """
    out = {}
    for entry in sorted(os.listdir(root)):
        if entry.startswith("."):
            continue
        full = os.path.join(root, entry)
        if os.path.islink(full):
            out[entry] = {
                "kind": "link",
                "link": os.readlink(full),
                "version": None,
                "files": 0,
                "bytes": 0,
            }
            continue
        if not os.path.isdir(full):
            continue
        if entry.startswith("@"):
            for sub in sorted(os.listdir(full)):
                path = os.path.join(full, sub)
                if os.path.isdir(path):
                    out[f"{entry}/{sub}"] = measure(path, sub)
        else:
            out[entry] = measure(full, entry)
    return out


def measure(path, name):
    version = None
    pj = os.path.join(path, "package.json")
    if os.path.exists(pj):
        try:
            with open(pj) as f:
                version = str(json.load(f).get("version"))
        except Exception:  # noqa: BLE001
            version = "<bad-manifest>"
    files = 0
    total = 0
    for dirpath, dirnames, filenames in os.walk(path, followlinks=False):
        # 嵌套 node_modules 里的包单独计数会破坏「按顶层包聚合」的口径，
        # 这里保留（部署态与复原态都会走到），只保证两侧口径一致。
        for dn in list(dirnames):
            p = os.path.join(dirpath, dn)
            if os.path.islink(p):
                dirnames.remove(dn)
        for fn in filenames:
            fp = os.path.join(dirpath, fn)
            if os.path.islink(fp):
                continue
            # proot --link2symlink 的伪硬链接残留：真数据落成 .l2s.xxx 文件，
            # 原文件名变成指向它的软链。真机 Linux 上不存在，比对时忽略。
            if fn.startswith(".l2s."):
                continue
            try:
                st = os.lstat(fp)
            except OSError:
                continue
            files += 1
            total += st.st_size
    return {"kind": "dir", "version": version, "files": files, "bytes": total}


def compare(mine, ref):
    """返回 (problems, notes)。problems 是必须一致的项，notes 是已知合理差异。"""
    problems = []
    notes = []
    names = sorted(set(mine) | set(ref))
    for n in names:
        a = mine.get(n)
        b = ref.get(n)
        if a is None or b is None:
            side = "仅在复原侧" if b is None else "仅在部署侧"
            if (a or b)["kind"] == "link" and n in KNOWN_LINKS:
                notes.append(f"{n}: {side}（本地包软链，复原需手工 ln -s）")
            else:
                problems.append(f"{n}: {side}")
            continue
        if a["kind"] != b["kind"]:
            if "link" in (a["kind"], b["kind"]) and n in KNOWN_LINKS:
                notes.append(f"{n}: 软链/实体不同（复原侧 {a['kind']}，部署侧 {b['kind']}）")
            else:
                problems.append(f"{n}: 类型不同（{a['kind']} vs {b['kind']}）")
            continue
        if a["kind"] == "link":
            if a["link"] != b["link"]:
                problems.append(f"{n}: 软链目标不同（{a['link']} vs {b['link']}）")
            continue
        if a["version"] != b["version"]:
            problems.append(f"{n}: 版本不同（{a['version']} vs {b['version']}）")
        if a["files"] != b["files"] or a["bytes"] != b["bytes"]:
            delta = b["bytes"] - a["bytes"]
            if n == "esbuild":
                notes.append(
                    f"esbuild: 体积差 {delta:+} B（postinstall 未跑，bin/esbuild 仍是 JS shim；"
                    "跑 node node_modules/esbuild/install.js 即等价）"
                )
            elif n == "sherpa-onnx-node":
                notes.append(
                    f"sherpa-onnx-node: 体积差 {delta:+} B（部署态多一份嵌套 "
                    "sherpa-onnx-linux-arm64；addon.js 兜底路径使两种布局等价）"
                )
            else:
                problems.append(
                    f"{n}: 体积不同（{a['files']} 文件/{a['bytes']} B vs "
                    f"{b['files']} 文件/{b['bytes']} B）"
                )
    return problems, notes


def main(argv):
    as_json = "--json" in argv
    args = [a for a in argv[1:] if not a.startswith("--")]
    if not args:
        print(__doc__)
        return 2
    mine_root = args[0]
    ref_root = args[1] if len(args) > 1 else DEFAULT_REF
    for label, p in (("复原侧", mine_root), ("部署侧", ref_root)):
        if not os.path.isdir(p):
            print(f"缺少{label}目录：{p}")
            return 2

    mine = scan(mine_root)
    ref = scan(ref_root)
    problems, notes = compare(mine, ref)

    if as_json:
        print(json.dumps(
            {
                "ok": not problems,
                "mine": {"root": mine_root, "entries": len(mine)},
                "ref": {"root": ref_root, "entries": len(ref)},
                "problems": problems,
                "notes": notes,
            },
            ensure_ascii=False,
            indent=2,
        ))
        return 0 if not problems else 1

    print(f"复原侧 {mine_root}：{len(mine)} 个顶层条目")
    print(f"部署侧 {ref_root}：{len(ref)} 个顶层条目")
    print()
    if notes:
        print(f"已知合理差异（{len(notes)} 项）：")
        for n in notes:
            print(f"  · {n}")
        print()
    if problems:
        print(f"❌ 非预期差异（{len(problems)} 项）：")
        for p in problems:
            print(f"  ! {p}")
        return 1
    print("✅ 依赖树等价：包清单 / 版本 / 体积全部一致（或仅剩上面已定性的合理差异）")
    return 0


if __name__ == "__main__":
    sys.exit(main(sys.argv))
