. $HOME/.bashrc

# RVM
# OPAM
. $HOME/.opam/opam-init/init.sh > /dev/null 2>&1
eval `opam config env`
# NVM
[[ -s /Users/baptiste/.nvm/nvm.sh ]] && . /Users/baptiste/.nvm/nvm.sh
# NPM
export PATH="/usr/local/share/npm/bin:$PATH"

[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*
