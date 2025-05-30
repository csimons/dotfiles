set fileencodings=utf-8

syntax on                " Syntax highlighting.
set autoindent           " Auto-indent upon opening new line.
set colorcolumn=72,80    " Show width boundary.

highlight ColorColumn ctermbg=gray
highlight Visual term=reverse cterm=reverse

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
highlight SpecialKey ctermfg=darkgray ctermbg=none

" File exclusions for tab-completion and search:
set wildignore=
set wildignore+=**/node_modules/*
set wildignore+=**/target/*
set wildignore+=*.jar
set wildignore+=*.pyc
set wildignore+=*.zip
set wildignore+=.git
set wildignore+=.svn
set wildignore+=tags

autocmd BufRead,BufNewFile *.1            set filetype=roff
autocmd BufRead,BufNewFile *.bash         set filetype=sh
autocmd BufRead,BufNewFile *.bashrc       set filetype=sh
autocmd BufRead,BufNewFile *.buf          set filetype=sql
autocmd BufRead,BufNewFile *.c            set filetype=c
autocmd BufRead,BufNewFile *.cpp          set filetype=cpp
autocmd BufRead,BufNewFile *.erb          set filetype=eruby
autocmd BufRead,BufNewFile *.feature      set filetype=feature
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
autocmd BufRead,BufNewFile *.nomad        set filetype=nomad
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
autocmd BufRead,BufNewFile Makefile       set filetype=makefile
autocmd BufRead,BufNewFile Plan           set filetype=text
autocmd BufRead,BufNewFile README         set filetype=text
autocmd BufRead,BufNewFile README.txt     set filetype=readme

autocmd BufRead,BufNewFile Makefile       set filetype=makefile
autocmd BufRead,BufNewFile makefile       set filetype=makefile

set number
set textwidth=79
set tabstop=4 softtabstop=4 shiftwidth=4 expandtab

autocmd FileType makefile   set textwidth=71 ts=4 noexpandtab number

autocmd FileType c          set ts=8 sts=8 noexpandtab number
autocmd FileType go         set ts=8 sts=8 noexpandtab number
autocmd FileType gitcommit  set textwidth=71 colorcolumn=50,72
autocmd FileType makefile   set ts=8 sts=8 noexpandtab number
autocmd FileType html       set nowrap
autocmd FileType java       set ts=4 sts=4 expandtab number
autocmd FileType javascript set ts=2 sts=2 expandtab number
autocmd FileType text       set textwidth=71 ts=4 sts=4 expandtab number
autocmd FileType todo       set textwidth=71 ts=4 sts=4 expandtab number
autocmd FileType typescript set ts=4 sts=4 expandtab number
autocmd FileType eruby      set ts=2 sts=2 expandtab
autocmd FileType feature    set ts=2 sts=2 expandtab
autocmd FileType nomad      set ts=2 sts=2 expandtab
autocmd FileType ruby       set ts=2 sts=2 expandtab
autocmd FileType tex        set ts=4 sts=4 expandtab
autocmd FileType yaml       set ts=2 sts=2 expandtab

map <C-g> :vimgrep <cword>    % <bar> :cw <Enter>
map <C-h> :vimgrep <cword> **/* <bar> :cw <Enter>

" Requires vim-plug, Node.js:
if filereadable(expand("~/.vim/autoload/plug.vim"))
    "call plug#begin('~/.vim/plugged')
    "Plug 'neoclide/coc.nvim', {'branch': 'release'}
    "call plug#end()

    " One-time setup:
    " sh    $ rustup component add rust-analyzer
    " vim   :PlugInstall
    " vim   :CocInstall coc-json
    " vim   :CocInstall coc-pyright
    " vim   :CocInstall coc-rust-analyzer

    "source $HOME/.coc.vimrc
endif

if filereadable(".local.vimrc")
    source .local.vimrc
endif
