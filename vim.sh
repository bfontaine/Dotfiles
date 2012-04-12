#! /bin/bash
#
# Post-Installation Script for Vim
#


VIM_DIR=~/.vim

for dir in after autoload backups bundle colors doc \
                    ftdetect indent plugin syntax; do
    mkdir -p ${VIM_DIR}/$dir
done

# == plugins ==

# pathogen
if ! [ -f ${VIM_DIR}/autoload/pathogen.vim ]; then
    wget http://www.vim.org/scripts/download_script.php?src_id=16224 \
        -O ${VIM_DIR}/autoload/pathogen.vim
fi

cd ${VIM_DIR}/bundle/

# nerdtree     : File tree

if ! [ -d ${VIM_DIR}/bundle/nerdtree ]; then
    git clone git://github.com/scrooloose/nerdtree.git;
fi

# fugitive     : Git wrapper
# markdown     : Markdown syntax
# haml         : HAML, Sass, SCSS syntax
# surround     : parentheses, quotes, XML/HTML tags
# commentary   : Universal shortcut to comment (programing)
# abolish      : String replacement with word variants

for plugin in fugitive markdown haml surround commentary abolish; do
    if ! [ -d ${VIM_DIR}/bundle/vim-${plugin} ]; then
        git clone git://github.com/tpope/vim-${plugin}.git;
    fi
done

# zencoding    : HTML coding made faster

if     ! [ -f ${VIM_DIR}/plugin/zencoding.vim ] \
    || ! [ -f ${VIM_DIR}/autoload/zencoding.vim ]; then

    cd /tmp/
    git clone http://github.com/mattn/zencoding-vim.git
    cd zencoding-vim/
    mv plugin/zencoding.vim ${VIM_DIR}/plugin/
    mv autoload/zencoding.vim ${VIM_DIR}/autoload/
    
fi

# l9           : Vim-script library (required by `autocomplpop`)

# if     ! [ -d ${VIM_DIR}/autoload/l9 ]   \
#     || ! [ -f ${VIM_DIR}/plugin/l9.vim ] \
#     || ! [ -f ${VIM_DIR}/doc/l9.txt ]; then
# 
#     cd /tmp/
#     wget https://bitbucket.org/ns9tks/vim-l9/get/tip.zip -O tip.zip
#     unzip -u tip.zip
#     cd ns9tks-vim-l9-*
#     mv plugin/l9.vim ${VIM_DIR}/plugin/
#     mv doc/l9.txt ${VIM_DIR}/doc/
#     mv autoload/l9 ${VIM_DIR}/autoload/l9
#     mv autoload/l9.vim ${VIM_DIR}/autoload/l9.vim
# 
# fi
# 
# autocomplpop : Pop-up for autocompletion
#
# if    ! [ -f ${VIM_DIR}/plugin/acp.vim ] \
#    || ! [ -f ${VIM_DIR}/doc/acp.txt ]; then
# 
#     cd /tmp/
#     wget https://bitbucket.org/ns9tks/vim-autocomplpop/get/tip.zip -O tip.zip
#     unzip -u tip.zip
#     cd ns9tks-vim-autocomplpop-*
#     mv plugin/acp.vim ${VIM_DIR}/plugin/
#     mv doc/acp.txt ${VIM_DIR}/doc/
#     mv autoload/acp.vim ${VIM_DIR}/autoload/
# 
# fi

# matchit : extended % matching for HTML, LaTeX, etc

if     ! [ -f ${VIM_DIR}/plugin/matchit.vim ] \
    || ! [ -f ${VIM_DIR}/doc/matchit.txt ]; then

    cd ${VIM_DIR}
    wget http://www.vim.org/scripts/download_script.php?src_id=8196 \
        -O matchit.zip
    unzip matchit.zip
    rm -f matchit.zip
fi

# alternate : switch quickly between .c & .h files
if     ! [ -f ${VIM_DIR}/plugin/a.vim ] \
    || ! [ -f ${VIM_DIR}/doc/alternate.txt ];then

    wget http://www.vim.org/scripts/download_script.php?src_id=7218 \
        -O ${VIM_DIR}/plugin/a.vim
    wget http://www.vim.org/scripts/download_script.php?src_id=6347 \
        -O ${VIM_DIR}/doc/alternate.txt
fi

# Rope : easier variables/functions renamming for Python
if ! [ -d ${VIM_DIR}/bundle/rope-vim ]; then
    cd ${VIM_DIR}/bundle/
    git clone git://github.com/klen/rope-vim.git
fi

# snipMate : allow TextMate's snippets in Vim

if ! [ -f ${VIM_DIR}/autoload/snipMate.vim ]; then
    wget http://www.vim.org/scripts/download_script.php?src_id=11006 \
        -O /tmp/sm.zip
    unzip /tmp/sm.zip -d ~/.vim
fi

# Gundo : easier undo tree visualization

if ! [ -d ${VIM_DIR}/bundle/gundo ]; then
    git clone http://github.com/sjl/gundo.vim.git ${VIM_DIR}/bundle/gundo
fi

# After-image : edit small images with vim

if ! [ -d ${VIM_DIR}/bundle/afterimage ]; then
    git clone git://github.com/tpope/vim-afterimage.git \
        ${VIM_DIR}/bundle/afterimage
fi

# == themes ==

# 256-jungle

if ! [ -f ${VIM_DIR}/colors/256-jungle.vim ]; then
    wget http://www.vim.org/scripts/download_script.php?src_id=8685 \
        -O ${VIM_DIR}/colors/256-jungle.vim
fi

# Molokai

if ! [ -f ${VIM_DIR}/colors/molokai.vim ]; then
    cd /tmp/
    git clone git://github.com/tomasr/molokai.git
    mv molokai/colors/molokai.vim ${VIM_DIR}/colors/
fi

# Tomorrow

if ! [ -f ${VIM_DIR}/colors/Tomorrow.vim ]; then
    cd /tmp/
    git clone git://github.com/chriskempson/tomorrow-theme.git
    mv tomorrow-theme/vim/colors/Tomorrow* ${VIM_DIR}/colors/
fi

# == syntax ==

# Brainfuck

if ! [ -f ${VIM_DIR}/syntax/brainfuck.vim ]; then
    cd ${VIM_DIR}/syntax/
    wget http://www.vim.org/scripts/download_script.php?src_id=14054 \
        -O brainfuck.vim
fi

# Scala
# see http://lorenzod8n.wordpress.com/2008/01/11/
#        getting-scala-syntax-hightlighting-to-work-in-vim/

for dir in ftdetect indent syntax; do

    if ! [ -f ${VIM_DIR}/${dir}/scala.vim ]; then
        wget https://lampsvn.epfl.ch/trac/scala/export/26099/scala-tool-support/trunk/src/vim/${dir}/scala.vim \
            -O ${VIM_DIR}/${dir}/scala.vim
    fi

done

# CoffeeScript

if ! [ -d ${VIM_DIR}/bundle/vim-coffee-script ]; then
    cd ${VIM_DIR}/bundle/
    git clone https://github.com/kchmck/vim-coffee-script.git
fi

# CSS3

if ! [ -f ${VIM_DIR}/after/syntax/css.vim ]; then
    cd /tmp/
    git clone git://github.com/kight/CSS3-syntax-file-for-vim.git
    mkdir -p ${VIM_DIR}/after/syntax
    mv CSS3-syntax-file-for-vim/after/syntax/css.vim \
        ${VIM_DIR}/after/syntax/css.vim
fi
