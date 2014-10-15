set nocompatible " no compatible with VI

filetype off
call pathogen#infect()
" call pathogen#helptags()
filetype plugin indent on

set background=dark             " dark background
set backspace=indent,eol,start  " allow backspace on everything in insert mode
set backup                      " keep a backup file
set cursorline                  " highlight current line
set encoding=utf-8              " set UTF-8 encoding
set ff=unix                     " default file types: UNIX
set foldmethod=manual           " manual folding
set formatoptions+=n            " recognize lists when formatting text
set grepprg=grep\ -nH\ $*       " always display filename when grepping
set hidden                      " buffers can exists in bg w/o being in a window
set history=40                  " more command history
set hlsearch                    " highlight current search
set ignorecase                  " ignore case for '/regex' search
set incsearch                   " incremental search with '/regex' search
set linebreak                   " don't wrap text in the middle of a word
set magic                       " set magic for regex
set matchtime=3                 " show the matching parent .3sec (default: .5)
set modelines=0                 " no modelines
set noautoread                  " don't re-read a file changed outside of Vim
set nofoldenable                " don't fold by default
set nojoinspaces                " use only one space after a dot
set lazyredraw                  " turn on lazy redraw (performance++)
set list                        " display unprintable chars (see listchars)
set listchars=tab:▸\ ,trail:·   " see 'list' above
set number                      " display line numbers
set numberwidth=1               " use only 1 column (+ 1 space) while possible
set nospell                     " do not use spell checking
set pumheight=10                " size of completion window: 10 lines
set ruler                       " show the cursor position all the time
set scrolloff=5                 " keep 5 context lines above/below the cursor
set shell=/bin/bash             " set Bash shell
set showcmd                     " show current incomplete command
set showmatch                   " show matching braces/brackets/etc
set smartcase                   " check case if upper case chars in /regex
set spelllang=en,fr             " spell languages: ENglish, FRench
set splitright                  " split windows on the right
set suffixes=,*.aux,*.toc,*lock " last used files when tab completing
set tabpagemax=8                " only show 8 tabs
set timeout                     " wait max 1sec for :mappings
set timeoutlen=800              " reduce waiting time to 0.8sec
set title                       " show title in console title bar
set undodir=~/.vim/backups      " keep undo history accross sessions
set undofile                    " see 'undodir' above
set virtualedit+=block          " virtual editing in visual block mode

" wildmenu

set wildmenu                    " show completion possibilities in command mode

set wildignore+=.hg,.git,.svn   " version control
set wildignore+=*.jpg,*.png     " images
set wildignore+=*.gif
set wildignore+=*~,*.sw?        " temporary/swap files
set wildignore+=.DS_Store
set wildignore+=*.o,*.cmo,*.cmx " compiled object files / bytecode
set wildignore+=*.pyc
set wildignore+=*.mo            " other compiled files
set wildignore+=*.odt,*.pdf     " other binary files
set wildignore+=venv,htmlcov    " directories
set wildignore+=__pycache__
set wildignore+=*.jar,*.zip     " archives / compressed files
set wildignore+=*.gz,*.tar

" indenting

set autoindent                  " auto-indentation
set expandtab                   " replace tabs with spaces
set smartindent                 " no autoindent when starting a new line
set shiftround                  " > & < cmds round the indent to a multpl of sw
set shiftwidth=2                " use 2-spaces indentation
set softtabstop=2               " 1 tab = 2 spaces
set tabstop=2                   " 1 tab = 2 spaces

" text width

set colorcolumn=+1              " color (textwidth + 1) th column
set textwidth=79                " text width = 79 columns

" syntax highlighting

syntax sync minlines=256
syntax sync maxlines=1024
syntax on

" -- Colorscheme

" the terminal has 256 colors
set t_Co=256

" Molokai looks better when we apply 256-jungle before it
colorscheme 256-jungle
colorscheme molokai
:hi CursorLine cterm=NONE ctermbg=black ctermfg=NONE

" -- Global Mappings --

let mapleader = ","

" move up and down on long wrapped lines
nnoremap j gj
nnoremap k gk

" avoid errors
nnoremap <f1> <esc>
inoremap <f1> <esc>
vnoremap <f1> <esc>

" disable the manual key
nnoremap K <nop>

" open dotfiles
nnoremap <leader>db :tabnew ~/.bashrc<cr>
nnoremap <leader>dg :tabnew ~/.gitconfig<cr>
nnoremap <leader>dl :tabnew ~/.lein/profiles.clj<cr>
nnoremap <leader>do :tabnew ~/.bashrc_osx<cr>
nnoremap <leader>dp :tabnew ~/.pythonrc.py<cr>
nnoremap <leader>ds :tabnew ~/.ssh/config<cr>
nnoremap <leader>dv :tabnew ~/.vimrc<cr>

" toggle paste mode
nnoremap <leader>p <esc>:setlocal paste!<cr>

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

" sudo to write
cmap w!! w !sudo tee % >/dev/null

" windows
noremap <c-left> <c-w>h
noremap <c-right> <c-w>l

" tabs
if has("mac")
    noremap ÷ :tabp<cr>
    nnoremap ≠ :tabn<cr>
else
    noremap <c-down> :tabn<cr>
    noremap <c-up>   :tabp<cr>
    inoremap <c-down> <esc>:tabn<cr>
    inoremap <c-up>   <esc>:tabp<cr>
endif

noremap <leader>T :tabnew<cr>
nnoremap gt <c-w>gf

" search
nnoremap <leader><space> :setlocal nohlsearch!<cr>

" sort
vnoremap <leader>s :sort u<cr>

" avoid accidently switching to ex mode (from Rémi Prévost’s Vim settings)
nnoremap Q :echo "ex mode is disabled"<cr>

" - plugins options/mappings -

" DelimitMate
let delimitMate_expand_cr=1
" Clang-complete
if isdirectory("/Applications")
    let g:clang_library_path="/Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/lib"
endif
" CSS colors
let g:cssColorVimDoNotMessMyUpdatetime=1
" CommandT
let g:CommandTFileScanner="find"
let g:CommandTMaxHeight=30
" Fugitive
nnoremap <leader>gb :Gblame<cr>
" NERDTree
nnoremap <leader>n :NERDTreeToggle<cr>
" Powerline
let g:Powerline_symbols='fancy'
set laststatus=2
" Syntastic
let g:syntastic_css_checkers = []
let g:syntastic_python_checkers = ['pyflakes']
let g:syntastic_tex_checkers = ['chktex']
let g:syntastic_html_checkers = []

" don't display these warnings
let g:syntastic_tex_chktex_args = "-n 26 -n 36 -n 57"
" Tabular
vnoremap <leader>t :Tabular<space>/
vnoremap <leader>{ :Tabular<space>/{<cr>gv:Tabular<space>/}<cr>
" Vim-latex
let g:tex_flavor='latex'
" Zencoding
let g:user_emmet_expandabbr_key='<leader>h'

" *sh syntax
let g:sg_no_error=1

" -- functions --

fun Set_indent(width)
    execute "set tabstop=".a:width
    execute "set softtabstop=".a:width
    execute "set shiftwidth=".a:width
endf

fun Set_tw(width)
    execute "set cc=".(a:width+1)
    execute "set tw=".a:width
endfun

if has("autocmd")

    " - plugins autocmds
    "
    " Closetag
    au Filetype html,xhtml,xml,xsl,htmljinja so ~/.vim/scripts/closetag.vim

    " filetypes
    au BufNewFile,BufRead *.bf             set ft=brainfuck
    au BufNewFile,BufRead *.e,*.E          set ft=e
    au BufNewFile,BufRead *.fish           set ft=fish
    au BufNewFile,BufRead *.ft,*.fh,*.fth  set ft=forth
    au BufNewFile,BufRead templates/*.html set ft=htmljinja
    au BufNewFile,BufRead *.ics            set ft=icalendar
    au BufNewFile,BufRead *.io             set ft=io
    au BufNewFile,BufRead *.json           set ft=json
    au BufNewFile,BufRead *.liquid         set ft=liquid
    au BufNewFile,BufRead *.mustache       set ft=mustache
    au BufNewFile,BufRead *.pastek,*.pstk  set ft=pastek
    au BufNewFile,BufRead *.pl             set ft=prolog " conflict with Perl
    au BufNewFile,BufRead *.pu             set ft=plantuml
    au BufNewFile,BufRead Procfile         set ft=yaml
    au BufNewFile,BufRead Vagrantfile      set ft=ruby

    " autocomplete
    au FileType c          setlocal ofu=ccomplete#Complete
    au FileType css        setlocal ofu=csscomplete#CompleteCSS
    au FileType java       setlocal ofu=javacomplete#Complete
    au FileType javascript setlocal ofu=javascriptcomplete#CompleteJS
    au FileType php        setlocal ofu=phpcomplete#CompletePHP
    au FileType python     setlocal ofu=pythoncomplete#Complete
    au FileType ruby       setlocal ofu=rubycomplete#Complete
    au FileType sql        setlocal ofu=sqlcomplete#Complete
    au FileType xml        setlocal ofu=xmlcomplete#CompleteTags

    " filetypes settings
    au FileType c call Set_indent(8)
    au FileType python call Set_indent(4)

    " plugins
    au FileType javascript let b:delimitMate_expand_space=1
    au FileType scala RainbowParenthesesActivate
    au FileType scala RainbowParenthesesLoadRound

    au FileType json       setlocal nocursorline
    au FileType txt        setlocal spell
    au FileType xml        setlocal fdm=indent fdl=1

    " these languages allow usage of a single quote alone, e.g.: 'a
    au FileType clojure,ocaml,lisp let b:delimitMate_quotes = "\""
    " Vim comments start with "
    au FileType vim let b:delimitMate_quotes = "'"

    " git commits
    au FileType gitcommit call Set_tw(72)

    " files skeletons
    au BufNewFile *.c     0r ~/.vim/skeletons/c.c
    au BufNewFile *.cpp   0r ~/.vim/skeletons/cpp.cpp
    au BufNewFile *.html  0r ~/.vim/skeletons/html.html
    au BufNewFile *.php   0r ~/.vim/skeletons/php.php
    au BufNewFile *.py    0r ~/.vim/skeletons/python.py
    au BufNewFile *.rb    0r ~/.vim/skeletons/ruby.rb
    au BufNewFile *.sh    0r ~/.vim/skeletons/bash.sh

    " UI tweaks
    " -- hide trailing spaces on insert mode
    au InsertEnter * set listchars=tab:▸\ ,
    au InsertLeave * set listchars=tab:▸\ ,trail:·

endif " has("autocmd")
