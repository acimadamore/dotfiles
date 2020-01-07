#!/bin/bash

declare -r GPG_KEYS__PATH="${BASH_SOURCE%/*}/config/gpg_keys"

# TODO shame. Improve this.
gpg_key__is_url() {
  [[ ${1} =~ ^https ]]
}

gpg_key__download_and_add() {
  curl -fsSL ${1} | sudo apt-key add -
}

gpg_key__add() {
  sudo apt-key adv --recv-keys ${1}
}

gpg_key__install() {
  declare -r key=$(read_file ${1})

  if $(gpg_key__is_url ${key}); then
    gpg_key__download_and_add ${key}
  else
    gpg_key__add ${key}
  fi
}

gpg_key__install_all() {
  for key in ${GPG_KEYS__PATH}/*; do
    gpg_key__install ${key}
  done
}

