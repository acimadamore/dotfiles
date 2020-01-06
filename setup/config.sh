#!/bin/bash

declare -r  OS=$(lsb_release -is)

declare -r  OS_RELEASE=$(lsb_release -cs)

declare -ra SUPPORTED_OS=( ubuntu mint )

declare -ra GPG_KEYS=( "https://download.spotify.com/debian/pubkey.gpg" "https://download.docker.com/linux/ubuntu/gpg" )

declare -r  DROPBOX_KEY="FC918B335044912E"

declare -rA THIRD_PARTY_REPOSITORIES=(
  [docker]="deb [arch=amd64] https://download.docker.com/linux/ubuntu ${OS_RELEASE} stable"
  [dropbox]="deb http://linux.dropbox.com/ubuntu/ ${OS_RELEASE} main"
  [spotify]="deb http://repository.spotify.com stable non-free"
)

# packages required by YCM vim plugin, rbenv-build & docker
declare -a required_packages=(
  apt-transport-http
  autoconf
  bison
  build-essential
  ca-certificates
  cmake
  gnupg-agent
  libffi-dev
  libgdbm-dev
  libgdbm5
  libmysqlclient-dev
  libncurses5-dev
  libreadline6-dev
  libssl-dev
  libyaml-dev
  python3-dev
  software-properties-common
  zlib1g-dev
)

declare -a programs=(
  containerd.io
  chromium-browser
  docker-ce
  docker-ce-cli
  dropbox
  exuberant-ctags
  git
  htop
  httpie
  lm-sensors
  mtr
  neofetch
  network-manager-openvpn
  nmap
  ranger
  screen
  silversearcher-ag
  spotify-client
  thefuck
  tmux
  tree
  unzip
  vim-gtk
  vagrant
  virtualbox
)

declare -a kde_programs=(
  kubuntu-restricted-extras
  partitionmanager
  virtualbox-qt
)
