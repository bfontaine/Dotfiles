# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# don't put duplicate lines in the history. See bash(1) for more options
# ... or force ignoredups and ignorespace
HISTCONTROL=ignoredups:ignorespace

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "$debian_chroot" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
#force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	# We have color support; assume it's compliant with Ecma-48
	# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
	# a case would tend to support setf rather than setaf.)
	color_prompt=yes
    else
	color_prompt=
    fi
fi

if [ "$color_prompt" = yes ]; then
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if [ -f /etc/bash_completion ] && ! shopt -oq posix; then
    . /etc/bash_completion
fi

# ------------------------------------------------------
#                      PERSO
# ------------------------------------------------------

# need <C-d> twice to quit
ignoreeof=1

# variables
export EDITOR="vim"
export PS2="... "

export PATH="$PATH:/opt/scala/bin"

# Python
export PYTHONPATH="$PYTHONPATH:$HOME/Documents/Programmation/libs/python"

# Ruby
alias irb="irb1.9.1"
alias gem="gem1.9.1"

# Rails
export PATH="$PATH:/var/lib/gems/1.8/bin"

# Bean Shell
export CLASSPATH="$CLASSPATH:$HOME/Documents/Programmation/libs/java/bsh-2.0b4.jar"

export DEBFULLNAME="Baptiste Fontaine"
export DEBEMAIL="batifon@yahoo.fr"

# usual
alias rm="rm -i"
alias rmdir="rm -Ri"

function mkdc() { mkdir $1 && cd $1; }

alias ps="ps x"

alias shred="shred -n 50 -z -u"
alias wipe="wipe -r -i -Q 50"

alias top="htop"

alias ls='ls -Fhg --color --group-directories-first'
alias l=ls
alias lsa='ls -a'
alias lszip="unzip -l"

alias cd="cd -P"

alias du="du -h"
alias df="df -h"

alias sag="sudo apt-get"
alias sai="sudo apt-get install"
alias saupg="sudo apt-get upgrade"
alias saupd="sudo apt-get update"
alias saar="sudo apt-get autoremove --purge"
alias sagautoclean="sudo apt-get autoclean"

alias aptisearch="aptitude search"

alias xlogo="xlogo -render"

alias pker="ping kernel.org"

# java
alias jInterpreter="java bsh.Interpreter"
alias minecraft="padsp java -jar ~/Applications/minecraft.jar"

# python
alias python="python3"

# ocaml
alias locaml="ledit ocaml"

# bash files
alias openbashrc="vim ~/.bashrc"
alias reload="source ~/.bashrc"

mkdir -p ~/PDF

# svn
alias svnlog="svn log | less"

# apps
alias chromium="chromium-browser"

alias sudoku="gnome-sudoku"
alias velib="lugdulov"
alias okawix="~/Documents/okawix/okawix"
alias MoM="~/Applications/MoM/MoM"
alias processing="sh ~/Applications/processing-1.5.1/processing"
alias gephi="~/Applications/gephi/bin/gephi"

alias apache_restart="sudo /etc/init.d/apache2 restart"

alias sl="sl -e"
alias LS="LS -e"

# perso

for f in ~/Documents/Programmation/AppsPerso/fonctions/*.sh;
do
    if [ -x $f ];then
        . $f;
    fi
done

# http://www.commandlinefu.com/commands/view/9824/resolve-short-urls
resolve() { curl -Is $1 | sed -n 's/^Location: //p'; }

# web
alias flushDNS="sudo rndc flush"
alias python2server="python2.7 -m SimpleHTTPServer"

if [ $COLUMNS -lt 35 ];
then
        # small terminal
        export PS1="% ";
        alias ls="ls -F --color --group-directories-first";
fi

# Flash cookies
rm -Rf ~/.adobe/*
rm -Rf ~/.macromedia/*

# demarrage
# linux_logo -a -L ubuntu
# clr
cp ~/.bashrc ~/.copie_bashrc-auto
clear
echo Bonjour \! # Hello !
echo 
