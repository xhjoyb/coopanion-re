#!/usr/bin/env python3
"""临时：测量 payload 用不同 gzip 级别重压后的大小（确定性重打包的收益上限）。"""
import zlib
import zipfile

apk = 'apk/Coopanion-v12.71.apk'
levels = [6, 9]
cos = {lv: zlib.compressobj(lv, zlib.DEFLATED, 31) for lv in levels}
tot = {lv: 0 for lv in levels}
raw = 0

with zipfile.ZipFile(apk) as z, z.open('assets/payload.asset') as f:
    while True:
        b = f.read(1 << 20)
        if not b:
            break
        raw += len(b)
        for lv, co in cos.items():
            tot[lv] += len(co.compress(b))
for lv in levels:
    n = tot[lv] + len(cos[lv].flush())
    print('level=%d gz=%d ratio=%.3f' % (lv, n, n / raw))
print('original_payload=%d' % raw)