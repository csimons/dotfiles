set fileencodings=utf-8

syntax on                " Syntax highlighting.
set autoindent           " Auto-indent upon opening new line.
set colorcolumn=72,80    " Show width boundary.
highlight ColorColumn ctermbg=red

set hlsearch             " Highlight search term matches.
set showmatch            " Show matching bracket.

set ruler                " Show line/column.
set showcmd              " Show partial commands at bottom.
"set cursorline           " Highlight current line.
set scrolloff=10         " Keep at least N lines above/below cursor.
set sidescrolloff=10     " Keep at least N lines left/right of cursor.

set list                             " Show whitespace.
set listchars=tab:>-,trail:~         " Whitespace display modifications.
highlight NonText ctermfg=red ctermbg=none
highlight SpecialKey ctermfg=red ctermbg=none

" File tab-completion modifications.
set wildignore=.git,.svn,**/target/*,tags,**/*.zip,**/*.jar

autocmd BufRead,BufNewFile *.1            set filetype=roff
autocmd BufRead,BufNewFile *.bash         set filetype=sh
autocmd BufRead,BufNewFile *.bashrc       set filetype=sh
autocmd BufRead,BufNewFile *.buf          set filetype=sql
autocmd BufRead,BufNewFile *.c            set filetype=c
autocmd BufRead,BufNewFile *.cpp          set filetype=cpp
autocmd BufRead,BufNewFile *.erb          set filetype=eruby
autocmd BufRead,BufNewFile *.fn           set filetype=sql
autocmd BufRead,BufNewFile *.fnc          set filetype=sql
autocmd BufRead,BufNewFile *.ftl          set filetype=html
autocmd BufRead,BufNewFile *.go           set filetype=go
autocmd BufRead,BufNewFile *.h            set filetype=c
autocmd BufRead,BufNewFile *.hpp          set filetype=cpp
autocmd BufRead,BufNewFile *.htm          set filetype=html
autocmd BufRead,BufNewFile *.html         set filetype=html
autocmd BufRead,BufNewFile *.inc          set filetype=cpp
autocmd BufRead,BufNewFile *.java         set filetype=java
autocmd BufRead,BufNewFile *.js           set filetype=javascript
autocmd BufRead,BufNewFile *.json         set filetype=json
autocmd BufRead,BufNewFile *.log          set filetype=log
autocmd BufRead,BufNewFile *.pkb          set filetype=sql
autocmd BufRead,BufNewFile *.prc          set filetype=sql
autocmd BufRead,BufNewFile *.py           set filetype=python
autocmd BufRead,BufNewFile *.rb           set filetype=ruby
autocmd BufRead,BufNewFile *.rs           set filetype=rust
autocmd BufRead,BufNewFile *.md           set filetype=text
autocmd BufRead,BufNewFile *.sh           set filetype=sh
autocmd BufRead,BufNewFile *.shtml        set filetype=html
autocmd BufRead,BufNewFile *.tbl          set filetype=table
autocmd BufRead,BufNewFile *.tex          set filetype=tex
autocmd BufRead,BufNewFile *.ts           set filetype=typescript
autocmd BufRead,BufNewFile *.txt          set filetype=text
autocmd BufRead,BufNewFile *.vimrc        set filetype=vim
autocmd BufRead,BufNewFile *.vw           set filetype=sql

autocmd BufRead,BufNewFile .plan          set filetype=text
autocmd BufRead,BufNewFile .todo          set filetype=todo
autocmd BufRead,BufNewFile COMMIT_EDITMSG set filetype=gitcommit
autocmd BufRead,BufNewFile Dockerfile     set filetype=dockerfile
autocmd BufRead,BufNewFile Plan           set filetype=text
autocmd BufRead,BufNewFile README         set filetype=text
autocmd BufRead,BufNewFile README.txt     set filetype=readme

autocmd FileType c          set tabstop=8 softtabstop=8 noexpandtab number
autocmd FileType cpp        set tabstop=4 softtabstop=4 expandtab number
autocmd FileType dockerfile set tabstop=4 softtabstop=4 expandtab
autocmd FileType eruby      set tabstop=2 softtabstop=2 expandtab
autocmd FileType gitcommit  set tabstop=4 softtabstop=4 expandtab
                            \ textwidth=71 colorcolumn=50,72
autocmd FileType go         set tabstop=8 softtabstop=8 noexpandtab number
autocmd FileType html       set tabstop=4 noexpandtab number nowrap
autocmd FileType java       set tabstop=4 softtabstop=4 noexpandtab number
autocmd FileType javascript set tabstop=2 softtabstop=2 expandtab number
                            \ wildignore+=node_modules/**
autocmd FileType json       set tabstop=4 softtabstop=4 expandtab
                            \ colorcolumn=0 textwidth=0
autocmd FileType log        set tabstop=4 softtabstop=4 expandtab number
autocmd FileType ora        set tabstop=2 softtabstop=2 expandtab
autocmd FileType php        set tabstop=4 softtabstop=4 expandtab number
autocmd FileType python     set tabstop=4 softtabstop=4 expandtab number
autocmd FileType readme     set tabstop=4 softtabstop=4 expandtab
autocmd FileType roff       set tabstop=4 softtabstop=4 expandtab textwidth=71
autocmd FileType ruby       set tabstop=2 softtabstop=2 expandtab
autocmd FileType rust       set tabstop=4 softtabstop=4 expandtab number
autocmd FileType sh         set tabstop=4 softtabstop=4 expandtab number
autocmd FileType sql        set tabstop=4 softtabstop=4 expandtab number
autocmd FileType table      set tabstop=4 softtabstop=4 expandtab
                            \ textwidth=0 colorcolumn=0
autocmd FileType tex        set textwidth=71 " Wrap after N characters.
autocmd FileType text       set tabstop=4 softtabstop=4 expandtab textwidth=71
autocmd FileType todo       set tabstop=4 softtabstop=4 expandtab textwidth=71
autocmd FileType typescript set tabstop=4 softtabstop=4 expandtab number
                            \ wildignore+=node_modules/**
autocmd FileType vim        set tabstop=4 softtabstop=4 expandtab
autocmd FileType xml        set tabstop=4 softtabstop=4 noexpandtab
autocmd FileType yaml       set tabstop=2 softtabstop=2 expandtab

map <C-g> :vimgrep <cword>    % <bar> :cw <Enter>
map <C-h> :vimgrep <cword> **/* <bar> :cw <Enter>

if filereadable(".local.vimrc")
    source .local.vimrc
endif
