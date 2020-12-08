#!/usr/bin/env bash


if [ -n "${EDITOR+1}" ]; then
    mkdir -p ".src" && cd .src
    touch "install.sh"
    chmod +x install.sh

    touch "writer"
    chmod +x writer

    curl "https://raw.githubusercontent.com/smcalilly/writer/main/writer.sh/src/writer.sh" -o writer
    curl "https://raw.githubusercontent.com/smcalilly/writer/main/install.sh" -o install.sh
    curl "https://raw.githubusercontent.com/smcalilly/writer/main/writer.sh/Makefile" -o Makefile
else
    echo "Download failed."
    echo
    echo "You need to change the $EDITOR variable in your shell's startup file."
    echo "It might look like this:"
    echo
    echo "      export EDITOR=vim"
fi