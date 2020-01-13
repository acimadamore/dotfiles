#!/bin/bash

source "./setup/utils.sh"

source "./setup/docker.sh"
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

gpg_key::install_all

repositories::add_all

system::install_programs

rbenv::install

nvm::install

docker::configure

system::upgrade
