USER_SCRIPTS=$HOME/scripts

if test ! -z "${PATH##*$USER_SCRIPTS*}"; then
    export PATH=$PATH:$USER_SCRIPTS
fi

export BLACK=#1c1c1c
export WHITE=#c5c8c6
export RED=#cc6666
export ORANGE=#de935f
export YELLOW=#f0c674
export GREEN=#b5bd68
export AQUA=#8abeb7
export BLUE=#81a2be
export PURPLE=#b294bb
export GREY=#282a2e
export LIGHT_GREY=#5F5F5F
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/usr/local/lib
export MONITOR=DVI-I-1
