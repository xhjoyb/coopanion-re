#!/usr/bin/env python3
"""Minimal Android binary XML (AXML) dumper - no deps."""
import struct, sys


def parse(path):
    d = open(path, 'rb').read()

    def u2(o):
        return struct.unpack_from('<H', d, o)[0]

    def u4(o):
        return struct.unpack_from('<I', d, o)[0]

    assert u2(0) == 0x0003, 'not axml'
    total = u4(4)
    o = 8
    strs = []
    resmap = []
    out = []
    depth = 0

    def read_uleb(pos):
        val = 0
        shift = 0
        while True:
            b = d[pos]
            pos += 1
            val |= (b & 0x7f) << shift
            if b < 0x80:
                break
            shift += 7
        return val, pos

    while o < total:
        ctype = u2(o)
        csize = u4(o + 4)
        if ctype == 0x0001:  # string pool
            cnt = u4(o + 8)
            flags = u4(o + 16)
            sstart = u4(o + 20)
            utf8 = bool(flags & 0x100)
            base = o + sstart
            for i in range(cnt):
                p = base + u4(o + 28 + 4 * i)
                if utf8:
                    n16, p = read_uleb(p)
                    n8, p = read_uleb(p)
                    strs.append(d[p:p + n8].decode('utf-8', 'replace'))
                else:
                    n16 = u2(p)
                    p += 2
                    if n16 & 0x8000:
                        n16 = ((n16 & 0x7fff) << 16) | u2(p)
                        p += 2
                    strs.append(d[p:p + n16 * 2].decode('utf-16-le', 'replace'))
        elif ctype == 0x0180:  # resource map：与字符串池索引一一对应的 attr 资源 id
            resmap = [u4(o + 8 + 4 * i) for i in range((csize - 8) // 4)]
        elif ctype == 0x0100:  # start namespace
            out.append('xmlns:%s="%s"' % (strs[u4(o + 16)], strs[u4(o + 20)]))
        elif ctype == 0x0101:  # end namespace
            out.append('')
        elif ctype == 0x0102:  # start element
            name = strs[u4(o + 20)]
            aoff = o + 16 + u2(o + 24)
            asize = u2(o + 26) or 20
            acount = u2(o + 28)
            attrs = []
            for a in range(acount):
                p = aoff + a * asize
                nidx = u4(p + 4)
                aname = strs[nidx]
                rid = resmap[nidx] if nidx < len(resmap) else 0
                if rid >> 24 == 0x01:      # 0x01 = android 包
                    aname = 'android:' + aname
                elif rid:                  # 0x7f = 应用自身，其余为外部包，保留原 id
                    aname = '0x%08x:' % rid + aname
                raw = u4(p + 8)
                dtype = d[p + 15]
                data = u4(p + 16)
                if raw != 0xFFFFFFFF and raw < len(strs):
                    val = strs[raw]
                elif dtype == 0x03:
                    val = strs[data] if data < len(strs) else 'str#%d' % data
                elif dtype == 0x12:
                    val = 'true' if data else 'false'
                elif dtype == 0x01:
                    val = '@0x%08x' % data
                elif dtype == 0x10:
                    val = str(data)
                elif dtype == 0x11:
                    val = '0x%x' % data
                elif dtype == 0x02:
                    val = '?0x%08x' % data
                else:
                    val = '0x%x(dt0x%02x)' % (data, dtype)
                attrs.append('%s="%s"' % (aname, val))
            attr_s = (' ' + ' '.join(attrs)) if attrs else ''
            out.append('%s<%s%s>' % ('  ' * depth, name, attr_s))
            depth += 1
        elif ctype == 0x0103:  # end element
            name = strs[u4(o + 20)]
            depth = max(depth - 1, 0)
            out.append('%s</%s>' % ('  ' * depth, name))
        o += csize
    return '\n'.join(out)


if __name__ == '__main__':
    print(parse(sys.argv[1]))