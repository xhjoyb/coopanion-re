#!/usr/bin/env python3
"""P4-A: 把 payload.tar 解到磁盘，再从磁盘按原元数据重打成 tar，比 sha256。

  extract <tar> <tree> <manifest.json>
  build   <manifest.json> <tree> <out.tar>

为什么必须自己写 L 头（不能用 tarfile 自动生成）：
  原厂 22 个 GNU LongLink 辅助头是 mode=0 / mtime=0 / uname=gname=''，
  而 CPython 的 _write_gnu_long_link 会从被指条目拷 uid/gid/uname/gname/mtime，
  直接 addfile 会 22 处全错。

为什么还要逐条记 magic（本工具第 2 版新增）：
  这个 tar 是【混合格式】—— 前 5107 条是 GNU（magic 'ustar  \\0'），
  最后 11 条（vendor/pet/web/*）是 POSIX ustar（'ustar\\0' + '00'）且 mtime=0。
  那不是 bug，是主 rootfs 打完后用另一个写入器追加的 web UI 覆盖层。
  重建时必须原样写回，否则 checksum 差 32，整块头变。
"""
import hashlib, json, os, sys, tarfile

BLK = 512
ZERO = b'\x00' * BLK
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


def cut(b):
    return b.split(b'\x00')[0]


def fix_magic(buf, magic):
    """把 magic/version 8 字节写回并重算 checksum（chksum 区当 8 个空格）。"""
    b = bytearray(buf)
    b[257:265] = magic
    b[148:156] = b' ' * 8
    chk = sum(b)
    b[148:156] = ('%06o' % chk).encode() + b'\x00 '
    return bytes(b)


def cmd_extract(tar_path, tree, man_path):
    entries = []
    os.makedirs(tree, exist_ok=True)
    with open(tar_path, 'rb') as f:
        size_total = os.path.getsize(tar_path)
        off = 0
        pending_long = None
        while off + BLK <= size_total:
            f.seek(off)
            h = f.read(BLK)
            if h == ZERO:
                break
            d = {k: h[a:b] for k, a, b in FIELDS}
            tf = d['typeflag']
            raw_name = cut(d['name'])
            dmode = num(d['mode']); dsize = num(d['size']); dmtime = num(d['mtime'])
            duname = cut(d['uname']); dgname = cut(d['gname'])
            magic = d['magic']
            off += BLK
            body_off = off
            data_blocks = (dsize + BLK - 1) // BLK * BLK

            if tf == b'L':
                f.seek(body_off)
                payload = f.read(dsize)
                assert payload.endswith(b'\x00'), payload[-4:]
                pending_long = payload[:-1]
                entries.append({'kind': 'L', 'long': pending_long.decode('utf-8', 'surrogateescape'),
                                'l_mode': dmode, 'l_mtime': dmtime, 'l_magic': magic.hex(),
                                'l_uname': duname.decode(), 'l_gname': dgname.decode(),
                                'l_size': dsize})
                off += data_blocks
                continue

            name = pending_long if pending_long is not None else raw_name
            pending_long = None
            nm = name.decode('utf-8', 'surrogateescape')
            rel = nm[2:] if nm.startswith('./') else nm
            dest = os.path.join(tree, rel) if rel not in ('.', '') else tree
            kind = {b'0': 'f', b'\x00': 'f', b'5': 'd', b'2': 's'}.get(tf, '?')
            entries.append({'kind': kind, 'name': nm, 'mode': dmode,
                            'uid': num(d['uid']), 'gid': num(d['gid']),
                            'size': dsize, 'mtime': dmtime, 'magic': magic.hex(),
                            'uname': duname.decode(), 'gname': dgname.decode(),
                            'linkname': cut(d['linkname']).decode('utf-8', 'surrogateescape'),
                            'raw_name': raw_name.decode('utf-8', 'surrogateescape')})

            if kind == 'd':
                os.makedirs(dest, exist_ok=True)
                os.chmod(dest, dmode & 0o7777)
                os.utime(dest, (dmtime, dmtime))
            elif kind == 's':
                parent = os.path.dirname(dest)
                if parent:
                    os.makedirs(parent, exist_ok=True)
                if os.path.lexists(dest):
                    os.remove(dest)
                os.symlink(entries[-1]['linkname'], dest)
            elif kind == 'f':
                parent = os.path.dirname(dest)
                if parent:
                    os.makedirs(parent, exist_ok=True)
                f.seek(body_off)
                left = dsize
                with open(dest, 'wb') as o:
                    while left > 0:
                        b = f.read(min(1 << 20, left))
                        if not b:
                            raise RuntimeError('truncated at %s' % nm)
                        o.write(b)
                        left -= len(b)
                os.chmod(dest, dmode & 0o7777)
                os.utime(dest, (dmtime, dmtime))
            else:
                raise SystemExit('未知 typeflag %r at %s' % (tf, nm))

            off += data_blocks

    with open(man_path, 'w', encoding='utf-8') as o:
        json.dump(entries, o, ensure_ascii=False, indent=0)
    n = {'f': 0, 'd': 0, 's': 0, 'L': 0}
    for e in entries:
        n[e['kind']] += 1
    print('extract: entries=%d %s' % (len(entries), n))
    print('manifest =', man_path)


def cmd_build(man_path, tree, out_path):
    entries = json.load(open(man_path, encoding='utf-8'))
    h = hashlib.sha256()
    total = 0
    with open(out_path, 'wb') as o:
        def emit(b):
            nonlocal total
            o.write(b); h.update(b); total += len(b)

        for e in entries:
            if e['kind'] == 'L':
                nm = e['long'].encode('utf-8', 'surrogateescape')
                ti = tarfile.TarInfo('././@LongLink')
                ti.type = tarfile.GNUTYPE_LONGNAME
                ti.mode = e['l_mode']; ti.uid = 0; ti.gid = 0
                ti.size = e['l_size']; ti.mtime = e['l_mtime']
                ti.uname = e['l_uname']; ti.gname = e['l_gname']
                buf = fix_magic(ti.tobuf(tarfile.GNU_FORMAT), bytes.fromhex(e['l_magic']))
                emit(buf)
                body = nm + b'\x00'
                assert len(body) == e['l_size'], (len(body), e['l_size'])
                emit(body + b'\x00' * ((-len(body)) % BLK))
                continue

            ti = tarfile.TarInfo(e['raw_name'])
            ti.mode = e['mode']; ti.uid = e['uid']; ti.gid = e['gid']
            ti.mtime = e['mtime']; ti.uname = e['uname']; ti.gname = e['gname']
            ti.linkname = e['linkname']
            ti.type = {'f': tarfile.REGTYPE, 'd': tarfile.DIRTYPE, 's': tarfile.SYMTYPE}[e['kind']]
            ti.size = e['size'] if e['kind'] == 'f' else 0
            emit(fix_magic(ti.tobuf(tarfile.GNU_FORMAT), bytes.fromhex(e['magic'])))
            if e['kind'] == 'f' and e['size']:
                rel = e['name'][2:] if e['name'].startswith('./') else e['name']
                src = os.path.join(tree, rel)
                left = e['size']
                with open(src, 'rb') as f:
                    while left > 0:
                        b = f.read(min(1 << 20, left))
                        if not b:
                            raise RuntimeError('short read %s' % src)
                        o.write(b); h.update(b); total += len(b)
                        left -= len(b)
                pad = (-e['size']) % BLK
                if pad:
                    emit(b'\x00' * pad)
        emit(ZERO + ZERO)
    print('build: bytes=%d' % total)
    print('sha256 =', h.hexdigest())
    print('out =', out_path)


if __name__ == '__main__':
    if len(sys.argv) < 2:
        raise SystemExit(__doc__)
    c = sys.argv[1]
    if c == 'extract':
        cmd_extract(sys.argv[2], sys.argv[3], sys.argv[4])
    elif c == 'build':
        cmd_build(sys.argv[2], sys.argv[3], sys.argv[4])
    else:
        raise SystemExit('unknown cmd ' + c)
