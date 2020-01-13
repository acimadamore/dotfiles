#!/bin/bash

repositories::_add() {
  echo ${2} | sudo tee /etc/apt/sources.list.d/${1}.list
}

repositories::_read_file() {
  echo "$(read_file ${1})" | sed -e "s/<OS_RELEASE>/$(os_codename)/g"
}

repositories::_add_from_file() {
  declare -r filename=$(basename ${1})
  declare -r repo_url="$(repositories::_read_file ${1})"

  repositories::_add ${filename} "${repo_url}"
}

repositories::add_all() {
  declare -r repositories_path="${BASH_SOURCE%/*}/config/repositories"

  for file in ${repositories_path}/*; do
    repositories::_add_from_file ${file}
  done

  notice "Added third party repositories"
}
