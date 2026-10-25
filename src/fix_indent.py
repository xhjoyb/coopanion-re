import re

p = 'dex2smali.py'
src = open(p).read().split('\n')
start = None
end = None
for i, ln in enumerate(src):
    if ln == '    while i < insns_size:' and i > 200:
        start = i
        break
for i in range(start, len(src)):
    if src[i].startswith("    return '\\n'.join(lines)"):
        end = i
        break
print('start', start, 'end', end)
for i in range(start + 1, end):
    ln = src[i]
    if ln.startswith('    '):
        src[i] = ln[4:]
open(p, 'w').write('\n'.join(src))
print('done')
