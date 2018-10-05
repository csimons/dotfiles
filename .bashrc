#!/usr/bin/env bash

export PS1='\w\$ '
export EDITOR=vim
export GIT_EDITOR=$EDITOR
export FORCE_COLOR=1
export PATH=~/bin:$PATH

alias lynx='lynx -accept_all_cookies'

countdown() {
    if [ $# -ne 1 ]
    then
        echo 'usage: countdown SECONDS'
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

gdiff() {
    if [ $# -ne 2 ]
    then
        echo 'usage: gdiff fileA fileB'
        return 1
    fi

    git diff --no-index --ignore-space-at-eol -- $1 $2
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
        echo $vars_msg
        return 1
    elif [ -z "$NEW_NAME" ]
    then
        echo $vars_msg
        return 1
    elif [ -z "$NEW_EMAIL" ]
    then
        echo $vars_msg
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

jarfind() {
    if [ "$#" -ne 1 ]
    then
        echo 'usage: jar-find filename'
        return 1
    fi

    local target=$1
    for filename in $(find . -type f -name '*.jar')
    do
        for hit in $(jar tf $filename | grep $target)
        do
            echo "$filename: $hit"
        done
    done
}

lclean() {
    rm -f \
        *-blx.bib \
        *.aux \
        *.bbl \
        *.bcf \
        *.blg \
        *.dvi \
        *.fdb_latexmk \
        *.fls \
        *.log \
        *.etd \
        *.doc \
        *.out \
        *.pdf \
        *.ps \
        *.run.xml \
        *.tex.blg
}

lmake() {
    if [ $# -ne 1 ]
    then
        echo "usage: $0 TEX_FILE"
        return 1
    elif [ -z "$PDF_VIEWER" ]
    then
        echo '$PDF_VIEWER must be set to open PDFs'
        return 1
    else
        local rawName=${1%\.*}
        lclean

        pdflatex $rawName.tex
        local rc=$?

        if [ -f $rawName.bcf ]
        then
            biber $rawName
            pdflatex $rawName.tex
            local rc=$((rc + $?))
        fi

        if [ $rc -eq 0 ]
        then
            $PDF_VIEWER $rawName.pdf &
        fi
    fi
}

motd() {
    cat ~/.motd
}

mvn() {
    if [ $# -lt 1 ]
    then
        echo "usage: mvn <args>"
        return 1
    elif [ -z "$MAVEN_HOME" ]
    then
        echo '$MAVEN_HOME is not set'
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

site() {
    if [ -z "$NFSN_USER" ]
    then
        echo '$NFSN_USER is not set'
        return 1
    fi

    if [ -z "$NFSN_HOST" ]
    then
        echo '$NFSN_HOST is not set'
        return 1
    fi

    if [ $# -eq 0 ]
    then
        ssh $NFSN_USER@$NFSN_HOST
    elif [ $# -eq 2 ]
    then
        if [ "$1" == "up" ]
        then
            scp $2 $NFSN_USER@$NFSN_HOST:~/
        elif [ "$1" == "down" ]
        then
            scp $NFSN_USER@$NFSN_HOST:~/$2 .
        else
            echo 'usage: site [ ( up | down ) FILE ]'
            return 1
        fi
    else
        echo 'usage: site [ ( up | down ) FILE ]'
        return 1
    fi
}

sloc() {
    #
    # TODO: fix for directories with whitespace in their names
    #
    echo $(cat $(find . -type f | egrep -v '(\.git|\.svn|target| |jpg|gif|png|ttf|woff|eot)') | wc -l)
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
        echo 'usage: timer'
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
        echo 'usage: winjdk-unpack FILENAME'
        return 1
    fi

    if [ ! -f "$1" ]
    then
        echo "file not found: $1"
        return 1
    fi

    tmpdir="$1__unpack"

    if [ -d $tmpdir ]
    then
        echo "$tmpdir/ already exists.  Aborting."
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
