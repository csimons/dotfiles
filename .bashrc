#!/usr/bin/env bash

export PS1='\w\$ '
export EDITOR=vim
export GIT_EDITOR=$EDITOR

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

site() {
    if [ $# -eq 0 ]
    then
        ssh $NFSN_USER@$NFSN_DOMAIN
    elif [ $# -eq 2 ]
    then
        if [ "$1" == "up" ]
        then
            scp $2 $NFSN_USER@$NFSN_DOMAIN:~/
        elif [ "$1" == "down" ]
        then
            scp $NFSN_USER@$NFSN_DOMAIN:~/$2 .
        else
            echo 'usage: site [ ( up | down ) FILE ]'
            return 1
        fi
    else
        echo 'usage: site [ ( up | down ) FILE ]'
        return 1
    fi
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

if [ -f ~/.motd ]
then
    cat ~/.motd
fi

if [ -f ~/.bashrc.local ]
then
    source ~/.bashrc.local
fi
