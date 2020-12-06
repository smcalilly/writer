#!/usr/bin/env bash


if [ -n "${WRITER_DIR+1}" ]; then
    echo "$WRITER_DIR"
    mkdir -p "$WRITER_DIR"
    cd "$WRITER_DIR"

    mkdir -p ".src" && cd .src
    touch "install.sh"
    chmod +x install.sh

    touch "writer.sh"
    chmod +x writer.sh
    touch "pre-writer.sh"
    chmod +x pre-writer.sh
    
    # add first line of the file
    curl "https://raw.githubusercontent.com/smcalilly/writer/main/writer.sh/src/writer.sh" | head -1 >> pre-writer.sh
    
    # add the $WRITER_DIR variable
    echo "export WRITER_DIR=$HOME/$WRITER_DIR" >> "pre-writer.sh"

    # then add the rest of the code
    curl "https://raw.githubusercontent.com/smcalilly/writer/main/writer.sh/src/writer.sh" | tail -n +2 >> pre-writer.sh
    

    curl "https://raw.githubusercontent.com/smcalilly/writer/main/install.sh" -o install.sh
  

    curl "https://raw.githubusercontent.com/smcalilly/writer/main/writer.sh/Makefile" -o Makefile
fi