function fish_prompt
    set_color normal
    echo -n " "(basename (pwd))
    set_color yellow
    echo -n " λ "
    set_color normal
end

# no greeting
function fish_greeting;end

## common aliases

alias c "cd -P"
alias f "find"
alias g "git"
alias l "ls -FGhg"
alias m "mv"
alias n "node"
alias o "open"
alias s "sudo"
alias v "vim -p"

alias ct "cat"
alias du "du -h"
alias df "df -h"
alias f~ "find . -name \"*~\" -delete"
alias la "ls -a"
alias lr "ls -R"
alias ps "ps -x"
alias sv "sudo vim -p"
alias vg "vagrant"

alias -  "cd -"
alias +x "chmod u+x"

alias less   "less -R"
alias locaml "ledit ocaml"
alias python "python3"
alias pker   "ping -c 1 kernel.org"
alias top    "htop"

function mkcd
    mkdir -p $argv ; and cd $argv
end
