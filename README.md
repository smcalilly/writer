# writer
A CLI to write without pause. 

Based upon [note.sh](https://github.com/hachibu/note.sh) - "A simple shell script for managing your random daily notes." Use `note.sh` if you want a simple note taking CLI. Use `writer` if you want a slightly less simple and somewhat opinionated (if you want) writing CLI.

## Installation
Install with this clunky command, setting `WRITER_DIR` as the directory name where you want your writing to live:
```
(curl https://raw.githubusercontent.com/smcalilly/writer/main/download.sh | WRITER_DIR='writer' bash) && cd "$WRITER_DIR" && .src/install.sh
```

This will download all the code and create a directory for all of your writing. It will also walk you through some steps to finish setting up your `writer`.

## quick start
Write in your daily note:
```
writer.sh -n
```

If you want to make an alias for the command, in your shell's startup file, add: 
```
alias writer='writer.sh'
```

Then, you can write in your daily note again:
```
writer -n
```

Write a note with a filename:
```
writer -f vague-turnip-green-recipe-idea
```

Write within a directory:
```
writer -d good-recipes
```

Write to a named file within a directory:
```
writer -d good-recipes -f turnip-green-soup
```

You can search through all the writing in your `writer` with `grep`. You'll view the results in `less`:
```
writer -g turnip
```

To get some help:
```
writer -h
```

## how it works
The basic structure of the $WRITER_DIR directory should look like this:

```
    $WRITER_DIR
            |.src/
            |
            |notes/
            |    |<todays-date>.md
```

### notes
This command will open a daily note to write in:
```
    writer.sh -n                 # opens /notes/<todays-date>.md in $EDITOR 
```

A new file is created each day. It's like a staging area or organized dumping ground, but accessible quickly and happily. An aggregation of notes in the same file throughout a day.  

**Important!** If you change the names of the `notes` directory, it will break this feature of CLI.


### directories
You can also create your own directories, like if you have a specific project where you want to write. Here is a command that will write a daily note in a new directory:
```
    writer.sh -d my-manuscript -n       # writes to $WRITER_DIR/my-manuscript/<todays-date>.md
    
```

You can also name a writing file in a directory:
```
    writer.sh -d my-manuscript -f chapter-1       # writes to $WRITER_DIR/my-manuscript/chapter-5.md
```
This can be organized however you wish - you can name directories within directories and files within those directories, and recall them via the CLI.

Of course, you don't have to use the CLI; it's just a handy way to write from your terminal.
Once you've created a directory, you can work with it however you want, like in your favorite text editor with a file system interface.


### filenames
As seen above, you can declare a filename with the `-f` flag. You can use it like the `-n` flag and save a named note to your notes directory:
```
    writer.sh -f recipe-idea                  # opens /notes/recipe-idea.md in $EDITOR
```

That's helpful for creating a specific or thematic note that doesn't yet have a place to live.

Both the daily note and a named note can be used the same way. It's just a matter of preference.
Would you rather have a dated note with random scribbles throughout the day, or do you want to name your notes? How about both?
 

### search

You can search with grep:
```
    writer.sh -g okra        # views all the files in /$WRITER_DIR with the word 'okra'
```

## Use with git
The `$WRITER_DIR` directory is initialized with git. I wanted version control for my writing, and git also lets me backup my writing and write on other devices. 

Here is how I setup my writer on one computer, so I could use the writer and work on writing from another computer.
- add your git remote to the `$WRITER_DIR` repo
- push it up to the remote
- get on other computer & clone the repo
- `cd` into the repo and in your terminal, run `.src/.install.sh`




## Uninstall
```
cd $WRITER_DIR/.src
make uninstall
cd ../..
rm -rf $WRITER_DIR
```
