#!/bin/bash

if command -v tmux &> /dev/null && [ -z "$TMUX" ]; then
  tmux has-session -t default 2> /dev/null

  if [ $? != 0 ]; then
    tmux new -s default
  fi

  #tmux attach-session -t default || tmux new -s default
fi
