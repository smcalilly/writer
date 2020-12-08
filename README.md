# writer
A CLI to write without restraint. 

Based upon [note.sh](https://github.com/hachibu/note.sh) - "A simple shell script for managing your random daily notes."

## installation
Create a new directory for your `writer`. This is where all of your writing will live:
```
mkdir writing
```

In your shell profile, set the name of your preferred text editor:
```
export EDITOR='vim'
```

Restart your shell and `cd` into your new writing directory. Then download and install:
```
cd writing
curl https://raw.githubusercontent.com/smcalilly/writer/main/download.sh | bash
.src/install.sh
```

This will download all the code into your new writing directory, which is where `writer` saves your writing. 

## quick start
Write in your daily note:
```
writer -n
```
That command opens a note where you can write random thoughts. A new note is created each day. This is the influence of [note.sh](https://github.com/hachibu/note.sh) on this project.

`writer` can also write to specific directories or filenames in your `writer` directory. This helps keep your notes or ideas or writing projects organized while still being able to write at moment's notice. Here are some commands:
```
writer -d good-recipes                              # Write a daily note within a directory
writer -d good-recipes -f turnip-green-soup         # Write to a named file within a directory
```

### stdin
`writer` also accepts stdin, with the `-s` flag:
```
echo "hello yall" | writer -s -n

writer -n -s<<<"woooooooooooooooooo" 

echo "i can send sentences to a specific place, too" | writer -s -f file-name -d dir-name
```

This is a useful feature if you're wanting to copy/paste something into a note or writing file. For example, you're writing some code and need to get rid of a function but you like the function or learned something while writing the code, so you want to keep it for future reference. But you don't want to commit it to the project's version control. Or your co-worker wrote some good code and you want to keep it and learn it. So you just send it to `writer`:
```
echo "function noteworthyFunction()" | writer -d code-snippets -s
```

## use with git
All of my writing projects need version control and a file system. `writer` takes care of the file system and `git` can easily be added to any of the directories. You can either initialize a repo at the `writer`'s root directory or have an individual repo per directory/project. `git` also lets me backup my writing and write on other devices. 


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
writer -n                 # opens /notes/<todays-date>.md in $EDITOR 
```

A new file is created each day. It's like a staging area or organized dumping ground, but accessible quickly. An aggregation of notes in the same file throughout a day.  

**Important!** If you change the names of the `notes` directory, it will break this feature of CLI.


### directories
You can also create your own directories, like if you have a specific project where you want to write. Here is a command that will write a daily note in a new directory:
```
writer -d my-manuscript -n       # writes to $WRITER_DIR/my-manuscript/<todays-date>.md
```

You can also name a writing file in a directory:
```
writer -d my-manuscript -f chapter-1       # writes to $WRITER_DIR/my-manuscript/chapter-5.md
```
This can be organized however you wish - you can name directories within directories and files within those directories, and recall them via the CLI.

Of course, you don't have to use the CLI; it's just a handy way to write from your terminal.
Once you've created a directory, you can work with it however you want, like in your favorite text editor with a file system interface.


### filenames
As seen above, you can declare a filename with the `-f` flag. You can use it like the `-n` flag and save a named note to your notes directory:
```
writer -f recipe-idea                  # opens /notes/recipe-idea.md in $EDITOR
```

That's helpful for creating a specific or thematic note that doesn't yet have a place to live.

Both the daily note and a named note can be used the same way. It's just a matter of preference.
Would you rather have a dated note with random scribbles throughout the day, or do you want to name your notes? How about both?
 

### search

You can search with grep:
```
writer -g okra        # views all the files in /$WRITER_DIR with the word 'okra'
```


## uninstall
```
cd $WRITER_DIR/.src
make uninstall
cd ../..
rm -rf $WRITER_DIR
```
