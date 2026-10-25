#!/usr/bin/env python3
"""P5: 基线树 vs 裁剪树的运行期访问矩阵（等价性的正面证据）。

p5_audit.py 回答「被删的东西运行期有没有被碰」，本工具反过来问：
**完整树里这些文件本来是会被访问的吗？**

    对每个被删文件 p，看它在两份 strace 里的出现情况：

      (F,F)  两边都不访问            → 与运行无关（绝大多数应落在这里）
      (T,F)  基线访问、裁剪不访问     → 只有「历史运行残留」属预期，其余需人看
      (T,T)  两边都访问              → O_CREAT 自建无害；read/probe 才是危险
      (F,T)  基线不访问、裁剪才访问   → 异常（随机性/环境差异）

PASS 条件：(F,T)=0；(T,T) 里没有 read/probe；(T,F) 全部落在允许前缀内。

用法
----
    python3 tools/p5_ab.py \
        --base-manifest manifest.json --base-trace traceB.log --base-tree /tmp/treeB \
        --cut-manifest manifest.cut5.json --cut-trace trace5.a.log --cut-tree /tmp/tree5
退出码 0 = PASS。
"""

import argparse
import os
import sys

sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
from p5_audit import load_manifest, norm, parse_trace, verdict  # noqa: E402

RANK = {'read': 0, 'probe': 1, 'create': 2, 'meta': 3}
# 历史运行记录被有意删除：基线会读它们，裁剪后不再读 —— 属预期
DEFAULT_TF_ALLOW = ('app/coop-stage/home/companion/data/runs/',)


def main(argv):
    ap = argparse.ArgumentParser()
    ap.add_argument('--base-manifest', required=True)
    ap.add_argument('--cut-manifest', required=True)
    ap.add_argument('--base-trace', required=True)
    ap.add_argument('--cut-trace', required=True)
    ap.add_argument('--base-tree', required=True)
    ap.add_argument('--cut-tree', required=True)
    ap.add_argument('--cwd-rel', default='app/coop-stage')
    ap.add_argument('--allow-tf', action='append', default=list(DEFAULT_TF_ALLOW),
                    help='允许出现 (T,F) 的路径前缀（可多次）')
    ap.add_argument('--out', default='')
    ap.add_argument('--limit', type=int, default=30)
    a = ap.parse_args(argv[1:])

    bm = load_manifest(a.base_manifest)
    cm = load_manifest(a.cut_manifest)
    base_f = {norm(n) for n, e in bm.items() if e.get('kind') == 'f'}
    cut_any = {norm(n) for n in cm}
    dropped = sorted(n for n in base_f if n not in cut_any)

    bseen, _, bstat = parse_trace(a.base_trace, a.base_tree, a.cwd_rel)
    cseen, _, cstat = parse_trace(a.cut_trace, a.cut_tree, a.cwd_rel)

    print('=== 采集 ===')
    print('  base: %d 行 / 树内唯一路径 %d' % (bstat['lines'], bstat['paths']))
    print('  cut : %d 行 / 树内唯一路径 %d' % (cstat['lines'], cstat['paths']))
    print('  被删文件 %d 个' % len(dropped))

    ff, tf, tt_bad, tt_create, ft = [], [], [], [], []
    for n in dropped:
        b, c = n in bseen, n in cseen
        if b and c:
            recs = cseen[n]
            vs = sorted({verdict(x[0], x[1], x[2]) for x in recs}, key=lambda k: RANK[k])
            rec = min(recs, key=lambda x: RANK[verdict(x[0], x[1], x[2])])
            row = (n, vs[0], rec[0], rec[1][:40], rec[2][:48], len(recs))
            (tt_create if vs[0] == 'create' else tt_bad).append(row)
        elif b:
            tf.append((n, bseen[n][0][0], bseen[n][0][2][:48]))
        elif c:
            ft.append((n, cseen[n][0][0], cseen[n][0][2][:48]))
        else:
            ff.append(n)

    tf_ok = [x for x in tf if any(x[0].startswith(p) for p in a.allow_tf)]
    tf_bad = [x for x in tf if x not in tf_ok]

    print('=== 访问矩阵（分母 = 被删 %d 个文件）===' % len(dropped))
    print('  (F,F) 两边都不访问          %6d  （%.1f%%）' % (len(ff), 100.0 * len(ff) / max(1, len(dropped))))
    print('  (T,F) 基线访问/裁剪不访问    %6d  （预期历史残留 %d，其他 %d）'
          % (len(tf), len(tf_ok), len(tf_bad)))
    print('  (T,T) 两边都访问            %6d  （create 自建 %d，真违规 %d）'
          % (len(tt_bad) + len(tt_create), len(tt_create), len(tt_bad)))
    print('  (F,T) 裁剪新访问            %6d' % len(ft))

    if tt_bad:
        print('\n❌ (T,T) 真违规明细：')
        for n, v, call, flags, ret, cnt in tt_bad[:a.limit]:
            print('    %-60s %s %s(%s) = %s ×%d' % (n, v, call, flags, ret, cnt))
    if tt_create:
        print('\n· (T,T) create 明细（两边都自建，无害）：')
        for n, v, call, flags, ret, cnt in tt_create[:a.limit]:
            print('    %-60s %s(%s) = %s' % (n, call, flags, ret))
    if ft:
        print('\n❌ (F,T) 明细：')
        for n, call, ret in ft[:a.limit]:
            print('    %-64s %s = %s' % (n, call, ret))
    if tf_bad:
        print('\n❌ (T,F) 非预期明细：')
        for n, call, ret in tf_bad[:a.limit]:
            print('    %-64s %s = %s' % (n, call, ret))
    if tf_ok:
        print('\n⚠ (T,F) 预期明细（历史运行记录，裁剪后不再读）：%d 条' % len(tf_ok))
        for n, call, ret in tf_ok[:a.limit]:
            print('    %-64s %s = %s' % (n, call, ret))
        if len(tf_ok) > a.limit:
            print('    ...还有 %d 条（同前缀）' % (len(tf_ok) - a.limit))

    # 全量访问差异（不限被删集合），看裁剪对整体行为的影响
    noise = lambda p: '/data/runs/' in p   # 每次运行生成随机 run id，属噪音
    b_only = sorted(p for p in set(bseen) - set(cseen) if not noise(p))
    c_only = sorted(p for p in set(cseen) - set(bseen) if not noise(p))
    print('\n=== 全量访问差异（排除 runs/ 随机名）===')
    print('  只有基线访问：%d 条   只有裁剪访问：%d 条' % (len(b_only), len(c_only)))
    for p in b_only[:a.limit]:
        print('    base-only  %s' % p)
    if len(b_only) > a.limit:
        print('    ...还有 %d 条' % (len(b_only) - a.limit))
    for p in c_only[:a.limit]:
        print('    cut-only   %s' % p)

    ok = not tt_bad and not ft and not tf_bad
    print('\n结论：' + ('✅ PASS —— 裁剪只影响被有意删除的历史数据，未引入新访问/新读取'
                       if ok else '❌ FAIL'))
    if a.out:
        with open(a.out, 'w', encoding='utf-8') as f:
            f.write('# FF=%d TF=%d(ok %d / bad %d) TT_create=%d TT_bad=%d FT=%d\n'
                    % (len(ff), len(tf), len(tf_ok), len(tf_bad), len(tt_create), len(tt_bad), len(ft)))
            for n in ff:
                f.write('FF\t%s\n' % n)
            for n, call, ret in tf_ok:
                f.write('TF_OK\t%s\t%s\t%s\n' % (n, call, ret))
            for n, call, ret in tf_bad:
                f.write('TF_BAD\t%s\t%s\t%s\n' % (n, call, ret))
            for n, v, call, flags, ret, cnt in tt_create:
                f.write('TT_CREATE\t%s\t%s\t%s\t%s\n' % (n, call, flags, ret))
            for n, v, call, flags, ret, cnt in tt_bad:
                f.write('TT_BAD\t%s\t%s\t%s\t%s\n' % (n, v, flags, ret))
            for n, call, ret in ft:
                f.write('FT\t%s\t%s\t%s\n' % (n, call, ret))
            f.write('# base-only %d ; cut-only %d\n' % (len(b_only), len(c_only)))
            for p in b_only:
                f.write('BASE_ONLY\t%s\n' % p)
            for p in c_only:
                f.write('CUT_ONLY\t%s\n' % p)
        print('  明细已写入 %s' % a.out)
    return 0 if ok else 1


if __name__ == '__main__':
    sys.exit(main(sys.argv))
