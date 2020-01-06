#!/bin/bash

declare -r REPOSITORIES_PATH="./config/repositories"

add_repository() {
  echo ${2} | sudo tee /etc/apt/sources.list.d/${1}.list
}

read_repo_file() {
  cat ${1} | sed -e "s/<OS_RELEASE>/$(lsb_release -cs)/g"
}

add_repository_from_file() {
  declare -r filename=$(basename ${1})
  declare -r repo_url="$(read_repo_file ${1})"

  add_repository ${filename} "${repo_url}"
}

add_third_party_repositories() {
  for file in ${REPOSITORIES_PATH}/*; do
    add_repository_from_file ${file}
  done
}
