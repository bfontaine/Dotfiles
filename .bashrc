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

function _bash_prompt_command() {

    local NEWPWD=$PWD
    local l=30
    local GITPROMPT=' '
    local ROOTPROMPT=

    [ $EUID -eq 0 ] && ROOTPROMPT='[#]'

    local GITSTATUS=$(git status 2> /dev/null)

    if [ $? -eq 0 ]; then
        echo $GITSTATUS | grep 'not staged' > /dev/null 2>&1
        [ $? -eq 0 ] && GITPROMPT="\[\033[1;31m\]+\[\033[0m\]"
    fi

    # replace $HOME with '~'
    [ ${PWD:0:${#HOME}} == $HOME ] && NEWPWD="~${PWD##$HOME}"

    # if pwd > 30 chars, add '…' before and keep only 30 chars
    [ ${#NEWPWD} -gt $l ] && NEWPWD=…${NEWPWD:$((${#NEWPWD}-${l})):${#NEWPWD}}

    # no colors:
    #PS1="\[\033[G\]\u@\h:${NEWPWD}[\$] ⚡ "
    
    # We assume that we have color support
    PS1="\u@\h:${NEWPWD}${ROOTPROMPT}${GITPROMPT}\[\033[1;33m\]⚡\[\033[0m\] "
}

case $TERM in
    xterm*|rxvt*|aterm|kterm|gnome*)
        _bash_prompt_command;
        PROMPT_COMMAND='_bash_prompt_command';;
    *)
        ;;
esac

mkdir -p ~/PDF

# need <C-d> twice to quit
ignoreeof=1

# variables
export EDITOR='vim'
export PS2='... '
export PATH="$PATH:$HOME/bin"

export DEBFULLNAME='Baptiste Fontaine'
export DEBEMAIL='batifon@yahoo.fr'

# Add home directory to the cd PATH
export CDPATH=:~

# == Programming ==

alias vim='vim -p'

# C. Lisp
alias clisp="clisp -q"

# OCaml
alias locaml='ledit ocaml'

# Processing
alias processing='sh ~/Applications/processing-1.5.1/processing'

# Python
export PYTHONPATH="$PYTHONPATH:$HOME/Documents/Programmation/libs/python"
alias python='python3'

# R
export R_HOME='/usr/lib/R'

# Ruby
alias ruby='ruby1.9.1'
alias irb='irb1.9.1'
alias gem='gem1.9.1'

# Scala
export PATH="$PATH:/opt/scala/bin"

# usual
alias rm='rm -i'
alias rmdir='rm -Ri'
alias ps='ps x'
alias top='htop'
alias cd='cd -P'
alias du='du -h'
alias df='df -h'

alias ls='ls -Fhg --color --group-directories-first'
alias la='ls -a'
alias lszip='unzip -l'

function mkcd() { mkdir $1 && cd $1; }
function vimtmp() { vim $(tempfile).$1; }
function prettyjson() { python -mjson.tool < $1; }

alias xclip='xclip -selection "clipboard"'

# perso
alias up7c='~/Documents/Programmation/UP7_Tools/up7connect.rb'
# see launchpad.net/clr
alias clr='clr -vd'

alias sag='sudo apt-get'
alias sai='sudo apt-get install'
alias saupg='sudo apt-get upgrade'
alias saupd='sudo apt-get update'

alias aptis='aptitude search'

# bashrc
alias openbashrc='vim ~/.bashrc'
alias reload='source ~/.bashrc'

# git
# see github.com/icefox/git-achievements
alias git='git-achievements'

# one-letter shortcuts
alias c=cat
alias g=git
alias l=ls

# apps
alias chromium='chromium-browser'
alias minecraft='padsp java -jar ~/Applications/minecraft.jar'
alias MoM='~/Applications/MoM/MoM'
alias gephi='~/Applications/gephi/bin/gephi'
[ -x ~/Applications/tetris ] && alias tetris="~/Applications/tetris";

alias sl='sl -e'
alias LS='LS -e'

for f in $HOME/bin/functions/*.sh;
do
    [ -x $f ] && . $f;
done

# Internet
alias flushDNS='sudo rndc flush'
alias pker='ping -c 1 -w 1 kernel.org'
resolve() { curl -Is $1 | sed -n 's/^Location: //p'; }

if [ $COLUMNS -lt 35 ];
then
        # small terminal
        PS1='\u@\h:\W\n\$ '
        alias ls='ls -F --color --group-directories-first';
fi

# Flash cookies
rm -Rf ~/.adobe/*
rm -Rf ~/.macromedia/*

# starting
clear
echo Bonjour \! # Hello !
echo 
