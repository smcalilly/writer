#!/usr/bin/env bash

set -euo pipefail
set -x

if [ -z ${WRITER_DIR+x} ]; then
  echo "Error: Please configure and export WRITER_DIR environment variable."
  exit 1
fi

if [ -z ${EDITOR+x} ]; then
  echo "Error: Please configure and export EDITOR environment variable."
  exit 1
fi


function walkthrough_guide() {
    echo 
    echo "The structure of the $WRITER_DIR directory should look like this:"
    echo
    echo "  $WRITER_DIR/"
    echo "  |"
    echo "  |"
    echo "  |notes/"
    echo "        |daily/"
    echo "        |     |<todays-date>.md"
    echo "        |     |<yesterdays-date>.md"
    echo "        |"
    echo "        |scribbles/"
    echo "                  |<named-note>.md"
    echo 
    echo
    echo "-------"
    echo
    echo "EXAMPLE COMMANDS"
    echo
    echo "These two commands will create or open a note in either of those places:"
    echo
    echo "    writer.sh                                            # opens /notes/daily/<todays-date>.md in $EDITOR"
    echo "    writer.sh -f recipe-idea                             # opens /notes/scribbles/recipe-idea.md in $EDITOR"
    echo 
    echo "You can write notes with either of these two options. This is the most opinionated part of the CLI." 
    echo "It's like a staging area or organized dumping ground, but accessible quickly and happily." 
    echo 
    echo "/daily is where you can write an aggregation of notes in the same file throughout a day. A new file is created each day."
    echo "/scribbles is useful if you want to name a random note, or have a specific or thematic note that doesn't yet have a place to live." 
    echo 
    echo "Both can be used the same way. It's just a matter of preference."
    echo "Would you rather have a dated note with random scribbles throughout the day, or do you want to name your notes? How about both?"
    echo
    echo "Important! If you change the names of these directories, it will break this feature of CLI." #todo: fix this bug or: if you don't like the names of the directories, then enter one 
    echo
    echo
    echo
    echo "-------"
    echo 
    echo "SEARCH"
    echo
    echo "You can search with grep:"
    echo
    echo "    writer.sh -g okra                                    # views all the files in $WRITER_DIR with the word 'okra'"
    echo
    echo 
    echo
    echo "-------"
    echo
    echo "NAMING THINGS"
    echo
    echo "You can also create your own directories, like if you have a specific project where you want to write. Here is a command:"
    echo 
    echo "    writer.sh -d my-manuscript -f chapter-1       # writes to $WRITER_DIR/my-manuscript/chapter-5.md"
    echo
    echo "This can be organized however you wish - you can name directories within directories and files within those directories, and recall them via the CLI."
    echo
    echo "Of course, you don't have to use the CLI; it's just a handy way to write from your terminal."
    echo "Once you've created a project, you can work with it however you want, like in your favorite text editor with a file system interface."
    echo "You can also use git and anything else you'd do with a normal git repo."
    echo
}

function usage() {
  echo "Usage: note.sh [action]"
  echo
  echo "  actions:"
  echo "    -f [file_name]"
  echo "    -d [directory]"
  echo "    -g grep [pattern]"
  echo
  echo
  walkthrough_guide
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



function write_daily_note() {
    mkdir -p "$WRITER_DIR/notes/daily"
    NOTE_PATH="$WRITER_DIR/notes/daily/$(date +'%Y-%m-%d').md"
    $EDITOR $NOTE_PATH
}


if [ -p /dev/stdin ]; then
    NOTE_PATH="$WRITER_DIR/notes/daily/$(date +'%Y-%m-%d').md"
    cat > $EDITOR $NOTE_PATH
fi

# if there is no argument, then write to the daily file
if [ $# -eq 0 ]; then
    write_daily_note

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
fibitch
bitch
