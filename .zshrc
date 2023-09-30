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

git-author-rewrite() {
    # usage:
    #
    #   Adapted from https://help.github.com/articles/changing-author-info/
    #
    #     $ git clone --bare https://github.com/user/repo.git
    #     $ cd repo.git
    #     $ OLD_EMAIL=... NEW_NAME=... NEW_EMAIL=... git-author-rewrite
    #     $ # review git log here to verify expectations ...
    #     $ git push --force --tags origin 'refs/heads/*'
    #

    vars_msg='must be set: $OLD_EMAIL, $NEW_NAME, $NEW_EMAIL'

    if [ -z "$OLD_EMAIL" ]
    then
        >&2 echo $vars_msg
        return 1
    elif [ -z "$NEW_NAME" ]
    then
        >&2 echo $vars_msg
        return 1
    elif [ -z "$NEW_EMAIL" ]
    then
        >&2 echo $vars_msg
        return 1
    fi

    git filter-branch --env-filter '
if [ "$GIT_COMMITTER_EMAIL" = "$OLD_EMAIL" ]
then
    export GIT_COMMITTER_NAME="$NEW_NAME"
    export GIT_COMMITTER_EMAIL="$NEW_EMAIL"
fi
if [ "$GIT_AUTHOR_EMAIL" = "$OLD_EMAIL" ]
then
    export GIT_AUTHOR_NAME="$NEW_NAME"
    export GIT_AUTHOR_EMAIL="$NEW_EMAIL"
fi
' --tag-name-filter cat -- --branches --tags
}

if [ -f ~/.motd ]
then
    cat ~/.motd | head -n 1
fi

if [ -f ~/.local.zshrc ]
then
    source ~/.local.zshrc
fi
