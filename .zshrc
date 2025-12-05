#!/usr/bin/env zsh

export PS1='%~ %# '
export EDITOR=vim
export GIT_EDITOR=$EDITOR
export FORCE_COLOR=1
export PATH="$HOME/.bin:$PATH"

alias dp='docker ps --format "table {{.Names}}\t{{.Status}}" #'
alias gdiff='diff -u --color=always'
alias lynx='lynx -accept_all_cookies'
alias todo="$EDITOR $HOME/.todo #"

########## BEGIN: MAKE ZSH MORE LIKE BASH

bindkey -e # Enable control-A/E etc. when EDITOR set to vim.
bindkey "^[[3~" delete-char # Fix delete key.
setopt interactivecomments # Allow comments in interactive shell.

#setopt autolist
unsetopt autolist
unsetopt menucomplete
#setopt noautomenu

bindkey "^F" forward-word
bindkey "^W" forward-word
bindkey "^B" backward-word
bindkey "^U" backward-kill-line

########## END: MAKE ZSH MORE LIKE BASH

HISTFILE="$HOME/.zsh_history"
HISTSIZE=1000000
SAVEHIST=1000000
setopt INC_APPEND_HISTORY        # Write to the history file immediately, not when the shell exits.
setopt SHARE_HISTORY             # Share history between all sessions.
setopt HIST_EXPIRE_DUPS_FIRST    # Expire duplicate entries first when trimming history.
setopt HIST_IGNORE_DUPS          # Don't record an entry that was just recorded again.
setopt HIST_IGNORE_ALL_DUPS      # Delete old recorded entry if new entry is a duplicate.
setopt HIST_FIND_NO_DUPS         # Do not display a line previously found.
setopt HIST_IGNORE_SPACE         # Don't record an entry starting with a space.
setopt HIST_SAVE_NO_DUPS         # Don't write duplicate entries in the history file.
setopt HIST_REDUCE_BLANKS        # Remove superfluous blanks before recording entry.
setopt HIST_VERIFY               # Don't execute immediately upon history expansion.
setopt HIST_BEEP                 # Beep when accessing nonexistent history.

if [ -f ~/.motd ]
then
    cat ~/.motd | head -n 1
fi

if [ -f ~/.local.zshrc ]
then
    source ~/.local.zshrc
fi
