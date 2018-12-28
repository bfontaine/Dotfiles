#! /bin/bash
cd ~/.vim/bundle/Command-T/ruby/command-t/ext/command-t || exit

ruby=$(vim --version | grep -Eo -m 1 '/\S+ruby/[0-9.]+/lib' | head -1 | sed 's%lib$%bin/ruby%')

if [ -z "$ruby" ] || [ ! -x "$ruby" ]; then
  ruby="ruby"
else
  echo "Using ruby from $ruby"
fi

[ -f Makefile ] && make clean
$ruby extconf.rb
make
