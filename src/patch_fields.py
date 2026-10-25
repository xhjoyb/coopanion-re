#!/usr/bin/env python3
"""给 dex2smali.py 补：字段输出 + 访问标志修饰符。"""
P = 'dex2smali.py'
s = open(P).read()

# 1) classes() 返回 access flags
old = """        for i in range(struct.unpack_from('<I', self.d, 0x60)[0]):
            o = self.class_off + 32 * i
            sup = self.u4(o + 8)
            out.append((self.types[self.u4(o)],
                        self.types[sup] if sup != 0xFFFFFFFF else None,
                        self.u4(o + 16), self.u4(o + 24)))
        return out"""
new = """        for i in range(struct.unpack_from('<I', self.d, 0x60)[0]):
            o = self.class_off + 32 * i
            sup = self.u4(o + 8)
            out.append((self.types[self.u4(o)], self.u4(o + 4),
                        self.types[sup] if sup != 0xFFFFFFFF else None,
                        self.u4(o + 16), self.u4(o + 24)))
        return out"""
assert old in s
s = s.replace(old, new)

# 2) class_methods -> class_data（同时产出字段）
old2 = """    def class_methods(self, data_off):
        if data_off == 0:
            return []
        o = data_off
        sf, o = self._uleb(o)
        inf, o = self._uleb(o)
        dm, o = self._uleb(o)
        vm, o = self._uleb(o)
        for _ in range(sf + inf):
            _, o = self._uleb(o)
            _, o = self._uleb(o)
        out = []
        for kind, cnt in (('direct', dm), ('virtual', vm)):
            idx = 0
            for _ in range(cnt):
                diff, o = self._uleb(o)
                acc, o = self._uleb(o)
                code, o = self._uleb(o)
                idx += diff
                out.append((kind, idx, acc, code))
        return out"""
new2 = """    def class_data(self, data_off):
        if data_off == 0:
            return [], []
        o = data_off
        sf, o = self._uleb(o)
        inf, o = self._uleb(o)
        dm, o = self._uleb(o)
        vm, o = self._uleb(o)
        flds = []
        for kind, cnt in (('static', sf), ('instance', inf)):
            idx = 0
            for _ in range(cnt):
                diff, o = self._uleb(o)
                acc, o = self._uleb(o)
                idx += diff
                flds.append((kind, idx, acc))
        ms = []
        for kind, cnt in (('direct', dm), ('virtual', vm)):
            idx = 0
            for _ in range(cnt):
                diff, o = self._uleb(o)
                acc, o = self._uleb(o)
                code, o = self._uleb(o)
                idx += diff
                ms.append((kind, idx, acc, code))
        return flds, ms"""
assert old2 in s
s = s.replace(old2, new2)

# 3) 插入修饰符辅助函数（放在 sx 之后）
anchor = """def sx(v, bits):"""
helper = """CFLAGS = [(0x1, 'public'), (0x2, 'private'), (0x4, 'protected'),
          (0x8, 'static'), (0x10, 'final'), (0x20, 'super'),
          (0x200, 'interface'), (0x400, 'abstract'),
          (0x1000, 'synthetic'), (0x2000, 'annotation'), (0x4000, 'enum')]
FFLAGS = [(0x1, 'public'), (0x2, 'private'), (0x4, 'protected'),
          (0x8, 'static'), (0x10, 'final'), (0x40, 'volatile'), (0x80, 'transient'),
          (0x1000, 'synthetic'), (0x8000, 'enum')]
MFLAGS = [(0x1, 'public'), (0x2, 'private'), (0x4, 'protected'),
          (0x8, 'static'), (0x10, 'final'), (0x20, 'synchronized'),
          (0x40, 'bridge'), (0x80, 'varargs'), (0x100, 'native'),
          (0x400, 'abstract'), (0x1000, 'synthetic'), (0x10000, 'constructor')]


def mods(acc, table):
    return ' '.join(n for b, n in table if acc & b)


def sx(v, bits):"""
assert anchor in s
s = s.replace(anchor, helper, 1)

# 4) main 重写
old4 = """    for cname, sup, ifaces, data in dx.classes():
        short = cname[1:-1].replace('/', '.')
        if filt and filt.lower() not in short.lower():
            continue
        out.append('.class %s' % short)
        out.append('.super %s' % ((sup[1:-1].replace('/', '.')) if sup else 'java.lang.Object'))
        out.append('')
        for kind, midx, acc, code in dx.class_methods(data):"""
new4 = """    for cname, cacc, sup, ifaces, data in dx.classes():
        short = cname[1:-1].replace('/', '.')
        if filt and filt.lower() not in short.lower():
            continue
        cm = mods(cacc & ~0x20, CFLAGS)
        out.append('.class %s%s' % (cm + ' ' if cm else '', cname))
        out.append('.super %s' % (sup if sup else 'Ljava/lang/Object;'))
        out.append('')
        flds, ms = dx.class_data(data)
        for kind, fidx, acc in flds:
            if fidx >= len(dx.fields):
                continue
            fcls, ftyp, fname = dx.fields[fidx]
            fm = mods(acc, FFLAGS)
            out.append('.field %s%s:%s' % (fm + ' ' if fm else '', fname, ftyp))
        if flds:
            out.append('')
        for kind, midx, acc, code in ms:"""
assert old4 in s
s = s.replace(old4, new4)

# 5) method 行加修饰符
old5 = """            out.append('# %s access=0x%x' % (kind, acc))
            out.append('.method %s' % sig)"""
new5 = """            mm = mods(acc, MFLAGS)
            out.append('# %s access=0x%x' % (kind, acc))
            out.append('.method %s%s' % (mm + ' ' if mm else '', sig))"""
assert old5 in s
s = s.replace(old5, new5)

open(P, 'w').write(s)
print('patched ok')
