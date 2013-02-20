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
set formatoptions+=n            " recognize lists when formatting text
set hidden                      " buffers can exists in bg w/o being in a window
set history=100                 " more command history
set hlsearch                    " highlight current search
set ignorecase                  " ignore case for '/regex' search
set incsearch                   " incremental search with '/regex' search
set linebreak                   " don't wrap text in the middle of a word
set magic                       " set magic for regex
set modelines=0                 " no modelines
set noautoread                  " don't re-read a file changed outside of Vim
set nolazyredraw                " turn off lazy redraw
set number                      " display line numbers
set numberwidth=1               " use only 1 column (+ 1 space) while possible
set nospell                     " do not use spell checking
set pumheight=10                " size of completion window: 10 lines
set ruler                       " show the cursor position all the time
set scrolloff=5                 " keep 3 context lines above/below the cursor
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
set wildignore+=*.o,.git/**
set wildmenu                    " show completion possibilities in command mode

" -- Colorscheme

colorscheme 256-jungle
:hi CursorLine cterm=NONE ctermbg=black ctermfg=NONE

" -- Global Mappings --

inoremap jj <esc>

let mapleader = ","

" get used to hjkl
" nnoremap <up> <nop>
" inoremap <up> <nop>
" vnoremap <up> <nop>
" nnoremap <down> <nop>
" inoremap <down> <nop>
" vnoremap <down> <nop>
" nnoremap <left> <nop>
" inoremap <left> <nop>
" vnoremap <left> <nop>
" nnoremap <right> <nop>
" inoremap <right> <nop>
" vnoremap <right> <nop>

" move up and down on long wrapped lines
nnoremap j gj
nnoremap k gk

" avoid errors
nnoremap <f1> <esc>
inoremap <f1> <esc>
vnoremap <f1> <esc>

" open dotfiles
nnoremap <leader>db :tabnew ~/.bashrc<cr>
nnoremap <leader>dc :tabnew ~/.curlrc<cr>
nnoremap <leader>dg :tabnew ~/.gitconfig<cr>
nnoremap <leader>dm :tabnew ~/.muttrc<cr>
nnoremap <leader>ds :tabnew ~/.ssh/config<cr>
nnoremap <leader>dv :tabnew ~/.vimrc<cr>

" toggle paste mode
nnoremap <leader>p :set paste!<cr>

" saving
inoremap <leader>w <esc>:w<cr>a

" moving into the file
inoremap <leader>z <esc>zza
inoremap <leader>A <esc>A
nnoremap <leader>z :set scrolloff=100<cr>
nnoremap <leader>Z :set scrolloff=3<cr>
nnoremap <space> <c-d>

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

" redraw the console screen (<c-l> has been remapped)
nnoremap L :redraw<cr>

" Adding a ';' at the end of the current line
nnoremap ; A;

" showing trailing spaces at the end of lines
nnoremap <leader>$ :set list!<cr>

" - plugins options/mappings -

" Command T
nnoremap <leader>f :CommandT<CR>
let g:CommandTMaxFiles=2000
let g:CommandTMaxHeight=25

" DelimitMate
let delimitMate_expand_cr=1
" CSS colors
let g:cssColorVimDoNotMessMyUpdatetime = 1
" Gundo
nnoremap <leader>g :GundoToggle<cr>
" NERDTree
nnoremap <leader>n :NERDTreeToggle<cr>
" Numbers
nnoremap <F3> :NumbersToggle<cr>
" Powerline
let g:Powerline_symbols='fancy'
set laststatus=2
" Tabular
vnoremap <leader>t :Tabular<space>
" Taglist
nnoremap <leader>t :TlistToggle<cr>
" Zencoding
" au FileType htmljinja,html,xhtml"
let g:user_zen_expandabbr_key='<leader>h'


" -- Command Aliasing --
" saving
command W :w
command WQ :wq
command SudoW :w !sudo tee % > /dev/null
" misc
command Clr !rm -f *~
" strip trailing whitespaces
command Strip :%s/ \+$//gc

" -- functions --

fun Set_indent(width)
    execute "set tabstop=".a:width
    execute "set softtabstop=".a:width
    execute "set shiftwidth=".a:width
endf

"fun Load_skeleton(name)
"    if glob("~/.vim/skeletons/".a:name) != ""
"        execute "0r ~/.vim/skeletons/".a:name
"    endif
"endf

fun Use_css()
    set ofu=csscomplete#CompleteCSS
endf

fun Use_html()
    " puts a 'Lorem Ipsum' <p> block on the line
    " under the current one. You need 'lorem' program,
    " download the package 'libtext-lorem-perl' for Ubuntu
    nnoremap <leader>l o<p><esc>:r!lorem<cr>kJxA</p><esc>
    set ofu=htmlcomplete#CompleteTags
endf

fun Use_js()
    inoremap <leader>c console.log();<left><left>
    set ofu=javascriptcomplete#CompleteJS
    let b:delimitMate_expand_space=1
endf

fun Use_markdown()
    " make titles
    inoremap <leader>H- <esc>yypVr-ki
    inoremap <leader>H= <esc>yypVr=ki
endf

fun Candy()
    colorscheme candycode
    :hi CursorLine cterm=NONE ctermbg=DarkCyan ctermfg=NONE
endf

if has("autocmd")

    " filetypes
    " - general
    au BufNewFile,BufRead *.bf,*.brainfuck set ft=brainfuck
    au BufNewFile,BufRead *.e,*.E          set ft=e
    au BufNewFile,BufRead *.ft,*.fh,*.fth  set ft=forth
    au BufNewFile,BufRead *.go             set ft=go
    au BufNewFile,BufRead *.groovy         set ft=groovy
    au BufNewFile,BufRead *.gs             set ft=golfscript
    au BufNewFile,BufRead *.io             set ft=io
    au BufNewFile,BufRead *.json           set ft=json
    au BufNewFile,BufRead *.liquid         set ft=liquid
    au BufNewFile,BufRead *.mustache       set ft=mustache
    au BufNewFile,BufRead *.omgrofl        set ft=omgrofl
    " - perso
    au BufNewFile,BufRead */templates/*.html set ft=htmljinja

    " autocomplete
    au FileType c          set ofu=ccomplete#Complete
    au FileType java       set ofu=javacomplete#Complete
    au FileType php        set ofu=phpcomplete#CompletePHP
    au FileType python     set ofu=pythoncomplete#Complete
    au FileType ruby       set ofu=rubycomplete#Complete
    au FileType sql        set ofu=sqlcomplete#Complete
    au FileType xml        set ofu=xmlcomplete#CompleteTags

    " filetypes settings
    au FileType markdown,txt set tw=80
    au FileType lisp,ocaml,scala,sql,yaml call Set_indent(2)
    au FileType css,javascript,markdown,sql,vim,txt call Candy()

    au FileType ruby,coffeescript nnoremap <leader>s viwc#{<c-r>"}<esc>

    au FileType css        call Use_css()
    au FileType html       call Use_html()
    au FileType javascript call Use_js()
    au FileType json       set nocursorline
    au FileType lisp       let b:delimitMate_quotes = "\""
    au FileType markdown   call Use_markdown()
    au FileType txt        set spell
    au FileType xml        set fdm=indent fdl=1

    " mutt
    au BufRead /tmp/mutt* set tw=72

    " files skeletons
    au BufNewFile *.c      0r ~/.vim/skeletons/c.c
    au BufNewFile *.cpp    0r ~/.vim/skeletons/cpp.cpp
    au BufNewFile *.e,*.E  0r ~/.vim/skeletons/e.e
    au BufNewFile *.groovy 0r ~/.vim/skeletons/groovy.groovy
    au BufNewFile *.html   0r ~/.vim/skeletons/html.html
    au BufNewFile *.io     0r ~/.vim/skeletons/io.io
    au BufNewFile *.pl     0r ~/.vim/skeletons/perl.pl
    au BufNewFile *.php    0r ~/.vim/skeletons/php.php
    au BufNewFile *.py     0r ~/.vim/skeletons/python.py
    au BufNewFile *.rb     0r ~/.vim/skeletons/ruby.rb
    au BufNewFile *.sh     0r ~/.vim/skeletons/bash.sh

endif " has("autocmd")
