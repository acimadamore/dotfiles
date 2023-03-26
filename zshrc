 autoload -Uz compinit promptinit colors
colors
compinit
promptinit

zstyle ':completion:*' menu select

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
  test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
  alias ls='ls --color=auto'
  #alias dir='dir --color=auto'
  #alias vdir='vdir --color=auto'

  alias grep='grep --color=auto'
  alias fgrep='fgrep --color=auto'
  alias egrep='egrep --color=auto'
fi

bindkey -v
bindkey '^R' history-incremental-search-backward

# PS1='\[\033[01;34m\]\w \[\033[00m\]🐱 '
setopt PROMPT_SUBST
PROMPT='%B%F{blue}%~%f%b %f🐱 '

[ -f ~/.aliases ] && source ~/.aliases

[ -f ~/.env ] && source ~/.env


if [ -d ~/.zsh ]; then 
  for rc_file in ~/.zsh/*; do
    source $rc_file
  done
fi

# Add local configuration
[[ -f ~/.zshrc.local ]] && source ~/.zshrc.local
