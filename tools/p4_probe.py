#!/usr/bin/env python3
"""P4-A 探针：原厂 tar 头 vs Python tarfile 写头，逐字节对比。

P4-A 能不能做，只取决于一件事：我们能不能写出与原厂逐字节相同的 512 字节头。
本脚本从 payload.tar 里取四类样本（普通文件 / 目录 / 软链 / 长名条目），
把原头字段解出来，再用 tarfile 按 GNU_FORMAT 生成同字段的头，逐字节 diff。
"""
import sys, tarfile

TAR = '/tmp/p4work/payload.tar'
BLK = 512
FIELDS = [
    ('name', 0, 100), ('mode', 100, 108), ('uid', 108, 116), ('gid', 116, 124),
    ('size', 124, 136), ('mtime', 136, 148), ('chksum', 148, 156),
    ('typeflag', 156, 157), ('linkname', 157, 257), ('magic', 257, 265),
    ('uname', 265, 297), ('gname', 297, 329), ('devmajor', 329, 337),
    ('devminor', 337, 345), ('prefix', 345, 500),
]


def num(b):
    if not b or b[0] in (0, 0x20):
        s = b.split(b'\x00')[0].strip()
        return int(s, 8) if s else 0
    if b[0] & 0x80:
        return int.from_bytes(b[1:], 'big')
    s = b.split(b'\x00')[0].strip()
    return int(s, 8) if s else 0


def parse(h):
    d = {}
    for k, a, b in FIELDS:
        d[k] = h[a:b]
    d['_mode'] = num(d['mode']); d['_uid'] = num(d['uid']); d['_gid'] = num(d['gid'])
    d['_size'] = num(d['size']); d['_mtime'] = num(d['mtime']); d['_chk'] = num(d['chksum'])
    return d


def samples(maxn=40):
    out = []
    with open(TAR, 'rb') as f:
        off = 0
        want = {'f': 1, 'd': 1, 's': 1, 'L': 1}
        while len(out) < maxn:
            f.seek(off); h = f.read(BLK)
            if len(h) < BLK or h == b'\x00' * BLK:
                break
            d = parse(h)
            tf = d['typeflag']
            key = {b'0': 'f', b'\x00': 'f', b'5': 'd', b'2': 's', b'L': 'L'}.get(tf, '?')
            off += BLK
            if key == 'L':
                if want['L']:
                    out.append((off - BLK, 'L', d))
                    want['L'] = 0
                lsz = d['_size']
                off += (lsz + BLK - 1) // BLK * BLK
                continue
            if key in want and want[key]:
                out.append((off - BLK, key, d))
                want[key] = 0
            off += (d['_size'] + BLK - 1) // BLK * BLK
    return out


def to_info(d):
    ti = tarfile.TarInfo(d['name'].split(b'\x00')[0].decode('utf-8', 'surrogateescape'))
    ti.mode = d['_mode']; ti.uid = d['_uid']; ti.gid = d['_gid']
    ti.size = d['_size']; ti.mtime = d['_mtime']
    ti.uname = d['uname'].split(b'\x00')[0].decode()
    ti.gname = d['gname'].split(b'\x00')[0].decode()
    ti.linkname = d['linkname'].split(b'\x00')[0].decode('utf-8', 'surrogateescape')
    tf = d['typeflag']
    ti.type = {b'0': tarfile.REGTYPE, b'\x00': tarfile.REGTYPE, b'5': tarfile.DIRTYPE,
               b'2': tarfile.SYMTYPE, b'L': tarfile.GNUTYPE_LONGNAME}.get(tf, tarfile.REGTYPE)
    return ti


def main():
    print('=== 样本头解析 ===')
    ss = samples()
    for off, key, d in ss:
        print()
        print('@%-10d type=%-2s size=%-10d mode=%o uid=%d gid=%d mtime=%d' % (
            off, key, d['_size'], d['_mode'], d['_uid'], d['_gid'], d['_mtime']))
        print('  name     =', d['name'].split(b'\x00')[0])
        print('  magic    =', d['magic'])
        print('  uname    =', d['uname'].split(b'\x00')[0], '| gname =', d['gname'].split(b'\x00')[0])
        print('  typeflag =', d['typeflag'], '| chksum =', oct(d['_chk']))
        if key == 's':
            print('  linkname =', d['linkname'].split(b'\x00')[0])
        # 用自己的逻辑生成头
        ti = to_info(d)
        gen = ti.tobuf(tarfile.GNU_FORMAT)
        with open(TAR, 'rb') as f:
            f.seek(off); orig = f.read(BLK)
        if gen == orig:
            print('  ✅ 头字节完全一致')
            continue
        print('  ❌ 头不一致，差异位：')
        for i in range(BLK):
            if gen[i] != orig[i]:
                a = max(0, i - 8); b = min(BLK, i + 16)
                print('    off=%d gen=%r' % (i, gen[a:b]))
                print('    off=%d org=%r' % (i, orig[a:b]))
                break


main()
