#!/usr/bin/env python3
"""校验 src/android 资源树与 resources.arsc 是否完全对齐（P1 自检）。

做三件事：
  1) 用 tools/parse_arsc.py 解析 src/x/resources.arsc，得到「类型/名字 → 资源 id」与文件型条目映射；
  2) 扫描 src/android 下的 XML，收集所有 @type/name 引用，检查是否都能在 arsc 里找到；
  3) 反向检查：arsc 里每个文件型条目（res/…png）在 src/android/res 下都真实存在，
     且 res 下除 values/ 外的文件都被 arsc 引用（无多余文件）。

用法：
    python3 tools/check_res.py                     # 默认仓库内路径
    python3 tools/check_res.py --root . --json     # 机器可读
退出码：0 全通过，1 有不一致。
"""
import json
import os
import re
import sys
import xml.etree.ElementTree as ET

sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
from parse_arsc import parse                    # noqa: E402

REF_RE = re.compile(r"@(mipmap|style|string|xml|drawable|layout|color|dimen|bool|integer)/"
                    r"([A-Za-z0-9_.]+)")


def norm_res_path(p):
    """arsc 里的 res/mipmap-mdpi-v4/ic_launcher.png → mipmap-mdpi/ic_launcher.png

    返回值相对 res/ 目录；同时去掉 aapt2 自动加的 -vN 版本限定符。
    """
    if p.startswith("res/"):
        p = p[len("res/"):]
    parts = p.split("/")
    return "/".join(re.sub(r"-v\d+$", "", s) if i == 0 else s for i, s in enumerate(parts))


def walk_xml(root_dir):
    for base, _dirs, files in os.walk(root_dir):
        for f in files:
            if f.endswith(".xml"):
                yield os.path.join(base, f)


def main(argv):
    as_json = "--json" in argv
    root = "."
    for i, a in enumerate(argv):
        if a == "--root" and i + 1 < len(argv):
            root = argv[i + 1]

    arsc = os.path.join(root, "src/x/resources.arsc")
    android = os.path.join(root, "src/android")
    res_dir = os.path.join(android, "res")

    _pool, packages = parse(arsc)
    ids, file_paths = {}, set()
    for pkg in packages:
        for e in pkg["entries"]:
            key = (e["type"], e["name"])
            ids.setdefault(key, e["res_id"])
            raw = e.get("raw") or ""
            if raw.startswith('"res/'):
                file_paths.add(norm_res_path(raw.strip('"')))

    refs, xml_errors = [], []
    for path in sorted(walk_xml(android)):
        try:
            ET.parse(path)
        except ET.ParseError as exc:
            xml_errors.append({"file": os.path.relpath(path, root), "error": str(exc)})
            continue
        text = open(path, encoding="utf-8").read()
        for typ, name in REF_RE.findall(text):
            refs.append({"file": os.path.relpath(path, root), "ref": f"@{typ}/{name}",
                         "key": (typ, name)})

    missing_refs = [r for r in refs if r["key"] not in ids]
    missing_files = [p for p in sorted(file_paths)
                     if not os.path.exists(os.path.join(res_dir, p))]

    on_disk = set()
    for base, _dirs, fs in os.walk(res_dir):
        if os.path.basename(base) == "values":
            continue
        for f in fs:
            on_disk.add(os.path.relpath(os.path.join(base, f), res_dir))
    extra_files = sorted(on_disk - file_paths)

    ok = not (missing_refs or missing_files or extra_files or xml_errors)
    report = {
        "ok": ok,
        "arsc_entries": sum(len(p["entries"]) for p in packages),
        "arsc_symbols": len(ids),
        "arsc_files": len(file_paths),
        "xml_files": len(list(walk_xml(android))),
        "refs": len(refs),
        "missing_refs": missing_refs,
        "missing_files": missing_files,
        "extra_files": extra_files,
        "xml_errors": xml_errors,
    }
    if as_json:
        print(json.dumps(report, ensure_ascii=False, indent=2))
        return 0 if ok else 1

    print(f"arsc：{report['arsc_entries']} 条配置 × 条目 / {report['arsc_symbols']} 个符号 / "
          f"{report['arsc_files']} 个文件型条目")
    print(f"源树：{report['xml_files']} 个 XML / {report['refs']} 处 @type/name 引用")
    if missing_refs:
        print("\n✗ 引用了不存在的资源：")
        for r in missing_refs:
            print(f"  {r['file']}: {r['ref']}")
    if missing_files:
        print("\n✗ arsc 指向但不存在的文件：")
        for f in missing_files:
            print(f"  {f['key']} → {f['expect']}")
    if extra_files:
        print("\n✗ res/ 下多余（arsc 未引用）的文件：")
        for f in extra_files:
            print(f"  {f}")
    if xml_errors:
        print("\n✗ XML 无法解析：")
        for e in xml_errors:
            print(f"  {e['file']}: {e['error']}")
    print("\n" + ("✅ 资源树与 arsc 完全对齐" if ok else "❌ 存在不一致，见上"))
    return 0 if ok else 1


if __name__ == "__main__":
    sys.exit(main(sys.argv))