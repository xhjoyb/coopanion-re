#!/usr/bin/env python3
"""P3: 一次性产出文档所需的全部统计表（单次流式扫描 payload.asset）。

输出到 stdout，供 docs/05 直接引用。表项：
  1) gzip 头 / trailer
  2) 条目按类型
  3) 顶层子树体积
  4) node_modules 顶层包体积（有文件的包）
  5) 原生 .so/.node 体积 + sha256
  6) tar 元数据分布（mode / uname / mtime top）
  7) bin 软链清单
  8) home/companion/runs 事故文件
"""
import hashlib
import sys
import tarfile
import zipfile

APK = 'apk/Coopanion-v12.71.apk'
ENTRY = 'assets/payload.asset'
NATIVE_EXT = ('.so', '.node', '.so.6', '.so.1', '.so.0', '.so.2')


def gzip_head():
    with zipfile.ZipFile(APK) as z:
        zi = z.getinfo(ENTRY)
        with open(APK, 'rb') as fh:
            fh.seek(zi.header_offset)
            lh = fh.read(30)
            nlen = int.from_bytes(lh[26:28], 'little')
            elen = int.from_bytes(lh[28:30], 'little')
            data_off = zi.header_offset + 30 + nlen + elen
            with z.open(ENTRY) as f2:
                head = f2.read(16)
            fh.seek(data_off + zi.compress_size - 8)
            tail = fh.read(8)
    return head, tail, zi.compress_size


def main():
    head, tail, csize = gzip_head()
    print('# === 1. gzip 层 ===')
    print('gzip_head_hex = %s' % head.hex())
    print('gzip_mtime    = %d' % int.from_bytes(head[4:8], 'little'))
    print('gzip_xfl      = %d' % head[8])
    print('gzip_os       = %d' % head[9])
    print('compress_size = %d' % csize)
    print('crc32         = 0x%08x' % int.from_bytes(tail[0:4], 'little'))
    print('ISIZE         = %d' % int.from_bytes(tail[4:8], 'little'))
    print()

    kinds = {}
    top = {}
    pkgs = {}
    natives = []
    modes = {}
    unames = {}
    mtimes = {}
    binlinks = []
    runs = []
    total = 0
    nbytes = 0

    with zipfile.ZipFile(APK) as z:
        with z.open(ENTRY) as raw:
            with tarfile.open(fileobj=raw, mode='r|gz') as tf:
                for m in tf:
                    total += 1
                    t = m.type
                    kinds[t] = kinds.get(t, 0) + 1
                    modes[oct(m.mode)] = modes.get(oct(m.mode), 0) + 1
                    unames[(m.uname, m.gname)] = unames.get((m.uname, m.gname), 0) + 1
                    mtimes[m.mtime] = mtimes.get(m.mtime, 0) + 1
                    if m.isreg():
                        nbytes += m.size
                    p = m.name
                    seg = [x for x in p.split('/') if x and x != '.']
                    if seg:
                        k = seg[0]
                        a = top.setdefault(k, [0, 0])
                        if m.isreg():
                            a[0] += m.size
                        a[1] += 1
                    if 'node_modules' in seg:
                        i = seg.index('node_modules')
                        if i + 1 < len(seg):
                            pkg = seg[i + 1]
                            if pkg.startswith('@') and i + 2 < len(seg):
                                pkg += '/' + seg[i + 2]
                            root = '/'.join(seg[:i]) or '.'
                            a = pkgs.setdefault((root, pkg), [0, 0])
                            if m.isreg():
                                a[0] += m.size
                            a[1] += 1
                    if m.isreg() and p.endswith(NATIVE_EXT):
                        f = tf.extractfile(m)
                        h = hashlib.sha256()
                        while True:
                            c = f.read(1 << 20)
                            if not c:
                                break
                            h.update(c)
                        natives.append((m.size, h.hexdigest()[:16], p))
                    if m.issym() and '/bin/' in p:
                        binlinks.append((p, m.linkname))
                    if '/home/companion/data/runs/' in p:
                        runs.append((m.size, p))

    print('# === 2. 条目按类型 ===')
    for k, v in sorted(kinds.items(), key=lambda x: -x[1]):
        print('  type %r : %d' % (k, v))
    print('  total = %d  file_bytes = %d' % (total, nbytes))
    print()

    print('# === 3. 顶层子树 ===')
    for k, v in sorted(top.items(), key=lambda x: -x[1][0]):
        print('  %-14s %12d B  %5d 条' % (k, v[0], v[1]))
    print()

    roots = {}
    for (root, pkg), v in pkgs.items():
        r = roots.setdefault(root, [0, 0, 0])
        r[0] += v[0]
        r[1] += v[1]
        r[2] += 1
    print('# === 4a. node_modules 根（%d 个根 / %d 包） ===' % (len(roots), len(pkgs)))
    for r, v in sorted(roots.items(), key=lambda x: -x[1][0]):
        print('  %-46s %12d B %5d 条 %3d 包' % (r, v[0], v[1], v[2]))
    print()
    print('# === 4b. app/coop-stage/node_modules 顶层包 ===')
    for (root, pkg), v in sorted(pkgs.items(), key=lambda x: -x[1][0]):
        if root == 'app/coop-stage':
            print('  %-34s %12d B  %5d 条' % (pkg, v[0], v[1]))
    print()
    print('# === 4c. 其它根的包 ===')
    for (root, pkg), v in sorted(pkgs.items(), key=lambda x: -x[1][0]):
        if root != 'app/coop-stage':
            print('  %-30s %-30s %10d B %5d 条' % (root, pkg, v[0], v[1]))
    print()

    print('# === 5. 原生 .so / .node（%d 个） ===' % len(natives))
    seen = {}
    for s, h, p in sorted(natives, key=lambda x: -x[0]):
        dup = seen.setdefault(h, 1)
        print('  %10d %s %s%s' % (s, h, p, '  [DUP]' if dup > 1 else ''))
        seen[h] = dup + 1
    print()

    print('# === 6. tar 元数据 ===')
    for k, v in sorted(modes.items(), key=lambda x: -x[1]):
        print('  mode %s : %d' % (k, v))
    for k, v in sorted(unames.items(), key=lambda x: -x[1]):
        print('  uname/gname %r : %d' % (k, v))
    mt = sorted(mtimes.items(), key=lambda x: -x[1])
    print('  mtime 种类 = %d, min=%d, max=%d' % (len(mtimes),
                                                 min(mtimes), max(mtimes)))
    for k, v in mt[:6]:
        print('  mtime %d : %d' % (k, v))
    print()

    print('# === 7. bin 软链（%d 条） ===' % len(binlinks))
    apps = sorted(p.split('/')[-1] for p, l in binlinks if l.endswith('busybox'))
    print('  busybox applet %d: %s' % (len(apps), ' '.join(apps)))
    for p, l in binlinks:
        if not l.endswith('busybox'):
            print('  %s -> %s' % (p, l))
    print()

    print('# === 8. home/companion/runs（%d 条） ===' % len(runs))
    tot = 0
    for s, p in runs:
        tot += s
    print('  bytes = %d' % tot)
    for s, p in runs[:12]:
        print('  %8d %s' % (s, p))
    if len(runs) > 12:
        print('  ... 其余 %d 条' % (len(runs) - 12))
    return 0


if __name__ == '__main__':
    sys.exit(main())