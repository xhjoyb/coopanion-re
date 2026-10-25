#!/usr/bin/env python3
"""P4-B/P6: 按 docs/05 §4 的 B/C/D/E/F 五组裁剪 payload 条目，产出新 manifest。

   python3 tools/p4_cut.py --manifest M --out OM --groups B,C,D,E [--patch-boot] [--report R] [--d-symlink]

设计要点：
1. 裁剪只改 manifest（决定哪些条目入 tar），不动磁盘上的解包树——树是 P4-A 的基准物，
   保持全量才能随时回退对比。只有当 --patch-boot 时才改树里的 boot.sh（需备份）。
2. GNU 长名头（kind=L）必须与它修饰的条目同生共死，否则 tar 会多出一个空 L 头。
3. 删空后的目录条目要连带删，但 FORCE_KEEP 里的目录即便空了也保留（运行时要往里写）。
4. --d-symlink：嵌套 sherpa 的 4 个 native 不真删，改写成指向顶层副本的相对软链
   （层数用 posixpath.relpath 动态算，实际是 ../../../sherpa-onnx-linux-arm64/<名>）。原因：
   APK 内 MainActivity 有一张硬编码的「关键文件 + 期望字节数」清单（4 条嵌套 sherpa + bin/node），
   File.length() 会跟随软链拿到与顶层相同的字节数，从而保持 [CHK] 5/5 OK；否则日志会打出
   「解压有问题，语音会失败」的假警报（该检查不阻断启动）。软链在 tar 里不占数据块。
   附带收益：`boot.sh` 的 PKG-ABS 自检原指嵌套路径，经软链可直接解析到顶层副本，
   因此**不再需要给 boot.sh 打补丁**，基准树保持原厂字节。
"""
import json, os, posixpath, sys

FORCE_KEEP_DIRS = {
    './app/coop-stage/home/companion/data/runs/',
    './app/coop-stage/home/companion/data/',
    './app/coop-stage/home/companion/',
}

DOC_EXT = ('.md', '.markdown', '.rst')
DOC_NAMES = ('readme', 'license', 'licence', 'changelog', 'notice', 'copying', 'authors')


def rules(group):
    if group == 'B':
        # 已作废（自 cut-sym4 起）：boot.sh 用 `exec /bin/node --import tsx run-core.mjs` 跑 TS，
        # 而 tsx@4.23.15 的 dependencies 里写着 esbuild ~0.28.0 —— tsx 在**运行期**用 esbuild
        # 做真实转译，不是「构建期工具链」。真机删掉后 core 一启动就
        # ERR_MODULE_NOT_FOUND: Cannot find package 'esbuild'，rc=1 → 17788 永不监听
        # → 桌宠只剩 7797 的 ERR_CONNECTION_REFUSED 报错壳。故 B 组恒为空，保留 esbuild 全量。
        return []
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
            # 只删 node_modules 里的包文档（README/LICENSE/CHANGELOG…）。
            # 不能全树删 .md：`app/core/seed/CONSTITUTION.md` 是 seed.ts 运行期 copyFile 的
            # 种子模板，persona/*.md、src/worlds/terminal/ENV_PROMPT.md 也是运行期数据，
            # 删了会在 core 启动阶段直接 ENOENT 崩掉（已实测）。
            if '/node_modules/' not in n:
                return False
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
    if group == 'F':
        # F 组：本地 strace 实证可裁的「声明但零引用」依赖子树（详见 docs/05 §10）。
        #
        # 1) dead-dep-subtree：`cortico/package.json` 声明了 `tar-stream: 3.2.1`，但
        #    cortico/{src,dist,bots} 里 grep 零命中 —— 死依赖。tar-stream 又拖来一整棵子树：
        #      tar-stream   -> b4a, bare-fs, fast-fifo, streamx
        #      streamx      -> events-universal, teex, text-decoder
        #      events-universal -> bare-events（仅 exports.bare 分支，Node 走 default -> require('events')）
        #      bare-fs      -> bare-events, bare-stream, bare-url
        #    这些包的 package.json 互相引用，形成闭合集合，全树无任何外部 require。
        #    实证：12 个包同时 mv 走 -> rc=0，web面板 17788 已启动，core已启动，shutdown 六步全 ok。
        # 2) esbuild-native：`@esbuild/linux-arm64/bin/esbuild`（10,289,264 B）。
        #    esbuild@0.28.2 的 lib/main.js 里 build/transform 等导出全是
        #    `() => ensureServiceIsRunning().xxx()`，require 时不 spawn；tsx@4.23.15 只在
        #    fallback 时才需要它。包内 Node 是 v24.21.0（原生剥 TypeScript 类型），
        #    app/ 下仅 5 个 .ts 且无 enum/namespace/装饰器，走不到 esbuild 二进制。
        #    实证：单独 mv 走 -> rc=0，六步全 ok，模块错误 0。
        #    注意：JS 包 `esbuild` 本身必须保留（static import 会加载 lib/main.js）。
        dead = ('bare-path', 'bare-events', 'bare-stream', 'bare-fs', 'bare-url',
                'tar-stream', 'streamx', 'b4a', 'events-universal', 'teex',
                'fast-fifo', 'text-decoder')
        NM = './app/coop-stage/node_modules/'

        def is_dead_subtree(n):
            if not n.startswith(NM):
                return False
            return n[len(NM):].split('/', 1)[0] in dead

        def is_esbuild_native(n):
            return n.startswith(NM + '@esbuild/linux-arm64/')

        return [
            ('dead-dep-subtree', is_dead_subtree),
            ('esbuild-native', is_esbuild_native),
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
    d_symlink = '--d-symlink' in a

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
            if d_symlink and hit == ('D', 'nested-sherpa'):
                base = e['name'].rsplit('/', 1)[-1]
                e['kind'] = 's'
                e['linkname'] = posixpath.relpath(
                    'app/coop-stage/node_modules/sherpa-onnx-linux-arm64/' + base,
                    e['name'][2:].rsplit('/', 1)[0])
                e['size'] = 0
                e['mode'] = 0o777
                stat[('D', 'dedup-symlink')] = stat.get(('D', 'dedup-symlink'), [0, 0])
                stat[('D', 'dedup-symlink')][0] += 1
                keep[i] = True
                i += 1
                continue
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
