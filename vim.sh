#! /bin/bash
#
# Post-Installation Script for Vim
#
# Author: Baptiste Fontaine <b@ptistefontaine.fr>
# URL: https://github.com/bfontaine/Dotfiles/blob/master/vim.sh
# License: MIT


VIM_DIR=~/.vim

for dir in after autoload backups colors doc \
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

# Vim-plug
curl -sfLo "$VIM_DIR/autoload/plug.vim" \
  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

# == plugins ==

vim_script scripts/closetag.vim  4318 # Close tag

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
