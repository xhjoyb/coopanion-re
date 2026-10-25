#!/bin/sh
# P5: 采集裁剪树的启动期文件访问轨迹（strace）。
#
#   sh tools/p5_run_trace.sh <tree> <log> [seconds] [home]
#
# 说明
# ----
# 用 tar 自带的 glibc 加载器跑 node（本机 proot 是 musl，不能直接执行 glibc 二进制），
# 这正是 APK 里 boot.sh 干的事，只是省掉 boot.sh 那层的自愈拷贝。
# strace -f 会跟住所有 fork 出来的子进程（World / 工具子进程），
# 输出给 tools/p5_audit.py 做「删除集合 ∩ 访问集合」求交。
set -e
tree=$1
log=$2
secs=${3:-60}
home=${4:-/tmp/p5home}

cd "$tree/app/coop-stage"
mkdir -p "$home"
rm -f "$log"

HOME="$home" LANG=C.UTF-8 strace -f -q \
    -e trace=openat,openat2,open,newfstatat,stat,lstat,statx,access,faccessat,faccessat2,readlink,readlinkat,execve,clone,clone3,fork,vfork,chdir,fchdir \
    -s 2048 -o "$log" \
    timeout -k 5 "$secs" \
    ../../lib/ld-linux-aarch64.so.1 \
    --library-path ../../lib/aarch64-linux-gnu:../../lib \
    ../../bin/node --import tsx run-core.mjs
echo "rc=$?"
echo "trace lines: $(wc -l < "$log")"
# timeout 现在套在 tracee 上（node 会被真正杀掉，不再只杀 strace 留着进程占 17788）。
# 这里再补一刀：清掉可能残留的 esbuild 服务子进程。它 exec 的是树内绝对路径，
# 用 "$tree/" 精确匹配；本脚本自身的 cmdline 是这个路径但不带结尾斜杠，不会误杀。
sleep 1
for p in $(ps -ef 2>/dev/null | grep -F "$tree/" | grep -v grep | awk '{print $1}'); do
  kill -9 "$p" 2>/dev/null || true
done
