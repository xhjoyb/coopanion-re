#!/usr/bin/env python3
"""把合并的 smali 拆成每类一个文件，便于走读。"""
import os
import re
import sys

out_dir = sys.argv[1] if len(sys.argv) > 1 else 'java2/classes'
os.makedirs(out_dir, exist_ok=True)

count = 0
for src in ('java2/classes.dex.smali', 'java2/classes2.dex.smali'):
    cur = None
    buf = []
    for line in open(src, encoding='utf-8', errors='replace'):
        if line.startswith('.class '):
            if cur and buf:
                open(os.path.join(out_dir, cur + '.smali'), 'w').write(''.join(buf))
                count += 1
            m = re.search(r'(L[^;]+;)', line)
            name = m.group(1)[1:-1].replace('/', '.') if m else 'unknown'
            cur = name
            buf = [line]
        elif cur:
            buf.append(line)
    if cur and buf:
        open(os.path.join(out_dir, cur + '.smali'), 'w').write(''.join(buf))
        count += 1

print('classes written:', count)
