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

# Vars
export EDITOR="gvim"
export JAVA_HOME=/usr/lib/jvm/java-7-jdk/jre/
export USER_SCRIPTS=$HOME/dotfiles/scripts
export PATH=$PATH:$USER_SCRIPTS
export _JAVA_OPTIONS='-Dawt.useSystemAAFontSettings=on -Dswing.aatext=true -Dswing.crossplatformlaf=com.sun.java.swing.plaf.gtk.GTKLookAndFeel'

# Colours
export WHITE=#C5C8C6
export BLACK=#1D1F21
export DARK_GRAY=#373B41
export LIGHT_GRAY=#969896
export RED=#CC6666
export ORANGE=#DE935F
export YELLOW=#F0C674
export GREEN=#B5BD68
export AQUA=#8ABEB7
export BLUE=#81A2BE
export PURPLE=#B294BB

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

# Hooks
source /usr/share/doc/pkgfile/command-not-found.zsh

