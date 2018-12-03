#! /bin/bash
cd ~/.vim/bundle/Command-T/ruby/command-t/ext/command-t || exit
[ -f Makefile ] && make clean
ruby extconf.rb
make
