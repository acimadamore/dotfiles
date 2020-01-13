#!/bin/bash

declare -r VIMPLUG__URL="https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim"

vimplug::install() {
  curl -fLo ~/.vim/autoload/plug.vim --create-dirs ${VIMPLUG__URL}
}
