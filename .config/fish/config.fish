function fish_prompt
    set_color normal
    echo -n " "(basename (pwd))
    set_color yellow
    echo -n " λ "
    set_color normal
end

## common aliases

function +x
    command chmod u+x $argv
end

function du
    command du -h $argv
end

function df
    command df -h $argv
end

function g
    command git $argv
end

function l
    command ls -FGhg $argv
end

function locaml
    command ledit ocaml $argv
end

function ps
    command ps -x $argv
end

function top
    command htop $argv
end

function v
    command vim -p $argv
end
