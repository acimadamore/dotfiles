#!/bin/bash

declare -r SUPPORTED_OS_FILE="${BASH_SOURCE%/*}/config/supported_os"

command_exists() {
  command -v ${1} &> /dev/null
}

is_element_in_array() {
  declare searched_element=${1}
  declare -a array=( "${@}" )

  for element in ${array[@]:1}; do
    if [[ ${element} = ${searched_element} ]]; then
      return 0
    fi
  done

  return 1
}

ask_confirmation() {
  read -p "${1} (y/n)" -n 1 -r
  echo
  [[ $REPLY =~ ^[Yy]$ ]]
}

read_file() {
  cat ${1} | grep -v '#'
}

os() {
  lsb_release -is | tr '[:upper:]' '[:lower:]'
}

os_codename() {
  lsb_release -cs
}

os_release(){
  lsb_release -rs
}

os_description() {
  lsb_release -ds
}

is_os_supported() {
  is_element_in_array "$(os)" "$(read_file ${SUPPORTED_OS_FILE})"
}

is_kde_desktop() {
  [[ ${XDG_CURRENT_DESKTOP^^} =~ "KDE" ]]
}

notice(){
  echo -e "\e[92m \xE2\x9C\x94 \e[39m $1" 
}

