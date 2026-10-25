#!/usr/bin/env python3
"""读取 DEX 中某个类的 static_values（encoded_array），把 static final 常量的
真实值打出来。反汇编器只打字段声明，不打这个数组，所以 PET_HOST_SHIM 这类
编译期常量必须靠这里取。

用法: python3 read_static.py <dex> <Lcom/foo/Bar;>
"""
import sys, struct

def uleb(buf, off):
    r = 0; sh = 0
    while True:
        b = buf[off]; off += 1
        r |= (b & 0x7f) << sh
        if not (b & 0x80):
            return r, off
        sh += 7

def mutf8(b):
    return b.decode('utf-8', 'replace')

def main():
    path, want = sys.argv[1], sys.argv[2]
    buf = open(path, 'rb').read()
    string_ids_size, string_ids_off = struct.unpack_from('<II', buf, 56)
    type_ids_size, type_ids_off = struct.unpack_from('<II', buf, 64)
    field_ids_off = struct.unpack_from('<I', buf, 84)[0]
    class_defs_size, class_defs_off = struct.unpack_from('<II', buf, 96)

    def get_string(idx):
        off = struct.unpack_from('<I', buf, string_ids_off + idx * 4)[0]
        n, p = uleb(buf, off)
        return mutf8(buf[p:p + n])

    def type_name(idx):
        sidx = struct.unpack_from('<I', buf, type_ids_off + idx * 4)[0]
        return get_string(sidx)

    def read_value(off, depth=0):
        hdr = buf[off]; off += 1
        vtype = hdr & 0x1f
        varg = (hdr >> 5) & 0x07
        size = varg + 1
        # 标量值：小端 size 字节
        if vtype in (0x00, 0x02, 0x03, 0x04, 0x06, 0x10, 0x11, 0x15, 0x16,
                     0x17, 0x18, 0x19, 0x1a, 0x1b):
            raw = buf[off:off + size]
            v = int.from_bytes(raw, 'little')
            off += size
            if vtype == 0x17:      # VALUE_STRING
                return ('str', get_string(v)), off
            if vtype == 0x00:      # VALUE_BYTE
                return ('byte', v), off
            if vtype == 0x02:      # VALUE_SHORT
                if v & (1 << (size * 8 - 1)): v -= 1 << (size * 8)
                return ('short', v), off
            if vtype == 0x03:      # VALUE_CHAR
                return ('char', v), off
            if vtype == 0x04:      # VALUE_INT
                if v & (1 << (size * 8 - 1)): v -= 1 << (size * 8)
                return ('int', v), off
            if vtype == 0x06:      # VALUE_LONG
                return ('long', v), off
            if vtype == 0x10:      # VALUE_FLOAT
                return ('float', struct.unpack('<f', raw.ljust(4, b'\0'))[0]), off
            if vtype == 0x11:      # VALUE_DOUBLE
                return ('double', struct.unpack('<d', raw.ljust(8, b'\0'))[0]), off
            if vtype == 0x15:      # VALUE_METHOD_TYPE
                return ('method_type', v), off
            if vtype == 0x16:      # VALUE_METHOD_HANDLE
                return ('method_handle', v), off
            if vtype == 0x18:      # VALUE_TYPE
                return ('type', type_name(v)), off
            if vtype == 0x19:      # VALUE_FIELD
                return ('field', v), off
            if vtype == 0x1a:      # VALUE_METHOD
                return ('method', v), off
            if vtype == 0x1b:      # VALUE_ENUM
                return ('enum', v), off
            return ('?%02x' % vtype, v), off
        if vtype == 0x1c:          # VALUE_ARRAY
            n, off = uleb(buf, off)
            arr = []
            for _ in range(n):
                val, off = read_value(off, depth + 1)
                arr.append(val)
            return ('array', arr), off
        if vtype == 0x1d:          # VALUE_ANNOTATION
            tidx, off = uleb(buf, off)
            n, off = uleb(buf, off)
            pairs = []
            for _ in range(n):
                ni, off = uleb(buf, off)
                val, off = read_value(off, depth + 1)
                pairs.append((get_string(ni), val))
            return ('annotation', type_name(tidx), pairs), off
        if vtype == 0x1e:          # VALUE_NULL
            return ('null', None), off
        if vtype == 0x1f:          # VALUE_BOOLEAN
            return ('boolean', bool(varg)), off
        return ('?%02x' % vtype, None), off

    for i in range(class_defs_size):
        base = class_defs_off + i * 32
        cidx = struct.unpack_from('<I', buf, base)[0]
        name = type_name(cidx)
        if name != want:
            continue
        class_data_off = struct.unpack_from('<I', buf, base + 24)[0]
        static_values_off = struct.unpack_from('<I', buf, base + 28)[0]
        print('class:', name)
        print('class_data_off=0x%x static_values_off=0x%x' % (class_data_off, static_values_off))
        if static_values_off == 0:
            print('(no static_values)')
            return
        # 先取 static 字段名顺序（field_idx 是 diff 编码，必须累加）
        names = []
        if class_data_off:
            p = class_data_off
            sf, p = uleb(buf, p)
            inf, p = uleb(buf, p)
            dm, p = uleb(buf, p)
            vm, p = uleb(buf, p)
            idx = 0
            for _ in range(sf):
                d, p = uleb(buf, p)
                idx += d
                _acc, p = uleb(buf, p)
                names.append(idx)
        n, p = uleb(buf, static_values_off)
        print('static_values count=%d' % n)
        for k in range(n):
            val, p = read_value(p)
            fname = '?'
            if k < len(names):
                foff = field_ids_off + names[k] * 8
                nidx = struct.unpack_from('<I', buf, foff + 4)[0]
                fname = get_string(nidx)
            print('  [%d] %-18s %r' % (k, fname, val))
        return
    print('class not found:', want)

main()