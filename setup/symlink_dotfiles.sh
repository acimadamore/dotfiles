#!/bin/bash

is_ignored_file(){
  declare -ra ignored_files=( LICENSE.md README.md install.sh ssh setup )

  for ignored_file in ${ignored_files[@]}; do
    if [[ $ignored_file == $1 ]]; then
      return 0
    fi
  done

  return 1
}

make_backup(){
  declare -a backup

  for file in *; do
    filepath="$HOME/.$file"
    if [[ -e $filepath && ! -L $filepath ]];then
      backup+=($filepath)
    fi
  done

  tar -czvf backup_$(date +"%Y%m%d").tar.gz ${backup[@]}
  echo -e "\e[92m \xF0\x9F\x96\xAB \e[39m Backed up current dotfiles at backup_$(date +"%Y%m%d").tar.gz"
}

symlink(){
  for file in *; do
    if ! $(is_ignored_file $file); then

      if [[ -e "$HOME/.$file" ]]; then
        if [[ -L "$HOME/.$file" ]]; then
          echo -e "\e[93m \xE2\x9A\xA0 \e[39m $HOME/.$file is already a symbolic link! Skipping..."
          continue
        else
          rm "$HOME/.$file"
          echo -e "\e[91m \xE2\x9C\x97 \e[39m $HOME/.$file deleted"
        fi
      fi

      ln -s "$PWD/$file" "$HOME/.$file" 
      echo -e "\e[92m \xE2\x9C\x94 \e[39m Created symbolic link: $HOME/.$file -> $PWD/$file"
    fi
  done
}

make_backup

symlink
