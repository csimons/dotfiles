#!/usr/bin/env bash

export PS1='\w \$ '
export EDITOR=vim
export GIT_EDITOR=$EDITOR
export FORCE_COLOR=1
export PATH="$HOME/.bin:$PATH"

alias gdiff='diff -u --color=always'
alias lynx='lynx -accept_all_cookies'

todo() {
    $EDITOR ~/.todo
}

if [ -f ~/.motd ]
then
    cat ~/.motd | head -n 1
fi

if [ -f ~/.local.bashrc ]
then
    source ~/.local.bashrc
fi
