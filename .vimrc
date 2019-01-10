set nocompatible " no compatible with VI

" Plugins
" https://github.com/junegunn/vim-plug
call plug#begin('~/.vim/bundle')

" = Basics =
Plug 'tpope/vim-sensible'              " A bit like normalize.css for Vim
Plug 'ConradIrwin/vim-bracketed-paste' " Bracketed paste

" = Global Tools =
Plug 'tpope/vim-repeat'                " Repeat plugin commands with '.'
Plug 'tpope/vim-speeddating'           " Increment dates w/ <C-A> and <C-X>
Plug 'tpope/vim-surround'              " parentheses, quotes, XML/HTML tags
Plug 'godlygeek/tabular'               " Tabular
Plug 'mhinz/vim-grepper'               " grep
Plug 'Raimondi/delimitMate'            " DelimitMate
Plug 'sjl/gundo.vim'                   " Gundo

" = Git =
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter' " +-~ in gutter

" = Autocomplete =
" Deoplete
" You need to `pip3 install --user pynvim` + :call deoplate#enable()
" TODO customize it to hide the preview window + complete ONLY on request
Plug 'Shougo/deoplete.nvim'
Plug 'roxma/nvim-yarp'
Plug 'roxma/vim-hug-neovim-rpc'

" = Languages Specifics =

" == C/C++ ==
Plug 'Rip-Rip/clang_complete'          " C/C++ completion

" == Clojure ==
Plug 'guns/vim-clojure-static'
Plug 'tpope/vim-dispatch'                         " Async build & test dispatcher
Plug 'tpope/vim-fireplace'                        " Clojure REPL support
Plug 'guns/vim-clojure-highlight'
Plug 'guns/vim-sexp'
Plug 'tpope/vim-sexp-mappings-for-regular-people'
Plug 'kien/rainbow_parentheses.vim'               " Rainbow Parentheses
Plug 'clojure-vim/async-clj-omni'                 " Deoplete

" == HTML ==
Plug 'alvan/vim-closetag'              " Auto-insert HTML closing tags

" == Ruby ==
Plug 'tpope/vim-endwise'               " Auto-insert 'end' in Ruby & more

" = Command Mode =
Plug 'tpope/vim-abolish'               " %s on steroids

" = Visual Mode =
Plug 'nelstrom/vim-visual-star-search' " * = search what's selected
Plug 'tpope/vim-commentary'            " comment stuff with gcc / gc+motion

" = Syntax =
Plug 'vim-scripts/abnf'                           " ABNF
Plug 'kchmck/vim-coffee-script'                   " CoffeeScript
Plug 'rhysd/vim-crystal'                          " Crystal
Plug 'hail2u/vim-css3-syntax'                     " CSS3
Plug 'ekalinin/Dockerfile.vim'                    " Dockerfile
Plug 'killphi/vim-ebnf'                           " EBNF
Plug 'dag/vim-fish'                               " Fish
Plug 'fatih/vim-go', {'for': 'go'}                " Go
Plug 'xu-cheng/brew.vim'                          " Homebrew formulae
Plug 'bfontaine/Brewfile.vim'                     " Homebrew bundle
Plug 'vim-scripts/icalendar.vim'                  " icalendar
Plug 'vim-scripts/Io-programming-language-syntax' " Io
Plug 'pangloss/vim-javascript'                    " JavaScript
Plug 'Glench/Vim-Jinja2-Syntax'                   " Jinja
Plug 'elzr/vim-json'                              " JSON
Plug 'mxw/vim-jsx'                                " JSX
Plug 'iqqmuT/vim-k'                               " K
Plug 'groenewege/vim-less'                        " LESS
Plug 'plasticboy/vim-markdown'                    " Markdown
Plug 'mustache/vim-mustache-handlebars'           " Mustache
Plug 'cespare/vim-toml'                           " TOML
Plug 'lumiliet/vim-twig'                          " Twig

" TODO Use Denite instead
Plug 'wincent/Command-T', {'do': 'cd ruby/command-t/ext/command-t; $(vim --version \| grep -Eo -m 1 \"/\S+ruby/[0-9.]+/lib\" \| head -1 \| sed \"s%lib$%bin/ruby%\") extconf.rb; make'}

" = Stuff to review/sort in other categories =

" SnipMate and its dependencies
" TODO use https://github.com/SirVer/ultisnips instead
Plug 'tomtom/tlib_vim'
Plug 'MarcWeber/vim-addon-mw-utils'
Plug 'garbas/vim-snipmate'

" Use https://gist.github.com/baopham/1838072 for Monaco and
" https://github.com/powerline/fonts for other fonts
Plug 'vim-airline/vim-airline'      " Airline
Plug 'scrooloose/syntastic'         " Syntastic (TODO use ALE: https://github.com/w0rp/ale)

call plug#end()

set background=dark             " dark background
set backspace=indent,eol,start  " allow backspace on everything in insert mode
set backup                      " keep a backup file
set cursorline                  " highlight current line
set diffopt+=algorithm:patience " better diffs
set diffopt+=indent-heuristic   " https://vimways.org/2018/the-power-of-diff/
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
set lazyredraw                  " turn on lazy redraw (performance++)
set linebreak                   " don't wrap text in the middle of a word
set list                        " display unprintable chars (see listchars)
set listchars=tab:▸\ ,trail:·   " see 'list' above
set magic                       " set magic for regex
set matchtime=3                 " show the matching parent .3sec (default: .5)
set modelines=0                 " no modelines
set noautoread                  " don't re-read a file changed outside of Vim
set nofoldenable                " don't fold by default
set nojoinspaces                " use only one space after a dot
set nospell                     " do not use spell checking
set number                      " display line numbers
set numberwidth=1               " use only 1 column (+ 1 space) while possible
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
set titleold=""                 " don't show 'Thanks for flying Vim' on exit
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
set wildignore+=target,out,Godeps
set wildignore+=*.jar,*.zip     " archives / compressed files
set wildignore+=*.gz,*.tar
set wildignore+=*.db            " SQLite

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

" shortcut to get a white background, e.g. when making a presentation with poor
" video projectors.
" Note you also need to change the terminal emulator's settings, or at least
" its background color.
fun White_bg()
  set background=light
  colorscheme default " necessary to get back a white background
  colorscheme PaperColor " get slightly better colors
  syntax on
endfun

" -- Global Mappings --

let mapleader = ","
let maplocalleader = " "

" move up and down on long wrapped lines
nnoremap j gj
nnoremap k gk
vnoremap j gj
vnoremap k gk

" avoid errors
nnoremap <f1> <esc>
inoremap <f1> <esc>
vnoremap <f1> <esc>

" disable the manual key
" nnoremap K <nop>

" open dotfiles
nnoremap <leader>db :tabnew ~/.bashrc<cr>
nnoremap <leader>dg :tabnew ~/.gitconfig<cr>
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
let g:CommandTWildIgnore=&wildignore

" CommandT requires '/*' at the end of dirs to work
" https://github.com/wincent/command-t/issues/305
let g:CommandTWildIgnore.=",*/venv/*,*/target/*,*/target-back/*,*/out/*,*/Godeps/*"
" Images
let g:CommandTWildIgnore.=",*.svg,*.ico"
" Java
let g:CommandTWildIgnore.=",**/*.class"

" Fugitive
nnoremap <leader>gb :Gblame<cr>

" Airline
let g:airline_powerline_fonts=1
let g:airline_extensions=[]
set laststatus=2

" Syntastic
let g:syntastic_css_checkers = []
let g:syntastic_clojure_checkers = [] " temporary 'fix'
let g:syntastic_go_checkers = ['golint', 'go']
let g:syntastic_python_checkers = ['pyflakes']
let g:syntastic_ruby_checkers = ['rubocop', 'mri']
let g:syntastic_tex_checkers = ['chktex']
let g:syntastic_html_checkers = []
" don't display these warnings
let g:syntastic_tex_chktex_args = "-n 26 -n 36 -n 57"
let g:syntastic_markdown_checkers = ['proselint']
let g:syntastic_python_python_exec = "/usr/bin/python3"

" Tabular
vnoremap <leader>t :Tabular<space>/

" Vim-go
let g:go_fmt_command = "goimports"

" Vim-latex
let g:tex_flavor='latex'

" *sh syntax
let g:sg_no_error=1

" Sexp (Clojure)
" Disable insert mode mappings because they might conflict with demimitMate.
" Remove me if that’s not the case.
let g:sexp_enable_insert_mode_mappings = 0

" Deoplete
" https://github.com/clojure-vim/async-clj-omni#deoplete
let g:deoplete#keyword_patterns = {}
let g:deoplete#keyword_patterns.clojure = '[\w!$%&*+/:<=>?@\^_~\-\.#]*'

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
augroup vimrc_autocmd
    au!

    " - plugins autocmds
    "
    " Closetag
    au Filetype html,xhtml,xml,xsl,htmljinja so ~/.vim/scripts/closetag.vim

    " filetypes
    au BufNewFile,BufRead *.bf             set ft=brainfuck
    au BufNewFile,BufRead *.eliom          set ft=ocaml
    au BufNewFile,BufRead *.fish           set ft=fish
    au BufNewFile,BufRead templates/*.html set ft=htmljinja
    au BufNewFile,BufRead *.ics            set ft=icalendar
    au BufNewFile,BufRead *.json           set ft=json
    au BufNewFile,BufRead *.yml.j2         set ft=yaml

    au BufNewFile,BufRead build.boot       set ft=clojure
    au BufNewFile,BufRead Jenkinsfile      set ft=groovy
    au BufNewFile,BufRead Procfile         set ft=yaml
    au BufNewFile,BufRead .cookiecutterrc  set ft=yaml
    au BufNewFile,BufRead pylintrc         set ft=config
    au BufNewFile,BufRead Vagrantfile      set ft=ruby
    au BufNewFile,BufRead .zprintrc        set ft=clojure
    au BufNewFile,BufRead .jshintrc        set ft=json

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
    au FileType go,markdown,php,python call Set_indent(4)
    au FileType gitconfig setlocal commentstring=#\ %s
    au FileType dockerfile,html,htmljinja,liquid setlocal tw=0
    au FileType rust setlocal tw=79

    " plugins
    au FileType javascript let b:delimitMate_expand_space=1
    au FileType clojure,scala RainbowParenthesesActivate
    au FileType clojure,scala RainbowParenthesesLoadRound
    " https://github.com/guns/vim-clojure-highlight#rainbow-parentheses-and-other-syntax-extensions
    au Syntax clojure RainbowParenthesesLoadRound

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
    " TODO: find a way to automate the discovery
    au BufNewFile *.html  0r ~/.vim/skeletons/html.html
    au BufNewFile *.py    0r ~/.vim/skeletons/python.py
    au BufNewFile *.rb    0r ~/.vim/skeletons/ruby.rb
    au BufNewFile *.sh    0r ~/.vim/skeletons/bash.sh
    au BufNewFile *.xml   0r ~/.vim/skeletons/xml.xml

    " UI tweaks
    " -- hide trailing spaces on insert mode
    au InsertEnter * set listchars=tab:▸\ ,
    au InsertLeave * set listchars=tab:▸\ ,trail:·

augroup END
endif " has("autocmd")
