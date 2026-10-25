#!/usr/bin/env python3
"""临时：对 payload 内特定路径做 sha256，用于判定重复副本。"""
import hashlib
import sys
import tarfile
import zipfile

apk = sys.argv[1]
needles = sys.argv[2:]

with zipfile.ZipFile(apk) as z, z.open('assets/payload.asset') as raw:
    with tarfile.open(fileobj=raw, mode='r|gz') as tf:
        for m in tf:
            if not m.isfile():
                continue
            if not any(n in m.name for n in needles):
                continue
            h = hashlib.sha256()
            f = tf.extractfile(m)
            while True:
                b = f.read(1 << 20)
                if not b:
                    break
                h.update(b)
            print('%s  %10d  %s' % (h.hexdigest()[:16], m.size, m.name))