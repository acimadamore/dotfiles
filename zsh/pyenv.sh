#!/bin/bash

export PYENV_ROOT="$HOME/.pyenv"
# command -v pyenv >/dev/null || export PATH="~/.pyenv/bin:$PATH"
export PATH="$HOME/.pyenv/bin:$PATH"
eval "$(pyenv init -)"
