USER_SCRIPTS=$HOME/scripts

if test ! -z "${PATH##*$USER_SCRIPTS*}"; then
    export PATH=$PATH:$USER_SCRIPTS
fi

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
