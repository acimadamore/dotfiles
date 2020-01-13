#!/bin/bash

# TODO shame. Improve this.
gpg_key::_is_url() {
  [[ ${1} =~ ^https ]]
}

gpg_key::_download_and_add() {
  curl -fsSL ${1} | sudo apt-key add -
}

gpg_key::_add() {
  sudo apt-key adv --recv-keys ${1}
}

gpg_key::_install() {
  declare -r key=$(read_file ${1})

  if $(gpg_key::_is_url ${key}); then
    gpg_key::_download_and_add ${key}
  else
    gpg_key::_add ${key}
  fi
}

gpg_key::install_all() {
  declare -r gpg_keys_path="${BASH_SOURCE%/*}/config/gpg_keys"

  for key in ${gpg_keys_path}/*; do
    gpg_key::_install ${key}
  done
}

