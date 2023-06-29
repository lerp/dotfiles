#!/bin/zsh

xrandr --setprovideroutputsource modesetting NVIDIA-0
xrandr --auto
xrandr --output HDMI-0 --right-of DP-0
xrandr --output eDP-1-1 --right-of HDMI-0

if [ -d /etc/X11/xinit/xinitrc.d ]; then
    for f in /etc/X11/xinit/xinitrc.d/*; do
        [ -x "$f" ] && . "$f"
    done

    unset f
fi

export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$HOME/bin/:$PATH"

sxhkd &
wmname LG3D &

exec bspwm
