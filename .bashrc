# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# don't put duplicate lines in the history, nor lines starting with a space
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend
# git-like `**` path expansion
shopt -s globstar
# don't try to complete empty lines
shopt -s no_empty_cmd_completion
# `echo` expands backslash-escape sequences by default
shopt -s xpg_echo
# update the values of LINES and COLUMNS after each command
shopt -s checkwinsize
# if a command name is the name of a directory, cd into it
shopt -s autocd

# This option is used to map ^W, and even if you bind another action
# on ^W in your .inputrc, it always take precedence, so you have
# to explicitely undefine it.
stty werase undef

# history length (very large for stats)
HISTSIZE=600
HISTFILESIZE=30000

# make less more friendly for non-text input files
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

[ -f ~/.private_bashrc ] && . ~/.private_bashrc;

# enable color support of ls/grep/…
DIRCOLOR=
[ -x /usr/bin/dircolors ] ||
    [[ $(tput -T$TERM colors) -ge 8 ]] && DIRCOLOR='--color=auto'

if [ -f /etc/bash_completion ] && ! shopt -oq posix; then
    . /etc/bash_completion
fi

prompt_special_char="⚡"
if [ "$(uname)" == "Darwin" ]; then prompt_special_char="%";fi

function _bash_prompt_command {

    local NEWPWD=$PWD
    local l=30
    local GITPROMPT=' '
    local TMP=
    local GITBR=
    local ROOTPROMPT=

    [ $EUID -eq 0 ] && ROOTPROMPT='[#]'

    local GITSTATUS=$(git status 2> /dev/null)

    if [ $? -eq 0 ]; then
        echo $GITSTATUS | grep 'not staged' &> /dev/null
        if [ $? -eq 0 ]; then
            if [ $DIRCOLOR ]; then
                GITPROMPT="\[\033[1;31m\]+\[\033[0m\]"
            else
                GITPROMPT='+'
            fi
        fi

        GITBR=$(git describe --contains --all HEAD 2> /dev/null)

        if [ $? -eq 0 ]; then
            if [ $DIRCOLOR ]; then
                GITPROMPT=" \033[0;36m{$GITBR}\[\033[0m\]$GITPROMPT";
            else
                GITPROMPT=" {$GITBR}$GITPROMPT";
            fi
        fi

    fi

    # Replace "/home/foo" with "~"
    NEWPWD=${PWD//$HOME/\~}

    # get current path, with only the first letter of the parent directoy, e.g.:
    #
    #  /home/alice/foo -> a/foo
    #
    NEWPWD=$(echo $NEWPWD | perl -pe 's%.*/(.)[^/]*(?=/)%\1%')
    
    if [ $DIRCOLOR ]; then
        # colors
        PS1="\h:${NEWPWD}${ROOTPROMPT}${GITPROMPT}\[\033[1;33m\]${prompt_special_char}\[\033[0m\] "
    else
        # no colors
        PS1="\h:${NEWPWD}${ROOTPROMPT}${GITPROMPT}${prompt_special_char} "
    fi
}

case $TERM in
    xterm*|rxvt*|aterm|kterm|gnome*)
        _bash_prompt_command;
        PROMPT_COMMAND='_bash_prompt_command';;
    *)
        ;;
esac

# Print to PDF files
mkdir -p ~/PDF

# need <C-d> twice to quit
ignoreeof=1

# variables
export EDITOR='vim'
export PS2='… '
export PATH="$PATH:$HOME/Documents/Programmation/Android/sdk/tools:$HOME/bin"

APPS_DIR="$HOME/Applications"

# == Programming ==

alias vim='vim -p'

# Clojure
hash clojure 2>/dev/null && alias clj=clojure

# Java
export JAVA_HOME=/usr/

# Node
export NODE_PATH='/usr/lib/node_modules'

# OCaml
alias locaml='ledit ocaml'
# OPAM configuration
[[ -d "$HOME/opam" ]] && . "$HOME/.opam/opam-init/init.sh"

# Python
alias python='python3'
export PYTHONSTARTUP=~/.pythonrc.py

# R
export R_HOME='/usr/lib/R'

# Ruby
[[ -s "$HOME/.rvm/scripts/rvm" ]] && . "$HOME/.rvm/scripts/rvm"

# usual
alias ps='ps x'
alias top='htop'
alias cd='cd -P'
alias du='du -h'
alias df='df -h'

alias -- -='cd -'

alias ack='ack-grep'

alias  grep="grep $DIRCOLOR"
alias fgrep="fgrep $DIRCOLOR"
alias egrep="egrep $DIRCOLOR"

alias la='ls -a'
alias lr='ls -R'

function mkcd { mkdir -p $1 && cd $1; }
function prettyjson { python -mjson.tool < $1; }
# adapted from http://www.commandlinefu.com/commands/view/3837/encode-image-to-base64-and-copy-to-clipboard
function base64 { uuencode -m $1 /dev/stdout | sed '1d' | sed '$d' | tr -d '\n'; }

hash xclip 2>/dev/null && \
    alias xclip='xclip -selection "clipboard"'

alias sag='sudo apt-get'
alias sai='sudo apt-get install'
alias mt='sag update; sag upgrade --yes && sag dist-upgrade --yes \
            && sag autoremove --yes && sag autoclean'

alias aptis='aptitude search'

# bashrc
alias reload='source ~/.bashrc'

# git
# see github.com/icefox/git-achievements
[ $(which git-achievements) ] && alias git='git-achievements'

# one-letter shortcuts
alias c=cd
alias g=git
alias l="ls -Fhg $DIRCOLOR --group-directories-first"
alias m=mv
alias n=node
alias s=sudo
alias v=vim

# two-letters ones
alias ct=cat
alias ev=evince
alias f~='find . -name "*~" -delete'
alias fn='find . -name'
alias mk=make

# apps
alias chromium='chromium-browser'
if [ -f $APPS_DIR/minecraft.jar ]; then
    alias minecraft="padsp java -jar $APPS_DIR/minecraft.jar";
    alias mc=minecraft;
fi
alias yuicompressor="java -jar $APPS_DIR/yuicompressor-2.4.7.jar"
alias closurecompiler="java -jar $APPS_DIR/GoogleClosureCompiler/compiler.jar"

[ -f $APPS_DIR/Chunky/Chunky.jar ] && alias chunky="java -jar $APPS_DIR/Chunky/Chunky.jar"

alias sl='sl -e'
alias LS='LS -e'

# Personal scripts
for f in $HOME/bin/functions/*.sh; do [ -x $f ] && . $f; done

# Internet
alias flushDNS='sudo rndc flush'
alias pker='ping -c 1 -w 1 kernel.org'

# Flash cookies
rm -Rf ~/.adobe/*
rm -Rf ~/.macromedia/*
