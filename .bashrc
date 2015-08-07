# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# don't put duplicate lines in the history nor lines starting with a space
HISTCONTROL=ignoreboth

# save multi-lines commands in the history
shopt -s cmdhist
# append to the history file, don't overwrite it
shopt -s histappend
# enable re-edition of failed commands
shopt -s histreedit
# load history substitutions in the readline buffer
shopt -s histverify
# don't try to complete empty lines
shopt -s no_empty_cmd_completion
# `echo` expands backslash-escape sequences by default
shopt -s xpg_echo
# update the values of LINES and COLUMNS after each command
shopt -s checkwinsize
# if a command name is the name of a directory, cd into it
shopt -s autocd

# disable file overriding with >
set -C

# This option is used to map ^W, and even if you bind another action
# on ^W in your .inputrc, it always take precedence, so you have
# to explicitely undefine it.
stty werase undef

# disable XON/XOFF flow control (^S & ^Q). This prevent Vim from freezing when
# you accidentally type ^S.
stty -ixon

# history length (very large for stats)
HISTSIZE=600
HISTFILESIZE=50000

# suffixes to remove from tab-completion.
FIGNORE=.swp:swo:~

# make less more friendly for non-text input files
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# load a private .bashrc (i.e. not in dotfiles repo) if it exists
[ -f $HOME/.private_bashrc ] && . $HOME/.private_bashrc;

# enable color support of ls/grep/…
DIRCOLOR=
[ -x /usr/bin/dircolors ] ||
    [[ $(tput -T$TERM colors) -ge 8 ]] && DIRCOLOR='--color=auto'

if [ -f /etc/bash_completion ] && ! shopt -oq posix; then
    . /etc/bash_completion
fi

PS1_PREFIX=' '
PS1_SYMBOL='λ'

function _bash_prompt_command {

    ## git prompt

    local GITPROMPT=
    local GITUNSTAGED=' '
    local GITBR=

    [ $EUID -eq 0 ] && PS1_SYMBOL='#'

    local GITSTATUS=$(git status --porcelain 2> /dev/null)

    if [ $? -eq 0 ]; then
        if [ "$GITSTATUS" ]; then
            if [ $DIRCOLOR ]; then
                GITUNSTAGED="\[\033[1;31m\]+\[\033[0m\]"
            else
                GITUNSTAGED='+'
            fi
        fi

        GITBR=$(git describe --contains --all HEAD 2> /dev/null)

        if [ $? -eq 0 ]; then
            if [ $DIRCOLOR ]; then
                GITPROMPT="\[\033[0;36m\]{$GITBR}\[\033[0m\]$GITUNSTAGED";
            else
                GITPROMPT="{$GITBR}$GITUNSTAGED";
            fi
        fi
    fi

    PS1="${PS1_PREFIX}\W ${GITPROMPT}";
    if [ $DIRCOLOR ]; then
        # colors
        PS1="${PS1}\[\033[1;33m\]${PS1_SYMBOL}\[\033[0m\] "
    else
        # no colors
        PS1="${PS1}${PS1_SYMBOL} "
    fi
}

# If connected through SSH, print the hostname
if [ -n "$SSH_CLIENT" ] || [ -n "$SSH_TTY" ] || [ -n "$SSH_CONNECTION" ]; then
    PS1_PREFIX=' \h:'
fi

case $TERM in
    xterm*|rxvt*|aterm|kterm|gnome*)
        _bash_prompt_command;
        PROMPT_COMMAND='_bash_prompt_command';;
    *)
        ;;
esac

# need <C-d> twice to quit
ignoreeof=1

# variables
export EDITOR='vim'
export PS2='… '

# more binaries
export PATH="$PATH:/usr/local/sbin:$HOME/bin"

# == Programming ==

alias vim='vim -p'

# Node
export NODE_PATH='/usr/lib/node_modules'

# OCaml
alias locaml='ledit ocaml'

# Python
[ -f "$HOME/.pythonrc.py" ] && export PYTHONSTARTUP=$HOME/.pythonrc.py
export VIRTUAL_ENV_DISABLE_PROMPT=1
export PYTHONIOENCODING=utf-8

# R
export R_HOME='/usr/lib/R'

# usual
alias ps='ps x'
alias top='htop'
alias du='du -h'
alias df='df -h'

alias pwd='pwd -P'

# print kill commands
alias pkill='pkill -l'

if [ -x "$HOME/bin/git-achievements" ]; then
    alias git=git-achievements
fi

alias -- -='cd - >/dev/null'
alias +x='chmod u+x'

alias less='less -R'
if [ -d "$HOME/.bash_utils" ]; then
    export LESSOPEN="|$HOME/.bash_utils/lesspipe.sh %s"
fi

alias  grep="grep $DIRCOLOR"
alias fgrep="fgrep $DIRCOLOR"
alias egrep="egrep $DIRCOLOR"

alias la='ls -a'
alias lr='ls -R'

function mkcd() { mkdir -p "$1" && cd "$1"; }

alias reload=". $HOME/.bash_profile"

# one-letter shortcuts
alias c='cd -P'
alias g=git
alias m=mv
alias n=node
alias s=sudo
alias v=vim

alias M=make

# two-letters ones
alias ct=cat
alias ff='find . -name "*~" -delete'
alias sv='sudo vim -p'

# Setup Amazon EC2 Command-Line Tools
export EC2_HOME=$HOME/.ec2

if [ -d "$EC2_HOME" ]; then
    export EC2_PRIVATE_KEY=`\ls $EC2_HOME/pk-*.pem`
    export EC2_CERT=`\ls $EC2_HOME/cert-*.pem`
    export PATH=$PATH:$EC2_HOME/bin
fi

# Safe default
export BROWSER='python -m webbrowser'

# custom autocomplete scripts
if [ -d "$HOME/.bash_utils/autocomplete" ]; then
    . "$HOME"/.bash_utils/autocomplete/*.sh
fi

if [ "`uname`" = "Darwin" ] && [ -f "$HOME/.bashrc_osx" ]; then
    . $HOME/.bashrc_osx
elif [[ "`uname -a`" =~ "Ubuntu" ]] || [[ "`uname -a`" =~ "Linux" ]]; then
    if [ -f "$HOME/.bashrc_linux" ]; then
        . $HOME/.bashrc_linux
    fi
fi

p7pp() {
    $BROWSER "https://p7pp.herokuapp.com/search/url?q=$*"
}

# Bash autocomplete for 'aws'
which aws >/dev/null && complete -C aws_completer aws

# avoid pranks where a script adds random stuff at the end of the ~/.bashrc
# http://blog.bfontaine.net/2015/01/17/preventing-bash-pranks/

b=tu
a=r
c=rn
d=n
${a}e$b$c
