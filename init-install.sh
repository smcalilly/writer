#!/usr/bin/env bash

echo "$WRITER_DIR"
mkdir -p "$WRITER_DIR"
cd "$WRITER_DIR"

touch -p "env-variables.sh"

./install.sh