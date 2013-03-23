# Inspired of github.com/sdball/dotfiles/blob/master/.irbrc
# Ruby 1.8.7 compatible
require 'rubygems'
require 'irb/completion'

# interactive editor: use vim from within irb
begin
  require 'interactive_editor'
rescue LoadError => err
  warn "Couldn't load interactive_editor: #{err}"
  warn "Use 'gem install interactive_editor'"
end

# awesome print
begin
  require 'awesome_print'
  AwesomePrint.irb!
rescue LoadError => err
  warn "Couldn't load awesome_print: #{err}"
  warn "Use 'gem install awesome_print'"
end

# configure irb
IRB.conf[:PROMPT_MODE] = :SIMPLE
IRB.conf[:AUTO_INDENT] = true

# irb history
IRB.conf[:EVAL_HISTORY] = 100
IRB.conf[:SAVE_HISTORY] = 2000
IRB.conf[:HISTORY_FILE] = File::expand_path('~/.irbhistory')
