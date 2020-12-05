#!/usr/bin/env bash
source "env-variables.sh"

echo "$WRITER_DIR"
mkdir -p "$WRITER_DIR"
cd "$WRITER_DIR"

mkdir -p ".src" && cd .src
touch -p "env-variables.sh"
echo "export WRITING_DIR=$WRITING_DIR_NAME" >> "env-variables.sh"
source "env-variables.sh"

curl -K https://raw.githubusercontent.com/smcalilly/write/main/install.sh?token=AJJKBIXR3S3JRW5RLQGOUB27ZQF2E -o install.sh
chmod +x install.sh

curl -K https://raw.githubusercontent.com/smcalilly/write/main/note.sh/src/note.sh?token=AJJKBIWZY7M2QQ5LGMODVB27ZQG7A -o write.sh
chmod +x write.sh

curl -K https://raw.githubusercontent.com/smcalilly/write/main/note.sh/Makefile?token=AJJKBIS22YZVRBAPUU2UBJS7ZQHKE -o Makefile

make install
./install.sh

# curl
# create directory
# 