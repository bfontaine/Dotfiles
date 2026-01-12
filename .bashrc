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

# history length
# -- note that if it's too large Bash takes a lot of time to start
HISTSIZE=10000
HISTFILESIZE=40000

# don't add those commands to the history
HISTIGNORE="ls:cd:fg:history"
# don't put duplicate lines in the history nor lines starting with a space
HISTCONTROL=ignoreboth

# suffixes to remove from tab-completion.
FIGNORE=.swp:.swo:~

# make less more friendly for non-text input files
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# load a private .bashrc (i.e. not in dotfiles repo) if it exists
[ -f $HOME/.private_bashrc ] && . "$HOME/.private_bashrc";

# enable color support of ls/grep/…
DIRCOLOR=
[ -x /usr/bin/dircolors ] ||
    [[ $(tput -T"$TERM" colors) -ge 8 ]] && DIRCOLOR='--color=auto'

if [ -f /etc/bash_completion ] && ! shopt -oq posix; then
    . /etc/bash_completion
fi

PS1_PREFIX=' '
[ -z "$PS1_SYMBOL" ] && PS1_SYMBOL='λ'

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
        PROMPT_COMMAND='_bash_prompt_command';;
    *)
        ;;
esac

# need <C-d> twice to quit
ignoreeof=1

# variables
export EDITOR='vim'
export PS2='… '

# usual
alias pwd='pwd -P'

# alias '-' to 'cd -'
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

mkcd() { mkdir -p "$1" && cd "$1"; }

alias reload=". $HOME/.bash_profile"

alias g=git
alias m=mv
alias s=sudo
alias ff='find . -name "*~" -type f -delete'

# $PATH doesn't contain Homebrew's bin prefix at this point, so `which brew` or `command brew`
# don't work.
for brew_prefix in '/home/linuxbrew/.linuxbrew' "$HOME/.linuxbrew" '/usr/local/Homebrew'; do
  if [ -d "$brew_prefix" ]; then
    brew_binary="$brew_prefix/bin/brew"
    BREW_PREFIX=$("$brew_binary" --prefix)

    # z
    if [ -f "$BREW_PREFIX/etc/profile.d/z.sh" ]; then
      . "$BREW_PREFIX/etc/profile.d/z.sh"
    fi

    # Bash completion
    if [ -f "$BREW_PREFIX/etc/bash_completion" ]; then
      . "$BREW_PREFIX/etc/bash_completion"
    fi

    export PATH="$BREW_PREFIX/bin:$PATH:$BREW_PREFIX/sbin"
    export MANPATH="$BREW_PREFIX/share/man:$MANPATH"
    export INFOPATH="$BREW_PREFIX/share/info:$INFOPATH"
    export XDG_DATA_DIRS="$BREW_PREFIX/share:$XDG_DATA_DIRS"

    # Node
    export NODE_PATH="$BREW_PREFIX/lib/node_modules:$NODE_PATH"

    # Don't print hints about HOMEBREW_* env variables
    export HOMEBREW_NO_ENV_HINTS=1
    # Enable Homebrew developers-specific warnings/features
    export HOMEBREW_DEVELOPER=1
    # Disable Homebrew autoupdate
    export HOMEBREW_NO_AUTO_UPDATE=1
    # Don't print the 'beer' emoji
    export HOMEBREW_NO_EMOJI=1

    # Use the new internal API
    # https://github.com/Homebrew/brew/pull/20951
    export HOMEBREW_USE_INTERNAL_API=1

    alias b=brew

    break
  fi
done

# == Programming ==

alias vim='vim -p'
alias v=vim
alias sv='sudo vim -p'

# Node
export NODE_PATH='/usr/lib/node_modules'
export N_PREFIX="$HOME/.n"
if [ -d "$N_PREFIX" ]; then
  PATH="$N_PREFIX/bin:$PATH"
fi

# Python
[ -f "$HOME/.pythonrc.py" ] && export PYTHONSTARTUP=$HOME/.pythonrc.py
export VIRTUAL_ENV_DISABLE_PROMPT=1
export PYTHONIOENCODING=utf-8
export POETRY_VIRTUALENVS_IN_PROJECT=true

alias vpython="uv run python"

# pipx & poetry & uv
if [ -d "$HOME/.local/bin" ]; then
  PATH="$PATH:$HOME/.local/bin"
fi

# R
[ -d /usr/lib/R ] && export R_HOME='/usr/lib/R'

if [ -z "$(which n)" ]; then
  if [ -n "$(which node)" ]; then
    alias n=node
  else
    alias n=nodejs
  fi
fi

# Setup Amazon EC2 Command-Line Tools
export EC2_HOME="$HOME/.ec2"

if [ -d "$EC2_HOME" ]; then
    export EC2_PRIVATE_KEY=`\ls $EC2_HOME/pk-*.pem`
    export EC2_CERT=`\ls $EC2_HOME/cert-*.pem`
    export PATH="$PATH:$EC2_HOME/bin"
fi

# Safe default
export BROWSER='python3 -m webbrowser'

# custom autocomplete scripts
if [ -d "$HOME/.bash_utils/autocomplete" ]; then
    . "$HOME"/.bash_utils/autocomplete/*.sh
fi

if [ "$(uname)" = "Darwin" ]; then
  if [ -f "$HOME/.bashrc_osx" ]; then
    . "$HOME/.bashrc_osx"
  fi
elif [ -f "$HOME/.bashrc_linux" ]; then
    if [[ "$(uname -a)" =~ "Ubuntu" ]] || [[ "$(uname -a)" =~ "Linux" ]]; then
        . "$HOME/.bashrc_linux"
    fi
fi

# Ensure ~/bin is before everything else
export PATH="$HOME/bin:$PATH"

# OCaml
which opam >/dev/null && . "$HOME/.opam/opam-init/init.sh" &>/dev/null
export OCAML_TOPLEVEL_PATH="$HOME/.opam/system/lib/toplevel"

PATH_BEFORE_GOOGLE_CLOUD="$PATH"
if [ -f "$HOME/.gcloud/google-cloud-sdk/path.bash.inc" ]; then
  . "$HOME/.gcloud/google-cloud-sdk/path.bash.inc"
  . "$HOME/.gcloud/google-cloud-sdk/completion.bash.inc"
  # go at the end, thanks
  PATH="$PATH_BEFORE_GOOGLE_CLOUD:$HOME/.gcloud/google-cloud-sdk/bin"
fi

export PLANTUML_LIMIT_SIZE=15000

# Ansible
export ANSIBLE_NOCOWS=1

# https://github.com/docker/scan-cli-plugin/issues/149#issuecomment-823969364
export DOCKER_SCAN_SUGGEST=false

if [ ! -z "$(which gem)" ]; then
  PATH="$PATH:$(gem environment gemdir)/bin"
fi
