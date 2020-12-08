#!/usr/bin/env bash
set -euo pipefail
set -o nounset
set -o errtrace
set -o errexit

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
    echo "    -s [writing via stdin]"
    echo "    -l [ls in the target directory"
    echo
    echo
    echo "  EXAMPLES:"
    echo "      writer.sh -n                               # opens a daily note to write in"
    echo "      writer.sh -d project-dir -f file-name      # opens a writing file named file-name in the project-dir"
    echo "      writer.sh -g collards                      # searches for the word 'collards' in your writer"
    echo "      writer.sh -l .                             # lists all files in the root of your writer"
    echo 
    echo
    echo "  visit https://github.com/smcalilly/writer#how-it-works for more details"
    echo
    echo
    echo "~~!~~!--!~~!--!~~!~~"
}

# parse any arguments
while getopts :snl:g:d:f: flag 
do
    case "${flag}" in
        f) file_name=${OPTARG};;
        d) directory=${OPTARG};;
        g) grp=${OPTARG};;
        s) stdin=true;;
	    n) note=true;;
        l) listdir=${OPTARG};;
        *) echo "You can't write. ${OPTARG}" is an unrecognized option && exit 0;;
    esac
done

writing_target="$WRITER_DIR"

if [ $# -eq 0 ]; then
    usage
elif [[ "${listdir:-}" ]]; then
    ls "$WRITER_DIR/$listdir"
elif [ "${grp:-}" ]; then
    writing=$(grep -nr "$2" $WRITER_DIR -l)
    echo $writing
    less -p "$2" $writing 
elif [ "${configure:-}"]
else
    if [[ "${directory:-}" ]]; then
        writing_target="$writing_target/$directory"
        mkdir -p $writing_target
    fi

    if [[ "${file_name:-}" ]]; then
        writing_target="$writing_target/$file_name.md"
    elif [[ "${note:-}" ]]; then 
        mkdir -p "$writing_target/notes"
        writing_target="$writing_target/notes/$(date +'%Y-%m-%d').md"
    fi

    if [ "${stdin:-}" ]; then 
        # this came in through STDIN, 
        # so just save it where it's intended
        echo "" | tee >> $writing_target
        echo "$(</dev/stdin)" | tee >> $writing_target
        echo; echo "Saved some writing to $writing_target"
    else
        # Open text editor
        set -o noclobber
        $EDITOR $writing_target
        echo "bye writer"
    fi
fi
