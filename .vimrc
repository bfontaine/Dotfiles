set nocompatible " no compatible with VI

filetype off
call pathogen#infect()
" call pathogen#helptags()
filetype on
filetype plugin indent on

set autoindent                  " auto-indentation
set autoread                    " auto re-read when a file is changed outside
set backspace=indent,eol,start  " allow backspace on everything in insert mode
set backup                      " keep a backup file
" set colorcolumn=80            " color 80th column
set cursorline                  " highlight current line
set encoding=utf-8              " set UTF-8 encoding
set expandtab                   " replace tabs with spaces
set ff=unix                     " default file types: UNIX
set formatoptions+=n            " recognize lists when formatting text
set hidden                      " buffers can exists in bg w/o being in a window
set history=100                 " more command history
set hlsearch                    " highlight current search
set ignorecase                  " ignore case for '/regex' search
set incsearch                   " incremental search with '/regex' search
set linebreak                   " don't wrap text in the middle of a word
set magic                       " set magic for regex
set noautoread                  " don't re-read a file changed outside of Vim
set nolazyredraw                " turn off lazy redraw
set number                      " display line numbers
set numberwidth=1               " use only 1 column (+ 1 space) while possible
set nospell                     " do not use spell checking
set pumheight=10                " size of completion window: 10 lines
set ruler                       " show the cursor position all the time
set scrolloff=3                 " keep 3 context lines above/below the cursor
set shell=/bin/bash             " set Bash shell
set shiftwidth=4                " use 4-spaces indentation
set showcmd                     " show current incomplete command
set smartcase                   " check case if upper case chars in /regex
set smartindent                 " no autoindent when starting a new line
set softtabstop=4               " 1 tab = 4 spaces
set spelllang=fr,en             " Spell languages: FRench, ENglish
set suffixes=,*.aux,*.toc       " last used files when tab completing
set tabpagemax=10               " only show 10 tabs
set tabstop=4                   " 1 tab = 4 spaces
" set textwidth=80              " text width = 80 characters
set timeout                     " Wait max 1sec for :mappings
set title                       " show title in console title bar
set undodir=~/.vim/backups      " keep undo history accross sessions
set undofile                    " see 'undodir'
set wildignore=*~,*.swp,*.class " files to ignore when tab completing
set wildmenu                    " show completion possibilities in command mode


" -- functions --

fun Set_indent(width)
    execute "set tabstop=".a:width
    execute "set softtabstop=".a:width
    execute "set shiftwidth=".a:width
endf

fun Use_c()
    set omnifunc=ccomplete#Complete
    " Need 'alternate' plugin
    nnoremap <leader>s :A<cr>
endf

fun Use_css()
    inoremap : :;<left>
    set omnifunc=csscomplete#CompleteCSS
endf

fun Use_html()
    " puts a 'Lorem Ipsum' <p> block on the line
    " under the current one. You need 'lorem' program,
    " download the package 'libtext-lorem-perl' for Ubuntu
    nnoremap <leader>l o<p><esc>:r!lorem<cr>kJxA</p><esc>
    set omnifunc=htmlcomplete#CompleteTags
endf

fun Use_java()
    set omnifunc=javacomplete#Complete
    set foldmethod=indent
    set foldlevel=1
endfun

fun Use_js()
    inoremap <leader>l console.log();<left><left>
    set omnifunc=javascriptcomplete#CompleteJS
endf

fun Use_python()
    "set omnifunc=python3complete#Complete
    set omnifunc=pythoncomplete#Complete
endf

fun Candy()
    colorscheme candycode
    :hi CursorLine cterm=NONE ctermbg=DarkCyan ctermfg=NONE
endf

colorscheme 256-jungle
:hi CursorLine cterm=NONE ctermbg=black ctermfg=NONE

if has("autocmd")

    " files type
    autocmd BufNewFile,BufRead *.bf,*.brainfuck set filetype=brainfuck
    autocmd BufNewFile,BufRead *.json set filetype=json 
    autocmd BufNewFile,BufRead *.mustache set filetype=mustache

    autocmd FileType txt,markdown set tw=80
    autocmd FileType ocaml,scala,sql call Set_indent(2)
    autocmd FileType ruby,coffeescript inoremap #{ #{}<left>
    autocmd FileType css,markdown,sql,vim,txt call Candy()

    autocmd FileType c call Use_c()
    autocmd FileType css call Use_css()
    autocmd FileType html call Use_html()
    autocmd FileType java call Use_java()
    autocmd FileType javascript call Use_js()
    autocmd FileType json set nocursorline
    autocmd FileType php set omnifunc=phpcomplete#CompletePHP
    autocmd FileType python call Use_python()
    autocmd FileType ruby set omnifunc=rubycomplete#Complete
    autocmd FileType sql set omnifunc=sqlcomplete#Complete
    autocmd FileType txt set spell
    " autocmd FileType xml set omnifunc=xmlcomplete#CompleteTags

    " mutt
    autocmd BufRead /tmp/mutt* set tw=72

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

" completing
inoremap <c-f> <c-x><c-f>

" saving
inoremap <leader>w <esc>:w<cr>a

" moving into the file
inoremap <leader>z <esc>zza
inoremap <leader>o <esc>o
inoremap <leader>O <esc>O
inoremap <leader>A <esc>A
nnoremap <leader>z :set scrolloff=100<cr>
nnoremap <leader>Z :set scrolloff=3<cr>

" command line like Bash
cnoremap <c-a> <Home>
inoremap <c-a> <esc>^i
cnoremap <c-e> <End>
inoremap <c-e> <esc>$a
noremap <c-e> $

" windows
noremap <c-j> <c-w>j
noremap <c-k> <c-w>k
noremap <c-h> <c-w>h
noremap <c-l> <c-w>l

" tabs
noremap <c-down> :tabn<cr>
noremap <c-up> :tabp<cr>
inoremap <c-down> <esc>:tabn<cr>
inoremap <c-up> <esc>:tabp<cr>

noremap <leader>T :tabnew<cr>
nnoremap gt <c-w>gf

" search
nnoremap <leader><space> :set nohlsearch!<cr>

" sort
vnoremap <leader>s :sort u<cr>

" hack to redraw the console screen
nnoremap <c-r> :!clear<cr><cr>

nnoremap ; A;

" - plugins options/mappings -

" DelimitMate
let delimitMate_expand_cr=1
" Gundo
nnoremap <leader>g :GundoToggle<cr>
" NERDTree
nnoremap <leader>n :NERDTreeToggle<cr>
" Taglist
nnoremap <leader>t :TlistToggle<cr>



" -- Command Aliasing --
command W :w
command WQ :wq
command Clr !rm -f *~
" strip trailing whitespaces
command Strip :%s/ \+$//gc

