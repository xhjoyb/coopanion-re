#!/usr/bin/env python3
"""P4: 把 APK 内 assets/payload.asset 解成裸 tar，度量大小与 sha256。

用途：P4-A 等价重打包的基准物。payload.asset 是单成员 gzip（FLG=0/mtime=0），
直接流式解压，不落地 gz 中间层。
"""
import gzip, hashlib, sys, zipfile

APK = 'apk/Coopanion-v12.71.apk'
ENTRY = 'assets/payload.asset'
OUT = sys.argv[1] if len(sys.argv) > 1 else '/tmp/p4/payload.tar'

h = hashlib.sha256()
n = 0
with zipfile.ZipFile(APK) as z, z.open(ENTRY) as raw:
    with open(OUT, 'wb') as f:
        with gzip.GzipFile(fileobj=raw, mode='rb') as g:
            while True:
                b = g.read(1 << 20)
                if not b:
                    break
                f.write(b)
                h.update(b)
                n += len(b)
print('tar =', OUT)
print('bytes =', n)
print('sha256 =', h.hexdigest())
print('blocks =', n // 512, 'rem =', n % 512)
