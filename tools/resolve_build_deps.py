#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""构建期依赖版本锚点还原（可复算）。

背景：payload 只带了「运行时」依赖树（coop-stage/node_modules，95 项），
构建期依赖（devDependencies + 浏览器侧 dependencies）从树里消失了，
package.json 里只剩下 ^x.y.z 范围，没有精确版本。本脚本把锚点补回来。

还原方法（按优先级）：
  1) exact     package.json 里本来就是精确版本（无 ^ ~），直接采用。
  2) deployed  部署态 node_modules 里实际装着的版本（ground truth）。
  3) artifact  产物里能直接读到版本号（dist/web 的 CSS 横幅、bundle 内
               version:"x.y.z" 字符串）—— 最硬证据。
  4) snapshot  以上都无痕迹的纯 dev 包：以构建时点为截止时刻，取
               「发布时点 <= 截止时刻」且满足声明范围的最高版本。

构建时点（CUTOFF）取自 payload 内 dist 文件的 mtime：
  dist/web/main-VF7OQOQ5.js  2026-10-10 17:44:10 UTC
  dist/web/asset-manifest.json 同上
  （tar 打包保留原始 mtime，故这是真实构建时间的上界）

用法:
  python3 tools/resolve_build_deps.py                # 全量解析并打印表
  python3 tools/resolve_build_deps.py --json out.json
  python3 tools/resolve_build_deps.py --cache-dir .anchor-cache
  python3 tools/resolve_build_deps.py --offline      # 只用缓存
"""

import argparse
import json
import os
import sys
import time
import urllib.error
import urllib.request

REPO = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
REG = 'https://registry.npmjs.org/'

# 构建时点（UTC）——见模块 docstring
CUTOFF = '2026-10-10T17:44:10Z'

# 各子包：清单路径 -> 部署态 node_modules（pnpm 扁平化：根树 + 子树）
PACKAGES = [
    ('cortico', 'src/recovered/cortico/package.json'),
    ('coop-stage', 'src/recovered/coop-stage/package.json'),
    ('vendor/cua', 'src/recovered/vendor/cua/package.json'),
    ('vendor/pet', 'src/recovered/vendor/pet/package.json'),
    ('vendor/coo', 'src/recovered/vendor/coo/package.json'),
]
STAGE = 'src/rootfs/app/coop-stage'
NM_DIRS = [
    STAGE + '/node_modules',
    STAGE + '/build/cortico/node_modules',
    STAGE + '/vendor/cua/node_modules',
    STAGE + '/vendor/pet/node_modules',
    STAGE + '/vendor/coo/node_modules',
]

# 产物证据（硬证据，优先于 snapshot 推断）
EVIDENCE = {
    'react': ('19.3.0', 'dist/web/main-VF7OQOQ5.js 内 version:"19.3.0"（4 处）'),
    'react-dom': ('19.3.0', '同上 bundle（react + react-dom 同版本）'),
    'tailwindcss': ('4.3.3', 'dist/web/styles.css 首行 /*! tailwindcss v4.3.3 | MIT License */'),
    '@tailwindcss/cli': ('4.3.3', '与 tailwindcss 同版本流水线（v4 起同步发版），产物 CSS 已证实 4.3.3'),
}


# ---------- 极简 semver ----------
def parse_ver(v):
    core = v.split('+')[0]
    if '-' in core:
        return None  # 预发布版一律不参与
    parts = core.split('.')
    if len(parts) != 3 or not all(p.isdigit() for p in parts):
        return None
    return tuple(int(p) for p in parts)


def satisfies(ver, rng):
    """只支持 ^a.b.c 与精确 a.b.c（本仓库全部声明形态）。"""
    tv = parse_ver(ver)
    if tv is None:
        return False
    rng = rng.strip()
    if rng.startswith('^'):
        base = parse_ver(rng[1:])
        if base is None:
            return False
        if tv < base:
            return False
        a, b, _ = base
        if a > 0:
            return tv[0] == a
        if b > 0:
            return tv[0] == 0 and tv[1] == b
        return tv == base
    if rng[:1].isdigit():
        return tv == parse_ver(rng)
    return False


def is_exact(rng):
    return rng.strip()[:1].isdigit()


# ---------- 部署态扫描 ----------
def scan_installed():
    out = {}

    def one(nm, name):
        pj = os.path.join(nm, name, 'package.json')
        if os.path.isfile(pj):
            try:
                out.setdefault(name, json.load(open(pj, encoding='utf-8')).get('version'))
            except Exception:
                pass

    for nm in NM_DIRS:
        if not os.path.isdir(nm):
            continue
        for e in os.listdir(nm):
            if e.startswith('@'):
                sub = os.path.join(nm, e)
                if os.path.isdir(sub):
                    for e2 in sorted(os.listdir(sub)):
                        one(nm, e + '/' + e2)
            else:
                one(nm, e)
    return out


# ---------- registry ----------
def fetch_packument(pkg, cache_dir, offline=False, retries=3):
    os.makedirs(cache_dir, exist_ok=True)
    path = os.path.join(cache_dir, pkg.replace('/', '__') + '.json')
    if os.path.isfile(path) and os.path.getsize(path) > 1024:
        return json.load(open(path, encoding='utf-8'))
    if offline:
        return None
    url = REG + pkg.replace('/', '%2f')
    last = None
    for i in range(retries):
        try:
            req = urllib.request.Request(url, headers={
                'Accept': 'application/json',
                'User-Agent': 'coopanion-anchor/1.0',
            })
            with urllib.request.urlopen(req, timeout=90) as f:
                raw = f.read()
            d = json.loads(raw)
            open(path, 'wb').write(raw)
            return d
        except Exception as e:  # noqa: BLE001
            last = e
            time.sleep(1.5 * (i + 1))
    sys.stderr.write('[WARN] %s 拉取失败: %s\n' % (pkg, last))
    return None


def resolve_one(pkg, rng, cache_dir, offline):
    rec = {'package': pkg, 'range': rng}
    if is_exact(rng):
        rec.update(anchor=rng, method='exact', note='package.json 本就精确锁定')
        return rec
    doc = fetch_packument(pkg, cache_dir, offline)
    if doc is None:
        rec.update(anchor=None, method='unresolved', note='registry 不可达且无缓存')
        return rec
    times = doc.get('time', {})
    versions = doc.get('versions', {})
    cands = [v for v in versions if satisfies(v, rng)]
    if not cands:
        rec.update(anchor=None, method='unresolved', note='范围内无版本')
        return rec
    cut = CUTOFF
    before = [v for v in cands if times.get(v) and times[v] <= cut]
    after = [v for v in cands if times.get(v) and times[v] > cut]
    max_all = max(cands, key=parse_ver)

    ev = EVIDENCE.get(pkg)
    if ev:
        v = ev[0]
        ok_range = satisfies(v, rng)
        ok_time = times.get(v, '') <= cut
        rec.update(anchor=v, method='artifact', source=ev[1],
                   published=times.get(v), satisfies_range=ok_range,
                   published_before_cutoff=ok_time,
                   latest_in_range=max_all, newer_than_cutoff=len(after))
        return rec
    if not before:
        rec.update(anchor=None, method='unresolved',
                   note='范围内版本全部晚于构建时点', latest_in_range=max_all)
        return rec
    v = max(before, key=parse_ver)
    rec.update(anchor=v, method='snapshot', published=times.get(v),
               latest_in_range=max_all, newer_than_cutoff=len(after))
    return rec


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument('--json')
    ap.add_argument('--cache-dir', default=os.path.join(REPO, '.anchor-cache'))
    ap.add_argument('--offline', action='store_true')
    args = ap.parse_args()

    installed = scan_installed()
    print('部署态 node_modules 扫描: %d 个包' % len(installed))
    print('构建时点 CUTOFF = %s' % CUTOFF)
    print()

    rows = []
    for name, man in PACKAGES:
        p = os.path.join(REPO, man)
        if not os.path.isfile(p):
            continue
        d = json.load(open(p, encoding='utf-8'))
        for section in ('dependencies', 'devDependencies'):
            for pkg, rng in sorted(d.get(section, {}).items()):
                if pkg in installed:
                    rows.append({'package': pkg, 'range': rng, 'owner': name,
                                 'section': section, 'anchor': installed[pkg],
                                 'method': 'deployed',
                                 'note': '部署态实测 %s' % installed[pkg]})
                    continue
                r = resolve_one(pkg, rng, args.cache_dir, args.offline)
                r.update(owner=name, section=section)
                rows.append(r)

    # 指纹：同包不同范围可能解出不同锚，按 (package, range) 去重
    seen = set()
    uniq = []
    for r in rows:
        k = (r['package'], r['range'])
        if k in seen:
            continue
        seen.add(k)
        uniq.append(r)

    print('%-28s %-12s %-11s %-10s %s' % ('package', 'range', 'anchor', 'method', 'owner'))
    print('-' * 96)
    for r in uniq:
        print('%-28s %-12s %-11s %-10s %s' % (
            r['package'], r['range'], r.get('anchor') or '-', r['method'], r['owner']))

    miss = [r for r in uniq if not r.get('anchor')]
    print()
    print('共 %d 条声明 / %d 个唯一 (package,range) / 未解 %d' % (len(rows), len(uniq), len(miss)))
    for m in miss:
        print('  UNRESOLVED', m['package'], m['range'], m.get('note'))

    out = {
        'cutoff': CUTOFF,
        'generated_by': 'tools/resolve_build_deps.py',
        'registry': REG,
        'installed_count': len(installed),
        'declarations': len(rows),
        'unique': len(uniq),
        'unresolved': len(miss),
        'rows': uniq,
    }
    if args.json:
        dest = args.json if os.path.isabs(args.json) else os.path.join(REPO, args.json)
        json.dump(out, open(dest, 'w', encoding='utf-8'), ensure_ascii=False, indent=2)
        print('\n已写出', dest)
    return 0 if not miss else 1


if __name__ == '__main__':
    sys.exit(main())
