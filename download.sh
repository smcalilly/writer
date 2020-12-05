#!/usr/bin/env bash
set -x

if [ -n "${WRITER_DIR+1}" ]; then
    echo "$WRITER_DIR"
    mkdir -p "$WRITER_DIR"
    cd "$WRITER_DIR"

    mkdir -p ".src" && cd .src
    touch "env-variables.sh"
    touch "install.sh"
    touch "write.sh"
    echo "export WRITER_DIR=$WRITER_DIR" > "env-variables.sh"


    curl "https://raw.githubusercontent.com/smcalilly/writer/main/note.sh/src/note.sh" -o write.sh
    chmod +x write.sh

    curl "https://raw.githubusercontent.com/smcalilly/writer/main/install.sh" -o install.sh
    chmod +x install.sh

    curl "https://raw.githubusercontent.com/smcalilly/writer/main/note.sh/Makefile" -o Makefile
fi


# ./install.sh
# make install

# curl
# create directory
# 