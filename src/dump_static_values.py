#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""把 DEX 里所有类的 static_values 一次性 dump 出来，供文档数值核对。

背景：反汇编器（dex2smali.py）只打 `.field` 声明、不打 `static_values`，
而本项目大量「协议常量」（端口、超时、缓存窗口、错误串）都是编译期常量，
文档一旦凭猜测写就必然错（EyesService 的 5 个常量曾被写错 4 个）。

用法:
    python3 dump_static_values.py src/x/classes.dex src/x/classes2.dex > src/static_values.txt

输出每行：
    Lcom/foo/Bar;    FIELD_NAME = <值>

注意：`field_idx` 在 class_data_item 里是 **diff 编码**（要累加），
早期 read_static.py 漏了这一步导致字段名整体错位，本脚本已修正。
"""
import struct
import sys


def uleb(buf, off):
    r = 0
    sh = 0
    while True:
        b = buf[off]
        off += 1
        r |= (b & 0x7F) << sh
        if not (b & 0x80):
            return r, off
        sh += 7


def parse(path, out):
    buf = open(path, "rb").read()
    string_ids_off = struct.unpack_from("<I", buf, 60)[0]
    type_ids_off = struct.unpack_from("<I", buf, 68)[0]
    field_ids_off = struct.unpack_from("<I", buf, 84)[0]
    class_defs_size, class_defs_off = struct.unpack_from("<II", buf, 96)

    def get_string(idx):
        off = struct.unpack_from("<I", buf, string_ids_off + idx * 4)[0]
        n, p = uleb(buf, off)
        return buf[p:p + n].decode("utf-8", "replace")

    def type_name(idx):
        sidx = struct.unpack_from("<I", buf, type_ids_off + idx * 4)[0]
        return get_string(sidx)

    def read_value(off):
        hdr = buf[off]
        off += 1
        vtype = hdr & 0x1F
        varg = (hdr >> 5) & 0x07
        size = varg + 1
        if vtype == 0x1F:                       # VALUE_BOOLEAN
            return ("boolean", bool(varg)), off
        if vtype == 0x1E:                       # VALUE_NULL
            return ("null", None), off
        if vtype == 0x1D:                       # VALUE_ANNOTATION（本项目未用到）
            return ("annotation", None), off
        if vtype in (0x00, 0x02, 0x03, 0x04, 0x06,
                     0x10, 0x11, 0x17, 0x18):
            raw = buf[off:off + size]
            v = int.from_bytes(raw, "little")
            off += size
            if vtype == 0x17:                   # VALUE_STRING
                return ("str", get_string(v)), off
            if vtype == 0x18:                   # VALUE_TYPE
                return ("type", type_name(v)), off
            if vtype == 0x04:                   # VALUE_INT
                if v & (1 << (size * 8 - 1)):
                    v -= 1 << (size * 8)
                return ("int", v), off
            if vtype == 0x02:                   # VALUE_SHORT
                if v & (1 << (size * 8 - 1)):
                    v -= 1 << (size * 8)
                return ("short", v), off
            if vtype == 0x06:                   # VALUE_LONG
                return ("long", v), off
            if vtype == 0x10:                   # VALUE_FLOAT
                return ("float", struct.unpack("<f", raw.ljust(4, b"\0"))[0]), off
            if vtype == 0x11:                   # VALUE_DOUBLE
                return ("double", struct.unpack("<d", raw.ljust(8, b"\0"))[0]), off
            return ("byte", v), off
        if vtype == 0x1C:                       # VALUE_ARRAY
            n, off = uleb(buf, off)
            arr = []
            for _ in range(n):
                v, off = read_value(off)
                arr.append(v)
            return ("array", arr), off
        return ("?%02x" % vtype, None), off

    for i in range(class_defs_size):
        base = class_defs_off + i * 32
        cidx = struct.unpack_from("<I", buf, base)[0]
        name = type_name(cidx)
        class_data_off = struct.unpack_from("<I", buf, base + 24)[0]
        static_values_off = struct.unpack_from("<I", buf, base + 28)[0]
        if not static_values_off:
            continue
        # static 字段名（field_idx 为 diff 编码，必须累加）
        names = []
        if class_data_off:
            p = class_data_off
            sf, p = uleb(buf, p)
            p = uleb(buf, p)[1]      # instance_fields_size
            p = uleb(buf, p)[1]      # direct_methods_size
            p = uleb(buf, p)[1]      # virtual_methods_size
            idx = 0
            for _ in range(sf):
                d, p = uleb(buf, p)
                idx += d
                p = uleb(buf, p)[1]
                names.append(idx)
        n, p = uleb(buf, static_values_off)
        for k in range(n):
            val, p = read_value(p)
            fname = "?"
            if k < len(names):
                nidx = struct.unpack_from("<I", buf, field_ids_off + names[k] * 8 + 4)[0]
                fname = get_string(nidx)
            out.append((name, fname, val))


def main():
    out = []
    for path in sys.argv[1:]:
        parse(path, out)
    out.sort()
    for cls, fname, (vt, v) in out:
        if isinstance(v, str):
            shown = '"%s"' % v
        elif isinstance(v, list):
            shown = str(v)
        else:
            shown = str(v)
        print("%-58s %-22s = %s   (%s)" % (cls, fname, shown, vt))


if __name__ == "__main__":
    main()