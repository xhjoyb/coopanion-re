#!/usr/bin/env python3
"""P3: 块级解析 payload.asset 内的 tar，判定 gzip ISIZE 与实际条目累计长度的差额。

为什么要单独做这一层：
  tarfile 只报告它认得的条目（5096 条 / 357,069,438 B 文件字节），
  但 gzip 尾部的 ISIZE 写成 360,825,344，按 512 块重算只有 360,802,816，
  差 22,528 B（= 44 块）。差额要么来自 tarfile 吞掉的扩展头（pax x/g、
  长名 L/K），要么来自 tar EOF 之后还有一段尾部数据。本脚本直接走 512
  字节块，把「真实条目 / 扩展头 / 零块尾巴 / 非零垃圾」分开计数。

性能纪律（上一版踩过的坑）：
  禁止 buf = buf[512:] 逐块切片——那是 O(n^2) 拷贝，344 MB 要切 67 万次。
  这里整块读入 1 MB、用下标 off 扫描、每轮只保留尾部残余 carry。
"""
import sys
import zipfile
import zlib

BLK = 512
ZERO = b'\x00' * BLK
APK = 'apk/Coopanion-v12.71.apk'
ENTRY = 'assets/payload.asset'


def align(size):
    return (size + BLK - 1) // BLK * BLK


def octal(b):
    if not b:
        return 0
    if b[0] & 0x80:                      # base-256
        return int.from_bytes(b[1:], 'big')
    s = b.split(b'\x00')[0].strip()
    if not s:
        return 0
    try:
        return int(s, 8)
    except ValueError:
        return 0


class Scanner:
    def __init__(self):
        self.carry = b''
        self.off = 0
        self.pos = 0                 # 已消费的 tar 逻辑字节数
        self.need = 0                # 当前条目还要跳过的 payload 字节
        self.state = 'hdr'
        self.entries = 0
        self.files = 0
        self.dirs = 0
        self.syms = 0
        self.other = 0
        self.file_bytes = 0
        self.meta = {}
        self.meta_sample = []
        self.zero_start = None
        self.tail_zero = 0
        self.tail_nonzero = 0
        self.anomalies = []

    def feed(self, data):
        self.carry += data
        buf = self.carry
        n = len(buf)
        off = self.off
        while True:
            if self.state == 'pay':
                take = min(self.need, n - off)
                off += take
                self.need -= take
                self.pos += take
                if self.need:
                    break
                self.state = 'hdr'
                continue
            if n - off < BLK:
                break
            hdr = buf[off:off + BLK]
            if hdr == ZERO:
                if self.zero_start is None:
                    self.zero_start = self.pos
                self.tail_zero += BLK
                off += BLK
                self.pos += BLK
                continue
            if self.zero_start is not None:
                # 零块之后又冒出非零块：不是干净 EOF
                self.tail_nonzero += BLK
                if len(self.anomalies) < 10:
                    self.anomalies.append(('after_eof', self.pos, hdr[:40]))
            name = hdr[0:100].split(b'\x00')[0]
            size = octal(hdr[124:136])
            tf = hdr[156:157]
            off += BLK
            self.pos += BLK
            if tf in (b'', b'\x00', b'0', b'7'):
                self.files += 1
                self.entries += 1
                self.file_bytes += size
            elif tf == b'5':
                self.dirs += 1
                self.entries += 1
            elif tf == b'2':
                self.syms += 1
                self.entries += 1
            elif tf in (b'x', b'g', b'L', b'K'):
                k = tf.decode()
                self.meta[k] = self.meta.get(k, 0) + 1
                if len(self.meta_sample) < 10:
                    self.meta_sample.append((k, size, name[:60].decode('utf-8', 'replace')))
            else:
                self.other += 1
                if len(self.anomalies) < 10:
                    self.anomalies.append((tf, name[:40], size))
            self.state = 'pay'
            self.need = align(size)
        self.carry = buf[off:]
        self.off = 0

    def total(self):
        return self.pos + len(self.carry)


def main():
    sc = Scanner()
    d = zlib.decompressobj(16 + zlib.MAX_WBITS)
    tail8 = b''
    post_eof = 0
    chunks = 0
    with zipfile.ZipFile(APK) as z:
        with z.open(ENTRY) as f:
            while True:
                chunk = f.read(1 << 20)
                if not chunk:
                    break
                if d.eof:
                    post_eof += len(chunk)
                    continue
                out = d.decompress(chunk)
                chunks += 1
                if out:
                    tail8 = (tail8 + out)[-8:]
                    sc.feed(out)
                if d.eof:
                    post_eof += len(d.unused_data)
    if not d.eof:
        out = d.flush()
        if out:
            tail8 = (tail8 + out)[-8:]
            sc.feed(out)

    total = sc.total()
    isize = int.from_bytes(tail8[4:8], 'little') if len(tail8) >= 8 else -1
    crc = int.from_bytes(tail8[0:4], 'little') if len(tail8) >= 8 else -1

    print('=== gzip 层 ===')
    print('decompressed_total = %d' % total)
    print('gzip_isize         = %d' % isize)
    print('gzip_crc32         = 0x%08x' % crc)
    print('isize_vs_total     = %+d' % (isize - total))
    print('post_gzip_eof_bytes= %d' % post_eof)
    print('read_chunks        = %d' % chunks)
    print('carry_left         = %d' % len(sc.carry))

    print('=== 条目层 ===')
    print('entries  = %d  (f %d / d %d / s %d / other %d)'
          % (sc.entries, sc.files, sc.dirs, sc.syms, sc.other))
    print('file_bytes = %d' % sc.file_bytes)
    print('hdr_bytes  = %d  (%d blocks)' % (sc.entries * BLK, sc.entries))

    print('=== 扩展头 ===')
    if sc.meta:
        for k, v in sorted(sc.meta.items()):
            print('  typeflag %s : %d' % (k, v))
        for s in sc.meta_sample:
            print('  sample %s size=%d name=%r' % s)
    else:
        print('  无 x/g/L/K 扩展头')

    print('=== 尾部结构 ===')
    print('zero_start_pos = %s' % sc.zero_start)
    print('tail_zero      = %d  (%d blocks)'
          % (sc.tail_zero, sc.tail_zero // BLK))
    print('tail_nonzero   = %d  (%d blocks)'
          % (sc.tail_nonzero, sc.tail_nonzero // BLK))
    if sc.anomalies:
        for a in sc.anomalies:
            print('  anomaly %r' % (a,))
    else:
        print('  anomaly: 无')

    real_end = sc.zero_start if sc.zero_start is not None else total
    print('=== 对照 ===')
    print('tar_body_end   = %d' % real_end)
    print('total          = %d' % total)
    print('isize - body   = %+d  (= %.3f blocks)'
          % (isize - real_end, (isize - real_end) / float(BLK)))
    print('body_end %%512  = %d' % (real_end % BLK))
    print('total %%512     = %d' % (total % BLK))
    print('total/512      = %.1f blocks' % (total / float(BLK)))

    return 0


if __name__ == '__main__':
    sys.exit(main())
