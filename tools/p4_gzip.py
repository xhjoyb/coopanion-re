#!/usr/bin/env python3
"""P4-A 第二层：把 tar 重压成 payload.asset，比 sha256 / 字节数。

原厂 gzip 头是人工可控的固定头（见 docs/05 §2.1）：
  1f 8b 08 00 | mtime=0 | XFL=0 | OS=255
注意 Python gzip.compress(level=9) 会写 XFL=2，所以必须自己写头 +
raw deflate + CRC32/ISIZE 尾。
"""
import hashlib, struct, sys, zlib

HDR = b'\x1f\x8b\x08\x00' + b'\x00\x00\x00\x00' + b'\x00' + b'\xff'


def main(tar, out, level=9):
    crc = 0
    isize = 0
    h = hashlib.sha256()
    c = zlib.compressobj(level, zlib.DEFLATED, -15)
    total = 0
    with open(tar, 'rb') as f, open(out, 'wb') as o:
        hdr = HDR
        o.write(hdr); h.update(hdr); total += len(hdr)
        while True:
            b = f.read(1 << 20)
            if not b:
                break
            crc = zlib.crc32(b, crc)
            isize += len(b)
            d = c.compress(b)
            if d:
                o.write(d); h.update(d); total += len(d)
        d = c.flush()
        if d:
            o.write(d); h.update(d); total += len(d)
        tr = struct.pack('<II', crc & 0xffffffff, isize & 0xffffffff)
        o.write(tr); h.update(tr); total += len(tr)
    print('level    =', level)
    print('gz bytes =', total)
    print('sha256   =', h.hexdigest())
    print('out      =', out)


if __name__ == '__main__':
    lv = int(sys.argv[3]) if len(sys.argv) > 3 else 9
    main(sys.argv[1], sys.argv[2], lv)
