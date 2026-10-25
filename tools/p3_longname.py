#!/usr/bin/env python3
"""P3: 找出触发 GNU LongLink(L) 头的条目，并直读 gzip trailer 校验 ISIZE。

tarstruct 已证明：tar 真实长度 360,825,344 = 条目累计 360,802,816 + 22 个 L 头 22,528。
本脚本回答两件事：
  1) 这 22 个 L 头对应哪些路径（P4 重打包时必须用 GNU 长名头，不能截断）；
  2) gzip 尾部的 ISIZE 是否等于解压总量（直读 zip 内压缩数据最后 8 字节，
     不做整包解压）。
"""
import sys
import tarfile
import zipfile

APK = 'apk/Coopanion-v12.71.apk'
ENTRY = 'assets/payload.asset'


def gzip_trailer():
    with zipfile.ZipFile(APK) as z:
        zi = z.getinfo(ENTRY)
        with open(APK, 'rb') as fh:
            fh.seek(zi.header_offset)
            lh = fh.read(30)
            nlen = int.from_bytes(lh[26:28], 'little')
            elen = int.from_bytes(lh[28:30], 'little')
            data_off = zi.header_offset + 30 + nlen + elen
            fh.seek(data_off + zi.compress_size - 8)
            t = fh.read(8)
    crc = int.from_bytes(t[0:4], 'little')
    isize = int.from_bytes(t[4:8], 'little')
    return crc, isize, zi.compress_size


def main():
    crc, isize, csize = gzip_trailer()
    print('=== gzip trailer（直读压缩数据末尾） ===')
    print('compress_size = %d' % csize)
    print('crc32         = 0x%08x' % crc)
    print('ISIZE         = %d  (%.2f MiB)' % (isize, isize / 1048576.0))
    print()

    longs = []
    total = 0
    with zipfile.ZipFile(APK) as z:
        with z.open(ENTRY) as raw:
            with tarfile.open(fileobj=raw, mode='r|gz') as tf:
                for m in tf:
                    total += 1
                    nl = len(m.name.encode('utf-8'))
                    if nl > 100:
                        longs.append((nl, m.type, m.size, m.name))
    print('=== LongLink 候选（name 字节长 > 100） ===')
    print('entries = %d' % total)
    print('long_names = %d' % len(longs))
    for nl, t, s, nm in longs:
        print('  len=%3d type=%s size=%9d %s' % (nl, t, s, nm))
    print()
    print('复算 tar 总长 = %d + %d = %d' % (isize - len(longs) * 1024,
                                            len(longs) * 1024, isize))
    return 0


if __name__ == '__main__':
    sys.exit(main())
