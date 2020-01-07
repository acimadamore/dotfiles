#!/bin/bash

declare -r NVM__INSTALLER_URL="https://raw.githubusercontent.com/nvm-sh/nvm/v0.35.1/install.sh"

nvm__install() {
  curl -o- ${NVM__INSTALLER_URL} | bash
}
