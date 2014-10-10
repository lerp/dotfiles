HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000

autoload -U compinit promptinit
compinit
promptinit

prompt walters

# Misc {{{

# Function for inserting sudo at the start of the line
insert_sudo() {
    if [[ $BUFFER != "sudo "* ]]; then
        BUFFER="sudo $BUFFER"
        CURSOR+=5
    fi
}
zle -N insert-sudo insert_sudo

# command-not-found hook
source /usr/share/doc/pkgfile/command-not-found.zsh

# }}}

# Keybindings {{{
typeset -g -A key
bindkey '^?' backward-delete-char   # Backspace
bindkey '^[[2~' overwite-mode       # Insert
bindkey '^[[3~' delete-char         # Delete
bindkey '^[[7~' beginning-of-line   # Home
bindkey '^[[8~' end-of-line         # End
bindkey '^S'    insert-sudo
# }}}

# Options {{{

# Change dir without typing cd
setopt autocd

# Disable flow control
setopt noflowcontrol

setopt appendhistory extendedglob
unsetopt beep nomatch notify

# }}}

# Vars {{{

# Make the default editor gvim
export EDITOR="gvim"

# }}}

# Aliases {{{
alias shutdown="sudo shutdown"
alias reboot="sudo reboot"
alias poweroff="sudo poweroff"
alias phone-tether="sudo dhcpcd enp0s26u1u2"
# }}}
