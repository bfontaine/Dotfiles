. $HOME/.bashrc

# RVM
[[ -s "$HOME/.rvm/scripts/rvm" ]] && . "$HOME/.rvm/scripts/rvm"
# OPAM
. $HOME/.opam/opam-init/init.sh > /dev/null 2>&1
# NVM
[[ -s /Users/baptiste/.nvm/nvm.sh ]] && . /Users/baptiste/.nvm/nvm.sh
# NPM
export PATH="/usr/local/share/npm/bin:$PATH"
