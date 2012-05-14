#! /bin/bash
#
# Post-Installation Script for Vim
#


VIM_DIR=~/.vim

for dir in after autoload backups bundle colors doc \
                    ftdetect indent plugin snippets syntax; do
    mkdir -p ${VIM_DIR}/$dir
done

# == plugins ==

# Pathogen
if [ ! -f ${VIM_DIR}/autoload/pathogen.vim ]; then
    wget http://www.vim.org/scripts/download_script.php?src_id=16224 \
        -O ${VIM_DIR}/autoload/pathogen.vim
fi

cd ${VIM_DIR}/bundle/

# abolish    : String replacement with word variants
# afterimage : edit small images with vim
# endwise    : add 'end' in Ruby files when using if/def/…
# fugitive   : Git wrapper
# commentary : Universal shortcut to comment (programing)
# haml       : HAML, Sass, SCSS syntax
# markdown   : Markdown syntax
# surround   : parentheses, quotes, XML/HTML tags

for plugin in abolish afterimage endwise fugitive commentary \
        haml markdown surround; do
    if [ ! -d ${VIM_DIR}/bundle/vim-${plugin} ]; then
        git clone git://github.com/tpope/vim-${plugin}.git
    fi
done

# Alternate : switch quickly between .c & .h files
if     [ ! -f ${VIM_DIR}/plugin/a.vim ] \
    || [ ! -f ${VIM_DIR}/doc/alternate.txt ];then

    wget http://www.vim.org/scripts/download_script.php?src_id=7218 \
        -O ${VIM_DIR}/plugin/a.vim
    wget http://www.vim.org/scripts/download_script.php?src_id=6347 \
        -O ${VIM_DIR}/doc/alternate.txt
fi

# DelimitMate : automatic closing of quotes, parenthesis, brackets, etc.
if     [ ! -f ${VIM_DIR}/doc/delimitMate.txt ] \
    || [ ! -f ${VIM_DIR}/plugin/delimitMate.vim ];then
    cd /tmp/
    git clone git://github.com/Raimondi/delimitMate.git
    cd delimitMate/
    mv autoload/delimitMate.vim ${VIM_DIR}/autoload/
    mv doc/delimitMate.txt ${VIM_DIR}/doc/
    mv plugin/delimitMate.vim ${VIM_DIR}/plugin/
fi

# Gundo : easier undo tree visualization
if [ ! -d ${VIM_DIR}/bundle/gundo ]; then
    git clone http://github.com/sjl/gundo.vim.git ${VIM_DIR}/bundle/gundo
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
# NerdCommenter : Mapppings for comments
for plugin in tree commenter; do
if [ ! -d ${VIM_DIR}/bundle/nerd${plugin} ]; then
    cd ${VIM_DIR}/bundle/
    git clone git://github.com/scrooloose/nerd${plugin}.git
fi
done

# Rope : easier variables/functions renamming for Python
if [ ! -d ${VIM_DIR}/bundle/rope-vim ]; then
    cd ${VIM_DIR}/bundle/
    git clone git://github.com/klen/rope-vim.git
fi

# SnipMate : allow TextMate's snippets in Vim
if [ ! -f ${VIM_DIR}/autoload/snipMate.vim ]; then
    wget http://www.vim.org/scripts/download_script.php?src_id=11006 \
        -O /tmp/sm.zip
    unzip /tmp/sm.zip -d ~/.vim
fi

## Supertab : tab-completion (instead of <c-x><c-n>)
#if     [ ! -f ${VIM_DIR}/plugin/supertab.vim ] \
#    || [ ! -f ${VIM_DIR}/doc/supertab.txt ]; then
#
#    cd /tmp/
#    git clone git://github.com/ervandew/supertab.git
#    mv supertab/doc/supertab.txt ${VIM_DIR}/doc/
#    mv supertab/plugin/supertab.vim ${VIM_DIR}/plugin/
#
#fi

# Tabular : text line up made easy
if [ ! -d ${VIM_DIR}/bundle/tabular ]; then
    cd ${VIM_DIR}/bundle/
    git clone git://github.com/godlygeek/tabular.git
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

# Zencoding : HTML coding made faster
if     [ ! -f ${VIM_DIR}/plugin/zencoding.vim ] \
    || [ ! -f ${VIM_DIR}/autoload/zencoding.vim ]; then

    cd /tmp/
    git clone http://github.com/mattn/zencoding-vim.git
    cd zencoding-vim/
    mv plugin/zencoding.vim ${VIM_DIR}/plugin/
    mv autoload/zencoding.vim ${VIM_DIR}/autoload/
    
fi

# == themes ==

# 256-jungle
if [ ! -f ${VIM_DIR}/colors/256-jungle.vim ]; then
    wget http://www.vim.org/scripts/download_script.php?src_id=8685 \
        -O ${VIM_DIR}/colors/256-jungle.vim
fi

# Candycode
if [ ! -f ${VIM_DIR}/colors/candycode.vim ]; then
    wget http://www.vim.org/scripts/download_script.php?src_id=6066 \
        -O ${VIM_DIR}/colors/candycode.vim
fi

# Molokai
if [ ! -f ${VIM_DIR}/colors/molokai.vim ]; then
    cd /tmp/
    git clone git://github.com/tomasr/molokai.git
    mv molokai/colors/molokai.vim ${VIM_DIR}/colors/
fi

# Tomorrow
if [ ! -f ${VIM_DIR}/colors/Tomorrow.vim ]; then
    cd /tmp/
    git clone git://github.com/chriskempson/tomorrow-theme.git
    mv tomorrow-theme/vim/colors/Tomorrow* ${VIM_DIR}/colors/
fi

# == syntax ==

# Brainfuck
if [ ! -f ${VIM_DIR}/syntax/brainfuck.vim ]; then
    cd ${VIM_DIR}/syntax/
    wget http://www.vim.org/scripts/download_script.php?src_id=14054 \
        -O brainfuck.vim
fi

# CoffeeScript
if [ ! -d ${VIM_DIR}/bundle/vim-coffee-script ]; then
    cd ${VIM_DIR}/bundle/
    git clone https://github.com/kchmck/vim-coffee-script.git
fi

# CSS3
if [ ! -f ${VIM_DIR}/after/syntax/css.vim ]; then
    cd /tmp/
    git clone git://github.com/kight/CSS3-syntax-file-for-vim.git
    mkdir -p ${VIM_DIR}/after/syntax
    mv CSS3-syntax-file-for-vim/after/syntax/css.vim \
        ${VIM_DIR}/after/syntax/css.vim
fi

# Io
if [ ! -f ${VIM_DIR}/syntax/io.vim ]; then
    wget http://www.vim.org/scripts/download_script.php?src_id=8129 \
        -O ${VIM_DIR}/syntax/io.vim
fi

# Javascript
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

# JSON
if [ ! -f ${VIM_DIR}/syntax/json.vim ]; then
    wget http://www.vim.org/scripts/download_script.php?src_id=10853 \
        -O ${VIM_DIR}/syntax/json.vim
fi

# Mustache
if [ ! -d ${VIM_DIR}/bundle/mustache ]; then
    cd ${VIM_DIR}
    [ ! -d .git ] && git init
    git submodule add git://github.com/juvenn/mustache.vim.git bundle/mustache
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

# Asciidoc
if [ ! -f ${VIM_DIR}/syntax/asciidoc.vim ]; then
    wget http://www.vim.org/scripts/download_script.php?src_id=6891 \
        -O ${VIM_DIR}/syntax/asciidoc.vim
fi

# == snippets (for SnipMate plugin) ==

# Backbone

if [ ! -f ${VIM_DIR}/snippets/backbone.snippets ];then
    url='https://raw.github.com/gist/959876/ab6981b2a882'
    url="${url}57e823ebd0cc4ecc5eaf54eb5634/backbone.snippets"
    wget $url -O ${VIM_DIR}/snippets/backbone.snippets
fi

# == Omnicomplete ==

if     [ ! -f ${VIM_DIR}/autoload/javacomplete.vim ] \
    || [ ! -f ${VIM_DIR}/autoload/Reflection.java ] \
    || [ ! -f ${VIM_DIR}/autoload/java_parser.vim ] \
    || [ ! -f ${VIM_DIR}/doc/javacomplete.txt ]; then

    cd /tmp/
    wget http://www.vim.org/scripts/download_script.php?src_id=14914 \
        -O javacomplete.zip
    unzip javacomplete.zip && rm javacomplete.zip
    for f in java_parser.vim javacomplete.vim Reflection.java; do
        mv autoload/$f ${VIM_DIR}/autoload/$f
    done
    mv doc/javacomplete.txt ${VIM_DIR}/doc/

    # Note: for the first use, Reflection.java will be compiled
    #       to ~/Reflection.class . You should move it to ${VIM_DIR}/autoload/
fi

# Bundles cleaning
rm -Rf ${VIM_DIR}/bundle/*/.git
