#!/usr/bin/env bash

export PS1='\w \$ '
export EDITOR=vim
export GIT_EDITOR=$EDITOR
export FORCE_COLOR=1
export PATH=~/bin:$PATH

alias lynx='lynx -accept_all_cookies'

countdown() {
    if [ $# -ne 1 ]
    then
        >&2 echo 'usage: countdown SECONDS'
        return 1
    fi

    local n=$1
    while [ $n -gt 0 ]
    do
        echo $n
        local n=$((n - 1))
        sleep 1
    done
}

dirsloc() {
    for i in $(ls)
    do
        if [ -d "$i" ]
        then
            cd "$i"
            echo $(cat $(find . -type f | egrep -v '(\.git|\.svn|target| |jpg|gif|png|ttf|woff|eot)') | wc -l)	$i
            cd - >/dev/null
        fi
    done
}

gdiff() {
    if [ $# -ne 2 ]
    then
        >&2 echo 'usage: gdiff BASE_FILE OTHER_FILE'
        return 1
    fi

    diff -u --color=always $1 $2
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

    git filter-branch -f --env-filter '
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

lsdiff() {
    msg='usage: lsdiff [-r] DIR1 DIR2'

    recursive=0
    if [ "$#" == '3' ] && [ "$1" == '-r' ]
    then
        recursive=1
        dirA="$2"
        dirB="$3"
    elif [ "$#" == '2' ]
    then
        dirA="$1"
        dirB="$2"
    else
        >&2 echo $msg
        return 1
    fi

    if [ ! -d "$dirA" ]
    then
        >&2 echo $msg
        return 1
    fi

    if [ ! -d "$dirB" ]
    then
        >&2 echo $msg
        return 1
    fi

    a=$(mktemp)
    b=$(mktemp)

    pushd "$dirA" >/dev/null
    if [ "$recursive" == '1' ]
    then
        find . | sort > $a
    else
        ls | sort > $a
    fi
    popd >/dev/null

    pushd "$dirB" >/dev/null
    if [ "$recursive" == '1' ]
    then
        find . | sort > $b
    else
        ls | sort > $b
    fi
    popd >/dev/null

    if hash git 2>/dev/null
    then
        git diff --no-index -- $a $b
    else
        diff $a $b
    fi

    rm $a
    rm $b
}

monitor() {
    while true
    do
        bash -c "$*"
        sleep 2
    done
}

mvn() {
    if [ $# -lt 1 ]
    then
        >&2 echo "usage: mvn <args>"
        return 1
    elif [ -z "$MAVEN_HOME" ]
    then
        >&2 echo '$MAVEN_HOME is not set'
        return 1
    elif [ -f './mvnw' ]
    then
        echo "changing command to the following: ./mvnw $*"
        ./mvnw $*
    else
        echo "no wrapper found; executing: ${MAVEN_HOME}/bin/mvn $*"
        $MAVEN_HOME/bin/mvn $*
    fi
}

sloc-dir() {
    for i in $(ls --color=no | sort)
    do
        if [ -d "$i" ]
        then
            pushd "$i" > /dev/null
            echo "$(sloc) $i"
            popd > /dev/null
        fi
    done
}

slog() {
    svn log --stop-on-copy $* | less
}

timer() {
    if [ $# -ne 0 ]
    then
        >&2 echo 'usage: timer'
        return 1
    fi

    local n=0
    while [ 1 -eq 1 ]
    do
        echo $n
        local n=$((n + 1))
        sleep 1
    done
}

todo() {
    $EDITOR ~/.todo
}

winjdk-unpack() {
    if [ "$#" -ne '1' ]
    then
        >&2 echo 'usage: winjdk-unpack FILENAME'
        return 1
    fi

    if [ ! -f "$1" ]
    then
        >&2 echo "file not found: $1"
        return 1
    fi

    tmpdir="$1__unpack"

    if [ -d $tmpdir ]
    then
        >&2 echo "$tmpdir/ already exists.  Aborting."
        return 1
    fi

    mkdir $tmpdir
    cd $tmpdir

    echo -n "Unpacking CAB ... "
    cabextract ../$1 > /dev/null 2>&1
    if [ "$?" -ne '0' ]
    then
        echo 'failed.  Aborting.'
        return 1
    fi
    rm COPYRIGHT jaureg jre.exe jucheck jusched src.zip
    if [ "$?" -ne '0' ]
    then
        echo 'failed.  Aborting.'
        return 1
    fi
    echo "ok."

    echo -n "Unpacking JDK tools ... "
    unzip tools.zip > /dev/null 2>&1
    if [ "$?" -ne '0' ]
    then
        echo 'failed.  Aborting.'
        return 1
    fi
    rm tools.zip
    if [ "$?" -ne '0' ]
    then
        echo 'failed.  Aborting.'
        return 1
    fi
    echo "ok."

    echo -n "Unpacking JDK pack files ... "
    for packfile in $(find . -type f -name '*.pack')
    do
        base=${packfile%\.*};
        ./jre/bin/unpack200.exe "$base.pack" "$base.jar"
        if [ "$?" -ne '0' ]
        then
            echo 'failed.  Aborting.'
            return 1
        fi
    done
    echo "ok."

    cd ..
}

if [ -f ~/.motd ]
then
    cat ~/.motd | head -n 1
fi

if [ -f ~/.local.bashrc ]
then
    source ~/.local.bashrc
fi
