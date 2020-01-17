#!/bin/bash

dotfiles::_is_ignored_file() {
  declare -ra ignored_files=( LICENSE.md README.md setup setup.sh Vagrantfile )

  declare -r regex_backup="^backup_[0-9]+\.tar\.gz$"
  declare -r regex_logs=".+\.log$"

  is_element_in_array "${1}" "${ignored_files[@]}" || [[ ${1} =~ ${regex_backup} ]] || [[ ${1} =~ ${regex_logs} ]]
}

dotfiles::_backup() {
  declare -a backup

  for file in *; do
    filepath="$HOME/.${file}"

    if [[ -e ${filepath} && ! -L ${filepath} ]];then
      backup+=(${filepath})
    fi
  done

  tar -czvf backup_$(date +"%Y%m%d").tar.gz ${backup[@]}
}

dotfiles::_symlink_directory() {
  if [[ ${#} -eq 0 ]]; then
    declare -r read_dir="*"
  else
    declare -r read_dir="${1}/*"
  fi


  for file in ${read_dir}; do
    if ! $(dotfiles::_is_ignored_file ${file}); then

      if [[ -d ${file} ]]; then
        mkdir -p "$HOME/.${file}"
        dotfiles::_symlink_directory $file
      else
        dotfiles::_symlink_file $file
      fi

    fi
  done
}

dotfiles::_symlink_file() {
  declare -r file=${1}

  if [[ -e "$HOME/.${file}" ]]; then
    if [[ -L "$HOME/.${file}" ]]; then
      continue
    else
      rm "$HOME/.${file}"
    fi
  fi

  ln -s "$PWD/${file}" "$HOME/.${file}"
}

dotfiles::install() {
  dotfiles::_backup

  dotfiles::_symlink_directory

  notice "Dotfiles installed"
}
