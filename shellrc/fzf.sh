#!/bin/bash

export FZF_DEFAULT_OPTS="--multi --cycle --height 50% --layout reverse --preview  'bat --style=numbers --color=always {} ' --border"
export FZF_DEFAULT_COMMAND='ag -g ""'

[ -f ~/.fzf.bash ] && source ~/.fzf.bash
