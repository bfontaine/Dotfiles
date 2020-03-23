# Inspired of github.com/sdball/dotfiles/blob/master/.irbrc
# Ruby 1.8.7 compatible
require 'rubygems'
require 'irb/completion'

# list methods of an object
def w(obj)
  obj.public_methods.sort - Object.methods
end

# configure irb
IRB.conf[:PROMPT_MODE] = :SIMPLE
IRB.conf[:AUTO_INDENT] = true

# irb history
IRB.conf[:EVAL_HISTORY] = 100
IRB.conf[:SAVE_HISTORY] = 2000
IRB.conf[:HISTORY_FILE] = File::expand_path('~/.irbhistory')

# this is so I can test for this variable in my scripts
$BFN_IRB = true
