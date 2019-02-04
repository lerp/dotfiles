HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000

export ZSH="/home/james/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
ZSH_THEME="bira"
plugins=(
    autojump
    git
    pip
)

bindkey '^R' fzf-history-widget
bindkey '^S' insert-sudo
zle -N insert-sudo insert_sudo

insert_sudo() {
    if [[ $BUFFER != "sudo "* ]]; then
        BUFFER="sudo $BUFFER"
        CURSOR+=5
    fi
}

source $ZSH/oh-my-zsh.sh
source /usr/share/fzf/completion.zsh
source /usr/share/fzf/key-bindings.zsh

alias sudo="sudo -E"
alias config="git --git-dir=$HOME/.cfg/ --work-tree=$HOME"
