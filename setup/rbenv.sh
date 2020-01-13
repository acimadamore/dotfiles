#!/bin/bash


rbenv::_install_required_packages() {
  declare -r rbenv_required_packages=( $(read_file "${BASH_SOURCE%/*}/config/rbenv_required_packages") )

  sudo apt-get install -y ${rbenv_required_packages[@]}
}

rbenv::_install_ruby_build() {
  declare -r ruby_build_repository="https://github.com/rbenv/ruby-build.git"

  mkdir -p ~/.rbenv/plugins

  git clone ${ruby_build_repository} ~/.rbenv/plugins/ruby-build
}

rbenv::_clone_rbenv() {
  declare -r rbenv_repository="https://github.com/rbenv/rbenv.git"

  git clone ${rbenv_repository} ~/.rbenv
}

rbenv::install() {
  rbenv::_install_required_packages
  rbenv::_clone_rbenv
  rbenv::_install_ruby_build
}
