#!/usr/bin/env python3
"""APK 出货前自检：zip 结构 / 对齐 / payload 头 / tar 条目断言 / v2 验签。

对应原来 `.operit/verify_pet3.py` 那些「每次改完手改路径再跑」的脚本。
断言全部走参数，不再写死文件名：

  # 现役基线（pet3）自检
  python3 tools/apk_verify.py --apk .operit/repack/Coopanion_v12.71_pet3_signed.apk \
      --expect-sha256 38128c2e423e5ec5bfcb323438dc5f61173578b5d32b6d8e6a5308d780d26032

  # 新包里断言两个补丁真的进去了
  python3 tools/apk_verify.py --apk out.apk \
      --contains './app/coop-stage/vendor/pet/web/pet-core.js=palette: icon(' \
      --contains './app/coop-stage/vendor/pet/web/pet-app.js=const want = Math.max(1, Math.min(MAX_PETS' \
      --absent   './app/coop-stage/vendor/pet/web/pet-app.js=send({ t: '\''petCount'\'', count: 1 })'

退出码：0 全过；1 有断言失败（便于接 CI）。
"""
import argparse
import hashlib
import os
import subprocess
import sys
import tarfile
import zipfile

JAVA_EXPORTS = ('--add-exports', 'java.base/sun.security.x509=ALL-UNNAMED',
                '--add-exports', 'java.base/sun.security.pkcs=ALL-UNNAMED',
                '--add-exports', 'java.base/sun.security.util=ALL-UNNAMED')
PAYLOAD = 'assets/payload.asset'
CHECKED = ('resources.arsc', 'classes.dex', 'classes2.dex', PAYLOAD)


def log(msg):
    print(msg, flush=True)


def sha256_bytes(data):
    return hashlib.sha256(data).hexdigest()


def data_offset(z, name):
    """STORED/DEFLATE 条目真实数据起点（判断对齐用）。"""
    i = z.getinfo(name)
    z.fp.seek(i.header_offset)
    h = z.fp.read(30)
    return i.header_offset + 30 + int.from_bytes(h[26:28], 'little') + int.from_bytes(h[28:30], 'little')


def main():
    ap = argparse.ArgumentParser(description='APK 出货前自检')
    ap.add_argument('--apk', required=True)
    ap.add_argument('--expect-sha256', default='')
    ap.add_argument('--contains', action='append', default=[], metavar='ENTRY=SUBSTR',
                    help='payload tar 内该条目必须包含子串')
    ap.add_argument('--absent', action='append', default=[], metavar='ENTRY=SUBSTR',
                    help='payload tar 内该条目必须不含子串')
    ap.add_argument('--entry-bytes', action='append', default=[], metavar='ENTRY=BYTES',
                    help='payload tar 内该条目字节数必须等于 BYTES')
    ap.add_argument('--entry-sha256', action='append', default=[], metavar='ENTRY=SHA256',
                     help='payload tar 内该条目 sha256（支持只给前缀，如 2f980348）')
    ap.add_argument('--skip-sign-check', action='store_true')
    ap.add_argument('--java', default='java')
    ap.add_argument('--apksig-jar', default='.operit/sign/apksig-2.3.0.jar')
    ap.add_argument('--tools-java', default='tools/java')
    a = ap.parse_args()

    fails = []

    def check(ok, msg):
        log(('  ✅ ' if ok else '  ❌ ') + msg)
        if not ok:
            fails.append(msg)
        return ok

    if not os.path.isfile(a.apk):
        raise SystemExit('找不到 %s' % a.apk)
    size = os.path.getsize(a.apk)
    log('== %s  %d bytes' % (a.apk, size))

    z = zipfile.ZipFile(a.apk)
    log('-- zip 结构')
    check(set(z.namelist()) >= set(CHECKED), '必备条目齐全（%d 条目）' % len(z.infolist()))
    check(z.testzip() is None, 'CRC 全量校验通过')

    log('-- 对齐（STORED: lib/→4096，其余→4）')
    for n in CHECKED:
        if n not in z.namelist():
            continue
        i = z.getinfo(n)
        doff = data_offset(z, n)
        align = 4096 if (n.startswith('lib/') and i.compress_type == 0) else (4 if i.compress_type == 0 else 0)
        log('  %-22s ct=%d size=%d doff=%d %%4=%d' % (n, i.compress_type, i.file_size, doff, doff % 4))
    bad1096 = [i.filename for i in z.infolist()
               if i.filename.startswith('lib/') and i.compress_type == 0
               and data_offset(z, i.filename) % 4096]
    check(not bad1096, 'lib/ STORED 条目 4096 对齐（%s）' % (bad1096[:3] if bad1096 else 'ok'))
    bad4 = [n for n in ('resources.arsc', 'classes.dex', 'classes2.dex')
            if n in z.namelist() and z.getinfo(n).compress_type == 0 and data_offset(z, n) % 4]
    check(not bad4, 'arsc/dex 4 字节对齐（%s）' % (bad4[:3] if bad4 else 'ok'))

    log('-- payload')
    with z.open(PAYLOAD) as raw:
        head = raw.read(10)
    check(head[:3] == b'\x1f\x8b\x08' and head[4:8] == b'\x00\x00\x00\x00',
          'gzip 头 1f8b08 / mtime=0（%s）' % head.hex(' '))

    want = {}
    for group, name in ((a.contains, 'contains'), (a.absent, 'absent'),
                        (a.entry_bytes, 'bytes'), (a.entry_sha256, 'sha256')):
        for spec in group:
            entry, sep, val = spec.partition('=')
            if not sep or not entry:
                raise SystemExit('参数格式必须是 ENTRY=VALUE，收到 %r（见 --help）' % spec)
            want.setdefault(entry, []).append((name, val))
    seen = {}
    with z.open(PAYLOAD) as raw, tarfile.open(fileobj=raw, mode='r|gz') as tf:
        n = 0
        for m in tf:
            n += 1
            if m.name not in want or m.name in seen:
                continue
            d = tf.extractfile(m).read()
            seen[m.name] = d
            log('  %-52s %d bytes  sha256 %s' % (m.name, len(d), sha256_bytes(d)[:16]))
            for kind, val in want[m.name]:
                if kind == 'contains':
                    check(val.encode() in d, '包含 %r' % val[:48])
                elif kind == 'absent':
                    check(val.encode() not in d, '不含 %r' % val[:48])
                elif kind == 'bytes':
                    check(len(d) == int(val), '等于 %s 字节' % val)
                else:
                    got = sha256_bytes(d)
                    ok = got == val if len(val) >= 64 else got.startswith(val)
                    check(ok, 'sha256 = %s' % val[:16])
        log('  payload tar 条目 %d' % n)
    missing = [e for e in want if e not in seen]
    check(not missing, '断言目标全部命中（%s）' % (missing or 'ok'))

    log('-- 签名')
    has_block = b'APK Sig Block 42' in open(a.apk, 'rb').read()[-200000:]
    check(has_block, '存在 APK Signing Block（v2+）')
    if not a.skip_sign_check:
        jar = os.path.abspath(a.apksig_jar)
        if not os.path.isfile(jar):
            log('  (跳过 apksig 验签：缺 %s，见 docs/07 §2)' % a.apksig_jar)
        else:
            cmd = [a.java] + list(JAVA_EXPORTS) + ['-cp', jar,
                   os.path.abspath(os.path.join(a.tools_java, 'Verify2.java')), a.apk]
            r = subprocess.run(cmd, capture_output=True, text=True)
            sys.stdout.write(r.stdout)
            check('verified=true' in r.stdout, 'apksig 验签通过')

    log('-- 指纹')
    h = hashlib.sha256()
    with open(a.apk, 'rb') as fh:
        for chunk in iter(lambda: fh.read(1 << 20), b''):
            h.update(chunk)
    digest = h.hexdigest()
    log('  sha256 %s' % digest)
    if a.expect_sha256:
        check(digest == a.expect_sha256, '与期望 sha256 一致')

    log('')
    if fails:
        log('❌ %d 项未通过：' % len(fails))
        for f in fails:
            log('   - ' + f)
        return 1
    log('✅ 全部通过')
    return 0


if __name__ == '__main__':
    sys.exit(main())