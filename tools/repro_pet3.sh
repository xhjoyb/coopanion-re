#!/usr/bin/env bash
# 一条命令复现 pet3 基线包，并断言 sha256 逐字节一致。
#
#   用法：bash tools/repro_pet3.sh
#   覆盖：OUT=/tmp/x.apk SIGNED=/tmp/x_signed.apk KS=... KS_PASS=... bash tools/repro_pet3.sh
#
# 依赖三样本地资产（都不入库，见 docs/07）：
#   1. apk/Coopanion-v12.71.apk                       原厂包（.gitignore 排 *.apk）
#   2. .operit/sign/coop.keystore                     签名证书，口令 123456 / alias coop
#   3. .operit/sign/apksig-2.3.0.jar                  Maven 可取
set -euo pipefail
cd "$(dirname "$0")/.."

BASE=${BASE:-apk/Coopanion-v12.71.apk}
KS=${KS:-.operit/sign/coop.keystore}
KS_PASS=${KS_PASS:-123456}
KS_ALIAS=${KS_ALIAS:-coop}
OUT=${OUT:-.operit/work/pet3_repro_unsigned.apk}
SIGNED=${SIGNED:-.operit/work/pet3_repro_signed.apk}
EXPECT=38128c2e423e5ec5bfcb323438dc5f61173578b5d32b6d8e6a5308d780d26032

for f in "$BASE" "$KS"; do
  [ -f "$f" ] || { echo "缺 $f（见 docs/07 §2 如何取得）" >&2; exit 1; }
done

python3 tools/apk_build.py \
  --base "$BASE" \
  --patch-tar './app/coop-stage/vendor/pet/web/pet-core.js=src/recovered/vendor/pet/web/pet-core.js' \
  --patch-tar './app/coop-stage/vendor/pet/web/pet-app.js=src/recovered/vendor/pet/web/pet-app.js' \
  --dex 'classes.dex=src/dex-baseline/classes.dex' \
  --dex 'classes2.dex=src/dex-baseline/classes2.dex' \
  --out "$OUT" \
  --keystore "$KS" --ks-pass "$KS_PASS" --ks-alias "$KS_ALIAS" \
  --signed-out "$SIGNED"

# 出货自检 + 复现性断言（pet3 指纹与两处补丁特征）
python3 tools/apk_verify.py \
  --apk "$SIGNED" \
  --expect-sha256 "$EXPECT" \
  --contains './app/coop-stage/vendor/pet/web/pet-core.js=palette: icon(' \
  --contains './app/coop-stage/vendor/pet/web/pet-app.js=const want = Math.max(1, Math.min(MAX_PETS' \
  --absent   "./app/coop-stage/vendor/pet/web/pet-app.js=send({ t: 'petCount', count: 1 })" \
  --entry-bytes  './app/coop-stage/vendor/pet/web/pet-core.js=64296' \
  --entry-bytes  './app/coop-stage/vendor/pet/web/pet-app.js=96120'
