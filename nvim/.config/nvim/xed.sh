#!/bin/bash
if [[ ! $(command -v nvim) ]]; then
  echo "Missing package nvim, installing..."
  sudo apt-get -q update
  sudo apt-get -yq install neovim
fi

DIR="$(dirname "$(readlink -f "$0")")"
nvim -u "$DIR/xed.vim" "${@:1}" 

