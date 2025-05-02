#!/bin/bash

# command -v fnm >/dev/null || export PATH="~/.fnm:$PATH"
export PATH="$HOME/.fnm:$PATH"
eval "$(fnm env --use-on-cd)"
