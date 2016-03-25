# Options
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000

setopt noflowcontrol
setopt appendhistory extendedglob
setopt promptsubst
unsetopt beep nomatch notify

# Keybindings
typeset -g -A key

bindkey '^?'    backward-delete-char    # Backspace
bindkey '^[[2~' overwite-mode           # Insert
bindkey '^[[3~' delete-char             # Delete
bindkey '^[[7~' beginning-of-line       # Home
bindkey '^[[8~' end-of-line             # End
bindkey '^S'    insert-sudo

# Prompt
autoload -U colors && colors

coloured() {
    local c='black'

    if [[ $# -ge 2 ]]; then
        c=$2
    fi

    echo "%{$fg_bold[$c]%}$1%{$reset_color%}"
}

local user_host="%n$(coloured '@')%m"
local current_dir=" %~ "

PROMPT="╭─${user_host}${current_dir}
╰─$ "

# Misc
# Function for inserting sudo at the start of the line
insert_sudo() {
    if [[ $BUFFER != "sudo "* ]]; then
        BUFFER="sudo $BUFFER"
        CURSOR+=5
    fi
}

zle -N insert-sudo insert_sudo

# Aliases
alias poweroff="sudo poweroff"
alias reboot="sudo reboot"
alias shutdown="sudo shutdown"
alias sudo="sudo -E"
alias config="git --git-dir=$HOME/.cfg/ --work-tree=$HOME"
