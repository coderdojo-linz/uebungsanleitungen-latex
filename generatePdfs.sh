#!/bin/bash

# Check if the path is provided as an argument
if [ -z "$1" ]; then
  echo "Usage: $0 <path>"
  exit 1
fi

# Get the absolute path
base_path=$(realpath "$1")

# Loop over all directories in the given path
for dir in "$base_path"/*/; do
  if [ -d "$dir" ]; then
    subfolder_name=$(basename "$dir")
    echo "Processing directory: $subfolder_name"

    docker run --rm -v "$(pwd):/data" -w /data/uebungsanleitungen_liste/$subfolder_name --entrypoint xelatex rstropek/pandoc-coderdojo main.tex
    mv uebungsanleitungen_liste/$subfolder_name/main.pdf uebungsanleitungen_liste/$subfolder_name/$subfolder_name.pdf
  fi
done
