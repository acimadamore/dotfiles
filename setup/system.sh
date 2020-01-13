#!/bin/bash

system::install_programs() {
  declare -a  programs=$(read_file "${BASH_SOURCE%/*}/config/programs")

  declare -ra kde_programs=$(read_file "${BASH_SOURCE%/*}/config/kde_programs")

  sudo apt-get update

  if $(is_kde_desktop); then
    programs=( "${programs[@]}" "${kde_programs[@]}" )
  fi

  sudo apt-get install -y ${programs[@]} 

  notice "Programs installed"
}

system::upgrade() {
  sudo apt-get dist-upgrade -y && \\
  sudo apt-get autoclean    -y && \\
  sudo apt-get autoremove   -y

  notice "System upgraded"
}
