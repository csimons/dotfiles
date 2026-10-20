#!/usr/bin/env bash

# Start tmux in interactive shells, unless already inside a tmux session.
if [[ $- == *i* ]] && [ -z "$TMUX" ] && [ -t 1 ] && command -v tmux >/dev/null 2>&1
then
    exec tmux
fi

export PS1='\w \$ '
export EDITOR=vim
export GIT_EDITOR=$EDITOR
export FORCE_COLOR=1
export PATH="$HOME/.bin:$PATH"
export PATH="$HOME/.local/bin:$PATH" # Default path for Claude.

export LSCOLORS="GxFxcxdxbxegedabagacad"
alias ls='ls -G'

alias dp='docker ps --format "table {{.Names}}\t{{.Status}}" #'
alias lynx='lynx -accept_all_cookies'
alias todo="$EDITOR $HOME/.todo #"

diff() {
    command diff -u --color=auto "$@"
}

if [ -f ~/.motd ]
then
    cat ~/.motd | head -n 1
fi

if [ -f ~/.local.bashrc ]
then
    source ~/.local.bashrc
fi
