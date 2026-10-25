#!/usr/bin/env python3
"""P4-A 验收：从 APK 出发，完整走一遍「解 → 树 → 重打 → 重压」，逐层比 sha256。

  python3 tools/p4_verify.py [--work DIR]

四层验收：
  L1 APK 里的 payload.asset          基准物
  L2 gunzip 出的裸 tar               与基准逐字节比
  L3 解到磁盘再重打的 tar              必须与 L2 相同
  L4 重打 tar 按 gzip -6 重压         必须与 L1 相同

全 PASS 退出码 0；任一 FAIL 退出码 1。
"""
import gzip, hashlib, os, shutil, sys, zipfile

sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
import p4_gzip as G
import p4_repack as R

APK = 'apk/Coopanion-v12.71.apk'
ENTRY = 'assets/payload.asset'


def sha(p):
    h = hashlib.sha256()
    with open(p, 'rb') as f:
        while True:
            b = f.read(1 << 20)
            if not b:
                break
            h.update(b)
    return h.hexdigest(), os.path.getsize(p)


def main():
    work = '/tmp/p4work'
    if '--work' in sys.argv:
        work = sys.argv[sys.argv.index('--work') + 1]
    os.makedirs(work, exist_ok=True)
    base_asset = os.path.join(work, 'base.asset')
    tar1 = os.path.join(work, 'base.tar')
    tree = os.path.join(work, 'tree')
    man = os.path.join(work, 'manifest.json')
    tar2 = os.path.join(work, 'rebuilt.tar')
    asset2 = os.path.join(work, 'rebuilt.asset')

    with zipfile.ZipFile(APK) as z, z.open(ENTRY) as src, open(base_asset, 'wb') as out:
        shutil.copyfileobj(src, out, 1 << 20)

    with gzip.open(base_asset, 'rb') as g, open(tar1, 'wb') as out:
        shutil.copyfileobj(g, out, 1 << 20)

    shutil.rmtree(tree, ignore_errors=True)
    R.cmd_extract(tar1, tree, man)
    R.cmd_build(man, tree, tar2)
    G.main(tar2, asset2, 6)

    rows = [
        ('L1 payload.asset  (APK 内)',) + sha(base_asset),
        ('L2 tar            (解压后)',) + sha(tar1),
        ('L3 tar            (重打)  ',) + sha(tar2),
        ('L4 payload.asset  (重压)  ',) + sha(asset2),
    ]
    print()
    print('%-28s %-12s %s' % ('层', 'bytes', 'sha256'))
    for name, h, n in rows:
        print('%-28s %-12d %s' % (name, n, h))

    ok3 = rows[1][1] == rows[2][1]
    ok4 = rows[0][1] == rows[3][1]
    print()
    print('L3 重打 tar 与基准 tar 一致 :', 'PASS' if ok3 else 'FAIL')
    print('L4 重压 asset 与基准 asset 一致:', 'PASS' if ok4 else 'FAIL')
    return 0 if (ok3 and ok4) else 1


if __name__ == '__main__':
    sys.exit(main())
