#!/usr/bin/env bash

echo
echo
echo "~~!~~!--!~~!--!~~!~~"
echo
echo "   !   writer   !   "
echo
echo "~~!~~!--!~~!--!~~!~~"
echo
echo
echo "Hi writer - hope you are well. Thanks for downloading writer."
echo
echo "Whenever you use this CLI, your writing will automatically open in a text editor."

if [ -n "${EDITOR+1}" ]; then
    echo "It looks like you're using $EDITOR as your text editor."

    echo "Do you want to use that for your writer? Type y/n: [y]"
    read use_existing_editor

    if [ "${use_existing_editor}" == 'n' ]; then
        echo "You need to change the $EDITOR variable in your shell's startup file."
        echo "It might look like this:"
        echo
        echo "      export EDITOR=vim"
    fi
else
    echo "You need to change the $EDITOR variable in your shell's startup file."
    echo "It might look like this:"
    echo
    echo "      export EDITOR=vim"
fi

echo
echo 

cd .src

$(make install 2> /dev/null)


echo "Your writer is setup! To write in your daily note, try:"
echo
echo "    writer -n"
echo
echo
echo "To get some help, try:"
echo
echo "    writer -h"
echo
echo
echo "Good luck writing !"
echo
echo 
echo "~~!~~!--!~~!--!~~!~~"
echo
echo "   !   writer   !   "
echo
echo "~~!~~!--!~~!--!~~!~~"




