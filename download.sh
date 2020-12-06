#!/usr/bin/env bash

set_user_editor() {
    echo "What is the executable name for your preferred text editor (i.e. vim or nano or atom or subl)?"

    echo "Type the name and hit enter: [nano]"
    read EDITOR
    
    # todo bug - need to validate editor
    echo "Thanks. We're going to use $EDITOR whenever we open any of your writing."
}

# set_user_editor

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