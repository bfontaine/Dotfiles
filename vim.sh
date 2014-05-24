#! /bin/bash
#
# Post-Installation Script for Vim
#


VIM_DIR=~/.vim

for dir in after autoload backups bundle colors doc \
                    ftdetect indent plugin scripts \
                    snippets syntax after/syntax; do
    mkdir -p ${VIM_DIR}/$dir
done

install_if_absent() {
    [ $# -ne 2 ] && return -1;

    name=${VIM_DIR}/${1%%.vim}.vim
    url=http://www.vim.org/scripts/download_script.php?src_id=$2

    if [ ! -f "${name}" ]; then
        echo "downloading ${name}..."
        wget -q $url -O "${name}";
    fi
}

gh_bundle() {
    local user=$1
    local name=$2

    if [ ! -d ${VIM_DIR}/bundle/${name} ]; then
        git clone https://github.com/${user}/${name}.git \
            ${VIM_DIR}/bundle/${name}
    fi
}

gh_raw() {
    local repo=$1
    local path=$2
    local target=$3

    if [ -z "$target" ]; then
        target=$path
    fi

    target="$VIM_DIR/$target"

    if [ ! -f ${target} ]; then
        wget -q https://raw.github.com/${repo}/master/${path} \
            -O ${target}
    fi
}

# == plugins ==

install_if_absent autoload/pathogen    16224 # Pathogen
install_if_absent scripts/closetag.vim  4318 # Close tag

# endwise    : add 'end' in Ruby files when using if/def/…
# haml       : HAML, Sass, SCSS syntax
# markdown   : Markdown syntax
# surround   : parentheses, quotes, XML/HTML tags

for plugin in endwise haml markdown surround; do
    gh_bundle tpope vim-${plugin}
done

# Clang complete : C/C++ autocompletion
# you need Clang installed (package 'clang' on Ubuntu)
if [ ! -f ${VIM_DIR}/plugin/clang_complete.vim ]; then
    cd /tmp/
    git clone https://github.com/Rip-Rip/clang_complete.git
    make -C clang_complete install
    rm -Rf clang_complete
fi


# CSS-Color : Show CSS colors
# gh_raw skammer/vim-css-color after/syntax/css.vim

# DelimitMate : automatic closing of quotes, parenthesis, brackets, etc.
if     [ ! -f ${VIM_DIR}/doc/delimitMate.txt ] \
    || [ ! -f ${VIM_DIR}/plugin/delimitMate.vim ];then
    cd /tmp/
    git clone https://github.com/Raimondi/delimitMate.git
    cd delimitMate/
    mv autoload/delimitMate.vim ${VIM_DIR}/autoload/
    mv doc/delimitMate.txt ${VIM_DIR}/doc/
    mv plugin/delimitMate.vim ${VIM_DIR}/plugin/
fi

# Jedi : completion for Python
if [ ! -d ${VIM_DIR}/bundle/jedi-vim ]; then
    gh_bundle davidhalter jedi-vim
    cd ${VIM_DIR}/bundle/jedi-vim/
    git clone https://github.com/davidhalter/jedi.git
fi

# Matchit : extended % matching for HTML, LaTeX, etc
if     [ ! -f ${VIM_DIR}/plugin/matchit.vim ] \
    || [ ! -f ${VIM_DIR}/doc/matchit.txt ]; then
    wget http://www.vim.org/scripts/download_script.php?src_id=8196 \
        -O /tmp/matchit.zip
    unzip /tmp/matchit.zip -d ${VIM_DIR}
fi

gh_bundle sjl         gundo.vim     # Gundo
gh_bundle mattn       emmet-vim     # Emmet (Zencoding-like plugin)
gh_bundle scrooloose  nerdtree      # NerdTree
gh_bundle Lokaltog    vim-powerline # Powerline
gh_bundle AndrewRadev splitjoin.vim # Splitjoin
gh_bundle godlygeek   tabular       # Tabular

# SnipMate : allow TextMate's snippets in Vim
if [ ! -f ${VIM_DIR}/autoload/snipMate.vim ]; then
    wget http://www.vim.org/scripts/download_script.php?src_id=11006 \
        -O /tmp/sm.zip
    unzip /tmp/sm.zip -d ${VIM_DIR}
fi

# Taglist : source code browser
# note: you need to install Ctags before
# (exuberant-ctags package in Ubuntu)
if     [ ! -f ${VIM_DIR}/plugin/taglist.vim ] \
    || [ ! -f ${VIM_DIR}/doc/taglist.txt ]; then

    cd /tmp/
    wget http://www.vim.org/scripts/download_script.php?src_id=7701 \
        -O taglist.zip
    unzip taglist.zip
    mv plugin/taglist.vim ${VIM_DIR}/plugin/taglist.vim
    mv doc/taglist.txt ${VIM_DIR}/doc/taglist.txt
fi

# == themes ==

# install_if_absent colors/256-jungle 8685 # 256-jungle
# install_if_absent colors/candycode  6066 # Candycode
#
# Molokai
# gh_raw tomasr/molokai colors/molokai.vim
#
# Tomorrow
#if [ ! -f ${VIM_DIR}/colors/Tomorrow.vim ]; then
#    cd /tmp/
#    git clone https://github.com/chriskempson/tomorrow-theme.git
#    mv tomorrow-theme/vim/colors/Tomorrow* ${VIM_DIR}/colors/
#fi

# == syntax ==

# *sh
if [ ! -f ${VIM_DIR}/syntax/sh.vim ]; then
    cd tmp
    wget http://www.drchip.org/astronaut/vim/syntax/sh.vim.gz
    gunzip sh.vim.gz
    mv sh.vim ${VIM_DIR}/syntax/
fi

install_if_absent syntax/asciidoc       6891 # Asciidoc
install_if_absent syntax/brainfuck     14054 # Brainfuck
install_if_absent syntax/conflicts.vim 19764 # *.conflicts files
install_if_absent syntax/forth         18049 # Forth
install_if_absent syntax/io             8129 # Io
install_if_absent syntax/jinja          8666 # Jinja
install_if_absent syntax/htmljinja      6961 # (same)
install_if_absent syntax/json          10853 # JSON

gh_bundle guns   vim-clojure-static # Clojure
gh_bundle kchmck vim-coffee-script  # CoffeeScript
gh_bundle hailu  vim-css3-syntax    # CSS3
gh_bundle dag    vim-fish           # Fish
gh_bundle juvenn mustache.vim       # Mustache
gh_bundle wting  rust.vim           # Rust

gh_raw bfontaine/e.vim e.vim syntax/e.vim        # E
gh_raw xhr/vim-io            indent/io.vim       # Io (again)
gh_raw bfontaine/omgrofl.vim omgrofl.vim syntax/omgrofl.vim # Omgrofl
gh_raw aklt/plantuml-syntax  syntax/plantuml.vim # PlantUML

# Go
for f in syntax indent ftdetect; do
    gh_raw jnwhiteh/vim-golang $f/go.vim
done


# Jade
if [ ! -f ${VIM_DIR}/syntax/jade.vim ]; then
    wget http://www.vim.org/scripts/download_script.php?src_id=13895 \
        -O jade.zip
    unzip jade.zip

    for d in ftdetect ftplugin indent syntax; do
        mv ${d}/jade.vim ${VIM_DIR}/$d/jade.vim
    done
fi

# JavaScript
if     [ ! -f ${VIM_DIR}/syntax/javascript.vim ] \
    || [ ! -f ${VIM_DIR}/indent/javascript.vim ]; then
    cd /tmp/
    wget http://www.vim.org/scripts/download_script.php?src_id=11296 \
        -O javascript.zip
    unzip javascript.zip -d js-vim
    for d in syntax indent; do
        mv js-vim/$d/javascript.vim ${VIM_DIR}/$d/
    done
    rm -f javascript.zip
fi

# LaTeX
#if [ ! -d ${VIM_DIR}/bundle/vim-latex ]; then
#    cd /tmp
#    wget http://bit.ly/vim-latex \
#        -O vl.tgz
#    tar -xzf vl.tgz
#    mv vim-latex-* ${VIM_DIR}/bundle/vim-latex
#fi

# Scala
for dir in ftdetect indent syntax; do

    if [ ! -f ${VIM_DIR}/${dir}/scala.vim ]; then
        url='https://lampsvn.epfl.ch/trac/scala/export/26099/scala-tool-'
        url="${url}support/trunk/src/vim/${dir}/scala.vim"
        wget $url -O ${VIM_DIR}/${dir}/scala.vim
    fi

done

# Textile
#
# need Ruby & RedCloth:
# sudo apt-get install ruby rubygems
# sudo gem install RedCloth
if [ ! -f ${VIM_DIR}/doc/textile.txt ]; then
    cd /tmp/
    wget http://www.vim.org/scripts/download_script.php?src_id=9427 \
        -O textile.zip
    unzip textile.zip
    for d in doc ftplugin plugin syntax; do
        mv textile*/${d}/textile.* ${VIM_DIR}/${d}/
    done
fi

# == Omnicomplete ==

# C++
if [ ! -f ${VIM_DIR}/doc/clang_complete.txt ]; then
    cd /tmp/
    wget http://www.vim.org/scripts/download_script.php?src_id=19588 \
        -Oclang_complete.vmb
    vim clang_complete.vmb -c 'so %' -c 'q'
fi

# Java complete
if     [ ! -f ${VIM_DIR}/autoload/javacomplete.vim ] \
    || [ ! -f ${VIM_DIR}/autoload/Reflection.java ] \
    || [ ! -f ${VIM_DIR}/autoload/java_parser.vim ] \
    || [ ! -f ${VIM_DIR}/doc/javacomplete.txt ]; then

    cd /tmp/
    wget http://www.vim.org/scripts/download_script.php?src_id=14914 \
        -O javacomplete.zip
    unzip javacomplete.zip -d ${VIM_DIR}
    rm -f javacomplete.zip

    # Note: for the first use, Reflection.java will be compiled
    #       to ~/Reflection.class . You should move it to ${VIM_DIR}/autoload/
fi

# Bundles cleaning
rm -Rf ${VIM_DIR}/bundle/*/.git
