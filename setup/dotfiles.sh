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
    filepath="$HOME/.${file}"

    if [[ -e ${filepath} && ! -L ${filepath} ]];then
      backup+=(${filepath})
    fi
  done

  tar -czvf backup_$(date +"%Y%m%d").tar.gz ${backup[@]}
}

dotfiles::_symlink_dir() {
  if [[ ${#} -eq 0 ]]; then
    read_dir="*"
  else
    read_dir="${1}/*"
  fi

  for file in ${read_dir}; do
    if [[ -d ${file} ]]; then
      dotfiles::_symlink_dir $file
    else
      dotfiles::_symlink_file $file
    fi
  done
}

dotfiles::_symlink_file() {

  # if [[ -e "$HOME/.$file" ]]; then
  #   if [[ -L "$HOME/.$file" ]]; then
  #     continue
  #   else
  #     rm "$HOME/.${file}"
  #   fi
  # fi

  # ln -s "$PWD/${file}" "$HOME/.${file}"

  echo "file: ${1} -> \$HOME/.${1}" 
}

dotfiles::_symlink_files() {
  # declare -r is_root_directory=[[ ${#} -e 0 ]]

  for file in *; do
    if ! $(dotfiles::_is_ignored_file ${file}); then
      if [[ -d ${file} ]]; then
        dotfiles::_symlink_dir ${file}
      else
        dotfiles::_symlink_file ${file}
      fi
    fi
  done
}

dotfiles::install() {
  # dotfiles::_backup

  #dotfiles::_symlink_files

  dotfiles::_symlink_dir 
}
cd ..
dotfiles::install
