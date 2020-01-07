#!/bin/bash

declare -r REPOSITORIES__PATH="${BASH_SOURCE%/*}/config/repositories"

repositories__add() {
  echo ${2} | sudo tee /etc/apt/sources.list.d/${1}.list
}

repositories__read_file() {
  echo "$(read_file ${1})" | sed -e "s/<OS_RELEASE>/$(os_codename)/g"
}

repositories__add_from_file() {
  declare -r filename=$(basename ${1})
  declare -r repo_url="$(repositories__read_file ${1})"

  repositories__add ${filename} "${repo_url}"
}

repositories__add_all() {
  for file in ${REPOSITORIES__PATH}/*; do
    repositories__add_from_file ${file}
  done
}
