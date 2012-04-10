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

# evide <c-d>
ignoreeof=1

# variables
export EDITOR="vim"
export PS2="... "

export PYTHONPATH="$PYTHONPATH:$HOME/Documents/Programmation/libs/python"

# Bean Shell
export CLASSPATH="$CLASSPATH:$HOME/Documents/Programmation/libs/java/bsh-2.0b4.jar"

export DEBFULLNAME="Baptiste Fontaine"
export DEBEMAIL="batifon@yahoo.fr"

# usuelles
alias rm="rm -i"
alias rmdir="rm -Ri"

function mkcd() { mkdir $1 && cd $1; }

alias ps="ps x"

alias shred="shred -n 50 -z -u"
alias wipe="wipe -r -i -Q 50"

alias ls="ls -Fgh --color --group-directories-first"
alias lsa="ls -a"
alias l=ls
alias lszip="unzip -l"

alias grep="grep -n"

alias top="htop"

alias cd="cd -P"

alias du="du -h"
alias df="df -h"

alias sag="sudo apt-get"
alias sai="sudo apt-get install"
alias saupg="sudo apt-get upgrade"
alias saupd="sudo apt-get update"
alias saar="sudo apt-get autoremove --purge"
alias sagautoclean="sudo apt-get autoclean"

alias aptis="aptitude search"

alias xclip="xclip -selection clipboard"

alias maintenance="saupd && saupg && saar && sudo updatedb"

alias xlogo="xlogo -render"

alias up7c="~/Documents/Programmation/UP7_Tools/up7connect.rb"

# java
alias jInterpreter="java bsh.Interpreter"

# python
alias python="python3"

# ruby
alias irb="irb1.9.1"
alias ruby="ruby1.9.1"
alias gem="gem1.9.1"

# ocaml
alias locaml="ledit ocaml"

# repertoires & fichiers
alias bureau="cd ~/Bureau"

alias openbashrc="vim ~/.bashrc"
alias reload="source ~/.bashrc"

mkdir -p ~/PDF

# svn
alias svnlog="svn log | less"

# apps
alias chromium="chromium-browser"

alias fortune="fortune -e"

alias msn="empathy"
alias pdf="evince"
alias sudoku="gnome-sudoku"
alias transmission="transmission-gtk"
# alias velib="lugdulov"
# alias okawix="~/Documents/okawix/okawix"
alias MoM="~/Applications/MoM/MoM"

alias aoe2="wine \"~/.wine/drive_c/Program Files/Microsoft Games/Age of Empires II/EMPIRE2.EXE\""
alias aoes="aoe_says"

alias starwars="telnet towel.blinkenlights.nl"

alias sl="sl -e"
alias LS="LS -e"

# perso

#alias clr="~/Documents/Programmation/AppsPerso/clr/clr.sh"
#alias sca="clr"
alias clr="clr -v"

alias maintenance="~/Documents/Programmation/AppsPerso/maintenance/maintenance.sh"
alias adressbook="~/Documents/Programmation/AppsPerso/adressbook/main.py"

alias dispo_clavier="xbkprint -color :0 -ll -o layout.ps;gv layout.ps"

alias updatepacketslist="dpkg -l > ~/Ubuntu\ One/liste-paquets-netbook.txt"

for f in ~/Documents/Programmation/AppsPerso/fonctions/*.sh;
do
    if test -x $f;
    then
        . $f;
    fi
done

# scripts
alias MER="~/Documents/Programmation/AppsPerso/mer.py"

alias exif-img="~/Documents/scripts/exif-img.sh"

alias "php-sh"="php-shell.sh"

# web
alias aspiSite="wget -r -k -np"
alias viderDNS="sudo rndc flush"
alias adzhosts="~/Documents/Programmation/ExternApps/adzhosts.sh"
alias whatweb="~/Applications/whatweb-0.4.7/whatweb"
alias python2server="python2.7 -m SimpleHTTPServer"
alias apache2-restart="sudo /etc/init.d/apache2 restart"

# Securite
# alias upmsf="sudo svn update /opt/metasploit3/msf3/"
# alias sqlmap="~/Documents/Programmation/ExternApps/sqlmap/sqlmap.py"

# Reseau
# si l'IP ne change pas c'est bon
# alias netbook_sshfs="sshfs baptiste@192.168.1.26:/home/baptiste /home/baptiste/_netbook"
# alias netbook_unsshfs="fusermount -u ~/_netbook"

alias fac_sshfs="sshfs fontaine@nivose.informatique.univ-paris-diderot.fr:/info/nouveaux/fontaine/ /home/baptiste/_fac"
alias fac_unsshfs="fusermount -u ~/_fac"

# scripts
# alias "php-sh"="php-shell.sh"

# multimedia
alias webcam-watch-only="mplayer tv://"

# misc
alias umlascii="ditaa"

# stopper/ralentir les blagueurs
# alias alias="echo 'et mon cul, c'est du poulet ?';"
# ulimit -u 256

if [ $COLUMNS -lt 45 ];
then
        # Petit terminal
        export PS1="% ";
        alias ls="ls -F --color --group-directories-first";
fi

# demarrage
# linux_logo -a -L ubuntu
# clr
cp ~/.bashrc ~/.copie_bashrc-auto

rm -f ~/Ubuntu\ One/*u1conflict*

clear
echo Bonjour \!
echo 
