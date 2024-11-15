if status is-interactive
    nvm use lts
    eval (ssh-agent -c)
end

set fish_greeting ""

if type -q eza
    alias ll "eza -l -g --icons"
    alias lla "ll -a"
end

# pnpm
set -gx PNPM_HOME "/home/yannick/.local/share/pnpm"
if not string match -q -- $PNPM_HOME $PATH
  set -gx PATH "$PNPM_HOME" $PATH
end
# pnpm end
