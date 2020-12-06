# writer
A CLI to write without pause. Based upon [note.sh](https://github.com/hachibu/note.sh) - "A simple shell script for managing your random daily notes." Use that if you want a simple, single thing.

## Installation
Install with this clunky command:
```
(curl https://raw.githubusercontent.com/smcalilly/writer/main/download.sh | WRITER_DIR='writer' bash) && cd "$WRITER_DIR" && .src/install.sh
```

This will download all the code, then walk you through some steps to setup your writer. WRITER_DIR should be the name of the directory where you want your writing to live. 

## Write with it
If you want to make an alias for the command, in your shell's startup file, add:
```
alias writer='writer.sh'
```

Then you can write in your daily note:
```
writer
```

If you want to write a note with a filename:
```
writer -f recipe-brainstorm
```

If you want to write within a directory:
```
writer -d good-recipes
```

If you want to write to a named file within a directory:
```
writer -f turnip-green-soup -d good-recipes
```

You can search with all the files in your writer, with `grep`:
```
writer -g turnip
```

To get some help:
```
writer -h
```

## Use with git
The writer directory is initialized with git. I wanted version control for my writing, but this also lets me backup my writing on github and use on other devices. 

Here is how I setup my writer on my other computer, for an existing writer repo.
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
