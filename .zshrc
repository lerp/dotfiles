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
bindkey '${terminfo[khome]}' beginning-of-line  # Home
bindkey '${terminfo[kend]}'	 end-of-line        # End
bindkey '^S'    insert-sudo

# Prompt
autoload -U colors && colors
autoload -Uz vcs_info

coloured() {
    local c='black'

    if [[ $# -ge 2 ]]; then
        c=$2
    fi

    echo "%{$fg_bold[$c]%}$1%{$reset_color%}"
}

zstyle ':vcs_info:*' enable git 
zstyle ':vsc_info:*' check-for-changes true
zstyle ':vcs_info:*' branchformat '%F{green}%b%f'
zstyle ':vcs_info:*' formats '(%b)'

precmd() {
	vcs_info
}

local user_host="%n$(coloured '@')%m"
local current_dir=" %~ "

PROMPT="╭─${user_host}${current_dir}${vcs_info_msg_0_}
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
