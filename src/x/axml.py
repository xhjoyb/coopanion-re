import struct,sys
d=open(sys.argv[1],'rb').read()
def u2(o):return struct.unpack_from('<H',d,o)[0]
def u4(o):return struct.unpack_from('<I',d,o)[0]
assert u2(0)==3
size=u4(4)
o=8
strs=[]
while o<size:
    ctype=u2(o); hsize=u2(o+2); csize=u4(o+4)
    if ctype==0x0001:
        cnt=u4(o+8); flags=u4(o+16); sstart=u4(o+20)
        utf8=bool(flags&0x100)
        base=o+sstart
        for i in range(cnt):
            p=base+u4(o+28+4*i)
            if utf8:
                n=d[p]; p+=1
                if n&0x80: p+=1
                v=d[p:p+n].split(b'\x00')[0].decode('utf-8','replace')
            else:
                n=u2(p); p+=2
                if n&0x8000:
                    n=((n&0x7fff)<<16)|u2(p); p+=2
                v=d[p:p+n*2].decode('utf-16-le','replace')
            strs.append(v)
    elif ctype==0x0102:
        ns=u4(o+16); name=u4(o+20)
        acount=u2(o+28); aoff=o+u2(o+24)
        attrs=[]
        for a in range(acount):
            p=aoff+a*20
            ans=u4(p); aname=u4(p+4); raw=u4(p+8)
            dtype=d[p+15]; data=u4(p+16)
            nm=strs[aname]
            if raw!=0xffffffff and raw<len(strs): val=strs[raw]
            elif dtype==0x03: val=strs[data] if data<len(strs) else str(data)
            elif dtype==0x12: val='true' if data else 'false'
            elif dtype==0x01: val='@0x%08x'%data
            elif dtype==0x10: val=str(data); 
            elif dtype==0x11: val='0x%x'%data
            else: val='0x%x(dt%d)'%(data,dtype)
            attrs.append('%s=%s'%(nm,val))
        print('<%s> %s'%(strs[name],' '.join(attrs)))
    o+=csize
