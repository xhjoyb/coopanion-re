#!/usr/bin/env python3
"""解析 resources.arsc（Android ResTable），无第三方依赖。

用途：把 APK 里 2,440 B 的资源表还原成可读的「type/name → 值」，供 P1 资源层还原使用。

用法：
    python3 tools/parse_arsc.py src/x/resources.arsc          # 全量 dump
    python3 tools/parse_arsc.py --json src/x/resources.arsc   # JSON 输出

设计取舍：只解析本项目用到的结构（单 package、无 sparse 表、无 overlayable），
遇到不认识的 chunk 直接跳过并打印，不猜。
"""

import json
import struct
import sys

RES_STRING_POOL = 0x0001
RES_TABLE = 0x0002
RES_TABLE_PACKAGE = 0x0200
RES_TABLE_TYPE = 0x0201
RES_TABLE_TYPE_SPEC = 0x0202

TYPE_NAMES = {
    0x00: "null", 0x01: "ref", 0x02: "attr", 0x03: "string",
    0x04: "float", 0x05: "dimen", 0x06: "fraction", 0x07: "dynamic_ref",
    0x08: "int_dec", 0x10: "int_hex", 0x11: "int_bool",
    0x12: "int_color_argb8", 0x1C: "int_color_rgb8",
}

DENSITY = {0: "anydpi", 120: "ldpi", 160: "mdpi", 213: "tvdpi",
           240: "hdpi", 320: "xhdpi", 480: "xxhdpi", 640: "xxxhdpi"}


def u2(d, o):
    return struct.unpack_from("<H", d, o)[0]


def u4(d, o):
    return struct.unpack_from("<I", d, o)[0]


def i4(d, o):
    return struct.unpack_from("<i", d, o)[0]


def parse_string_pool(d, off):
    """返回该 chunk 内所有字符串（按索引）。"""
    typ, hsize, size = u2(d, off), u2(d, off + 2), u4(d, off + 4)
    assert typ == RES_STRING_POOL, f"not string pool @{off:#x}: {typ:#x}"
    count, style_count, flags, str_start = (u4(d, off + 8), u4(d, off + 12),
                                            u4(d, off + 16), u4(d, off + 20))
    utf8 = bool(flags & 0x100)
    out = []
    for i in range(count):
        p = off + str_start + u4(d, off + hsize + i * 4)
        if utf8:
            # 两段 uleb128 长度（字符数、字节数），跳过
            for _ in range(2):
                while d[p] & 0x80:
                    p += 1
                p += 1
            end = d.index(b"\x00", p)
            out.append(d[p:end].decode("utf-8", "replace"))
        else:
            n = u2(d, p)
            p += 2
            if n & 0x8000:
                n = ((n & 0x7FFF) << 16) | u2(d, p)
                p += 2
            out.append(d[p:p + n * 2].decode("utf-16-le", "replace"))
    return out


def parse_config(d, off):
    """把 ResTable_config 转成目录限定符（如 mdpi / zh-rCN / land），只覆盖常用字段。"""
    size = u4(d, off)
    parts = []
    if size >= 12:
        mcc, mnc = u2(d, off + 4), u2(d, off + 6)
        if mcc:
            parts.append(f"mcc{mcc}")
        if mnc:
            parts.append(f"mnc{mnc}")
    if size >= 16:
        lang = d[off + 8:off + 10].rstrip(b"\x00")
        country = d[off + 10:off + 12].rstrip(b"\x00")
        if lang:
            parts.append(lang.decode("ascii", "replace"))
        if country:
            parts.append("r" + country.decode("ascii", "replace"))
    if size >= 28:
        density = u2(d, off + 14)
        if density:
            parts.append(DENSITY.get(density, f"{density}dpi"))
    if size >= 40:
        sdk = u2(d, off + 24)
        if sdk:
            parts.append(f"v{sdk}")
    return "-".join(parts)


def fmt_value(d, dtype, data, pool):
    if dtype == 0x03:
        return f'"{pool[data]}"' if data < len(pool) else f"<bad str {data}>"
    if dtype in (0x01, 0x02, 0x07):
        return f"@{data:#010x}"
    if dtype == 0x11:
        return "true" if data else "false"
    if dtype == 0x12:
        return f"#{data:#010x}"
    if dtype in (0x10, 0x1C):
        return f"{data:#x}"
    if dtype == 0x08:
        return str(i4(d, 0) if False else struct.unpack("<i", struct.pack("<I", data))[0])
    return f"{data:#x}"


def entry_offsets(d, p, h2, flags, entry_count, entries_start):
    """返回 [(资源索引, 条目相对偏移)]，兼容 dense / sparse / offset16 三种布局。

    ResTable_type.flags: bit0 = FLAG_SPARSE，bit1 = FLAG_OFFSET16。
    dense    : u32 偏移数组，0xFFFFFFFF 表示无条目。
    offset16 : u16 偏移数组，单位为 4 字节，0xFFFF 表示无条目。
    sparse   : (u16 资源索引, u16 偏移/4) 对，无哨兵。
    """
    if entries_start == 0 or entry_count == 0:
        return []
    idx = p + h2
    out = []
    if flags & 0x01:                      # FLAG_SPARSE
        for i in range(entry_count):
            b = idx + i * 4
            out.append((u2(d, b), u2(d, b + 2) * 4))
    elif flags & 0x02:                    # FLAG_OFFSET16
        for i in range(entry_count):
            off = u2(d, idx + i * 2)
            if off != 0xFFFF:
                out.append((i, off * 4))
    else:                                 # dense
        for i in range(entry_count):
            off = u4(d, idx + i * 4)
            if off != 0xFFFFFFFF:
                out.append((i, off))
    return out


def parse(path, want=None):
    d = open(path, "rb").read()
    assert u2(d, 0) == RES_TABLE, "not an arsc"
    o = u2(d, 2)                     # headerSize
    pool = None
    packages = []
    while o < len(d):
        typ, hsize, size = u2(d, o), u2(d, o + 2), u4(d, o + 4)
        if typ == RES_STRING_POOL:
            pool = parse_string_pool(d, o)
        elif typ == RES_TABLE_PACKAGE:
            pkg_id = u4(d, o + 8)
            name = d[o + 12:o + 12 + 256].decode("utf-16-le", "replace").rstrip("\x00")
            type_str_off = u4(d, o + 268)
            key_str_off = u4(d, o + 276)
            types = parse_string_pool(d, o + type_str_off)
            keys = parse_string_pool(d, o + key_str_off)
            packages.append({
                "id": pkg_id, "name": name, "types": types, "keys": keys,
                "entries": [], "raw": o, "size": size,
            })
            # 遍历 package 内的子 chunk
            p = o + hsize
            cur_type = None
            while p < o + size:
                t2, h2, s2 = u2(d, p), u2(d, p + 2), u4(d, p + 4)
                if t2 == RES_TABLE_TYPE_SPEC:
                    cur_type = d[p + 8]
                elif t2 == RES_TABLE_TYPE:
                    tid = d[p + 8]
                    flags = d[p + 9]
                    entry_count = u4(d, p + 12)
                    entries_start = u4(d, p + 16)
                    config = parse_config(d, p + 20)
                    tname = types[tid - 1] if 1 <= tid <= len(types) else f"type{tid}"
                    for i, eoff in entry_offsets(d, p, h2, flags, entry_count, entries_start):
                        e = p + entries_start + eoff
                        if e + 8 > p + s2:
                            continue
                        esize, eflags = u2(d, e), u2(d, e + 2)
                        ki = u4(d, e + 4)
                        key = keys[ki] if ki < len(keys) else f"key#{ki}"
                        rid = f"{pkg_id:#04x}{tid:02x}{i:04x}"
                        if want and rid not in want:
                            continue
                        if eflags & 0x0001:      # 复杂条目（style）
                            parent, count = u4(d, e + 8), u4(d, e + 12)
                            maps = []
                            for m in range(count):
                                mo = e + esize + m * 12
                                maps.append((u4(d, mo), u4(d, mo + 4), u4(d, mo + 8)))
                            packages[-1]["entries"].append({
                                "type": tname, "type_id": tid, "name": key,
                                "config": config, "res_id": f"{pkg_id:#04x}{tid:02x}{i:04x}",
                                "parent": f"@{parent:#010x}" if parent else None,
                                "maps": [{"key": f"@{a:#010x}",
                                          "type": TYPE_NAMES.get(t, hex(t)),
                                          "data": fmt_value(d, t, v, pool)} for a, t, v in maps],
                            })
                        else:
                            v = e + esize
                            dtype = d[v + 3]
                            data = u4(d, v + 4)
                            packages[-1]["entries"].append({
                                "type": tname, "type_id": tid, "name": key,
                                "config": config, "res_id": f"{pkg_id:#04x}{tid:02x}{i:04x}",
                                "value_type": TYPE_NAMES.get(dtype, hex(dtype)),
                                "raw": fmt_value(d, dtype, data, pool or []),
                            })
                p += s2
        o += size if size else 8
    return pool or [], packages


def main(argv):
    as_json = "--json" in argv
    ids = []
    for a in argv[1:]:
        if a.startswith("--ids="):
            ids = [x.strip().lower() for x in a.split("=", 1)[1].split(",") if x.strip()]
    args = [a for a in argv[1:] if not a.startswith("--")]
    if not args:
        print(__doc__)
        return 2
    pool, packages = parse(args[0], set(ids) or None)
    if as_json:
        print(json.dumps({"global_strings": pool, "packages": packages},
                         ensure_ascii=False, indent=2))
        return 0
    print(f"全局字符串池: {len(pool)} 条")
    for pkg in packages:
        if ids and not pkg["entries"]:
            continue                     # --ids 过滤后空包不打印（framework 有多个拆分块）
        print(f"\npackage {pkg['name']} (id={pkg['id']:#04x})  "
              f"types={len(pkg['types'])} keys={len(pkg['keys'])} entries={len(pkg['entries'])}")
        if len(pkg["types"]) <= 40:
            print(f"  types: {', '.join(f'{i + 1}={t}' for i, t in enumerate(pkg['types']))}")
        else:
            print(f"  types: 共 {len(pkg['types'])} 个（名称表过大，省略）")
        for e in pkg["entries"]:
            cfg = e["config"] or "default"
            head = f"  {e['res_id']}  {e['type']}/{e['name']}  [{cfg}]"
            if "maps" in e:
                print(head + f"  parent={e['parent']}  items={len(e['maps'])}")
                for m in e["maps"]:
                    print(f"      {m['key']} = {m['data']}")
            else:
                print(head + f"  = {e['raw']}  ({e['value_type']})")
    return 0


if __name__ == "__main__":
    sys.exit(main(sys.argv))