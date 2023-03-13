#!/bin/bash

command -v fnm >/dev/null || export PATH="~/.fnm:$PATH"
eval "$(fnm env --use-on-cd)"
