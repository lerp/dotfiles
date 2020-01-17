HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000

export ZSH="/home/james/.oh-my-zsh"
export VISUAL=nvim
export EDITOR=nvim

ZSH_THEME="bira"
plugins=(
    autojump
    git
    pip
)

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
alias gdb="gdb -q"

bindkey '^S' insert-sudo

export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"

eval $(thefuck --alias)
