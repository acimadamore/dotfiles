#!/bin/bash

source "./utils.sh"

declare -r YCM__REQUIRED_PACKAGES_PATH="./config/youcompleteme_required_packages"

declare -r YCM__PLUGIN_PATH="~/.vim/plugged/youcompleteme"

ycm::_install_required_packages() {
  declare -r ycm_required_packages=( $(read_file ${YCM__REQUIRED_PACKAGES_PATH}) )
  sudo apt-get install -y ${ycm_required_packages[@]}
}

ycm::_is_plugin_installed() {
  [[ -d ${YCM__PLUGIN_PATH} ]]
}

ycm::install() {
  if $(ycm::_is_plugin_installed); then
    ycm::_install_required_packages
    cd ${YCM__PLUGIN_PATH}
    python3 install.py --all
    cd -
  fi
}
