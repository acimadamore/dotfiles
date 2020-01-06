#!/bin/bash

command_exists() {
  command -v ${1} &> /dev/null
}

is_element_in_array() {
  declare searched_element=${1}
  declare -a array=( ${@} )

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
  return $(cat ${1})
}

operating_system() {
  return $(lsb_release -is,,)
}

operating_system_release() {
  return $(lsb_release -cs)
}

