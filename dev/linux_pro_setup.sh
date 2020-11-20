#! /bin/bash -ex
sudo apt update
sudo apt upgrade
sudo apt install vim git curl

mkdir -p ~/GitHub
pushd ~/GitHub
git clone http://github.com/bfontaine/Dotfiles.git
pushd Dotfiles
for f in .ackrc .bash_profile .bashrc .bashrc_linux .ctags .cvsignore .emacs \
  .gemrc .gitattributes .gitconfig .hushlogin .inputrc .irbrc .pythonrc.py \
  .safe-rm .up-commands .vimrc .zshrc \
; do
  rm -f "$HOME/$f"
  ln -s "$f" "$HOME/$f"
done

cp -r .bash_utils ~/
mkdir -p ~/.config
cp -r .config/fish ~/.config/

mkdir -p ~/bin
cp bin/* ~/bin/

# Vim
cp -r .vim ~/
./setup.sh

