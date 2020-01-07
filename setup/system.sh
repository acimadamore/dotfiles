#!/bin/bash

declare -r SYSTEM__PROGRAMS_PATH="${BASH_SOURCE%/*}/config/programs"
declare -r SYSTEM__KDE_PROGRAMS_PATH="${BASH_SOURCE%/*}/config/kde_programs"

system__install_programs() {
  declare -a  programs=$(read_file ${SYSTEM__PROGRAMS_PATH})
  declare -ra kde_programs=$(read_file ${SYSTEM__KDE_PROGRAMS_PATH})

  sudo apt-get update

  if $(is_kde_desktop); then
    echo "KDE!"
    programs=( "${programs[@]}" "${kde_programs[@]}" )
  fi

  sudo apt-get install -y ${programs[@]} 
}

system__upgrade() {
  sudo apt-get dist-upgrade -y && \\
  sudo apt-get autoclean    -y && \\
  sudo apt-get autoremove   -y
}
