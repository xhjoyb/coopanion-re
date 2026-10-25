#!/usr/bin/env python3
"""dex2smali: minimal Dalvik bytecode disassembler (no deps).

Usage: python3 dex2smali.py <classes.dex> [class-filter]
"""
import struct
import sys

OPS = {
    0x00: ('nop', '10x'), 0x01: ('move', '12x'), 0x02: ('move/from16', '22x'),
    0x03: ('move/16', '32x'), 0x04: ('move-wide', '12x'), 0x05: ('move-wide/from16', '22x'),
    0x06: ('move-wide/16', '32x'), 0x07: ('move-object', '12x'), 0x08: ('move-object/from16', '22x'),
    0x09: ('move-object/16', '32x'), 0x0a: ('move-result', '11x'), 0x0b: ('move-result-wide', '11x'),
    0x0c: ('move-result-object', '11x'), 0x0d: ('move-exception', '11x'),
    0x0e: ('return-void', '10x'), 0x0f: ('return', '11x'), 0x10: ('return-wide', '11x'),
    0x11: ('return-object', '11x'), 0x12: ('const/4', '11n'), 0x13: ('const/16', '21s'),
    0x14: ('const', '31i'), 0x15: ('const/high16', '21h'), 0x16: ('const-wide/16', '21s'),
    0x17: ('const-wide/32', '31i'), 0x18: ('const-wide', '51l'), 0x19: ('const-wide/high16', '21h'),
    0x1a: ('const-string', '21c'), 0x1b: ('const-string/jumbo', '31c'), 0x1c: ('const-class', '21c'),
    0x1d: ('monitor-enter', '11x'), 0x1e: ('monitor-exit', '11x'), 0x1f: ('check-cast', '21c'),
    0x20: ('instance-of', '22c'), 0x21: ('array-length', '12x'), 0x22: ('new-instance', '21c'),
    0x23: ('new-array', '22c'), 0x24: ('filled-new-array', '35c'), 0x25: ('filled-new-array/range', '3rc'),
    0x26: ('fill-array-data', '31t'), 0x27: ('throw', '11x'), 0x28: ('goto', '10t'),
    0x29: ('goto/16', '20t'), 0x2a: ('goto/32', '30t'), 0x2b: ('packed-switch', '31t'),
    0x2c: ('sparse-switch', '31t'), 0x2d: ('cmpl-float', '23x'), 0x2e: ('cmpg-float', '23x'),
    0x2f: ('cmpl-double', '23x'), 0x30: ('cmpg-double', '23x'), 0x31: ('cmp-long', '23x'),
    0x32: ('if-eq', '22t'), 0x33: ('if-ne', '22t'), 0x34: ('if-lt', '22t'), 0x35: ('if-ge', '22t'),
    0x36: ('if-gt', '22t'), 0x37: ('if-le', '22t'), 0x38: ('if-eqz', '21t'), 0x39: ('if-nez', '21t'),
    0x3a: ('if-ltz', '21t'), 0x3b: ('if-gez', '21t'), 0x3c: ('if-gtz', '21t'), 0x3d: ('if-lez', '21t'),
    0x44: ('aget', '23x'), 0x45: ('aget-wide', '23x'), 0x46: ('aget-object', '23x'),
    0x47: ('aget-boolean', '23x'), 0x48: ('aget-byte', '23x'), 0x49: ('aget-char', '23x'),
    0x4a: ('aget-short', '23x'), 0x4b: ('aput', '23x'), 0x4c: ('aput-wide', '23x'),
    0x4d: ('aput-object', '23x'), 0x4e: ('aput-boolean', '23x'), 0x4f: ('aput-byte', '23x'),
    0x50: ('aput-char', '23x'), 0x51: ('aput-short', '23x'),
    0x52: ('iget', '22c'), 0x53: ('iget-wide', '22c'), 0x54: ('iget-object', '22c'),
    0x55: ('iget-boolean', '22c'), 0x56: ('iget-byte', '22c'), 0x57: ('iget-char', '22c'),
    0x58: ('iget-short', '22c'), 0x59: ('iput', '22c'), 0x5a: ('iput-wide', '22c'),
    0x5b: ('iput-object', '22c'), 0x5c: ('iput-boolean', '22c'), 0x5d: ('iput-byte', '22c'),
    0x5e: ('iput-char', '22c'), 0x5f: ('iput-short', '22c'),
    0x60: ('sget', '21c'), 0x61: ('sget-wide', '21c'), 0x62: ('sget-object', '21c'),
    0x63: ('sget-boolean', '21c'), 0x64: ('sget-byte', '21c'), 0x65: ('sget-char', '21c'),
    0x66: ('sget-short', '21c'), 0x67: ('sput', '21c'), 0x68: ('sput-wide', '21c'),
    0x69: ('sput-object', '21c'), 0x6a: ('sput-boolean', '21c'), 0x6b: ('sput-byte', '21c'),
    0x6c: ('sput-char', '21c'), 0x6d: ('sput-short', '21c'),
    0x6e: ('invoke-virtual', '35c'), 0x6f: ('invoke-super', '35c'), 0x70: ('invoke-direct', '35c'),
    0x71: ('invoke-static', '35c'), 0x72: ('invoke-interface', '35c'),
    0x74: ('invoke-virtual/range', '3rc'), 0x75: ('invoke-super/range', '3rc'),
    0x76: ('invoke-direct/range', '3rc'), 0x77: ('invoke-static/range', '3rc'),
    0x78: ('invoke-interface/range', '3rc'),
    0x7b: ('neg-int', '12x'), 0x7c: ('not-int', '12x'), 0x7d: ('neg-long', '12x'),
    0x7e: ('not-long', '12x'), 0x7f: ('neg-float', '12x'), 0x80: ('neg-double', '12x'),
    0x81: ('int-to-long', '12x'), 0x82: ('int-to-float', '12x'), 0x83: ('int-to-double', '12x'),
    0x84: ('long-to-int', '12x'), 0x85: ('long-to-float', '12x'), 0x86: ('long-to-double', '12x'),
    0x87: ('float-to-int', '12x'), 0x88: ('float-to-long', '12x'), 0x89: ('float-to-double', '12x'),
    0x8a: ('double-to-int', '12x'), 0x8b: ('double-to-long', '12x'), 0x8c: ('double-to-float', '12x'),
    0x8d: ('int-to-byte', '12x'), 0x8e: ('int-to-char', '12x'), 0x8f: ('int-to-short', '12x'),
}
for _i, _n in enumerate(['add', 'sub', 'mul', 'div', 'rem', 'and', 'or', 'xor', 'shl', 'shr', 'ushr']):
    OPS[0x90 + _i] = ('%s-int' % _n, '23x')
for _i, _n in enumerate(['add', 'sub', 'mul', 'div', 'rem', 'and', 'or', 'xor', 'shl', 'shr', 'ushr']):
    OPS[0x9b + _i] = ('%s-long' % _n, '23x')
for _i, _n in enumerate(['add', 'sub', 'mul', 'div', 'rem']):
    OPS[0xa6 + _i] = ('%s-float' % _n, '23x')
for _i, _n in enumerate(['add', 'sub', 'mul', 'div', 'rem']):
    OPS[0xab + _i] = ('%s-double' % _n, '23x')
for _i, _n in enumerate(['add', 'sub', 'mul', 'div', 'rem', 'and', 'or', 'xor', 'shl', 'shr', 'ushr']):
    OPS[0xb0 + _i] = ('%s-int/2addr' % _n, '12x')
for _i, _n in enumerate(['add', 'sub', 'mul', 'div', 'rem', 'and', 'or', 'xor', 'shl', 'shr', 'ushr']):
    OPS[0xbb + _i] = ('%s-long/2addr' % _n, '12x')
for _i, _n in enumerate(['add', 'sub', 'mul', 'div', 'rem']):
    OPS[0xc6 + _i] = ('%s-float/2addr' % _n, '12x')
for _i, _n in enumerate(['add', 'sub', 'mul', 'div', 'rem']):
    OPS[0xcb + _i] = ('%s-double/2addr' % _n, '12x')
for _i, _n in enumerate(['add', 'rsub', 'mul', 'div', 'rem', 'and', 'or', 'xor']):
    OPS[0xd0 + _i] = ('%s-int/lit16' % _n, '22s')
for _i, _n in enumerate(['add', 'rsub', 'mul', 'div', 'rem', 'and', 'or', 'xor', 'shl', 'shr', 'ushr']):
    OPS[0xd8 + _i] = ('%s-int/lit8' % _n, '22b')
OPS[0xfa] = ('invoke-polymorphic', '45cc')
OPS[0xfb] = ('invoke-polymorphic/range', '4rcc')
OPS[0xfc] = ('invoke-custom', '35c')
OPS[0xfd] = ('invoke-custom/range', '3rc')
OPS[0xfe] = ('const-method-handle', '21c')
OPS[0xff] = ('const-method-type', '21c')

SIZE = {'10x': 1, '12x': 1, '11n': 1, '11x': 1, '10t': 1, '20t': 2, '22x': 2, '21t': 2,
        '21s': 2, '21h': 2, '21c': 2, '23x': 2, '22b': 2, '22t': 2, '22s': 2, '22c': 2,
        '30t': 3, '31t': 3, '31i': 3, '31c': 3, '32x': 3, '35c': 3, '3rc': 3, '45cc': 4,
        '4rcc': 4, '51l': 5}


CFLAGS = [(0x1, 'public'), (0x2, 'private'), (0x4, 'protected'),
          (0x8, 'static'), (0x10, 'final'), (0x20, 'super'),
          (0x200, 'interface'), (0x400, 'abstract'),
          (0x1000, 'synthetic'), (0x2000, 'annotation'), (0x4000, 'enum')]
FFLAGS = [(0x1, 'public'), (0x2, 'private'), (0x4, 'protected'),
          (0x8, 'static'), (0x10, 'final'), (0x40, 'volatile'), (0x80, 'transient'),
          (0x1000, 'synthetic'), (0x8000, 'enum')]
MFLAGS = [(0x1, 'public'), (0x2, 'private'), (0x4, 'protected'),
          (0x8, 'static'), (0x10, 'final'), (0x20, 'synchronized'),
          (0x40, 'bridge'), (0x80, 'varargs'), (0x100, 'native'),
          (0x400, 'abstract'), (0x1000, 'synthetic'), (0x10000, 'constructor')]


def mods(acc, table):
    return ' '.join(n for b, n in table if acc & b)


def sx(v, bits):
    if v & (1 << (bits - 1)):
        v -= 1 << bits
    return v


class Dex:
    def __init__(self, path):
        self.d = open(path, 'rb').read()
        d = self.d
        u4 = lambda o: struct.unpack_from('<I', d, o)[0]
        self.u4 = u4
        self.string_ids_off = u4(0x3c)
        self.type_ids_off = u4(0x44)
        self.proto_off = u4(0x4c)
        self.field_off = u4(0x54)
        self.method_off = u4(0x5c)
        self.class_off = u4(0x64)
        self.strings = [self._str(i) for i in range(u4(0x38))]
        self.types = [self.strings[u4(self.type_ids_off + 4 * i)] for i in range(u4(0x40))]
        self.methods = []
        for i in range(u4(0x58)):
            o = self.method_off + 8 * i
            cls = struct.unpack_from('<H', d, o)[0]
            proto = struct.unpack_from('<H', d, o + 2)[0]
            name = u4(o + 4)
            po = self.proto_off + 12 * proto
            self.methods.append((self.types[cls], self.strings[name], self.types[u4(po + 4)], u4(po + 8)))
        self.fields = []
        for i in range(u4(0x50)):
            o = self.field_off + 8 * i
            cls = struct.unpack_from('<H', d, o)[0]
            typ = struct.unpack_from('<H', d, o + 2)[0]
            self.fields.append((self.types[cls], self.types[typ], self.strings[u4(o + 4)]))

    def _uleb(self, o):
        val = 0
        shift = 0
        while True:
            b = self.d[o]
            o += 1
            val |= (b & 0x7f) << shift
            if b < 0x80:
                break
            shift += 7
        return val, o

    def _str(self, i):
        o = self.u4(self.string_ids_off + 4 * i)
        n, o = self._uleb(o)
        end = self.d.index(b'\x00', o)
        return self.d[o:end].decode('utf-8', 'replace')

    def params(self, off):
        if off == 0:
            return []
        n = self.u4(off)
        return [self.types[struct.unpack_from('<H', self.d, off + 4 + 2 * i)[0]] for i in range(n)]

    def mref(self, idx):
        if idx >= len(self.methods):
            return '?'
        c, name, ret, p = self.methods[idx]
        return '%s->%s(%s)%s' % (c, name, ''.join(self.params(p)), ret)

    def fref(self, idx):
        if idx >= len(self.fields):
            return '?'
        c, t, n = self.fields[idx]
        return '%s->%s:%s' % (c, n, t)

    def classes(self):
        out = []
        for i in range(struct.unpack_from('<I', self.d, 0x60)[0]):
            o = self.class_off + 32 * i
            sup = self.u4(o + 8)
            out.append((self.types[self.u4(o)], self.u4(o + 4),
                        self.types[sup] if sup != 0xFFFFFFFF else None,
                        self.u4(o + 16), self.u4(o + 24)))
        return out

    def class_data(self, data_off):
        if data_off == 0:
            return [], []
        o = data_off
        sf, o = self._uleb(o)
        inf, o = self._uleb(o)
        dm, o = self._uleb(o)
        vm, o = self._uleb(o)
        flds = []
        for kind, cnt in (('static', sf), ('instance', inf)):
            idx = 0
            for _ in range(cnt):
                diff, o = self._uleb(o)
                acc, o = self._uleb(o)
                idx += diff
                flds.append((kind, idx, acc))
        ms = []
        for kind, cnt in (('direct', dm), ('virtual', vm)):
            idx = 0
            for _ in range(cnt):
                diff, o = self._uleb(o)
                acc, o = self._uleb(o)
                code, o = self._uleb(o)
                idx += diff
                ms.append((kind, idx, acc, code))
        return flds, ms

    def disasm(self, code_off, indent='    '):
        d = self.d
        u2 = lambda o: struct.unpack_from('<H', d, o)[0]
        regs = u2(code_off)
        ins = u2(code_off + 2)
        tries = u2(code_off + 6)
        insns_size = self.u4(code_off + 12)
        base = code_off + 16
        code = [u2(base + 2 * i) for i in range(insns_size)]

        def payload_len(i):
            if i + 4 > len(code):
                return 0
            u = code[i]
            if u == 0x0100:
                return 4 + code[i + 1] * 2
            if u == 0x0200:
                return 2 + code[i + 1] * 4
            if u == 0x0300:
                w = code[i + 1]
                n = code[i + 2] | (code[i + 3] << 16)
                return 4 + (n * w + 1) // 2
            return 0

        targets = set()
        switch_at = {}
        i = 0
        while i < insns_size:
            pl = payload_len(i)
            if pl:
                i += pl
                continue
            unit = code[i]
            op = unit & 0xff
            fmt = OPS.get(op, ('?', '10x'))[1]
            sz = SIZE.get(fmt, 1)
            if fmt == '10t':
                targets.add(i + sx((unit >> 8) & 0xff, 8))
            elif fmt == '20t' and i + 1 < len(code):
                targets.add(i + sx(code[i + 1], 16))
            elif fmt == '30t' and i + 2 < len(code):
                off = code[i + 1] | (code[i + 2] << 16)
                targets.add(i + (off - 0x1000000 if off & 0x800000 else off))
            elif fmt == '21t' and i + 1 < len(code):
                targets.add(i + sx(code[i + 1], 16))
            elif fmt == '22t' and i + 1 < len(code):
                targets.add(i + sx(code[i + 1], 16))
            elif fmt == '31t' and i + 2 < len(code):
                off = code[i + 1] | (code[i + 2] << 16)
                off = off - 0x1000000 if off & 0x800000 else off
                if op in (0x26, 0x2b, 0x2c):
                    switch_at[i] = ('array' if op == 0x26 else
                                    'packed' if op == 0x2b else 'sparse', i + off)
                else:
                    targets.add(i + off)
            i += sz

        # ---- switch / fill-array-data payload：解析并命名 ----
        # Dalvik 约定：payload 里的 target 偏移是「相对 switch 指令地址」，不是相对 payload 本身，
        # 所以基准必须取 sw_off。这里把 case 值 → 目标标签的映射显式打出来（旧版直接丢掉）。
        def hx(v):
            return '0x%x' % v if v >= 0 else '-0x%x' % -v

        payloads = {}   # payload_off -> (kind, payload_name, entries)
        name_of = {}    # switch / fill-array-data 指令 off -> payload 名字
        label_at = {}   # 目标 off -> [case 标签]
        n_sw = {'packed': 0, 'sparse': 0, 'array': 0}
        n_case = 0
        for sw_off in sorted(switch_at):
            kind, poff = switch_at[sw_off]
            if poff < 0 or poff + 3 >= len(code):
                continue
            pname = '%s_%d' % ({'packed': 'pswitch_data', 'sparse': 'sswitch_data',
                                'array': 'array'}[kind], n_sw[kind])
            n_sw[kind] += 1
            name_of[sw_off] = pname
            entries = []
            if kind in ('packed', 'sparse'):
                size = code[poff + 1]
                if kind == 'packed':
                    first = sx(code[poff + 2] | (code[poff + 3] << 16), 32)
                    keys = [first + k for k in range(size)]
                    tbase = poff + 4
                else:
                    keys = [sx(code[poff + 2 + 2 * k] | (code[poff + 3 + 2 * k] << 16), 32)
                            for k in range(size)]
                    tbase = poff + 2 + 2 * size
                for k in range(size):
                    rel = sx(code[tbase + 2 * k] | (code[tbase + 2 * k + 1] << 16), 32)
                    lab = ('pswitch_%d' if kind == 'packed' else 'sswitch_%d') % n_case
                    n_case += 1
                    label_at.setdefault(sw_off + rel, []).append(lab)
                    entries.append((keys[k], lab))
            else:
                w = code[poff + 1]
                n = code[poff + 2] | (code[poff + 3] << 16)
                dbase = base + 2 * (poff + 4)
                vals = [int.from_bytes(d[dbase + k * w:dbase + (k + 1) * w], 'little', signed=True)
                        for k in range(n)]
                entries.append((w, vals))
            payloads[poff] = (kind, pname, entries)

        lines = []
        i = 0
        while i < insns_size:
            if i in payloads:
                kind, pname, entries = payloads[i]
                pl = payload_len(i)
                if kind == 'packed':
                    lines.append('%s:%s' % (indent, pname))
                    lines.append('%s.packed-switch %s' % (indent, hx(entries[0][0]) if entries else '0x0'))
                    for _key, lab in entries:
                        lines.append('%s    :%s' % (indent, lab))
                    lines.append('%s.end packed-switch' % indent)
                elif kind == 'sparse':
                    lines.append('%s:%s' % (indent, pname))
                    lines.append('%s.sparse-switch' % indent)
                    for key, lab in entries:
                        lines.append('%s    %s -> :%s' % (indent, hx(key), lab))
                    lines.append('%s.end sparse-switch' % indent)
                else:
                    w, vals = entries[0]
                    lines.append('%s:%s' % (indent, pname))
                    lines.append('%s.array-data %d' % (indent, w))
                    for v in vals:
                        lines.append('%s    %s' % (indent, hx(v)))
                    lines.append('%s.end array-data' % indent)
                i += pl
                continue
            pl = payload_len(i)
            if pl:
                i += pl
                continue
            unit = code[i]
            op = unit & 0xff
            hi = (unit >> 8) & 0xff
            name, fmt = OPS.get(op, ('unopt-%02x' % op, '10x'))
            sz = SIZE.get(fmt, 1)
            if i in targets:
                lines.append('%s:L%d' % (indent, i))
            if i in label_at:
                lines.append('%s%s' % (indent, ' '.join(':%s' % x for x in label_at[i])))
            arg = ''
            nxt = code[i + 1] if i + 1 < len(code) else 0
            nxt2 = code[i + 2] if i + 2 < len(code) else 0
            if fmt == '10x':
                arg = ''
            elif fmt == '12x':
                arg = 'v%d, v%d' % (hi & 0xf, hi >> 4)
            elif fmt == '11n':
                arg = 'v%d, #%d' % (hi & 0xf, sx(hi >> 4, 4))
            elif fmt == '11x':
                arg = 'v%d' % hi
            elif fmt == '10t':
                arg = ':L%d' % (i + sx(hi, 8))
            elif fmt == '20t':
                arg = ':L%d' % (i + sx(nxt, 16))
            elif fmt == '22x':
                arg = 'v%d, v%d' % (hi, nxt)
            elif fmt == '21t':
                arg = 'v%d, :L%d' % (hi, i + sx(nxt, 16))
            elif fmt == '21s':
                arg = 'v%d, #%d' % (hi, sx(nxt, 16))
            elif fmt == '21h':
                arg = 'v%d, #int 0x%x' % (hi, (sx(nxt, 16) << 16) & 0xffffffff)
            elif fmt == '21c':
                if name == 'const-string':
                    arg = 'v%d, "%s"' % (hi, self.strings[nxt] if nxt < len(self.strings) else '?')
                elif name in ('const-class', 'check-cast', 'new-instance'):
                    arg = 'v%d, %s' % (hi, self.types[nxt] if nxt < len(self.types) else '?')
                elif name.startswith('sget') or name.startswith('sput'):
                    arg = 'v%d, %s' % (hi, self.fref(nxt))
                else:
                    arg = 'v%d, idx%d' % (hi, nxt)
            elif fmt == '23x':
                arg = 'v%d, v%d, v%d' % (hi, nxt & 0xff, nxt >> 8)
            elif fmt == '22b':
                arg = 'v%d, v%d, #%d' % (hi, nxt & 0xff, sx(nxt >> 8, 8))
            elif fmt == '22t':
                arg = 'v%d, v%d, :L%d' % (hi & 0xf, hi >> 4, i + sx(nxt, 16))
            elif fmt == '22s':
                arg = 'v%d, v%d, #%d' % (hi & 0xf, hi >> 4, sx(nxt, 16))
            elif fmt == '22c':
                a = hi & 0xf
                b = hi >> 4
                if name in ('instance-of', 'new-array'):
                    arg = 'v%d, v%d, %s' % (a, b, self.types[nxt] if nxt < len(self.types) else '?')
                else:
                    arg = 'v%d, v%d, %s' % (a, b, self.fref(nxt))
            elif fmt == '30t':
                off = nxt | (nxt2 << 16)
                arg = ':L%d' % (i + (off - 0x1000000 if off & 0x800000 else off))
            elif fmt == '31t':
                off = nxt | (nxt2 << 16)
                if i in name_of:
                    arg = 'v%d, :%s' % (hi, name_of[i])
                else:
                    arg = 'v%d, :L%d' % (hi, i + (off - 0x1000000 if off & 0x800000 else off))
            elif fmt == '31i':
                val = sx(nxt | (nxt2 << 16), 32)
                arg = 'v%d, #%d%s' % (hi, val, 'L' if name.startswith('const-wide') else '')
            elif fmt == '31c':
                idx = nxt | (nxt2 << 16)
                arg = 'v%d, "%s"' % (hi, self.strings[idx] if idx < len(self.strings) else '?')
            elif fmt == '32x':
                arg = 'v%d, v%d' % (nxt, nxt2)
            elif fmt in ('35c', '45cc'):
                cnt = hi >> 4
                idx = nxt
                g = code[i + 3] if (fmt == '45cc' and i + 3 < len(code)) else (hi & 0xf)
                rl = [nxt2 & 0xf, (nxt2 >> 4) & 0xf, (nxt2 >> 8) & 0xf, (nxt2 >> 12) & 0xf, g][:cnt]
                arg = '{%s}, %s' % (', '.join('v%d' % r for r in rl), self.mref(idx))
            elif fmt in ('3rc', '4rcc'):
                cnt = hi
                idx = nxt
                first = nxt2
                regs_s = '' if cnt == 0 else 'v%d..v%d' % (first, first + cnt - 1)
                arg = '{%s}, %s' % (regs_s, self.mref(idx))
            elif fmt == '51l':
                lo = nxt | (nxt2 << 16)
                hiw = (code[i + 3] if i + 3 < len(code) else 0) | \
                      ((code[i + 4] if i + 4 < len(code) else 0) << 16)
                v = (hiw << 32) | lo
                if v & (1 << 63):
                    v -= 1 << 64
                arg = 'v%d, #%dL' % (hi, v)
            lines.append('%s%s %s' % (indent, name, arg.rstrip()))
            i += sz
        return '\n'.join(lines), regs, ins, tries


def main():
    path = sys.argv[1]
    filt = sys.argv[2] if len(sys.argv) > 2 else None
    dx = Dex(path)
    out = []
    for cname, cacc, sup, ifaces, data in dx.classes():
        short = cname[1:-1].replace('/', '.')
        if filt and filt.lower() not in short.lower():
            continue
        cm = mods(cacc & ~0x20, CFLAGS)
        out.append('.class %s%s' % (cm + ' ' if cm else '', cname))
        out.append('.super %s' % (sup if sup else 'Ljava/lang/Object;'))
        out.append('')
        flds, ms = dx.class_data(data)
        for kind, fidx, acc in flds:
            if fidx >= len(dx.fields):
                continue
            fcls, ftyp, fname = dx.fields[fidx]
            fm = mods(acc, FFLAGS)
            out.append('.field %s%s:%s' % (fm + ' ' if fm else '', fname, ftyp))
        if flds:
            out.append('')
        for kind, midx, acc, code in ms:
            mcls, mname, mret, mparams = dx.methods[midx]
            sig = '%s->%s(%s)%s' % (mcls, mname, ''.join(dx.params(mparams)), mret)
            mm = mods(acc, MFLAGS)
            out.append('# %s access=0x%x' % (kind, acc))
            out.append('.method %s%s' % (mm + ' ' if mm else '', sig))
            if code:
                body, regs, ins, tries = dx.disasm(code)
                out.append('    # registers=%d ins=%d tries=%d' % (regs, ins, tries))
                out.append(body)
            else:
                out.append('    # (no code)')
            out.append('.end method')
            out.append('')
    print('\n'.join(out))


if __name__ == '__main__':
    main()