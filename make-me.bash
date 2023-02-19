#!/usr/bin/env bash

MAIN_DIR="${HOME}/my-stuff/"

# copy over scripts and dotfiles
echo "copying scripts and dotfiles"
"${MAIN_DIR}copy-over.bash"

# copy over emacs packages
echo "copying emacs packages"
cp -r "${MAIN_DIR}.emacs.d/" "${HOME}/."

# modify dotfiles appropriately

# .bashrc modifications
# remove aliases
# change prompt
# remove tigress settings
# remove OD-LLVM settings

