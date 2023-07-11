# NVM
[ -d "$HOME/.nvm" ] && . $HOME/.nvm/nvm.sh
# NPM
export PATH="/usr/local/share/npm/bin:$PATH"

. $HOME/.bashrc

 # Load RVM into a shell session *as a function*
[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm"
[[ -s /etc/profile.d/rvm.sh ]] && source /etc/profile.d/rvm.sh
