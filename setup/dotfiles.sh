#!/bin/bash

source ./utils.sh

dotfiles::_is_ignored_file() {
  declare -ra ignored_files=( LICENSE.md README.md setup setup.sh Vagrantfile )

  declare -r regex_backup="^backup_[0-9]+\.tar\.gz$"
  declare -r regex_logs=".+\.log$"

  is_element_in_array "${1}" "${ignored_files[@]}" || [[ ${1} =~ ${regex_backup} ]] || [[ ${1} =~ ${regex_logs} ]]
}

dotfiles::_backup() {
  declare -a backup

  for file in *; do
    filepath="$HOME/.$file"
    if [[ -e ${filepath} && ! -L ${filepath} ]];then
      backup+=(${filepath})
    fi
  done

  tar -czvf backup_$(date +"%Y%m%d").tar.gz ${backup[@]}
}

dotfiles::_symlink_files() {
}

dotfiles::_install_vimplug() {
  echo "-- TODO -- Install Vimplug"
}

dotfiles::_install_vim_plugins() {
  echo "-- TODO -- Install Vim plugins"
}

dotfiles::install() {
  dotfiles::_backup

  dotfiles::_symlink_files

  dotfiles::_install_vim_plugins
}

