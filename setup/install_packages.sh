#!/bin/bash

notice(){
  echo -e "\e[92m \xE2\x9C\x94 \e[39m $1" 
}

gpg_keys=( "https://download.spotify.com/debian/pubkey.gpg" "https://download.docker.com/linux/ubuntu/gpg" )

declare -Ar repositories=(
  [docker]="deb [arch=amd64] https://download.docker.com/linux/ubuntu bionic stable"
  [dropbox]="deb http://linux.dropbox.com/ubuntu/ bionic main"
  [spotify]="deb http://repository.spotify.com stable non-free"
)

# packages required by YCM vim plugin, rbenv-build & docker
required_packages=(
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

programs=(
  #bat
  containerd.io
  chromium-browser
  docker-ce
  docker-ce-cli
  dropbox
  exuberant-ctags
  git
  htop
  httpie
  kubuntu-restricted-extras
  lm-sensors
  mtr
  neofetch
  network-manager-openvpn
  nmap
  partitionmanager
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
  virtualbox-qt
)

for key in ${gpg_keys[@]}; do
  curl -fsSL $key | sudo apt-key add -
done

sudo apt-key adv --recv-keys FC918B335044912E

notice "Added thirdparty GPG keys"

for name in ${!repositories[@]}; do
  echo ${repositories[$name]} | sudo tee /etc/apt/sources.list.d/$name.list
done

notice "Added thirdparty repositories"

sudo apt update

sudo apt install -y ${required_packages[@]}
sudo apt install -y ${programs[@]}

notice "Applications installed"

curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

notice "Vim Plug installed"

git clone https://github.com/rbenv/rbenv.git ~/.rbenv
mkdir -p ~/.rbenv/plugins
git clone https://github.com/rbenv/ruby-build.git ~/.rbenv/plugins/ruby-build

notice "RBENV installed"

curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.35.1/install.sh | bash

notice "NVM installed"

sudo apt dist-upgrade -y && sudo apt autoclean -y && sudo apt autoremove -y

notice "System upgraded"
