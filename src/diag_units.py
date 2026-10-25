#!/usr/bin/env python3
"""诊断：打印某方法前 N 个 code unit 的原始值，核对 opcode 表。"""
import struct
import sys

path, cls, meth = sys.argv[1], sys.argv[2], sys.argv[3]
d = open(path, 'rb').read()
u4 = lambda o: struct.unpack_from('<I', d, o)[0]
u2 = lambda o: struct.unpack_from('<H', d, o)[0]

string_ids, type_ids, proto_ids, field_ids, method_ids, class_defs = (
    u4(0x3c), u4(0x44), u4(0x4c), u4(0x54), u4(0x5c), u4(0x64))


def s(i):
    o = u4(string_ids + 4 * i)
    n = 0
    sh = 0
    while True:
        b = d[o]
        o += 1
        n |= (b & 0x7f) << sh
        if b < 0x80:
            break
        sh += 7
    end = d.index(b'\x00', o)
    return d[o:end].decode('utf-8', 'replace')


types = [s(u4(type_ids + 4 * i)) for i in range(u4(0x40))]
methods = []
for i in range(u4(0x58)):
    o = method_ids + 8 * i
    methods.append((types[u2(o)], s(u4(o + 4))))

uleb_at = None


def uleb(o):
    v = 0
    sh = 0
    while True:
        b = d[o]
        o += 1
        v |= (b & 0x7f) << sh
        if b < 0x80:
            return v, o
        sh += 7


for i in range(u4(0x60)):
    o = class_defs + 32 * i
    if types[u4(o)] != cls:
        continue
    data = u4(o + 24)
    p = data
    sf, p = uleb(p)
    inf, p = uleb(p)
    dm, p = uleb(p)
    vm, p = uleb(p)
    for _ in range(sf + inf):
        _, p = uleb(p)
        _, p = uleb(p)
    for cnt, kind in ((dm, 'direct'), (vm, 'virtual')):
        idx = 0
        for _ in range(cnt):
            diff, p = uleb(p)
            acc, p = uleb(p)
            code, p = uleb(p)
            idx += diff
            name = methods[idx][1]
            if name != meth:
                continue
            regs, ins, outs, tries = u2(code), u2(code + 2), u2(code + 4), u2(code + 6)
            size = u4(code + 12)
            print('method %s regs=%d ins=%d tries=%d units=%d' % (name, regs, ins, tries, size))
            base = code + 16
            for k in range(min(size, 280)):
                unit = u2(base + 2 * k)
                print('  [%3d] %04x   op=%02x  hi=%02x' % (k, unit, unit & 0xff, unit >> 8))
            sys.exit()
print('method not found')
