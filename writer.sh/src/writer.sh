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
    echo "    -n [write in your daily note]"
    echo "    -f [write in a named file]"
    echo "    -d [write in a specific directory]"
    echo "    -g grep [pattern]"
    echo "    -s [writing via stdin]"
    echo "    -l [ls in the target directory]"
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
while getopts :htsnl:g:d:f: flag 
do
    case "${flag}" in
        h) help=true;;
        f) file_name=${OPTARG};;
        d) directory=${OPTARG};;
        g) grp=${OPTARG};;
        s) stdin=true;;
	    n) note=true;;
        l) listdir=${OPTARG};;
        t) trash=true;;
        *) echo "You can't write. ${OPTARG}" is an unrecognized option. && exit 0;;
    esac
done

writing_target="$WRITER_DIR"

if [ $# -eq 0 ]; then
    usage
elif [[ "${help:-}" ]]; then
    usage
elif [[ "${listdir:-}" ]]; then
    ls "$WRITER_DIR/$listdir"
elif [ "${grp:-}" ]; then
    writing=$(grep -nr "$2" $WRITER_DIR -l)
    echo $writing
    less -p "$2" $writing 
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
    elif [[ "${trash:-}" ]]; then
        echo "Are you sure you want to move your writing to the trash? [y/n]"
        read response
        if [[ "${response}" = [yY] ]]; then
            original_path=$writing_target
            name=$(basename $writing_target)
            target="${original_pathpath%/*}/trash"
            sudo mkdir -p $target
            cp $writing_target "$target/$name"
            rm $writing_target
        fi
    else
        # Open text editor
        set -o noclobber
        $EDITOR $writing_target
        echo "bye writer"
    fi
fi
