#!/bin/zsh

if [ -d /etc/X11/xinit/xinitrc.d ]; then
    for f in /etc/X11/xinit/xinitrc.d/*; do
        [ -x "$f" ] && . "$f"
    done

    unset f
fi

VBoxClient-all
sxhkd &
wmname LG3D &

exec bspwm
