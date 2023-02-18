#!/usr/bin/env bash

DOT_DIR="${HOME}/my-stuff/dotfiles/"
DOT_FILE="${DOT_DIR}dotfiles.txt"
while read f
do
    cp -v "${DOT_DIR}${f}" "${HOME}/."
done < "${DOT_FILE}"

exit 0
