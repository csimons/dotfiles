#!/usr/bin/env bash

export PS1='\w \$ '
export EDITOR=vim
export GIT_EDITOR=$EDITOR
export FORCE_COLOR=1
export PATH="$HOME/.bin:$PATH"

alias gdiff='diff -u --color=always'
alias lynx='lynx -accept_all_cookies'

libfind() {
    if [ $# -ne 2 ]
    then
        >&2 echo "usage: libfind SYMBOL ROOTPATH"
        return 1
    fi

    SYMBOL=$1
    ROOTPATH=$2

    for candidate in $(find $ROOTPATH -type f 2>&1 | egrep '\.(a|o|so|dylib)$')
    do
        count=$(nm -g $candidate 2>&1 | grep $SYMBOL | wc -l)
        if [ $count != 0 ]
        then
            echo $candidate
        fi
    done
}

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
