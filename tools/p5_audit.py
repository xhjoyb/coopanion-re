#!/usr/bin/env python3
"""P5: 裁包等价性审计 —— 证明「被删掉的条目在运行期从未被真正读取」。

思路
----
P4-B 把 payload 从 5,118 条目裁到 2,625 条目（删掉 1,997 个文件 / 50,766,668 B）。
「删了不影响运行」不能靠肉眼断言，本工具把它变成可复算的三步：

  L0 清单自洽    base manifest − cut manifest = 删除集合；
                 用 tools/p4_cut.py 的 rules() 复算分组字节，与裁包时的 cut5.txt 对账。
                 只统计 kind=f（普通文件）；连带删掉的软链单列 linked_removed，不计入组账。
  L1 运行期访问  strace -f 记录整条启动链的 openat / stat / access / readlink / execve，
                 按 pid 追踪 cwd 还原出「实际碰过的每个路径」，并保留 flags 与返回值。
  L2 结果分类    对命中的被删路径按 syscall 结果分三类：
                   read   只读打开成功     → 违规（文件已删，不可能成功）
                   probe  stat/access 失败 → 代码找过它但容错了，逐条列出供人判
                   create O_CREAT 写       → 运行期自建（如 home/.../runs/index.jsonl），无害
                 PASS 条件：违规 0；probe 全部在 --allow-probe 白名单内。

strace 采集见 tools/p5_run_trace.sh。建议 base 树与 cut 树各跑一份，diff 掉本底噪音。

用法
----
    python3 tools/p5_audit.py --base B.json --cut C.json --trace T.log --tree /tmp/tree5
    python3 tools/p5_audit.py ... --json out.json --allow-probe 'home/companion/data/runs/'
退出码 0 = PASS。
"""

import argparse
import json
import os
import re
import sys

# strace 行：  pid syscall(args) = ret
LINE_RE = re.compile(r'^(\d+)\s+([a-z0-9_]+)\((.*)\)\s+=\s+(.*)$')
STR_RE = re.compile(r'"((?:[^"\\]|\\.)*)"')
TAIL_RE = re.compile(r'"(?:[^"\\]|\\.)*"\s*,?\s*(.*)$', re.S)

PATH_CALLS = {
    'openat', 'openat2', 'open', 'creat',
    'newfstatat', 'stat', 'lstat', 'statx', 'fstatat64', 'stat64',
    'access', 'faccessat', 'faccessat2',
    'readlink', 'readlinkat',
    'execve', 'execveat',
}
META_CALLS = {
    'newfstatat', 'stat', 'lstat', 'statx', 'fstatat64', 'stat64',
    'access', 'faccessat', 'faccessat2', 'readlink', 'readlinkat',
}
OPEN_CALLS = {'openat', 'openat2', 'open', 'creat'}
FORK_CALLS = {'clone', 'clone3', 'fork', 'vfork'}
CWD_CALLS = {'chdir', 'fchdir'}

# cut5.txt 的实测账面（只算 kind=f；用于自洽校验，不一致告警不阻断）
EXPECT = {
    ('C', 'koffi'): (92, 4065490),
    ('D', 'lib-onnxruntime'): (1, 34606912),
    ('E', 'docs'): (267, 1366491),
    ('E', 'home-runs'): (23, 41977),
    ('E', 'npm'): (1614, 10685798),
}
EXPECT_TOTAL = (1997, 50766668)


def load_manifest(path):
    """manifest 是 tar 条目列表；返回 {raw_name: entry}（跳过 GNU 长名头 L）。"""
    with open(path, encoding='utf-8') as f:
        rows = json.load(f)
    out = {}
    for e in rows:
        if e.get('kind') == 'L':
            continue
        n = e.get('name')
        if n:
            out[n] = e
    return out


def norm(n):
    """'./app/x' -> 'app/x'；去掉目录尾斜杠。"""
    while n.startswith('./'):
        n = n[2:]
    return n.rstrip('/')


def build_rules():
    """从 tools/p4_cut.py 取规则（唯一真源，避免两处漂移）。"""
    sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
    import p4_cut  # noqa: E402

    out = []
    for g in ('B', 'C', 'D', 'E'):
        for label, pred in p4_cut.rules(g):
            out.append((g, label, pred))
    return out


def classify(name, rules):
    key = './' + name
    for g, label, pred in rules:
        if pred(key):
            return g, label
    return None


def verdict(call, flags, ret):
    if ret.startswith('-1'):
        return 'probe'
    if call in OPEN_CALLS and 'O_CREAT' in (flags or ''):
        return 'create'
    if call in META_CALLS:
        return 'meta'
    return 'read'


def parse_trace(path, tree, cwd_rel):
    """解析 strace -> (seen, outside, stats)；seen[rel] = [(call, flags, ret, pid)]"""
    tree = os.path.realpath(tree) if tree else None
    init_cwd = os.path.join(tree, cwd_rel) if tree else os.path.abspath(cwd_rel)
    cwd, seen, outside = {}, {}, set()
    stats = {'lines': 0, 'calls': 0, 'enoent': 0, 'unparsed': 0, 'unresolved': 0}

    def resolve(pid, p):
        if p.startswith('/'):
            return os.path.normpath(p)
        return os.path.normpath(os.path.join(cwd.get(pid, init_cwd), p))

    with open(path, encoding='utf-8', errors='replace') as f:
        for line in f:
            stats['lines'] += 1
            m = LINE_RE.match(line.rstrip('\n'))
            if not m:
                stats['unparsed'] += 1
                continue
            pid, call, args, ret = int(m.group(1)), m.group(2), m.group(3), m.group(4).strip()
            if call in FORK_CALLS:
                mm = re.match(r'^(-?\d+)', ret)
                if mm and int(mm.group(1)) > 0:
                    cwd[int(mm.group(1))] = cwd.get(pid, init_cwd)
                continue
            if call not in PATH_CALLS and call not in CWD_CALLS:
                continue
            sm = STR_RE.search(args)
            if not sm:
                continue
            p = sm.group(1).replace('\\"', '"').replace('\\\\', '\\')
            stats['calls'] += 1
            if call in CWD_CALLS:
                cwd[pid] = resolve(pid, p)
                continue
            if ret.startswith('-1'):
                stats['enoent'] += 1
            tm = TAIL_RE.search(args)
            flags = tm.group(1) if tm else ''
            abs_p = resolve(pid, p)
            if tree and abs_p.startswith(tree + os.sep):
                rel = abs_p[len(tree) + 1:].replace(os.sep, '/')
                seen.setdefault(rel, []).append((call, flags, ret, pid))
            else:
                stats['unresolved'] += 1
                outside.add((call, p, ret))
    stats['paths'] = len(seen)
    stats['outside'] = len(outside)
    return seen, outside, stats


def main(argv):
    ap = argparse.ArgumentParser()
    ap.add_argument('--base', required=True)
    ap.add_argument('--cut', required=True)
    ap.add_argument('--trace', required=True)
    ap.add_argument('--tree', default='')
    ap.add_argument('--cwd-rel', default='app/coop-stage')
    ap.add_argument('--json', default='')
    ap.add_argument('--limit', type=int, default=25)
    ap.add_argument('--allow-probe', action='append', default=[],
                    help='probe 类命中的白名单前缀（可多次），如 home/companion/data/runs/')
    a = ap.parse_args(argv[1:])

    base = load_manifest(a.base)
    cut = load_manifest(a.cut)

    # ---------- L0 清单自洽 ----------
    base_f = {norm(n): e for n, e in base.items() if e.get('kind') == 'f'}
    base_s = {norm(n): e for n, e in base.items() if e.get('kind') == 's'}
    cut_any = {norm(n) for n in cut}
    dropped = {n: e for n, e in base_f.items() if n not in cut_any}
    linked = {n: e for n, e in base_s.items() if n not in cut_any}

    rules = build_rules()
    groups, unknown = {}, []
    for n, e in dropped.items():
        g = classify(n, rules)
        if g is None:
            unknown.append(n)
            continue
        groups.setdefault(g, [0, 0])
        groups[g][0] += 1
        groups[g][1] += e.get('size', 0) or 0

    total_files = sum(v[0] for v in groups.values())
    total_bytes = sum(v[1] for v in groups.values())
    mismatch = []
    for k, exp in EXPECT.items():
        got = groups.get(k)
        if not got or tuple(got) != exp:
            mismatch.append((k, exp, tuple(got) if got else None))
    if (total_files, total_bytes) != EXPECT_TOTAL:
        mismatch.append(('TOTAL', EXPECT_TOTAL, (total_files, total_bytes)))

    print('=== L0 清单自洽 ===')
    print('  base %d 条目（普通文件 %d / 软链 %d）  cut %d 条目'
          % (len(base), len(base_f), len(base_s), len(cut)))
    print('  删除集合 %d 个普通文件 / %d B；连带删除软链 %d 条'
          % (total_files, total_bytes, len(linked)))
    for (g, label), (n, b) in sorted(groups.items()):
        print('    %s/%-16s files=%-5d bytes=%d' % (g, label, n, b))
    if unknown:
        print('  ⚠ %d 个删除项不属于任何组（首个：%s）' % (len(unknown), unknown[0]))
    if mismatch:
        print('  ⚠ 与 cut5.txt 账面不一致：')
        for k, exp, got in mismatch:
            print('      %s 期望 %s 实际 %s' % (k, exp, got))
    else:
        print('  ✅ 分组与字节和 cut5.txt 完全一致')

    # ---------- L1 运行期访问 ----------
    seen, outside, stats = parse_trace(a.trace, a.tree, a.cwd_rel)
    print('=== L1 运行期访问（strace） ===')
    print('  日志 %d 行 / 路径类调用 %d 次（返回失败 %d）/ 树内唯一路径 %d'
          % (stats['lines'], stats['calls'], stats['enoent'], stats['paths']))
    print('  树外访问 %d 次 / 无法归一 %d 次%s'
          % (stats['outside'], stats['unresolved'],
             '（cwd 恒定，归一可信）' if stats['unresolved'] == 0 else '（⚠ 有路径落在树外）'))

    # ---------- L2 结果分类 ----------
    hits = []
    rank = {'read': 0, 'probe': 1, 'create': 2, 'meta': 3}
    for n in dropped:
        recs = seen.get(n)
        if not recs:
            continue
        best = min(recs, key=lambda r: rank[verdict(r[0], r[1], r[2])])
        v = verdict(best[0], best[1], best[2])
        hits.append({'path': n, 'verdict': v, 'call': best[0],
                     'flags': best[1][:90], 'ret': best[2][:80], 'count': len(recs)})

    by_v = {}
    for h in hits:
        by_v.setdefault(h['verdict'], []).append(h)
    allowed = [h for h in by_v.get('probe', [])
               if any(h['path'].startswith(x) for x in a.allow_probe)]
    bad = by_v.get('read', [])
    prob = [h for h in by_v.get('probe', []) if h not in allowed]

    print('=== L2 求交：删除集合 ∩ 运行期访问 ===')
    print('  命中 %d 条：read %d / probe %d / create %d / meta %d'
          % (len(hits), len(bad), len(by_v.get('probe', [])),
             len(by_v.get('create', [])), len(by_v.get('meta', []))))
    for tag, lst in (('❌ read（真违规）', bad), ('⚠ probe（找了但容错）', prob),
                     ('· create（运行期自建，无害）', by_v.get('create', []))):
        if not lst:
            continue
        print('  %s：%d 条' % (tag, len(lst)))
        for h in lst[:a.limit]:
            print('      %-64s %s(%s) = %s' % (h['path'], h['call'], h['flags'], h['ret']))
        if len(lst) > a.limit:
            print('      ...还有 %d 条' % (len(lst) - a.limit))
    if allowed:
        print('  · probe 白名单放行：%d 条（前缀 %s）' % (len(allowed), ', '.join(a.allow_probe)))

    ok = (not bad) and (not prob) and (not mismatch) and (not unknown)
    print()
    print('结论：' + ('✅ PASS —— 裁剪未改变运行期文件依赖' if ok else '❌ FAIL'))

    if a.json:
        with open(a.json, 'w', encoding='utf-8') as f:
            json.dump({'ok': ok, 'base_entries': len(base), 'cut_entries': len(cut),
                       'dropped': {'files': total_files, 'bytes': total_bytes,
                                   'linked_removed': len(linked),
                                   'groups': {'%s/%s' % k: v for k, v in groups.items()}},
                       'manifest_match_cut5': not mismatch,
                       'trace': stats, 'hits': hits, 'allow_probe': a.allow_probe},
                      f, ensure_ascii=False, indent=2)
        print('  结果已写入 %s' % a.json)
    return 0 if ok else 1


if __name__ == '__main__':
    sys.exit(main(sys.argv))
