#! /bin/bash
#
# Post-Installation Script for Vim
#
# Author: Baptiste Fontaine <b@ptistefontaine.fr>
# URL: https://github.com/bfontaine/Dotfiles/blob/master/vim.sh
# License: MIT


VIM_DIR=~/.vim

for dir in after autoload backups bundle colors doc \
                    ftdetect indent plugin scripts \
                    snippets syntax after/syntax; do
    mkdir -p ${VIM_DIR}/$dir
done

__progress() { # string 0|1
    local prefix='--->'
    if [ "$2" -eq "1" ]; then
        prefix='[ok]'
    fi
    echo "$prefix $1"
}

vim_script() { # path num
    local name=${1%%.vim}.vim
    local fname=${VIM_DIR}/${name}
    local url=http://www.vim.org/scripts/download_script.php?src_id=$2

    if [ ! -f "${fname}" ]; then
        __progress $name 0
        wget -q $url -O "${fname}";
    else
        __progress $name 1
    fi
}

gh_bundle() {
    local repo=$1
    local target=bundle/$(echo "$repo" | cut -d/ -f2)

    if [ ! -d ${VIM_DIR}/$target ]; then
        __progress $target 0
        git clone --depth=1 https://github.com/${repo}.git \
            ${VIM_DIR}/$target
    else
        __progress $target 1
    fi
}

gh_raw() {
    local repo=$1
    local path=$2
    local target=$3
    local fname=

    if [ -z "$target" ]; then
        target=$path
    fi

    fname="$VIM_DIR/$target"

    if [ ! -f $fname ]; then
        __progress $target 0
        wget -q https://raw.github.com/${repo}/master/${path} \
            -O $fname
    else
        __progress $target 1
    fi
}

wzip() { # script_id test_file
    if [ ! -f "${VIM_DIR}/$2" ]; then
        __progress $2 0
        wget http://www.vim.org/scripts/download_script.php?src_id=$1 \
            -O /tmp/w.zip
        unzip /tmp/w.zip -d ${VIM_DIR}
    else
        __progress $2 1
    fi
}

# == plugins ==

vim_script autoload/pathogen    16224 # Pathogen
vim_script scripts/closetag.vim  4318 # Close tag

# endwise : add 'end' in Ruby files when using if/def/…
# haml    : HAML, Sass, SCSS syntax
# markdown: Markdown syntax
# surround: parentheses, quotes, XML/HTML tags
for plugin in endwise haml markdown surround; do
    gh_bundle tpope/vim-${plugin}
done

# Clang complete: C/C++ autocompletion
# you need Clang installed (package 'clang' on Ubuntu)
if [ ! -f ${VIM_DIR}/plugin/clang_complete.vim ]; then
    pushd /tmp
    git clone --depth=1 https://github.com/Rip-Rip/clang_complete.git
    make -C clang_complete install
    rm -Rf clang_complete
    popd
fi

wzip  8196 plugin/matchit.vim    # Matchit

# SnipMate and its dependencies
gh_bundle tomtom/tlib_vim
gh_bundle MarcWeber/vim-addon-mw-utils
gh_bundle garbas/vim-snipmate

# Vim-fireplace and its dependencies (Clojure toolset)
gh_bundle tpope/vim-salve         # Static support for Leiningen
gh_bundle tpope/vim-projectionist
gh_bundle tpope/vim-dispatch      # Async build & test dispatcher
gh_bundle tpope/vim-fireplace     # Clojure REPL support

gh_bundle tpope/vim-abolish      # Abolish: %s on steroids
gh_bundle tell-k/vim-autopep8    # autopep8
gh_bundle ConradIrwin/vim-bracketed-paste # Bracketed paste
gh_bundle Raimondi/delimitMate   # DelimitMate
gh_bundle tpope/vim-fugitive     # Fugitive
gh_bundle sjl/gundo.vim          # Gundo
gh_bundle venantius/vim-eastwood # Eastwood for Vim
gh_bundle mattn/emmet-vim        # Emmet (Zencoding-like plugin)
# Use https://gist.github.com/baopham/1838072 for Monaco and
# https://github.com/powerline/fonts for other fonts
gh_bundle vim-airline/vim-airline # Airline
gh_bundle kien/rainbow_parentheses.vim # Rainbow Parentheses (for Scala/Clojure)
gh_bundle tpope/vim-repeat       # Repeat plugin commands with "."
gh_bundle tpope/vim-speeddating  # Increment dates w/ <C-A> and <C-X>
gh_bundle scrooloose/syntastic   # Syntastic
gh_bundle godlygeek/tabular      # Tabular

# Command-T
if [ ! -d ${VIM_DIR}/bundle/Command-T ]; then
    gh_bundle wincent/Command-T
    pushd "$VIM_DIR/bundle/Command-T/ruby/command-t" >/dev/null
    echo "Compiling Command-T's extensions..."
    ruby extconf.rb
    make
    popd >/dev/null
fi

# == themes ==

# Those are already in the dotfiles repo:
#
# vim_script colors/256-jungle 8685        # 256-jungle
# gh_raw tomasr/molokai colors/molokai.vim # Molokai

# == syntax ==

# *sh
if [ ! -f ${VIM_DIR}/syntax/sh.vim ]; then
    pushd /tmp
    wget http://www.drchip.org/astronaut/vim/syntax/sh.vim.gz
    gunzip sh.vim.gz
    mv sh.vim ${VIM_DIR}/syntax/
    popd
fi

vim_script syntax/abnf           5805 # ABNF
vim_script syntax/asciidoc       6891 # Asciidoc
vim_script syntax/icalendar      5573 # iCalendar
vim_script syntax/io             8129 # Io
vim_script syntax/jinja          8666 # Jinja
vim_script syntax/htmljinja      6961 # (same)
vim_script syntax/json          10853 # JSON

gh_bundle guns/vim-clojure-static  # Clojure
gh_bundle kchmck/vim-coffee-script # CoffeeScript
gh_bundle rhysd/vim-crystal        # Crystal
gh_bundle hail2u/vim-css3-syntax   # CSS3
gh_bundle ekalinin/Dockerfile.vim  # Dockerfile
gh_bundle killphi/vim-ebnf         # EBNF
gh_bundle dag/vim-fish             # Fish
gh_bundle xu-cheng/brew.vim        # Homebrew formulae
gh_bundle bfontaine/Brewfile.vim   # Homebrew bundle
gh_bundle pangloss/vim-javascript  # JavaScript
gh_bundle mxw/vim-jsx              # JSX
gh_bundle iqqmuT/vim-k             # K
gh_bundle groenewege/vim-less      # LESS
gh_bundle plasticboy/vim-markdown  # Markdown
gh_bundle juvenn/mustache.vim      # Mustache
gh_bundle cespare/vim-toml         # TOML
gh_bundle evidens/vim-twig         # Twig

if [ x"$(which go)" != x"" ]; then
  gh_bundle "fatih/vim-go"
else
  echo "WARN: Please install Golang and re-run this script to get Go support"
fi

# https://github.com/candid82/joker
if [ x"$(which joker)" != x"" ]; then
  gh_bundle aclaimant/syntastic-joker
else
  echo "WARN: Please install github.com/candid82/joker and re-run this script to get Clojure linting support"
fi

# LaTeX
#if [ ! -d ${VIM_DIR}/bundle/vim-latex ]; then
#    pushd /tmp
#    wget http://bit.ly/vim-latex \
#        -O vl.tgz
#    tar -xzf vl.tgz
#    mv vim-latex-* ${VIM_DIR}/bundle/vim-latex
#    popd
#fi

# == Omnicomplete ==

# C++
if [ ! -f ${VIM_DIR}/doc/clang_complete.txt ]; then
    pushd /tmp
    wget http://www.vim.org/scripts/download_script.php?src_id=19588 \
        -Oclang_complete.vmb
    vim clang_complete.vmb -c 'so %' -c 'q'
    popd
fi

# Java complete
# Note: for the first use, Reflection.java will be compiled
#       to ~/Reflection.class. You should move it to ${VIM_DIR}/autoload/
wzip 14914 doc/javacomplete.txt

# Bundles cleaning
rm -Rf ${VIM_DIR}/bundle/*/.git
