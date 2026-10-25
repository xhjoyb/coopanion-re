#!/usr/bin/env python3
"""修正 dex2smali 的指令格式解码（21c/21h/22t/22s/35c/45cc/51l）。"""
P = 'dex2smali.py'
s = open(P).read()

# --- 21c：只有 const-string 用字符串表 ---
old = """            elif fmt == '21c':
                if name in ('const-string', 'const-class', 'check-cast'):
                    arg = 'v%d, "%s"' % (hi, self.strings[nxt] if nxt < len(self.strings) else '?')
                elif name == 'new-instance':"""
new = """            elif fmt == '21c':
                if name == 'const-string':
                    arg = 'v%d, "%s"' % (hi, self.strings[nxt] if nxt < len(self.strings) else '?')
                elif name in ('const-class', 'check-cast', 'new-instance'):"""
assert old in s
s = s.replace(old, new)

# --- 21h：const/high16 字面量要左移 16 ---
old = """            elif fmt == '21h':
                arg = 'v%d, #int 0x%x' % (hi, sx(nxt, 16))"""
new = """            elif fmt == '21h':
                arg = 'v%d, #int 0x%x' % (hi, (sx(nxt, 16) << 16) & 0xffffffff)"""
assert old in s
s = s.replace(old, new)

# --- 22t / 22s：4 位寄存器对 + 16 位立即数 ---
old = """            elif fmt == '22t':
                arg = 'v%d, v%d, :L%d' % (hi, nxt & 0xff, i + sx(nxt >> 8, 8))
            elif fmt == '22s':
                arg = 'v%d, v%d, #%d' % (hi, nxt & 0xff, sx(nxt >> 8, 8))"""
new = """            elif fmt == '22t':
                arg = 'v%d, v%d, :L%d' % (hi & 0xf, hi >> 4, i + sx(nxt, 16))
            elif fmt == '22s':
                arg = 'v%d, v%d, #%d' % (hi & 0xf, hi >> 4, sx(nxt, 16))"""
assert old in s
s = s.replace(old, new)

# --- 22t 分支目标扫描同步修正 ---
old = """            elif fmt == '22t' and i + 1 < len(code):
                targets.add(i + sx(code[i + 1] >> 8, 8))"""
new = """            elif fmt == '22t' and i + 1 < len(code):
                targets.add(i + sx(code[i + 1], 16))"""
assert old in s
s = s.replace(old, new)

# --- 35c / 45cc 寄存器列表（G 寄存器位置不同） ---
old = """            elif fmt in ('35c', '45cc'):
                cnt = hi >> 4
                idx = nxt
                rl = [nxt2 & 0xf, (nxt2 >> 4) & 0xf, (nxt2 >> 8) & 0xf, (nxt2 >> 12) & 0xf,
                      code[i + 3] if i + 3 < len(code) else 0][:cnt]
                arg = '{%s}, %s' % (', '.join('v%d' % r for r in rl), self.mref(idx))"""
new = """            elif fmt in ('35c', '45cc'):
                cnt = hi >> 4
                idx = nxt
                g = code[i + 3] if (fmt == '45cc' and i + 3 < len(code)) else (hi & 0xf)
                rl = [nxt2 & 0xf, (nxt2 >> 4) & 0xf, (nxt2 >> 8) & 0xf, (nxt2 >> 12) & 0xf, g][:cnt]
                arg = '{%s}, %s' % (', '.join('v%d' % r for r in rl), self.mref(idx))"""
assert old in s
s = s.replace(old, new)

# --- 3rc 空寄存器列表保护 ---
old = """            elif fmt in ('3rc', '4rcc'):
                cnt = hi
                idx = nxt
                first = nxt2
                arg = '{v%d..v%d}, %s' % (first, first + cnt - 1, self.mref(idx))"""
new = """            elif fmt in ('3rc', '4rcc'):
                cnt = hi
                idx = nxt
                first = nxt2
                regs_s = '' if cnt == 0 else 'v%d..v%d' % (first, first + cnt - 1)
                arg = '{%s}, %s' % (regs_s, self.mref(idx))"""
assert old in s
s = s.replace(old, new)

# --- 31i 区分 int / long ---
old = """            elif fmt == '31i':
                val = nxt | (nxt2 << 16)
                arg = 'v%d, #%d' % (hi, sx(val, 32))"""
new = """            elif fmt == '31i':
                val = sx(nxt | (nxt2 << 16), 32)
                arg = 'v%d, #%d%s' % (hi, val, 'L' if name.startswith('const-wide') else '')"""
assert old in s
s = s.replace(old, new)

# --- 51l：64 位字面量跨 4 个 code unit ---
old = """            elif fmt == '51l':
                arg = 'v%d, #wide' % hi"""
new = """            elif fmt == '51l':
                lo = nxt | (nxt2 << 16)
                hiw = (code[i + 3] if i + 3 < len(code) else 0) | \\
                      ((code[i + 4] if i + 4 < len(code) else 0) << 16)
                v = (hiw << 32) | lo
                if v & (1 << 63):
                    v -= 1 << 64
                arg = 'v%d, #%dL' % (hi, v)"""
assert old in s
s = s.replace(old, new)

open(P, 'w').write(s)
print('decode patched ok')