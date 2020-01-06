#!/bin/bash

declare -r VIM_PLUG_URL="https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim"

install_vim_plug() {
  curl -fLo ~/.vim/autoload/plug.vim --create-dirs ${VIM_PLUG_URL}
}
