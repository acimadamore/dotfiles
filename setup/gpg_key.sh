#!/bin/bash

declare -r GPG_KEYS_PATH="./config/gpg_keys"

read_file() {
  cat ${1}
}

# TODO shame. Improve this.
is_url() {
  [[ ${1} =~ ^https ]]
}

download_and_add_key() {
  curl -fsSL ${1} | sudo apt-key add -
}

add_key() {
  sudo apt-key adv --recv-keys ${1}
}

install_gpg_key() {
  declare -r key=$(read_file ${1})

  if $(is_url ${key}); then
    download_and_add_key ${key}
  else
    add_key ${key}
  fi
}

install_gpg_keys() {
  for key in ${GPG_KEYS_PATH}/*; do
    install_gpg_key ${key}
  done
}
