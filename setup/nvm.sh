#!/bin/bash

nvm::install() {
  declare -r nvm_installer_url="https://raw.githubusercontent.com/nvm-sh/nvm/v0.35.1/install.sh"

  curl -o- ${nvm_installer_url} | bash

  notice "NVM installed"
}
