# OPAM
if [ -d "$HOME/.opam" ]; then
  . $HOME/.opam/opam-init/init.sh > /dev/null 2>&1
  eval `opam config env`
fi
# NVM
[ -d "$HOME/.nvm" ] && . /Users/baptiste/.nvm/nvm.sh
# NPM
export PATH="/usr/local/share/npm/bin:$PATH"

. $HOME/.bashrc

# # Load RVM into a shell session *as a function*

[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*
