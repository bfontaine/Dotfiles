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

if [ ! -f ~/.ssh/config ]; then
  mkdir -p ~/.ssh
  cp base_ssh_config ~/.ssh/config
fi

echo "==> Done."
