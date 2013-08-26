set nocompatible " no compatible with VI

filetype off
call pathogen#infect()
" call pathogen#helptags()
filetype on
filetype plugin indent on

set autoindent                  " auto-indentation
set backspace=indent,eol,start  " allow backspace on everything in insert mode
set backup                      " keep a backup file
" set colorcolumn=80            " color 80th column
set cursorline                  " highlight current line
set encoding=utf-8              " set UTF-8 encoding
set expandtab                   " replace tabs with spaces
set ff=unix                     " default file types: UNIX
set foldmethod=manual           " manual folding
set formatoptions+=n            " recognize lists when formatting text
set hidden                      " buffers can exists in bg w/o being in a window
set history=15                  " more command history
set hlsearch                    " highlight current search
set ignorecase                  " ignore case for '/regex' search
set incsearch                   " incremental search with '/regex' search
set linebreak                   " don't wrap text in the middle of a word
set magic                       " set magic for regex
set modelines=0                 " no modelines
set noautoread                  " don't re-read a file changed outside of Vim
set lazyredraw                  " turn on lazy redraw (performance++)
set number                      " display line numbers
set numberwidth=1               " use only 1 column (+ 1 space) while possible
set nospell                     " do not use spell checking
set pumheight=10                " size of completion window: 10 lines
set ruler                       " show the cursor position all the time
set scrolloff=5                 " keep 5 context lines above/below the cursor
set shell=/bin/bash             " set Bash shell
set shiftwidth=4                " use 4-spaces indentation
set showcmd                     " show current incomplete command
set showmatch                   " show matching braces/brackets/etc
set smartcase                   " check case if upper case chars in /regex
set smartindent                 " no autoindent when starting a new line
set softtabstop=4               " 1 tab = 4 spaces
set spelllang=fr,en             " Spell languages: FRench, ENglish
set suffixes=,*.aux,*.toc,*lock " last used files when tab completing
set tabpagemax=8                " only show 8 tabs
set tabstop=4                   " 1 tab = 4 spaces
" set textwidth=80              " text width = 80 characters
set timeout                     " Wait max 1sec for :mappings
set title                       " show title in console title bar
set undodir=~/.vim/backups      " keep undo history accross sessions
set undofile
set wildignore=*~,*.swp,*.class " files to ignore when tab completing
set wildignore+=*.cmo,*.cmx
set wildignore+=*.o,.git/**
set wildmenu                    " show completion possibilities in command mode

syntax sync minlines=256
syntax sync maxlines=1024
syntax on

" -- Colorscheme

colorscheme 256-jungle
:hi CursorLine cterm=NONE ctermbg=black ctermfg=NONE

" -- Global Mappings --

inoremap jj <esc>

let mapleader = ","

" move up and down on long wrapped lines
nnoremap j gj
nnoremap k gk

" avoid errors
nnoremap <f1> <esc>
inoremap <f1> <esc>
vnoremap <f1> <esc>

" open dotfiles
nnoremap <leader>db :tabnew ~/.bashrc<cr>
nnoremap <leader>dg :tabnew ~/.gitconfig<cr>
nnoremap <leader>ds :tabnew ~/.ssh/config<cr>
nnoremap <leader>dv :tabnew ~/.vimrc<cr>

" toggle paste mode
nnoremap <leader>p <esc>:setlocal paste!<cr>

" saving
inoremap <leader>w <esc>:w<cr>a

" moving into the file
inoremap <leader>z <esc>zza
nnoremap <leader>z :set scrolloff=100<cr>
nnoremap <leader>Z :set scrolloff=3<cr>

" command line like Bash
cnoremap <c-a> <Home>
inoremap <c-a> <esc>^i
cnoremap <c-e> <End>
inoremap <c-e> <esc>$a
noremap  <c-e> $

" windows
noremap <c-left> <c-w>h
noremap <c-right> <c-w>l

" tabs
noremap <c-down> :tabn<cr>
noremap <c-up>   :tabp<cr>
inoremap <c-down> <esc>:tabn<cr>
inoremap <c-up>   <esc>:tabp<cr>

" When <c-up/down> is already mapped by the OS
noremap ÷ :tabp<cr>
nnoremap ≠ :tabn<cr>

noremap <leader>T :tabnew<cr>
nnoremap gt <c-w>gf

" search
nnoremap <leader><space> :setlocal nohlsearch!<cr>

" sort
vnoremap <leader>s :sort u<cr>

" showing trailing spaces at the end of lines
nnoremap <leader>$ :set list!<cr>

" - plugins options/mappings -

" Command T
nnoremap <leader>f :CommandT<CR>
let g:CommandTMaxFiles=2000
let g:CommandTMaxHeight=25

" DelimitMate
let delimitMate_expand_cr=1
" Closetag
au Filetype html,xhtml,xml,xsl,htmljinja so ~/.vim/scripts/closetag.vim 
" CSS colors
let g:cssColorVimDoNotMessMyUpdatetime=1
" Gundo
nnoremap <leader>g :GundoToggle<cr>
" NERDTree
nnoremap <leader>n :NERDTreeToggle<cr>
" Powerline
let g:Powerline_symbols='fancy'
set laststatus=2
" TableMode
" let g:table_mode_toggle_map = '<leader>-'
" Tabular
vnoremap <leader>t :Tabular<space>/
vnoremap <leader>{ :Tabular<space>/{<cr>gv:Tabular<space>/}<cr>
" Zencoding
" au FileType htmljinja,html,xhtml"
let g:user_zen_expandabbr_key='<leader>h'


" -- Command Aliasing --
" saving
command W :w
command WQ :wq

" -- functions --

fun Set_indent(width)
    execute "set tabstop=".a:width
    execute "set softtabstop=".a:width
    execute "set shiftwidth=".a:width
endf

fun Use_js()
    setlocal ofu=javascriptcomplete#CompleteJS
    let b:delimitMate_expand_space=1
endf

if has("autocmd")

    " filetypes
    " - general
    au BufNewFile,BufRead *.clap           set ft=clap
    au BufNewFile,BufRead *.conflicts      set ft=conflicts
    au BufNewFile,BufRead *.e,*.E          set ft=e
    au BufNewFile,BufRead *.ft,*.fh,*.fth  set ft=forth
    au BufNewFile,BufRead *.go             set ft=go
    au BufNewFile,BufRead *.io             set ft=io
    au BufNewFile,BufRead *.json           set ft=json
    au BufNewFile,BufRead *.liquid         set ft=liquid
    au BufNewFile,BufRead *.mustache       set ft=mustache
    " - perso
    au BufNewFile,BufRead */templates/*.html set ft=htmljinja

    " autocomplete
    au FileType c      setlocal ofu=ccomplete#Complete
    au FileType css    setlocal ofu=csscomplete#CompleteCSS
    au FileType java   setlocal ofu=javacomplete#Complete
    au FileType php    setlocal ofu=phpcomplete#CompletePHP
    au FileType python setlocal ofu=pythoncomplete#Complete
    au FileType ruby   setlocal ofu=rubycomplete#Complete
    au FileType sql    setlocal ofu=sqlcomplete#Complete
    au FileType xml    setlocal ofu=xmlcomplete#CompleteTags

    " filetypes settings
    au FileType markdown,txt set tw=80
    au FileType lisp,ocaml,ruby,scala,sql,yaml call Set_indent(2)
    au FileType css,javascript,markdown,sql,vim,txt colorscheme molokai

    au FileType javascript call Use_js()
    au FileType json       setlocal nocursorline
    au FileType lisp       let b:delimitMate_quotes = "\""
    au FileType txt        setlocal spell
    au FileType xml        setlocal fdm=indent fdl=1

    " mutt
    au BufRead /tmp/mutt* set tw=72

    " files skeletons
    au BufNewFile *.c     0r ~/.vim/skeletons/c.c
    au BufNewFile *.cpp   0r ~/.vim/skeletons/cpp.cpp
    au BufNewFile *.html  0r ~/.vim/skeletons/html.html
    au BufNewFile *.pl    0r ~/.vim/skeletons/perl.pl
    au BufNewFile *.php   0r ~/.vim/skeletons/php.php
    au BufNewFile *.py    0r ~/.vim/skeletons/python.py
    au BufNewFile *.rb    0r ~/.vim/skeletons/ruby.rb
    au BufNewFile *.sh    0r ~/.vim/skeletons/bash.sh

endif " has("autocmd")
