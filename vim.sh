#! /bin/bash
#
# Post-Installation Script for Vim
#


VIM_DIR=~/.vim

for dir in after autoload backups bundle colors doc \
                    ftdetect indent plugin scripts \
                    snippets syntax; do
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

# == plugins ==

# Pathogen
install_if_absent autoload/pathogen 16224

cd ${VIM_DIR}/bundle/

# endwise    : add 'end' in Ruby files when using if/def/…
# haml       : HAML, Sass, SCSS syntax
# markdown   : Markdown syntax
# surround   : parentheses, quotes, XML/HTML tags

for plugin in endwise haml markdown surround; do
    if [ ! -d ${VIM_DIR}/bundle/vim-${plugin} ]; then
        git clone https://github.com/tpope/vim-${plugin}.git
    fi
done

# Clang complete : C/C++ autocompletion
# you need Clang installed (package 'clang' on Ubuntu)
if     [ ! -f ${VIM_DIR}/plugin/clang_complete.vim ]; then
    cd /tmp/
    git clone https://github.com/Rip-Rip/clang_complete.git
    cd clang_complete/
    make install
    cd ..
    rm -Rf clang_complete
fi

# Close tag : close (X)HTML/XML tags
install_if_absent scripts/closetag.vim 4318

# CSS-Color : Show CSS colors
# if [ ! -f ${VIM_DIR}/after/syntax/css.vim ]; then
#
#     cd /tmp/
#     git clone https://github.com/skammer/vim-css-color.git
#     mkdir -p ${VIM_DIR}/after/syntax
#     mv vim-css-color/after/syntax/css.vim ${VIM_DIR}/after/syntax/
#
# fi

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

# Gundo : easier undo tree visualization
if [ ! -d ${VIM_DIR}/bundle/gundo ]; then
    git clone http://github.com/sjl/gundo.vim.git ${VIM_DIR}/bundle/gundo
fi

# Jedi : completion for Python
if [ ! -d ${VIM_DIR}/bundle/jedi-vim ]; then
    git clone https://github.com/davidhalter/jedi-vim.git \
        ${VIM_DIR}/bundle/jedi-vim
    cd ${VIM_DIR}/bundle/jedi-vim/
    git clone https://github.com/davidhalter/jedi.git
fi

# Matchit : extended % matching for HTML, LaTeX, etc
if     [ ! -f ${VIM_DIR}/plugin/matchit.vim ] \
    || [ ! -f ${VIM_DIR}/doc/matchit.txt ]; then

    cd ${VIM_DIR}
    wget http://www.vim.org/scripts/download_script.php?src_id=8196 \
        -O matchit.zip
    unzip matchit.zip
    rm -f matchit.zip
fi

# NerdTree : File tree
if [ ! -d ${VIM_DIR}/bundle/nerdtree ]; then
    cd ${VIM_DIR}/bundle/
    git clone https://github.com/scrooloose/nerdtree.git
fi

# Powerline : better status line
if [ ! -d ${VIM_DIR}/bundle/vim-powerline ]; then
    cd ${VIM_DIR}/bundle/
    git clone https://github.com/Lokaltog/vim-powerline.git
fi

# SnipMate : allow TextMate's snippets in Vim
if [ ! -f ${VIM_DIR}/autoload/snipMate.vim ]; then
    wget http://www.vim.org/scripts/download_script.php?src_id=11006 \
        -O /tmp/sm.zip
    unzip /tmp/sm.zip -d ~/.vim
fi

# Tabular : text line up made easy
if [ ! -d ${VIM_DIR}/bundle/tabular ]; then
    cd ${VIM_DIR}/bundle/
    git clone https://github.com/godlygeek/tabular.git
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

# Emmet Zencoding-like plugin
if     [ ! -d ${VIM_DIR}/bundle/emmet-vim ]; then

    cd /tmp/
    git clone http://github.com/mattn/emmet-vim.git
    mv emmet-vim ${VIM_DIR}/bundle/

fi

# == themes ==

# 256-jungle
# install_if_absent colors/256-jungle 8685
#
# Candycode
# install_if_absent colors/candycode 6066
#
# Molokai
#if [ ! -f ${VIM_DIR}/colors/molokai.vim ]; then
#    cd /tmp/
#    git clone https://github.com/tomasr/molokai.git
#    mv molokai/colors/molokai.vim ${VIM_DIR}/colors/
#fi
#
# Tomorrow
#if [ ! -f ${VIM_DIR}/colors/Tomorrow.vim ]; then
#    cd /tmp/
#    git clone https://github.com/chriskempson/tomorrow-theme.git
#    mv tomorrow-theme/vim/colors/Tomorrow* ${VIM_DIR}/colors/
#fi

# == syntax ==

# Asciidoc
install_if_absent syntax/asciidoc 6891

# *sh
if [ ! -f ${VIM_DIR}/syntax/sh.vim ]; then
    cd tmp
    wget http://www.drchip.org/astronaut/vim/syntax/sh.vim.gz
    gunzip sh.vim.gz
    mv sh.vim ${VIM_DIR}/syntax/
fi

# Brainfuck
install_if_absent syntax/brainfuck 14054

# *.conflicts files
install_if_absent syntax/conflicts.vim 19764

# Clojure
if [ ! -d ${VIM_DIR}/bundle/vim-clojure-static ]; then

    cd ${VIM_DIR}/bundle
    git clone https://github.com/guns/vim-clojure-static.git

fi

# CoffeeScript
if [ ! -d ${VIM_DIR}/bundle/vim-coffee-script ]; then
    cd ${VIM_DIR}/bundle/
    git clone https://github.com/kchmck/vim-coffee-script.git
fi

# CSS3
if [ ! -d ${VIM_DIR}/bundle/vim-css3-syntax ]; then
    cd ${VIM_DIR}/bundle
    git clone https://github.com/hail2u/vim-css3-syntax.git
fi

# E
if [ ! -f ${VIM_DIR}/syntax/e.vim ]; then
    wget http://raw.github.com/bfontaine/e.vim/master/e.vim \
        -O ${VIM_DIR}/syntax/e.vim
fi

# Fish
if [ ! -d ${VIM_DIR}/bundle/vim-fish ]; then
    git clone https://github.com/dag/vim-fish.git \
        ${VIM_DIR}/bundle/vim-fish
fi

# Forth
install_if_absent syntax/forth 18049

# Go
for f in syntax indent ftdetect; do
    if [ ! -f ${VIM_DIR}/syntax/go.vim ]; then
        wget https://raw.github.com/jnwhiteh/vim-golang/master/$f/go.vim \
            -O ${VIM_DIR}/$f/go.vim
    fi
done

# Io
install_if_absent syntax/io 8129

if [ ! -f ${VIM_DIR}/indent/io.vim ]; then
    wget https://raw.github.com/xhr/vim-io/master/indent/io.vim \
        -O ${VIM_DIR}/indent/io.vim
fi

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

# Jinja
install_if_absent syntax/jinja 8666
install_if_absent syntax/htmljinja 6961

# JSON
install_if_absent syntax/json 10853

# LaTeX
#if [ ! -d ${VIM_DIR}/bundle/vim-latex ]; then
#    cd /tmp
#    wget http://bit.ly/vim-latex \
#        -O vl.tgz
#    tar -xzf vl.tgz
#    mv vim-latex-* ${VIM_DIR}/bundle/vim-latex
#fi

# Mustache
if [ ! -d ${VIM_DIR}/bundle/mustache ]; then
    cd ${VIM_DIR}
    [ ! -d .git ] && git init
    git submodule add https://github.com/juvenn/mustache.vim.git bundle/mustache
fi

# Omgrofl
if [ ! -f ${VIM_DIR}/syntax/omgrofl.vim ]; then
    wget https://raw.github.com/bfontaine/omgrofl.vim/master/omgrofl.vim \
        -O ${VIM_DIR}/syntax/omgrofl.vim
fi

# PlantUML
if [ ! -f ${VIM_DIR}/syntax/plantuml.vim ]; then
    wget https://raw.github.com/aklt/plantuml-syntax/master/syntax/plantuml.vim \
        -O ${VIM_DIR}/syntax/plantuml.vim
fi

# Rust
if [ ! -d ${VIM_DIR}/bundle/rust.vim ]; then
    cd ${VIM_DIR}/bundle
    git clone https://github.com/wting/rust.vim.git
fi

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
# need Ruby & RedCloth :
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

# == snippets (for SnipMate plugin) ==

# Backbone

if [ ! -f ${VIM_DIR}/snippets/backbone.snippets ];then
    url='https://raw.github.com/gist/959876/ab6981b2a882'
    url="${url}57e823ebd0cc4ecc5eaf54eb5634/backbone.snippets"
    wget $url -O ${VIM_DIR}/snippets/backbone.snippets
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
