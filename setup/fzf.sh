#!/bin/bash

fzf::install() {
  declare -r fzf_repo_url="https://github.com/junegunn/fzf.git"

  git clone --depth 1 ${fzf_repo_url} ~/.fzf

  ~/.fzf/install --key-bindings --completion --no-update-rc
}
