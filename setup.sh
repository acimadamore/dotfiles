#!/bin/bash

# source ./setup/install_packages.sh
# source ./setup/symlink_dotfiles.sh

source ./setup/config.sh

command_exists() {
  command -v ${1} &> /dev/null
}

is_element_in_array() {
  declare searched_element=${1}
  declare -a array=( ${@} )

  for element in ${array[@]:1}; do
    if [[ ${element} = ${searched_element} ]]; then
      return 0
    fi
  done

  return 1
}

is_kde_desktop() {
  [[ ${XDG_CURRENT_DESKTOP^^} =~ "KDE" ]]
}

is_os_supported() {
  is_element_in_array ${OS,,} "${SUPPORTED_OS[@]}" 
}

ask_confirmation() {
  read -p "${1} (y/n)" -n 1 -r
  echo
  [[ $REPLY =~ ^[Yy]$ ]]
}

if $(! is_os_supported); then
  if $(command_exists "apt-get"); then
    if $(! ask_confirmation  "OS \"$(lsb_release -ds)\" is not in the list of supported OSs but apt-get was detected. Proceed?"); then
      exit 1
    fi
  else
    echo "apt-get not found. FAIL"
    exit 1
  fi
fi

if $(! command_exists "curl"); then
  echo "Whaaat, you don't have Curl. I need it so i will install it..."
  sudo apt-get install curl
fi



for key in ${GPG_KEYS[@]}; do
  curl -fsSL ${key} | sudo apt-key add -
done

sudo apt-key adv --recv-keys ${DROPBOX_KEY}



for name in ${!THIRD_PARTY_REPOSITORIES[@]}; do
  echo ${THIRD_PARTY_REPOSITORIES[${name}]} | sudo tee /etc/apt/sources.list.d/${name}.list
done


sudo apt-get update

sudo apt-get install -y ${required_packages}

if $(is_kde_desktop); then
  programs=( "${programs[@]}" "${kde_programs[@]}" )
fi

sudo apt-get install -y ${programs}

curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim


git clone https://github.com/rbenv/rbenv.git ~/.rbenv
mkdir -p ~/.rbenv/plugins
git clone https://github.com/rbenv/ruby-build.git ~/.rbenv/plugins/ruby-build


curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.35.1/install.sh | bash


sudo apt dist-upgrade -y && sudo apt autoclean -y && sudo apt autoremove -y
