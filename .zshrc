# added by travis gem
[ -f /Users/baptiste/.travis/travis.sh ] && source /Users/baptiste/.travis/travis.sh

export PATH="$PATH:$HOME/.rvm/bin" # Add RVM to PATH for scripting

# https://github.com/homebrew/homebrew-command-not-found
. $(brew --prefix)/Library/Taps/homebrew/homebrew-command-not-found/handler.sh

# http://stackoverflow.com/a/26479426/735926
autoload -U compinit && compinit
zmodload -i zsh/complist
