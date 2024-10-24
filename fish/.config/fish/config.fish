if status is-interactive
    nvm use lts
    eval (ssh-agent -c)
end

set fish_greeting ""

if type -q eza
    alias ll "eza -l -g --icons"
    alias lla "ll -a"
end
