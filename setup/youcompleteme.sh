#!/bin/bash

ycm::_install_required_packages() {
  declare -r ycm_required_packages=( $(read_file "${BASH_SOURCE%/*}/config/youcompleteme_required_packages") )

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

    notice "Vim's YouCompleteMe plugin  Installed"
  fi
}
