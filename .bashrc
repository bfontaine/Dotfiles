# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# Default language
[ -z "$LC_ALL" ] && LC_ALL=en_US.UTF-8

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
# don't expand PS1's value, e.g. PS1='$(echo yo)' doesn't become 'yo'
shopt -u promptvars

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
HISTSIZE=100000
HISTFILESIZE=400000

# don't add those commands to the history
HISTIGNORE="ls:cd:fg:history"
# don't put duplicate lines in the history nor lines starting with a space
HISTCONTROL=ignoreboth

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
export PATH="$PATH:/usr/local/sbin"

# == Programming ==

alias vim='vim -p'

# Node
export NODE_PATH='/usr/lib/node_modules'

# OCaml
alias locaml="ledit -x -h '$HOME/.ocaml_history' ocaml"

# Python
[ -f "$HOME/.pythonrc.py" ] && export PYTHONSTARTUP=$HOME/.pythonrc.py
export VIRTUAL_ENV_DISABLE_PROMPT=1
export PYTHONIOENCODING=utf-8

# R
[ -d /usr/lib/R ] && export R_HOME='/usr/lib/R'

# usual
alias top='htop'
alias du='du -h'
alias df='df -h'

alias pwd='pwd -P'

# print kill commands
alias pkill='pkill -l'

alias -- -='cd - >/dev/null'
alias +x='chmod u+x'

alias less='less -R'
if [ -x "$HOME/.bash_utils/lesspipe.sh" ]; then
    export LESSOPEN="|$HOME/.bash_utils/lesspipe.sh %s"
fi

alias  grep="grep $DIRCOLOR"
alias fgrep="fgrep $DIRCOLOR"
alias egrep="egrep $DIRCOLOR"

alias la='ls -a'
alias lr='ls -R'

mkcd() { mkdir -p "$1" && cd "$1"; }

alias reload=". $HOME/.bash_profile"

alias c='cd -P'
alias g=git
alias m=mv
alias n=node
alias s=sudo
alias v=vim
alias M=make
alias ct=cat
alias ff='find . -name "*~" -type f -delete'
alias sv='sudo vim -p'

if [ x"$(which node)" != x ]; then
  alias n=node
else
  alias n=nodejs
fi

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

# Ensure ~/bin is before everything else
export PATH="$HOME/bin:$PATH"

# Use Go 1.5 vendor directory
export GO15VENDOREXPERIMENT=1

# OCaml
which opam >/dev/null && . .opam/opam-init/init.sh &>/dev/null
export OCAML_TOPLEVEL_PATH="$HOME/.opam/system/lib/toplevel"

if [ -f "$HOME/.gcloud/google-cloud-sdk/path.bash.inc" ]; then
  . $HOME/.gcloud/google-cloud-sdk/path.bash.inc
  . $HOME/.gcloud/google-cloud-sdk/completion.bash.inc
fi

export PLANTUML_LIMIT_SIZE=15000

# Ansible
export ANSIBLE_NOCOWS=1

alias vpip=./venv/bin/pip
alias v3="virtualenv --python python3 venv"
alias freeze="./venv/bin/pip freeze >| requirements.txt"

vpython() { PYTHONPATH=. ./venv/bin/python $*; }
zprint_inplace() { zprint < $1 | sponge $1; }
