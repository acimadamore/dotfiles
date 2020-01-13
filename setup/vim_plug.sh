#!/bin/bash

vimplug::install() {
  declare -r vimplug_repository_url="https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim"

  curl -fLo ~/.vim/autoload/plug.vim --create-dirs ${vimplug_repository_url}
}
