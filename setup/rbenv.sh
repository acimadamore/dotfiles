#!/bin/bash

declare -r RBENV__REPOSITORY="https://github.com/rbenv/rbenv.git"

declare -r RBENV__RUBY_BUILD_REPOSITORY="https://github.com/rbenv/ruby-build.git"

declare -r RBENV__REQUIRED_PACKAGES_PATH="./config/rbenv_required_packages"

rbenv__install_required_packages() {
  declare -r rbenv_required_packages=( $(read_file ${RBENV__REQUIRED_PACKAGES_PATH}) )
  sudo apt-get install -y ${rbenv_required_packages[@]}
}

rbenv__install_ruby_build() {
  mkdir -p ~/.rbenv/plugins
  git clone ${RBENV__RUBY_BUILD_REPOSITORY} ~/.rbenv/plugins/ruby-build
}

rbenv__clone_rbenv() {
  git clone ${RBENV__REPOSITORY} ~/.rbenv
}

rbenv__install() {
  rbenv__install_required_packages
  rbenv__clone_rbenv
  rbenv__install_ruby_build
}
