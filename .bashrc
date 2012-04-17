# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# don't put duplicate lines in the history.
# … or force ignoredups and ignorespace
HISTCONTROL=ignoredups:ignorespace

# append to the history file, don't overwrite it
shopt -s histappend

# history length
HISTSIZE=1000
HISTFILESIZE=2000

# update the values of LINES and COLUMNS after each command
shopt -s checkwinsize

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "$debian_chroot" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
    # We have color support; assume it's compliant with Ecma-48
    # (ISO/IEC-6429). (Lack of such support is extremely rare, and such
    # a case would tend to support setf rather than setaf.)
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

# enable color support of ls/grep/…
if [ -x /usr/bin/dircolors ]; then
    alias   grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

if [ -f /etc/bash_completion ] && ! shopt -oq posix; then
    . /etc/bash_completion
fi

# ------------------------------------------------------
#                      PERSO
# ------------------------------------------------------

# need <C-d> twice to quit
ignoreeof=1

# variables
export EDITOR='vim'
export PS2='... '
export PATH="$PATH:$HOME/bin"

# Scala
export PATH="$PATH:/opt/scala/bin"

# Python
export PYTHONPATH="$PYTHONPATH:$HOME/Documents/Programmation/libs/python"

# Ruby
alias ruby='ruby1.9.1'
alias irb='irb1.9.1'
alias gem='gem1.9.1'

# Rails
export PATH="$PATH:/var/lib/gems/1.8/bin"

# Node.js
export NODE_PATH='/usr/lib/nodejs'

# Bean Shell
export CLASSPATH="$CLASSPATH:$HOME/Documents/Programmation/libs/java/bsh-2.0b4.jar"

export DEBFULLNAME='Baptiste Fontaine'
export DEBEMAIL='batifon@yahoo.fr'

# usual
alias rm='rm -i'
alias rmdir='rm -Ri'

mkcd() { mkdir $1 && cd $1; }

alias ps='ps x'

alias shred='shred -n 50 -z -u'
alias wipe='wipe -r -i -Q 50'

alias top='htop'

alias ls='ls -Fhg --color --group-directories-first'
alias l=ls
alias lsa='ls -a'
alias lszip='unzip -l'

alias cd='cd -P'

alias du='du -h'
alias df='df -h'

alias sag='sudo apt-get'
alias sai='sudo apt-get install'
alias saupg='sudo apt-get upgrade'
alias saupd='sudo apt-get update'

alias aptis='aptitude search'

alias pker='ping -c 1 -w 1 kernel.org'

# java
alias jInterpreter='java bsh.Interpreter'
alias minecraft='padsp java -jar ~/Applications/minecraft.jar'

# python
alias python='python3'

# ocaml
alias locaml='ledit ocaml'

# bashrc
alias openbashrc='vim ~/.bashrc'
alias reload='source ~/.bashrc'

mkdir -p ~/PDF

# git
# see github.com/icefox/git-achievements
alias git='git-achievements'

# apps
alias chromium='chromium-browser'

alias MoM='~/Applications/MoM/MoM'
alias processing='sh ~/Applications/processing-1.5.1/processing'
alias gephi='~/Applications/gephi/bin/gephi'

alias apache_restart='sudo /etc/init.d/apache2 restart'

alias sl='sl -e'
alias LS='LS -e'

for f in $HOME/bin/functions/*.sh;
do
    [ -x $f ] && . $f;
done

# perso
alias up7c='~/Documents/Programmation/UP7_Tools/up7connect.rb'

# http://www.commandlinefu.com/commands/view/9824/resolve-short-urls
resolve() { curl -Is $1 | sed -n 's/^Location: //p'; }

# web
alias flushDNS='sudo rndc flush'
alias python2server='python2.7 -m SimpleHTTPServer'

if [ $COLUMNS -lt 35 ];
then
        # small terminal
        export PS1='% ';
        alias ls='ls -F --color --group-directories-first';
fi

# Flash cookies
rm -Rf ~/.adobe/*
rm -Rf ~/.macromedia/*

# starting
cp ~/.bashrc ~/.bashrc_autosave
clear
echo Bonjour \! # Hello !
echo 
