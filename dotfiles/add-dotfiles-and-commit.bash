#!/usr/bin/env bash

# for each file in ~/scripts/dotfiles.txt, copy the new verson to dotfiles
DOTFILES_FILE="/home/ddinu/my-stuff/dotfiles/dotfiles.txt"
DOT_DIR="/home/ddinu/my-stuff/dotfiles/"
while read f
do
    ln -sf "/home/ddinu/${f}" "${f}"
    git -C "${DOT_DIR}" add "${f}"
done < "${DOTFILES_FILE}"
git -C "${DOT_DIR}" add "copy-over.bash"
git -C "${DOT_DIR}" add "${DOTFILES_FILE}"
git -C "${DOT_DIR}" commit -m "daily commit $(date)"
git -C "${DOT_DIR}" push

exit 0
