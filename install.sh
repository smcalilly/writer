#!/usr/bin/env bash

set_user_editor() {
    echo "What is the executable name for your preferred text editor (i.e. vim or nano or atom or subl)?"

    echo "Type the name and hit enter: [nano]"
    read EDITOR
    echo
    
    # todo bug - need to validate editor
    echo "Thanks. Your writing will open in $EDITOR."

    # bad way of adding the $EDITOR variable
    cat .src/pre-writer.sh | head -2 >> .src/writer.sh
    echo "export EDITOR=$EDITOR" >> .src/writer.sh
    cat .src/pre-writer.sh | tail -n +3 >> .src/writer.sh
}

set_writing_directory() {
    echo "What do you want to name your writing directory?"
    echo "Type the name and hit enter: [writing]"
    read WRITING_DIR_NAME
    echo
    echo "All of your writing will live in the /$WRITING_DIR_NAME directory now."
    echo "You can always reconfigure this by re-running this install script."
    echo
}

walkthrough_guide() {
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
    echo "to continue, press [return]:"
    read 
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
    echo "to continue, press [return]:"
    read
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
    echo "to continue, press [return]:"
    read 
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

reconfigure_writer_directory() {
    if [ -n "${WRITER_DIR+1}" ]; then
    echo "You've already setup your writer. Do you want to create a new one?"
    echo "This will overwrite your existing writer settings, but it will not delete writing. y/n: [n]"
    read setup_new_writer
    echo

        if [ "${setup_new_writer}" == 'y' ]; then
            set_writing_directory
        fi
    else
        set_writing_directory
    fi
}

echo
echo
echo
echo
echo
echo "~~!~~!--!~~!--!~~!~~"
echo
echo "   !   writer   !   "
echo
echo "~~!~~!--!~~!--!~~!~~"
echo
echo
echo "Hi - hope you are well. Thanks for downloading writer."
echo
echo "Whenever you use this CLI, your writing will automatically open in a text editor."

if [ -n "${EDITOR+1}" ]; then
    echo "It looks like you're using $EDITOR as your text editor."

    echo "Do you want to use that for your writer? Type y/n: [y]"
    read use_existing_editor

    if [ "${use_existing_editor}" == 'n' ]; then
        set_user_editor
    fi
else
   set_user_editor
fi

echo
echo 



echo "Your writer is setup! Would you like to do a walkthrough guide? y/n: [n]"
read needs_walkthrough_guide

echo 
echo "-------"

if [ "${needs_walkthrough_guide}" == 'y' ]; then
    walkthrough_guide
fi


cd .src

make install

echo "Good luck writing !"
echo "hint:     write.sh"
# todo - make project opinionated


# echo "Within that directory, you have a /notes directory. This directory can be tracked by git."
# echo "Your daily notes will save to the /notes/daily directory."
# echo "The notes directory also has a /scribbles directory, where you can name your notes."