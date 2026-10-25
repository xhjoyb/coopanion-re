#!/usr/bin/env python3
"""临时：按分组估算「删掉后在 APK 里省多少」（各组独立 gzip -9）。"""
import re
import zlib
import zipfile

apk = 'apk/Coopanion-v12.71.apk'
groups = {
    'nested_sherpa': lambda n: n.startswith('./app/coop-stage/node_modules/sherpa-onnx-node/node_modules/'),
    'lib_onnxruntime': lambda n: n == './lib/aarch64-linux-gnu/libonnxruntime.so',
    'koffi': lambda n: n.startswith('./app/coop-stage/node_modules/koffi/') or n.startswith('./app/coop-stage/node_modules/@koromix/'),
    'npm': lambda n: n.startswith('./lib/node_modules/npm/'),
    'docs_tests': lambda n: bool(re.search(r'/(tests?|examples?)/', n)) or n.endswith(('.md', '.map')) or re.search(r'/(LICENSE|THIRD_PARTY_NOTICES)', n),
}
cos = {k: zlib.compressobj(9, zlib.DEFLATED, 31) for k in groups}
raw = {k: 0 for k in groups}

with zipfile.ZipFile(apk) as z, z.open('assets/payload.asset') as f:
    import tarfile
    with tarfile.open(fileobj=f, mode='r|gz') as tf:
        for m in tf:
            if not m.isfile():
                continue
            hit = [k for k, fn in groups.items() if fn(m.name)]
            if not hit:
                continue
            data = tf.extractfile(m).read()
            for k in hit:
                raw[k] += m.size
                cos[k].compress(data)
            del data

print('% -16s %12s %12s' % ('group', 'raw', 'gz9'))
for k in groups:
    gz = cos[k].flush()
    print('%-16s %12d %12d' % (k, raw[k], len(gz)))