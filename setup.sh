#! /bin/bash

echo "==> Vim"
VIM_DIR=~/.vim

echo "--> Create user directories"
for dir in after autoload backups colors doc \
                    ftdetect indent plugin scripts \
                    snippets syntax after/syntax; do
    mkdir -p ${VIM_DIR}/$dir
done

echo "--> Install Vim-plug"
curl -#fLo ~/.vim/autoload/plug.vim \
  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

echo "==> Done."
