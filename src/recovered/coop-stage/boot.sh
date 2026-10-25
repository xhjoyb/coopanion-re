#!/bin/sh
cd /app/coop-stage || exit 1
export HOME=/root
export PATH=/bin:/usr/bin:/usr/local/bin
export LANG=C.UTF-8
# ★ v11.14 根因 C 修复：rootfs 是精简 glibc 2.39，缺 librt.so.1（>=2.34 已并入 libc.so.6）。
#   而 libonnxruntime.so 硬依赖 librt.so.1 → dlopen 必失败。
#   这里启动时自愈：缺则建 librt.so.1 -> libc.so.6 兼容软链（三个库搜索路径都补）。
_LIBDIR=/lib/aarch64-linux-gnu
if [ ! -e "$_LIBDIR/librt.so.1" ]; then
  ln -sf libc.so.6 "$_LIBDIR/librt.so.1" 2>/dev/null && echo "[B0] created $_LIBDIR/librt.so.1 -> libc.so.6"
fi
mkdir -p /usr/lib/aarch64-linux-gnu 2>/dev/null
if [ ! -e /usr/lib/aarch64-linux-gnu/librt.so.1 ]; then
  ln -sf ../../../lib/aarch64-linux-gnu/libc.so.6 /usr/lib/aarch64-linux-gnu/librt.so.1 2>/dev/null
fi
mkdir -p /app/sherpa-native 2>/dev/null
if [ ! -e /app/sherpa-native/librt.so.1 ]; then
  ln -sf ../../../lib/aarch64-linux-gnu/libc.so.6 /app/sherpa-native/librt.so.1 2>/dev/null
fi
# ★ v11.9: sherpa-onnx native 依赖 libonnxruntime.so，必须让它能被动态链接器找到。
export LD_LIBRARY_PATH=/app/sherpa-native:/app/coop-stage/node_modules/sherpa-onnx-linux-arm64:/app/coop-stage/node_modules/sherpa-onnx-node/node_modules/sherpa-onnx-linux-arm64:/lib/aarch64-linux-gnu:/usr/lib/aarch64-linux-gnu
# ★ v11.13: 启动前把 native 完整拷到 /app/sherpa-native（绝对、独立、无软链），
#   彻底摆脱 proot --link2symlink 的 .l2s. 伪目录问题。
if [ ! -f /app/sherpa-native/sherpa-onnx.node ]; then
  mkdir -p /app/sherpa-native 2>/dev/null
  SRC=""
  for d in /app/coop-stage/node_modules/sherpa-onnx-node/node_modules/sherpa-onnx-linux-arm64 \
           /app/coop-stage/node_modules/sherpa-onnx-linux-arm64; do
    if [ -f "$d/sherpa-onnx.node" ]; then SRC="$d"; break; fi
  done
  if [ -n "$SRC" ]; then
    for f in sherpa-onnx.node libonnxruntime.so libsherpa-onnx-c-api.so libsherpa-onnx-cxx-api.so; do
      cp -f "$SRC/$f" /app/sherpa-native/ 2>/dev/null
    done
    chmod 755 /app/sherpa-native/* 2>/dev/null
  fi
fi
# 补建 sherpa-native 里的 librt（拷贝后再次确保）
if [ ! -e /app/sherpa-native/librt.so.1 ]; then
  ln -sf ../../../lib/aarch64-linux-gnu/libc.so.6 /app/sherpa-native/librt.so.1 2>/dev/null
fi
# ---- native self-check ----
echo "[B0] ---- native self-check ----"
echo "[B0] LD_LIBRARY_PATH=$LD_LIBRARY_PATH"
echo "[B0] librt: $(ls -la /lib/aarch64-linux-gnu/librt.so.1 2>&1)"
ls -la /app/sherpa-native/ 2>&1 | head -10
/bin/node -e '
function t(label, fn) { try { var m = fn(); console.log("[B0] " + label + " OK, keys=" + Object.keys(m).slice(0,3).join(",")); } catch (e) { console.log("[B0] " + label + " FAIL: " + (e && e.message ? String(e.message).split("\n")[0].slice(0,300) : e)); } }
t("NATIVE-DIR", function(){ return require("/app/sherpa-native/sherpa-onnx.node"); });
t("PKGNAME",    function(){ return require("/app/coop-stage/node_modules/sherpa-onnx-node"); });
t("PKG-ABS",    function(){ return require("/app/coop-stage/node_modules/sherpa-onnx-node/node_modules/sherpa-onnx-linux-arm64/sherpa-onnx.node"); });
' 2>&1
echo "[B0] ---- end self-check ----"
exec /bin/node --import tsx run-core.mjs