#!/usr/bin/env python3
"""P4-B: 按 docs/05 \u00a74 的 B/C/D/E 四组裁剪 payload 条目，产出新 manifest。

  python3 tools/p4_cut.py --manifest M --out OM --groups B,C,D,E [--patch-boot] [--report R]

设计要点：
1. 裁剪只改 manifest（决定哪些条目入 tar），不动磁盘上的解包树——树是 P4-A 的基准物，
   保持全量才能随时回退对比。只有当 --patch-boot 时才改树里的 boot.sh（需备份）。
2. GNU 长名头（kind=L）必须与它修饰的条目同生共死，否则 tar 会多出一个空 L 头。
3. 删空后的目录条目要连带删，但 FORCE_KEEP 里的目录即便空了也保留（运行时要往里写）。
"""
import json, os, sys

FORCE_KEEP_DIRS = {
    './app/coop-stage/home/companion/data/runs/',
    './app/coop-stage/home/companion/data/',
    './app/coop-stage/home/companion/',
}

DOC_EXT = ('.md', '.markdown', '.rst')
DOC_NAMES = ('readme', 'license', 'licence', 'changelog', 'notice', 'copying', 'authors')


def rules(group):
    if group == 'B':
        return [('esbuild', lambda n: '/node_modules/esbuild/' in n or '/node_modules/@esbuild/' in n)]
    if group == 'C':
        return [('koffi', lambda n: '/node_modules/koffi/' in n or '/node_modules/@koromix/' in n)]
    if group == 'D':
        return [
            ('nested-sherpa', lambda n: n.startswith(
                './app/coop-stage/node_modules/sherpa-onnx-node/node_modules/'
                'sherpa-onnx-linux-arm64/')),
            ('lib-onnxruntime', lambda n: n == './lib/aarch64-linux-gnu/libonnxruntime.so'),
        ]
    if group == 'E':
        def is_doc(n):
            low = n.lower()
            if low.endswith(DOC_EXT):
                return True
            base = n.rsplit('/', 1)[-1].lower()
            return any(base.startswith(x) for x in DOC_NAMES)
        return [
            ('npm', lambda n: n.startswith('./lib/node_modules/npm/')
                              or n in ('./bin/npm', './bin/npx')),
            ('home-runs', lambda n: n.startswith(
                './app/coop-stage/home/companion/data/runs/')),
            ('tests-scripts', lambda n: n.startswith(
                ('./app/coop-stage/tests/', './app/coop-stage/scripts/',
                 './app/coop-stage/.claude/'))),
            ('docs', is_doc),
        ]
    raise SystemExit('unknown group ' + group)


def main():
    a = sys.argv
    def opt(k, d=None):
        return a[a.index(k) + 1] if k in a else d
    man_p = opt('--manifest', '/tmp/p4work/manifest.json')
    out_p = opt('--out', '/tmp/p4work/manifest.cut.json')
    groups = [g.strip() for g in opt('--groups', 'BCDE').split(',') if g.strip()]
    rep_p = opt('--report')

    M = json.load(open(man_p, encoding='utf-8'))
    print('input entries =', len(M))

    drop = {}
    for g in groups:
        for label, pred in rules(g):
            drop[(g, label)] = pred

    # 逐条判定（L 单独处理）
    keep = [None] * len(M)
    i = 0
    stat = {}
    dropped_files = 0
    dropped_bytes = 0
    while i < len(M):
        e = M[i]
        if e['kind'] == 'L':
            i += 1
            continue
        hit = None
        for (g, label), pred in drop.items():
            if pred(e['name']):
                hit = (g, label)
                break
        if hit and e['kind'] == 'f':
            stat[hit] = stat.get(hit, [0, 0])
            stat[hit][0] += 1
            stat[hit][1] += e['size']
            dropped_files += 1
            dropped_bytes += e['size']
        keep[i] = not bool(hit) or e['kind'] == 'd'
        i += 1

    # L 与后一条同生共死
    for i, e in enumerate(M):
        if e['kind'] == 'L':
            j = i + 1
            while j < len(M) and M[j]['kind'] == 'L':
                j += 1
            keep[i] = keep[j] if j < len(M) else False

    # 孤儿目录剪除
    kept_names = [M[i]['name'] for i in range(len(M))
                  if keep[i] and M[i]['kind'] in ('f', 's') and 'name' in M[i]]
    for i, e in enumerate(M):
        if keep[i] and e['kind'] == 'd':
            n = e['name']
            if n in FORCE_KEEP_DIRS:
                continue
            if not any(kn.startswith(n) for kn in kept_names):
                keep[i] = False

    # 软链连带删除：只删「因本次裁剪才悬空」的软链。
    # 原厂本来就悬空的（如 app/sherpa-native/librt.so.1）不动，避免改变原厂行为。
    def resolve_set(flags):
        s2 = set()
        for j, e2 in enumerate(M):
            if flags[j] and 'name' in e2:
                s2.add(os.path.normpath(e2['name']))
        return s2

    before = resolve_set([True] * len(M))
    after = resolve_set([bool(k) for k in keep])
    newly = 0
    for i, e in enumerate(M):
        if e['kind'] != 's' or not keep[i]:
            continue
        t = e['linkname']
        if t.startswith('/'):
            continue
        r = os.path.normpath(os.path.join(os.path.dirname(e['name']), t))
        if r in after:
            continue
        if r in before:
            keep[i] = False
            newly += 1
            print('  drop dangling symlink: %s -> %s' % (e['name'], t))
    if newly:
        print('  newly dangling symlinks dropped =', newly)

    out = [e for i, e in enumerate(M) if keep[i]]

    # 尺寸同步：build 是从磁盘读内容的，若树上的文件被改过（如 boot.sh 补丁），
    # manifest 里的 size 必须跟着变，否则 tar 会短读或错位。
    tree = opt('--tree', '/tmp/p4work/tree')
    fixed = 0
    for e in out:
        if e['kind'] != 'f':
            continue
        rel = e['name'][2:] if e['name'].startswith('./') else e['name']
        p = os.path.join(tree, rel)
        real = os.path.getsize(p)
        if real != e['size']:
            print('  size sync: %s %d -> %d' % (e['name'], e['size'], real))
            e['size'] = real
            fixed += 1
    if fixed:
        print('  size synced entries =', fixed)
    # 长名条目：被修饰条目的 raw_name 可能被截断，重建时靠 L 头还原，无需额外处理
    json.dump(out, open(out_p, 'w', encoding='utf-8'), ensure_ascii=False, indent=0)

    lines = []
    lines.append('groups = %s' % ','.join(groups))
    total = 0
    for (g, label) in sorted(stat):
        n, b = stat[(g, label)]
        total += b
        lines.append('  %s/%-16s files=%-6d bytes=%d' % (g, label, n, b))
    lines.append('  %-24s files=%-6d bytes=%d' % ('TOTAL dropped', dropped_files, total))
    lines.append('entries %d -> %d' % (len(M), len(out)))
    txt = '\n'.join(lines)
    print(txt)
    if rep_p:
        open(rep_p, 'w', encoding='utf-8').write(txt + '\n')


if __name__ == '__main__':
    main()
