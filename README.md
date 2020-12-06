# writer
A writer for the command line. Based heavily upon [note.sh](https://github.com/hachibu/note.sh) - "A simple shell script for managing your random daily notes."

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

To get some help:
```
writer -h
```

## Uninstall
```
cd $WRITER_DIR/.src
make uninstall
cd ../..
rm -rf $WRITER_DIR
```