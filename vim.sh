#! /bin/bash
#
# Post-Installation Script for Vim (deprecated, see .vimrc)
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

vim_script() { # path num
    local name=${1}.vim
    local fname=${VIM_DIR}/${name}
    local url=http://www.vim.org/scripts/download_script.php?src_id=$2

    if [ ! -f "${fname}" ]; then
        echo "--> $name"
        wget -q $url -O "${fname}";
    else
        echo "[ok] $name"
    fi
}

# Vim-plug
curl -sfLo "$VIM_DIR/autoload/plug.vim" \
  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

# == syntax ==

vim_script syntax/abnf       5805 # ABNF
vim_script syntax/icalendar  5573 # iCalendar
vim_script syntax/io         8129 # Io
