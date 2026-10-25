#!/usr/bin/env python3
"""上游对账：src/recovered/（入仓源码树）↔ src/rootfs/app/coop-stage/（APK 部署态）。

验收目标
--------
同相对路径的文件必须 sha256 相同 —— 证明入仓的是「APK 里真正跑的那份代码」，
而不是同名不同版的上游快照。这是 P0 的验收条件。

映射（rootfs 侧是文件系统里的实际布局，recovered 侧是整理后的源码树）
------------------------------------------------------------------
  recovered/coop-stage/{package.json,package-lock.json,run-core.mjs,app,home}
      ↔ rootfs/app/coop-stage/同名
  recovered/cortico              ↔ rootfs/app/coop-stage/build/cortico
  recovered/vendor/{coo,cua,pet} ↔ rootfs/app/coop-stage/vendor/同名

判定规则
--------
  diff     两侧都有但内容不同  → 失败
  only_b   只在部署态存在      → 失败（源码树没覆盖到运行态 = 缺口）
  only_a   只在源码树存在      → 不算失败；dist/ 等构建产物按 DEPS.md 本就该只在一侧

用法
----
    python3 tools/recon_upstream.py            # 人读
    python3 tools/recon_upstream.py --json     # 机器读
退出码 0 = 无 diff / 无 only_b。
"""

import argparse
import hashlib
import json
import os
import sys

EXCLUDE_DIRS = {"node_modules", ".git", "__pycache__"}

# rootfs 里 coop-stage 根目录还挂着 build/ vendor/ node_modules/，
# 所以 stage-root 这一组只比这几个顶层项。
# 注：boot.sh 不在这个列表里——rootfs 侧它在 app/boot.sh，见 PAIRS 的 boot-sh 项。
STAGE_SUBSET = ["package.json", "package-lock.json", "run-core.mjs", "app", "home"]

PAIRS = [
    ("stage-root", "coop-stage", "app/coop-stage"),
    ("cortico", "cortico", "app/coop-stage/build/cortico"),
    ("vendor/coo", "vendor/coo", "app/coop-stage/vendor/coo"),
    ("vendor/cua", "vendor/cua", "app/coop-stage/vendor/cua"),
    ("vendor/pet", "vendor/pet", "app/coop-stage/vendor/pet"),
    # boot.sh 在 rootfs 里挂在 app/ 下（运行时就是 /app/boot.sh），
    # recovered 侧整理进了 coop-stage/，两侧形态不同，
    # 所以单列一条 PAIR，而不是塞进 STAGE_SUBSET。
    ("boot-sh", "coop-stage/boot.sh", "app/boot.sh"),
]


def sha256(path):
    h = hashlib.sha256()
    with open(path, "rb") as f:
        for chunk in iter(lambda: f.read(1 << 20), b""):
            h.update(chunk)
    return h.hexdigest()


def walk(root, subset=None):
    """返回 {相对路径: sha256}；目录不存在返回 {}。

    root 也可以是单个文件（用于 boot.sh 这种两侧形态不同的对象），
    此时返回 {basename: sha256}。
    """
    out = {}
    if os.path.isfile(root):
        return {os.path.basename(root): sha256(root)}
    if not os.path.isdir(root):
        return out

    def add(full):
        rel = os.path.relpath(full, root).replace(os.sep, "/")
        out[rel] = sha256(full)

    def scan(p):
        for dirpath, dirnames, filenames in os.walk(p):
            dirnames[:] = [d for d in dirnames if d not in EXCLUDE_DIRS]
            for fn in filenames:
                add(os.path.join(dirpath, fn))

    if subset:
        for name in subset:
            p = os.path.join(root, name)
            if os.path.isfile(p):
                out[name] = sha256(p)
            elif os.path.isdir(p):
                scan(p)
        return out

    scan(root)
    return out


def main(argv):
    ap = argparse.ArgumentParser()
    ap.add_argument("--root", default=".", help="仓库根（含 src/recovered 与 src/rootfs）")
    ap.add_argument("--json", action="store_true")
    ap.add_argument("--limit", type=int, default=15, help="每组最多列出的差异条数")
    args = ap.parse_args(argv[1:])

    rec = os.path.join(args.root, "src", "recovered")
    run = os.path.join(args.root, "src", "rootfs")

    if not os.path.isdir(rec) or not os.path.isdir(run):
        print("缺少 src/recovered 或 src/rootfs；后者需按 BASELINE §3 解包复原", file=sys.stderr)
        return 2

    report = {"ok": True, "pairs": []}
    for label, a_rel, b_rel in PAIRS:
        a_root = os.path.join(rec, a_rel)
        b_root = os.path.join(run, b_rel)
        subset = STAGE_SUBSET if label == "stage-root" else None
        a = walk(a_root, subset)
        b = walk(b_root, subset)

        same = [k for k in a if k in b and a[k] == b[k]]
        diff = sorted(k for k in a if k in b and a[k] != b[k])
        only_a = sorted(set(a) - set(b))
        only_b = sorted(set(b) - set(a))
        ok = not diff and not only_b

        report["pairs"].append({
            "label": label,
            "recovered": a_rel,
            "rootfs": b_rel,
            "both": len(same) + len(diff),
            "same": len(same),
            "diff": diff,
            "only_recovered": only_a,
            "only_rootfs": only_b,
            "ok": ok,
        })
        if not ok:
            report["ok"] = False

    if args.json:
        print(json.dumps(report, ensure_ascii=False, indent=2))
    else:
        for p in report["pairs"]:
            flag = "OK  " if p["ok"] else "FAIL"
            print(f'[{flag}] {p["label"]:<12} both={p["both"]:<4} same={p["same"]:<4} '
                  f'diff={len(p["diff"])} only_rec={len(p["only_recovered"])} only_run={len(p["only_rootfs"])}')
            for k in p["diff"][:args.limit]:
                print(f'         DIFF   {k}')
            if len(p["diff"]) > args.limit:
                print(f'         ...还有 {len(p["diff"]) - args.limit} 条')
            for k in p["only_rootfs"][:args.limit]:
                print(f'         MISS   {k}  仅在部署态')
            for k in p["only_recovered"][:args.limit]:
                print(f'         extra  {k}  仅在源码树')
            if len(p["only_recovered"]) > args.limit:
                print(f'         ...还有 {len(p["only_recovered"]) - args.limit} 条 extra')
        print()
        total_both = sum(p["both"] for p in report["pairs"])
        total_same = sum(p["same"] for p in report["pairs"])
        print(f'合计：{total_both} 个同名文件，{total_same} 个 sha256 相同'
              f'（{total_same}/{total_both}）')
        print("结论：" + ("✅ 入仓源码与部署态完全一致" if report["ok"] else "❌ 存在差异，见上"))

    return 0 if report["ok"] else 1


if __name__ == "__main__":
    sys.exit(main(sys.argv))
