#!/bin/bash

source "./setup/utils.sh"

source "./setup/gpg_keys.sh"
source "./setup/nvm.sh"
source "./setup/rbenv.sh"
source "./setup/repositories.sh"
source "./setup/system.sh"

# TODO Move this
if $(! is_os_supported); then
  if $(command_exists "apt-get"); then
    if $(! ask_confirmation  "OS \"$(os_description)\" is not in the list of supported OSs but apt-get was detected. Proceed?"); then
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

gpg_key__install_all

repositories__add_all

system__install_programs

rbenv__install

nvm__install

system__upgrade
