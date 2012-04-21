set nocompatible " no compatible with VI

filetype off
call pathogen#infect()
call pathogen#helptags()
filetype on
filetype plugin indent on

set autoindent                 " auto-indentation
set autoread                   " auto re-read when a file is changed outside
set backspace=indent,eol,start " allow backspace on everything in insert mode
set backup	                   " keep a backup file
" set bomb                     " set UTF-8 bomb
" set colorcolumn=80           " color 80th column
set encoding=utf-8             " set UTF-8 encoding
set expandtab                  " replace tabs with spaces
set ff=unix                    " default file types
set formatoptions+=n           " recognize lists when formatting text
set guicursor=a:blinkon0       " no cursor blinking
set hidden                     " buffers can exists in bg w/o being in a window
set history=100                " more command history
set hlsearch                   " highlight current search
set ignorecase                 " ignore case for '/regex' search
set incsearch                  " incremental search with '/regex' search
set linebreak                  " don't wrap text in the middle of a word
set magic                      " set magic for regex
set noautoread                 " don't re-read a file changed outside of Vim
set nolazyredraw               " turn off lazy redraw
set number                     " display line numbers
set numberwidth=1              " use only 1 column (+ 1 space) while possible
set pumheight=10               " size of completion window: 10 lines
set ruler                      " show the cursor position all the time
set scrolloff=3                " keep 3 context lines above/below the cursor
set shell=/bin/bash            " set Bash shell
set shiftwidth=4               " use 4-spaces indentation
set showcmd                    " show current incomplete command
set smartcase                  " check case if upper case chars in /regex
set smartindent                " no autoindent when starting a new line
set softtabstop=4              " 1 tab = 4 spaces
set suffixes=,*~,*.swp,*.class " files to ignore when tab completing
set suffixes+=*.pdf,*.aux,*.toc,*.dvi,*.ps,*.out,*.pyc,*.odt,*.docx,*.pptx
set suffixes+=*.zip,*.tgz,*.bz2,*.tbz2,*.tar,*.7z,*.txz
set tabpagemax=10              " only show 10 tabs
set tabstop=4                  " 1 tab = 4 spaces
set textwidth=80               " text width = 80 characters
set title                      " show title in console title bar
set undodir=~/.vim/backups     " keep undo history accross sessions
set undofile                   " see 'undodir'
set wildmenu                   " show completion possibilities in command mode

setlocal spelllang=fr,en
set nospell " default (no .txt)
autocmd FileType txt set spell

" -- functions --

fun Set_tab2()
    set tabstop=2
    set softtabstop=2
    set shiftwidth=2
endf

fun Use_ada()
    set omnifunc=adacomplete#Complete
endf

fun Use_c()
    set omnifunc=ccomplete#Complete
    " Need 'alternate' plugin
    nnoremap <leader>s :A<cr>
endf

fun Use_coffeescript()
    inoremap #{ #{}<left>
endf

fun Use_css()
    inoremap { {}<left>
    inoremap : :;<left>
    set omnifunc=csscomplete#CompleteCSS
endf

fun Use_html()
    " inoremap = =""<left>
    inoremap =" =""<left>
    " puts a 'Lorem Ipsum' <p> block on the line
    " under the current one. You need 'lorem' program,
    " download the package 'libtext-lorem-perl' for Ubuntu
    nnoremap <leader>l o<p><esc>:r!lorem<cr>kJxA</p><esc>
    set textwidth=0
    set omnifunc=htmlcomplete#CompleteTags
endf

fun Use_js()
    inoremap <leader>l console.log();<esc>hi
    inoremap ( ()<left>
    inoremap { {}<left>
    inoremap ' ''<left>
    inoremap " ""<left>
    set omnifunc=javascriptcomplete#CompleteJS
endf

fun Use_php()
    set omnifunc=phpcomplete#CompletePHP
endf

fun Use_python()
    "set omnifunc=python3complete#Complete
    set omnifunc=pythoncomplete#Complete
endf

fun Use_ruby()
    inoremap #{ #{}<left>
    set omnifunc=rubycomplete#Complete
endf

fun Use_sql()
    call Set_tab2()
    set omnifunc=sqlcomplete#Complete
endf

fun Use_xml()
    set textwidth=0
    set omnifunc=xmlcomplete#CompleteTags
endf

if has("autocmd")

    " files type
    autocmd BufNewFile,BufRead *.bf,*.brainfuck setlocal ft=brainfuck

    " mutt
    autocmd BufRead /tmp/mutt* set tw=72

    " completion
    autocmd FileType ada call Use_ada()
    autocmd FileType c call Use_c()
    autocmd FileType coffeescript call Use_coffeescript()
    autocmd FileType css call Use_css()
    autocmd FileType html call Use_html()
    autocmd FileType javascript call Use_js()
    autocmd FileType ocaml call Set_tab2()
    autocmd FileType php call Use_php()
    autocmd FileType python call Use_python()
    autocmd FileType ruby call Use_ruby()
    autocmd FileType scala call Set_tab2()
    autocmd FileType sql call Use_sql()
    autocmd FileType xml call Use_xml()

    " files skeletons
    autocmd BufNewFile *.c    0r ~/.vim/skeletons/c.c
    autocmd BufNewFile *.html 0r ~/.vim/skeletons/html.html
    autocmd BufNewFile *.php  0r ~/.vim/skeletons/php.php
    autocmd BufNewFile *.py   0r ~/.vim/skeletons/python.py
    autocmd BufNewFile *.rb   0r ~/.vim/skeletons/ruby.rb
    autocmd BufNewFile *.sh   0r ~/.vim/skeletons/bash.sh

endif " has("autocmd")

" -- Mappings --

inoremap jj <esc>

let mapleader = ","

" vimrc
nnoremap <leader>v :tabnew ~/.vimrc<cr>

" saving
inoremap <leader>w <esc>:w<cr>a
inoremap <leader>x <esc>:x<cr>

" centering
inoremap <leader>z <esc>zza

" command line like Bash
cnoremap <c-a> <Home>
cnoremap <c-e> <End>

" windows
noremap <c-j> <c-w>j
noremap <c-k> <c-w>k
noremap <c-h> <c-w>h
noremap <c-l> <c-w>l

" tabs
noremap <c-down> :tabn<cr>
noremap <c-up> :tabp<cr>
noremap <c-c> <c-t><c-c>
noremap <leader>tn :tabnew<cr>
nnoremap gt <c-w>gf

" search
nnoremap <leader><space> :nohlsearch<cr>

" sort
vnoremap <leader>s :sort u<cr>

" hack to redraw the console screen
nnoremap <c-r> :!clear<cr><cr>

" - plugins mappings -

" NERDTree
nnoremap <leader>n :NERDTreeToggle<cr>

" Gundo
nnoremap <leader>g :GundoToggle<cr>

" -- Command Aliasing --
command Reload source $MYVIMRC
command Clr !rm -f *~
command Mkdn !markdown % > %.html
" strip trailing whitespaces
command Strip :%s/ \+$//gc

colorscheme 256-jungle
