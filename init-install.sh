#!/usr/bin/env bash
set -x

echo "$WRITER_DIR"
mkdir -p "$WRITER_DIR"
cd "$WRITER_DIR"

mkdir -p ".src" && cd .src
touch "env-variables.sh"
touch "install.sh"
touch "write.sh"

curl "https://raw.githubusercontent.com/smcalilly/writer/main/note.sh/src/note.sh" -o write.sh
chmod +x write.sh

curl "https://raw.githubusercontent.com/smcalilly/writer/main/install.sh" -o install.sh
chmod +x install.sh

curl "https://raw.githubusercontent.com/smcalilly/writer/main/note.sh/Makefile" -o Makefile

./install.sh
make install

# curl
# create directory
# 