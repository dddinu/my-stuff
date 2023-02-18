#!/usr/bin/env bash

# copy over dotfiles
D_DIR="${HOME}/my-stuff/dotfiles/"
D_FILE="${D_DIR}dotfiles.txt"
while read f
do
    cp -v "${D_DIR}${f}" "${HOME}/."
done < "${D_FILE}"

# copy over scripts
S_DIR="${HOME}/my-stuff/scripts/"
S_FILE="${S_DIR}scripts.txt"
while read f
do
    cp -v "${S_DIR}${f}" "${HOME}/."
done < "${S_FILE}"

exit 0
