#!/usr/bin/env python3
"""Dump dex structure: strings, classes, methods, and a lightweight smali disassembler."""
import struct
import sys


class Dex:
    def __init__(self, path):
        self.d = open(path, 'rb').read()
        d = self.d
        u4 = lambda o: struct.unpack_from('<I', d, o)[0]
        u2 = lambda o: struct.unpack_from('<H', d, o)[0]
        self.u2, self.u4 = u2, u4
        self.string_ids_size = u4(0x38)
        self.string_ids_off = u4(0x3c)
        self.type_ids_size = u4(0x40)
        self.type_ids_off = u4(0x44)
        self.proto_ids_size = u4(0x48)
        self.proto_ids_off = u4(0x4c)
        self.field_ids_size = u4(0x50)
        self.field_ids_off = u4(0x54)
        self.method_ids_size = u4(0x58)
        self.method_ids_off = u4(0x5c)
        self.class_defs_size = u4(0x60)
        self.class_defs_off = u4(0x64)
        self.strings = [self.get_string(i) for i in range(self.string_ids_size)]
        self.types = [self.strings[u4(self.type_ids_off + 4 * i)] for i in range(self.type_ids_size)]

    def uleb128(self, o):
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

    def get_string(self, i):
        o = self.u4(self.string_ids_off + 4 * i)
        n, o = self.uleb128(o)
        end = self.d.index(b'\x00', o)
        while self.d[end - 1] == 0x00 and end > o:
            end -= 1
        raw = self.d[o:end + 1]
        # decode MUTF-8
        try:
            return raw.decode('utf-8')
        except UnicodeDecodeError:
            return raw.decode('latin-1')

    def type_name(self, idx):
        n = self.types[idx]
        if n.startswith('L') and n.endswith(';'):
            return n[1:-1].replace('/', '.')
        return n

    def class_list(self):
        out = []
        for i in range(self.class_defs_size):
            o = self.class_defs_off + 32 * i
            t = self.u4(o)
            sup = self.u4(o + 8)
            data_off = self.u4(o + 24)
            out.append((self.types[t], self.types[sup] if sup != 0xffffffff else None, data_off))
        return out

    def method_list(self):
        out = []
        for i in range(self.method_ids_size):
            o = self.method_ids_off + 8 * i
            cls = self.u2(o)
            proto = self.u2(o + 2)
            name = self.u4(o + 4)
            p = self.proto_ids_off + 12 * proto
            ret = self.u4(p + 4)
            params = self.u4(p + 8)
            out.append({
                'class': self.types[cls], 'name': self.strings[name],
                'ret': self.types[ret], 'params_off': params,
            })
        return out

    def proto_params(self, params_off):
        if params_off == 0:
            return []
        n = self.u4(params_off)
        return [self.types[self.u2(params_off + 4 + 2 * i)] for i in range(n)]

    def field_list(self):
        out = []
        for i in range(self.field_ids_size):
            o = self.field_ids_off + 8 * i
            cls = self.u2(o)
            typ = self.u2(o + 2)
            name = self.u4(o + 4)
            out.append((self.types[cls], self.types[typ], self.strings[name]))
        return out

    def class_data(self, off):
        """returns dict of direct/virtual methods with code offsets"""
        if off == 0:
            return None
        d = self.d
        o = off
        sf, o = self.uleb128(o)
        inf, o = self.uleb128(o)
        dm, o = self.uleb128(o)
        vm, o = self.uleb128(o)
        fields = []
        idx = 0
        for _ in range(sf + inf):
            diff, o = self.uleb128(o)
            acc, o = self.uleb128(o)
            idx += diff
            fields.append((idx, acc))
        methods = []
        idx = 0
        for kind, cnt in (('direct', dm), ('virtual', vm)):
            for _ in range(cnt):
                diff, o = self.uleb128(o)
                acc, o = self.uleb128(o)
                code_off, o = self.uleb128(o)
                idx += diff
                methods.append((kind, idx, acc, code_off))
        return methods


if __name__ == '__main__':
    path = sys.argv[1]
    mode = sys.argv[2] if len(sys.argv) > 2 else 'all'
    dx = Dex(path)
    if mode in ('all', 'strings'):
        for s in dx.strings:
            print(s)
    if mode in ('all', 'classes'):
        print('=== CLASSES ===')
        for t, sup, data in dx.class_list():
            print('%s extends %s' % (t, sup))
    if mode in ('all', 'methods'):
        print('=== METHODS ===')
        for m in dx.method_list():
            ps = dx.proto_params(m['params_off'])
            print('%s->%s(%s)%s' % (m['class'], m['name'], ','.join(ps), m['ret']))
    if mode in ('all', 'fields'):
        print('=== FIELDS ===')
        for c, t, n in dx.field_list():
            print('%s->%s:%s' % (c, n, t))