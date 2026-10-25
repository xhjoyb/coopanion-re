#!/usr/bin/env python3
"""Export the recovered Node/TS source tree out of the unpacked proot rootfs."""
import os
import shutil
import sys

SRC = '/data/user/0/app.operit/files/workspaces/identities/identity-1792103375772-2c229dc7/dafeiyu/Coopanion_v12.71/src'
STAGE = os.path.join(SRC, 'rootfs/app/coop-stage')
OUT = os.path.join(SRC, 'recovered')

SKIP_DIRS = {'node_modules', '.git', '.cache'}
SKIP_EXT = {'.node', '.so', '.so.1'}

JOBS = [
    ('cortico', os.path.join(STAGE, 'build/cortico'), None),
    ('vendor/cua', os.path.join(STAGE, 'vendor/cua'), None),
    ('vendor/coo', os.path.join(STAGE, 'vendor/coo'), None),
    ('vendor/pet', os.path.join(STAGE, 'vendor/pet'), None),
    ('coop-stage/app', os.path.join(STAGE, 'app'), None),
    ('coop-stage/home', os.path.join(STAGE, 'home'), None),
]
FILES = [
    ('coop-stage/boot.sh', os.path.join(SRC, 'rootfs/app/boot.sh')),
    ('coop-stage/run-core.mjs', os.path.join(STAGE, 'run-core.mjs')),
    ('coop-stage/package.json', os.path.join(STAGE, 'package.json')),
    ('coop-stage/package-lock.json', os.path.join(STAGE, 'package-lock.json')),
]

stats = {'files': 0, 'bytes': 0, 'skipped_bin': 0}


def copy_tree(src, dst):
    for root, dirs, files in os.walk(src):
        dirs[:] = [d for d in dirs if d not in SKIP_DIRS]
        rel = os.path.relpath(root, src)
        target = dst if rel == '.' else os.path.join(dst, rel)
        os.makedirs(target, exist_ok=True)
        for f in files:
            sp = os.path.join(root, f)
            ext = os.path.splitext(f)[1]
            if ext in SKIP_EXT:
                stats['skipped_bin'] += 1
                continue
            try:
                if os.path.islink(sp):
                    link = os.readlink(sp)
                    dp = os.path.join(target, f)
                    if not os.path.exists(dp):
                        os.symlink(link, dp)
                    continue
                size = os.path.getsize(sp)
                if size > 4 * 1024 * 1024:
                    stats['skipped_bin'] += 1
                    continue
                shutil.copy2(sp, os.path.join(target, f))
                stats['files'] += 1
                stats['bytes'] += size
            except Exception as e:
                print('skip %s: %s' % (sp, e))


def main():
    os.makedirs(OUT, exist_ok=True)
    for name, src, _ in JOBS:
        dst = os.path.join(OUT, name)
        if not os.path.isdir(src):
            print('MISSING', src)
            continue
        copy_tree(src, dst)
        print('exported', name)
    for name, src in FILES:
        dst = os.path.join(OUT, name)
        os.makedirs(os.path.dirname(dst), exist_ok=True)
        shutil.copy2(src, dst)
        stats['files'] += 1
        stats['bytes'] += os.path.getsize(src)
        print('exported', name)
    print('TOTAL files=%d bytes=%d skipped_bin=%d' % (stats['files'], stats['bytes'], stats['skipped_bin']))


if __name__ == '__main__':
    main()