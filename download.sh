#!/usr/bin/env bash

if [ -n "${EDITOR+1}" ] && [ -n "${WRITER_DIR+1}" ]; then
    cd $WRITER_DIR
    mkdir -p ".src" && cd .src
    touch "install.sh"
    chmod +x install.sh

    touch "writer"
    chmod +x writer

    curl "https://raw.githubusercontent.com/smcalilly/writer/main/writer/src/writer" -o writer
    curl "https://raw.githubusercontent.com/smcalilly/writer/main/install.sh" -o install.sh
    curl "https://raw.githubusercontent.com/smcalilly/writer/main/writer/Makefile" -o Makefile
else
    echo "Unable to download."
    echo
    echo "You need to set the $WRITER_DIR and $EDITOR variables in your shell's startup file."
    echo "It might look like this:"
    echo
    echo "      export WRITER_DIR=writing"
    echo "      export EDITOR=vim"
fi