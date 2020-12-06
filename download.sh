#!/usr/bin/env bash

set_user_editor() {
    echo "What is the executable name for your preferred text editor (i.e. vim or nano or atom or subl)?"

    echo "Type the name and hit enter: [nano]"
    read EDITOR
    
    # todo bug - need to validate editor
    echo "Thanks. We're going to use $EDITOR whenever we open any of your writing."
}

set_user_editor

if [ -n "${WRITER_DIR+1}" ]; then
    echo "$WRITER_DIR"
    mkdir -p "$WRITER_DIR"
    cd "$WRITER_DIR"

    mkdir -p ".src" && cd .src
    touch "env-variables.sh"
    touch "install.sh"
    touch "writer.sh"
   
    # echo "export WRITER_DIR=$HOME/$WRITER_DIR" > "env-variables.sh"

    
    curl "https://raw.githubusercontent.com/smcalilly/writer/main/writer.sh/src/writer.sh" | head -1 >> writer.sh
    echo "export WRITER_DIR=$HOME/$WRITER_DIR" >> "writer.sh"
    echo "export EDITOR=$EDITOR" >> "writer.sh"
    curl "https://raw.githubusercontent.com/smcalilly/writer/main/writer.sh/src/writer.sh" | tail -n +2 >> writer.sh
    chmod +x writer.sh

    curl "https://raw.githubusercontent.com/smcalilly/writer/main/install.sh" -o install.sh
    chmod +x install.sh

    curl "https://raw.githubusercontent.com/smcalilly/writer/main/writer.sh/Makefile" -o Makefile
fi


# ./install.sh
# make install

# curl
# create directory
# 