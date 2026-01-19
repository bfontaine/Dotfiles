#! /bin/bash -ex
sudo apt update
sudo apt upgrade
sudo apt install --yes vim git curl make ruby safe-rm xclip build-essential file terminator kolourpaint \
    fonts-powerline ansible-core imapfilter mplayer zlib1g-dev nmap gnome-tweaks tree whois filezilla composer ffmpeg \
    python3-pip apt-transport-https

sudo snap install firefox
sudo snap install slack

mkdir -p ~/GitHub
git clone http://github.com/bfontaine/Dotfiles.git ~/GitHub/Dotfiles
pushd ~/GitHub/Dotfiles

cp -r .bash_utils ~/
mkdir -p ~/.config
cp -r .config/fish ~/.config/

mkdir -p ~/bin
cp bin/* ~/bin/

# Vim
cp -r .vim ~/
./setup.sh

popd

for f in .ackrc .bash_profile .bashrc .bashrc_linux .ctags .cvsignore .emacs \
  .gemrc .gitattributes .gitconfig .hushlogin .inputrc .irbrc .pythonrc.py \
  .safe-rm .up-commands .vimrc .zshrc .keyboard \
  .config/fish .config/ghostty .config/nvim \
; do
  rm -f "$HOME/$f"
  ln -s "$HOME/GitHub/Dotfiles/$f" "$HOME/$f"
done

for d in fish ghostty nvim \
; do
  rm -rf "$HOME/.config/$d"
  ln -s "$HOME/GitHub/Dotfiles/.config/$d" "$HOME/.config/$d"
done
