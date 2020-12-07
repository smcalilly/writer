#!/usr/bin/env bash
export WRITER_DIR=/Users/sammcalilly/writer
export EDITOR=nano

set -euo pipefail

if [ -z ${WRITER_DIR+x} ]; then
  echo "Error: Please configure and export WRITER_DIR environment variable."
  exit 1
fi

if [ -z ${EDITOR+x} ]; then
  echo "Error: Please configure and export EDITOR environment variable."
  exit 1
fi

function usage() {
    echo
    echo "~~!~~!--!~~!--!~~!~~"
    echo
    echo "   !   writer   !   "
    echo
    echo "~~!~~!--!~~!--!~~!~~"
    echo
    echo
    echo "Usage: writer.sh [action]"
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
    echo 
    echo
    echo "visit https://github.com/smcalilly/writer#how-it-works for more details"
    echo
    echo
    echo "~~!~~!--!~~!--!~~!~~"
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