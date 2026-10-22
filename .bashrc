#!/usr/bin/env bash

if [ -f ~/.shrc ]
then
    source ~/.shrc
fi

export PS1='\w \$ '

if [ -f ~/.local.bashrc ]
then
    source ~/.local.bashrc
fi
