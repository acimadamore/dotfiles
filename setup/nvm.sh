#!/bin/bash

declare -r NVM_INSTALLER_URL="https://raw.githubusercontent.com/nvm-sh/nvm/v0.35.1/install.sh"

install_nvm() {
  curl -o- ${NVM_INSTALLER_URL} | bash
}
