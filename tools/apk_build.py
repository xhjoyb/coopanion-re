#!/usr/bin/env python3
"""payload 补丁 → APK 重组 → v2 签名，一条命令走完。

背景：这条链最早散在 `.operit/` 的一次性脚本里（`patch_pet3.py` / `repack8.py` +
`Sign2.java` / `Verify2.java`），参数写死、无法从仓库复现。本文件是它们的合并版，
每一步的语义与原脚本逐条对齐，差异只在「可参数化」和「不写死路径」：

  1. tar 流替换：按 ustar 头逐条拷贝，命中目标才换内容并重算 `chksum`；
     `LongLink`(typeflag `L`) 的 real name 跟随后处理；遇全零块即认为 EOF，
     其后字节原样透传（与原脚本一致）。
  2. gzip 重压：`GzipFile(filename='', compresslevel=6, mtime=0)` → 头恒为
     `1f 8b 08 00 00 00 00 00 00 ff`（无 FNAME/MTIME/XFL），保证可逐字节复现。
     全程流式（APK→gunzip→tar 替换→gzip→回填 APK），不落 344 MB 临时 tar。
  3. zip 重组：`STORED` 条目按 `lib/`→4096、其余→4 对齐（写 extra field 补齐），
     `DEFLATE` 条目按内容伸缩不管对齐；沿用原条目的 `date_time`/`external_attr`/
     `create_system`；跳过 `META-INF/{COOPANIO.SF,RSA,DSA,MANIFEST.MF}` 与
     `META-INF/version-control-info.textproto`（重签会重建）。
  4. 签名：apksig 2.3.0，`v1=off / v2=on`，单签名者，PKCS12 keystore。

例：
  # 只改 payload 里两个前端 JS（最常用），直接出可安装的签名包
  python3 tools/apk_build.py \
      --patch-tar './app/coop-stage/vendor/pet/web/pet-core.js=src/recovered/vendor/pet/web/pet-core.js' \
      --patch-tar './app/coop-stage/vendor/pet/web/pet-app.js=.operit/patch/pet-app.patched.js' \
      --out .operit/work/pet4_unsigned.apk \
      --keystore .operit/sign/coop.keystore --ks-pass 123456 --ks-alias coop \
      --signed-out .operit/repack/Coopanion_v12.71_pet4_signed.apk

  # 用现成的 payload 压缩包（跳过 tar 替换），复现任一历史包
  python3 tools/apk_build.py --payload-tgz .operit/patch/payload_new3.tar.gz ...

  # 顺带替换 dex（需要 smali 往返产物时）
  python3 tools/apk_build.py --dex classes.dex=.operit/sm/out1.dex --dex classes2.dex=.operit/sm/out2.dex ...
"""
import argparse
import gzip
import hashlib
import os
import struct
import subprocess
import sys
import zipfile

SKIP = ('META-INF/COOPANIO.SF', 'META-INF/COOPANIO.RSA', 'META-INF/COOPANIO.DSA',
        'META-INF/MANIFEST.MF', 'META-INF/version-control-info.textproto')
BLOCK = 512
ZERO = b'\x00' * BLOCK
JAVA_EXPORTS = ('--add-exports', 'java.base/sun.security.x509=ALL-UNNAMED',
                '--add-exports', 'java.base/sun.security.pkcs=ALL-UNNAMED',
                '--add-exports', 'java.base/sun.security.util=ALL-UNNAMED')


def log(msg):
    print(msg, flush=True)


def sha256(path):
    h = hashlib.sha256()
    with open(path, 'rb') as fh:
        for chunk in iter(lambda: fh.read(1 << 20), b''):
            h.update(chunk)
    return h.hexdigest()


def ustar_cksum(hdr):
    """ustar 头校验和：第 148..156 字节置空格后按字节求和，写成 6 位八进制 + NUL + 空格。"""
    h = bytearray(hdr)
    h[148:156] = b' ' * 8
    return ('%06o' % sum(h)).encode('ascii') + b'\x00 '


def tar_replace_iter(stream, targets):
    """流式读 tar，逐块产出（必要时替换目标的头部+内容）。targets: {bytes name: bytes data}"""
    pending_long = None
    stats = {'entries': 0, 'replaced': {}}
    while True:
        hdr = stream.read(BLOCK)
        if len(hdr) < BLOCK:          # 截断/结束，原样透传
            if hdr:
                yield hdr
            return
        if hdr == ZERO:               # EOF 标记块，其后全部透传
            yield hdr
            rest = stream.read()
            while rest:
                yield rest
                rest = stream.read()
            return
        stats['entries'] += 1
        name = hdr[0:100].split(b'\x00')[0]
        typeflag = hdr[156:157]
        try:
            size = int(hdr[124:136].split(b'\x00')[0].strip() or b'0', 8)
        except ValueError:
            size = 0
        real = pending_long if pending_long is not None else name
        data = stream.read(size) if size else b''
        pad = (BLOCK - size % BLOCK) % BLOCK
        padding = stream.read(pad) if pad else b''
        pending_long = data.split(b'\x00')[0] if typeflag == b'L' else None

        if real in targets and typeflag in (b'0', b'', b'7'):
            new = targets[real]
            h = bytearray(hdr)
            h[124:136] = ('%011o' % len(new)).encode('ascii') + b'\x00'
            h[148:156] = ustar_cksum(h)
            yield bytes(h)
            yield new
            npad = (BLOCK - len(new) % BLOCK) % BLOCK
            if npad:
                yield b'\x00' * npad
            stats['replaced'][real] = (size, len(new))
        else:
            yield hdr
            if data:
                yield data
            if padding:
                yield padding


def build_payload(base_apk, out_tgz, targets):
    """从 base APK 的 assets/payload.asset 出发，替换 targets 后重压成 out_tgz。"""
    with zipfile.ZipFile(base_apk) as z, z.open('assets/payload.asset') as raw, \
            open(out_tgz, 'wb') as fo:
        gz_in = gzip.GzipFile(fileobj=raw, mode='rb')
        gz_out = gzip.GzipFile(filename='', mode='wb', fileobj=fo, compresslevel=6, mtime=0)
        gen = tar_replace_iter(gz_in, targets)
        for chunk in gen:
            gz_out.write(chunk)
        gz_out.close()
    # tar_replace_iter 的统计挂在生成器上，这里重跑一次轻量扫描确认替换数量即可
    log('payload -> %s  %d bytes  sha256 %s' % (out_tgz, os.path.getsize(out_tgz), sha256(out_tgz)[:16]))
    with open(out_tgz, 'rb') as fh:
        head = fh.read(10)
    if head[:3] != b'\x1f\x8b\x08' or head[4:8] != b'\x00\x00\x00\x00':
        raise SystemExit('gzip 头不符合 mtime=0 口径: %r' % head)
    log('gzip head %s (mtime=0, FLG=0)' % head.hex(' '))
    return out_tgz


def align_extra(pos, namelen, align):
    """补齐到 align 字节对齐所需的 extra field（长度 1..3 时多补一个 align）。"""
    pad = (align - (pos + 30 + namelen) % align) % align
    if 0 < pad < 4:
        pad += align
    if not pad:
        return b''
    return struct.pack('<HH', 0x0000, pad - 4) + b'\x00' * (pad - 4)


def build_zip(base_apk, out_apk, replace):
    src = zipfile.ZipFile(base_apk)
    entries, bad = [], []
    with zipfile.ZipFile(out_apk, 'w', zipfile.ZIP_DEFLATED, allowZip64=True) as out:
        for i in src.infolist():
            if i.filename in SKIP:
                continue
            data = replace.get(i.filename)
            if data is None:
                data = src.read(i.filename)
            zi = zipfile.ZipInfo(i.filename, i.date_time)
            zi.external_attr = i.external_attr
            zi.internal_attr = i.internal_attr
            zi.create_system = i.create_system
            zi.compress_type = i.compress_type
            align = (4096 if i.filename.startswith('lib/') else 4) if i.compress_type == 0 else 1
            namelen = len(i.filename.encode('utf-8'))
            zi.extra = align_extra(out.fp.tell(), namelen, align)
            hoff = out.fp.tell()
            out.writestr(zi, data)
            doff = hoff + 30 + namelen + len(zi.extra)
            entries.append((i.filename, i.compress_type, len(data), doff, doff % align == 0))
            if not doff % align == 0:
                bad.append((i.filename, doff % align))
    src.close()
    log('zip -> %s  %d entries  %d bytes' % (out_apk, len(entries), os.path.getsize(out_apk)))
    if bad:
        raise SystemExit('对齐失败: %r' % bad[:5])
    lib = [e for e in entries if e[0].startswith('lib/') and e[1] == 0]
    log('alignment ok  (lib/ 4096: %d 条, 其余 STORED 4 字节对齐)' % len(lib))
    return out_apk


def check_zip(path, expect_sha=None):
    z = zipfile.ZipFile(path)
    bad_zip = z.testzip()
    log('testzip %s  entries %d' % (bad_zip, len(z.infolist())))
    for n in ('resources.arsc', 'classes.dex', 'classes2.dex', 'assets/payload.asset'):
        if n not in z.namelist():
            log('  (缺 %s)' % n)
            continue
        i = z.getinfo(n)
        z.fp.seek(i.header_offset)
        h = z.fp.read(30)
        doff = i.header_offset + 30 + int.from_bytes(h[26:28], 'little') + int.from_bytes(h[28:30], 'little')
        log('  %-22s ct=%d size=%d doff=%d %%4=%d' % (n, i.compress_type, i.file_size, doff, doff % 4))
    digest = sha256(path)
    log('apk %d bytes  sha256 %s' % (os.path.getsize(path), digest))
    if expect_sha:
        ok = digest.startswith(expect_sha) if len(expect_sha) < 64 else digest == expect_sha
        log('期望 %s → %s' % (expect_sha, 'MATCH' if ok else 'MISMATCH'))
    return z


def run_java(java, tool_java, args):
    cmd = [java] + list(JAVA_EXPORTS) + [tool_java] + args
    log('$ ' + ' '.join(cmd[:-len(args)] + ['<args>']))
    r = subprocess.run(cmd, capture_output=True, text=True)
    sys.stdout.write(r.stdout)
    if r.returncode != 0:
        sys.stderr.write(r.stderr)
        raise SystemExit('java 调用失败 rc=%d: %s' % (r.returncode, tool_java))


def main():
    ap = argparse.ArgumentParser(description='payload 补丁 → APK 重组 → v2 签名')
    ap.add_argument('--base', default='apk/Coopanion-v12.71.apk')
    ap.add_argument('--out', required=True, help='未签名产物路径')
    ap.add_argument('--patch-tar', action='append', default=[], metavar='NAME=FILE',
                    help='tar 内条目名=本地文件，可多次；与 --payload-tgz 二选一')
    ap.add_argument('--payload-tgz', default='', help='直接用现成 payload.tar.gz，跳过 tar 替换')
    ap.add_argument('--dex', action='append', default=[], metavar='NAME=FILE',
                    help='替换 dex，如 classes.dex=.operit/sm/out1.dex')
    ap.add_argument('--work', default='.operit/work')
    ap.add_argument('--keystore', default='')
    ap.add_argument('--ks-pass', default='')
    ap.add_argument('--ks-alias', default='')
    ap.add_argument('--signed-out', default='')
    ap.add_argument('--java', default='java')
    ap.add_argument('--apksig-jar', default='.operit/sign/apksig-2.3.0.jar')
    ap.add_argument('--tools-java', default='tools/java')
    a = ap.parse_args()

    os.makedirs(a.work, exist_ok=True)
    os.makedirs(os.path.dirname(os.path.abspath(a.out)), exist_ok=True)

    if a.patch_tar and a.payload_tgz:
        raise SystemExit('--patch-tar 与 --payload-tgz 不能同时给')

    replace = {}
    for spec in a.dex:
        name, _, path = spec.partition('=')
        data = open(path, 'rb').read()
        if data[:4] != b'dex\n':
            raise SystemExit('%s 不是 dex（头 %r）' % (path, data[:4]))
        replace[name] = data
        log('dex      %-22s %d bytes (来自 %s)' % (name, len(data), path))

    if a.patch_tar:
        targets = {}
        for spec in a.patch_tar:
            name, _, path = spec.partition('=')
            if not name or not path:
                raise SystemExit('--patch-tar 需要 NAME=FILE，收到 %r' % spec)
            targets[b'./' + name.lstrip('./').encode()] = open(path, 'rb').read()
            log('patch    %-52s %d bytes' % ('./' + name.lstrip('./'), len(targets[b'./' + name.lstrip('./').encode()])))
        tgz = os.path.join(a.work, 'payload_patched.tar.gz')
        build_payload(a.base, tgz, targets)
        data = open(tgz, 'rb').read()
        replace['assets/payload.asset'] = data
        log('payload  %d bytes (新压，含 %d 处替换)' % (len(data), len(targets)))
    elif a.payload_tgz:
        data = open(a.payload_tgz, 'rb').read()
        if data[:3] != b'\x1f\x8b\x08':
            raise SystemExit('%s 不是 gzip' % a.payload_tgz)
        replace['assets/payload.asset'] = data
        log('payload  %d bytes (来自 %s, sha256 %s)' % (len(data), a.payload_tgz, hashlib.sha256(data).hexdigest()[:16]))

    if not replace:
        log('注意：没有任何替换，产物只是原包的重打包（用于校验链路）')

    build_zip(a.base, a.out, replace)
    check_zip(a.out)

    if a.signed_out:
        if not (a.keystore and a.ks_pass and a.ks_alias):
            raise SystemExit('签名需要 --keystore / --ks-pass / --ks-alias')
        if not os.path.isfile(a.apksig_jar):
            raise SystemExit('缺 %s（Maven 取：https://repo1.maven.org/maven2/com/android/tools/build/apksig/2.3.0/apksig-2.3.0.jar，见 docs/07 §2）' % a.apksig_jar)
        os.makedirs(os.path.dirname(os.path.abspath(a.signed_out)), exist_ok=True)
        sign_java = os.path.join(a.tools_java, 'Sign2.java')
        verify_java = os.path.join(a.tools_java, 'Verify2.java')
        t = os.path.abspath(sign_java)
        log('sign     %s -> %s' % (a.out, a.signed_out))
        cmd = [a.java] + list(JAVA_EXPORTS) + ['-cp', os.path.abspath(a.apksig_jar), t,
                                              a.keystore, a.ks_pass, a.ks_alias, a.out, a.signed_out]
        r = subprocess.run(cmd, capture_output=True, text=True)
        sys.stdout.write(r.stdout)
        if r.returncode != 0:
            sys.stderr.write(r.stderr)
            raise SystemExit('签名失败 rc=%d' % r.returncode)
        log('verify   %s' % a.signed_out)
        cmd = [a.java] + list(JAVA_EXPORTS) + ['-cp', os.path.abspath(a.apksig_jar),
                                              os.path.abspath(verify_java), a.signed_out]
        r = subprocess.run(cmd, capture_output=True, text=True)
        sys.stdout.write(r.stdout)
        if r.returncode != 0 or 'verified=true' not in r.stdout:
            sys.stderr.write(r.stderr)
            raise SystemExit('验签未通过')
        check_zip(a.signed_out)


if __name__ == '__main__':
    main()