#!/usr/bin/env bash

set -euo pipefail

if [ -z ${WRITER_DIR+x} ]; then
  echo "Error: Please configure and export WRITER_DIR environment variable."
  exit 1
fi

function usage() {
  echo "Usage: note.sh [action]"
  echo
  echo "  actions:"
  echo "    -f [file_name]"
  echo "    -d [directory]"
  echo "    -g grep [pattern]"
}

# parse any arguments
while getopts g:d:f: flag 
do
    case "${flag}" in
        f) file_name=${OPTARG};;
        d) directory=${OPTARG};;
        g) grp=${OPTARG};;
    esac
done

# if there is no argument, then write to the daily file
if [ $# -eq 0 ]; then
    mkdir -p "$WRITER_DIR/notes/daily"
    NOTE_PATH="$WRITER_DIR/notes/daily/$(date +'%Y-%m-%d').md"
    $EDITOR $NOTE_PATH

# decide which filename/directory & open the text editor
elif [ -n "${directory+1}" ] || [ -n "${file_name+1}" ]; then
    if [ -n "${directory+1}" ] && [  -n "${file_name+1}" ]; then
        mkdir -p $WRITER_DIR/$directory
        NOTE_PATH="$WRITER_DIR/$directory/$file_name.md"
    elif [ -n "${directory+1}" ] && [ ! -n "${file_name+1}" ]; then
        mkdir -p $WRITER_DIR/$directory
        NOTE_PATH="$WRITER_DIR/$directory/$(date +'%Y-%m-%d').md"
    else
        mkdir -p "$WRITER_DIR/notes/scribbles"
        NOTE_PATH="$WRITER_DIR/notes/scribbles/${file_name}.md"
    fi
  $EDITOR $NOTE_PATH

# search with grep and open the files with less
elif [ -n "${grp+1}" ]; then
    notes=$(grep -nr "$2" $WRITER_DIR -l)
    echo $notes
    less -p "$2" $notes 
else
    usage
fi