#!/usr/bin/env bash
export WRITER_DIR=/Users/sammcalilly/writer
export EDITOR=nano

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
  echo "  ACTIONS:"
  echo "    -n [notepad for each day]"
  echo "    -f [file_name]"
  echo "    -d [directory]"
  echo "    -g grep [pattern]"
  echo
  echo
  echo "  EXAMPLES:"
  echo "      writer.sh -n                               # opens a daily note to write in"
  echo "      writer.sh -d project-dir -f file-name      # opens a writing file named file-name in the project-dir"
  echo "      writer.sh -g collards                      # searches for the word 'collards' in your writer"
}

# parse any arguments
while getopts n:g:d:f: flag 
do
    case "${flag}" in
        f) file_name=${OPTARG};;
        d) directory=${OPTARG};;
        g) grp=${OPTARG};;
    esac
done


# parse_stdin() {
#     if [ -p /dev/stdin ]; then
#         input="$(< /dev/stdin)"
#         echo >> $NOTE_PATH
#         echo "$input" >> $NOTE_PATH
#     fi
#     echo "Words written to $NOTE_PATH" >&2
# }


# todo bug: parse out any / from arguments

writing_target="$WRITER_DIR"

if [ $# -eq 0 ]; then
    usage
elif [ -n "${grp+1}" ]; then
    writing=$(grep -nr "$2" $WRITER_DIR -l)
    echo $writing
    less -p "$2" $writing 
else
    if [[ -n "${directory+1}" ]]; then
        writing_target="$writing_target/$directory"
        mkdir -p $writing_target
    fi

    if [[ -n "${file_name+1}" ]]; then
        writing_target="$writing_target/$file_name.md"
    elif [[ $1 == "-n" ]]; then 
        mkdir -p "$writing_target/notes"
        writing_target="$writing_target/notes/$(date +'%Y-%m-%d').md"
    fi

    echo $writing_target

    # Open text editor
    set -o noclobber
    $EDITOR $writing_target
fi

walkthrough_guide > about.md