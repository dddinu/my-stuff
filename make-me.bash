#!/usr/bin/env bash

MAIN_DIR="${HOME}/my-stuff/"

# copy over scripts and dotfiles
"${MAIN_DIR}copy-over.bash"

# copy over emacs packages
cp "${MAIN_DIR}.emacs.d/" "${HOME}/."

# modify dotfiles appropriately

