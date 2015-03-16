# added by travis gem
[ -f /Users/baptiste/.travis/travis.sh ] && source /Users/baptiste/.travis/travis.sh

export PATH="$PATH:$HOME/.rvm/bin" # Add RVM to PATH for scripting

# https://github.com/bfontaine/homebrew-command-not-found
. $(brew --prefix)/Library/Taps/bfontaine/homebrew-command-not-found/handler.sh
