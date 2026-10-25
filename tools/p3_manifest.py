#!/usr/bin/env python3
"""P3: 列 payload.asset 清单（流式，不解包到磁盘）。

用法: python3 tools/p3_manifest.py <apk> <out.tsv>
输出 TSV: kind \t size \t linkname \t path
kind: f 普通文件 / d 目录 / s 软链接 / h 硬链接
"""
import sys
import tarfile
import zipfile

apk, out = sys.argv[1], sys.argv[2]

rows = []
with zipfile.ZipFile(apk) as z, z.open('assets/payload.asset') as raw:
    with tarfile.open(fileobj=raw, mode='r|gz') as tf:
        for m in tf:
            if m.isdir():
                kind = 'd'
            elif m.issym():
                kind = 's'
            elif m.islnk():
                kind = 'h'
            else:
                kind = 'f'
            rows.append((kind, m.size, m.linkname or '', m.name))

with open(out, 'w', encoding='utf-8') as f:
    for kind, size, link, name in rows:
        f.write('%s\t%d\t%s\t%s\n' % (kind, size, link, name))

by = {}
for kind, size, link, name in rows:
    c, b = by.get(kind, (0, 0))
    by[kind] = (c + 1, b + size)
for k in ('f', 'd', 's', 'h'):
    c, b = by.get(k, (0, 0))
    print('kind=%s count=%d bytes=%d' % (k, c, b))
print('entries=%d' % len(rows))
print('payload_files_bytes=%d' % sum(r[1] for r in rows if r[0] == 'f'))