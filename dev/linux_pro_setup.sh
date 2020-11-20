#! /bin/bash -ex
sudo apt update
sudo apt upgrade
sudo apt install --yes vim git curl make ruby safe-rm

mkdir -p ~/GitHub
pushd ~/GitHub
git clone http://github.com/bfontaine/Dotfiles.git
pushd Dotfiles

cp -r .bash_utils ~/
mkdir -p ~/.config
cp -r .config/fish ~/.config/

mkdir -p ~/bin
cp bin/* ~/bin/

# Vim
cp -r .vim ~/
./setup.sh

popd # Dotfiles
popd # GitHub

for f in .ackrc .bash_profile .bashrc .bashrc_linux .ctags .cvsignore .emacs \
  .gemrc .gitattributes .gitconfig .hushlogin .inputrc .irbrc .pythonrc.py \
  .safe-rm .up-commands .vimrc .zshrc \
; do
  rm -f "$HOME/$f"
  ln -s "$HOME/GitHub/Dotfiles/$f" "$HOME/$f"
done
