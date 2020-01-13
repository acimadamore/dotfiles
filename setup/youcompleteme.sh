#!/bin/bash

source "./utils.sh"

ycm::_install_required_packages() {
  declare -r ycm_required_packages=( $(read_file "./config/youcompleteme_required_packages") )

  sudo apt-get install -y ${ycm_required_packages[@]}
}

ycm::_is_plugin_installed() {
  [[ -d "~/.vim/plugged/youcompleteme" ]]
}

ycm::install() {
  if $(ycm::_is_plugin_installed); then
    ycm::_install_required_packages

    cd "~/.vim/plugged/youcompleteme" 

    python3 install.py --all

    cd -
  fi
}
