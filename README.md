# writer
A CLI to write without pause. Based upon [note.sh](https://github.com/hachibu/note.sh) - "A simple shell script for managing your random daily notes." Use `note.sh` if you want a simple note taking CLI. Use `writer` if you want a slightly less simple and somewhat opinionated (if you want) writing CLI.

## Installation
Install with this clunky command, with `WRITER_DIR` set as the directory name where you want your writing to live:
```
(curl https://raw.githubusercontent.com/smcalilly/writer/main/download.sh | WRITER_DIR='writer' bash) && cd "$WRITER_DIR" && .src/install.sh
```

This will download all the code and walk you through some steps to install your writer.

## Write with it
To write in your daily note:
```
writer.sh
```

If you want to make an alias for the command, in your shell's startup file, add:
```
alias writer='writer.sh'
```

Then you can write in your daily note like this:
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
writer -d good-recipes -f turnip-green-soup
```

You can search through all the writing in your `writer` with `grep`:
```
writer -g turnip
```
You'll view the results in `less`.


To get some help:
```
writer -h
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
