#!/bin/bash

declare -r RBENV_REPOSITORY="https://github.com/rbenv/rbenv.git"

declare -r RUBY_BUILD_REPOSITORY="https://github.com/rbenv/ruby-build.git"

declare -r REQUIRED_PACKAGES_PATH="./config/rbenv_required_packages"

install_required_packages() {
  declare -r rbenv_required_packages=( $(cat $(REQUIRED_PACKAGES_PATH)) )
  sudo apt-get install -y ${rbenv_required_packages[@]}
}

install_ruby_build() {
  mkdir -p ~/.rbenv/plugins
  git clone ${RUBY_BUILD_REPOSITORY} ~/.rbenv/plugins/ruby-build
}

clone_rbenv() {
  git clone ${RBENV_REPOSITORY} ~/.rbenv
}

install_rbenv() {
  install_required_packages
  clone_rbenv
  install_ruby_build
}
