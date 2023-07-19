#!/usr/bin/env zsh

bindkey -e # Enable control-A/E etc. when EDITOR set to vim.
bindkey "^[[3~" delete-char # Fix delete key.
setopt interactivecomments # Allow comments in interactive shell.

# Make zsh tab-completion behave more like bash.
#setopt autolist
unsetopt autolist
unsetopt menucomplete
#setopt noautomenu

#export PS1='%1d %# '
export PS1='%~ %# '
export TERM=xterm
export EDITOR=vim
export GIT_EDITOR=$EDITOR
export FORCE_COLOR=1

todo() {
    vim $HOME/.todo
}

if [ -f ~/.motd ]
then
    cat ~/.motd | head -n 1
fi

if [ -f ~/.local.zshrc ]
then
    source ~/.local.zshrc
fi
