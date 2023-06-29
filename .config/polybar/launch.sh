#!/bin/sh

killall -q polybar

if type "xrandr"; then
  IFS=$'\n'
  for entry in $(xrandr --query | grep " connected"); do
    monitor=$(cut -d" " -f1 <<< "$entry")
    status=$(cut -d" " -f3 <<< "$entry")
    tray_pos=""

    if [ "$status" == "primary" ]; then
        tray_pos="right"
    fi

    MONITOR=$monitor TRAY_POS=$tray_pos polybar -r top 2>&1 \
        | tee -a /tmp/polybar-monitor-"$monitor".log \
        & disown
  done
  unset IFS
else
    polybar -r top 2>&1 | tee -a /tmp/polybar.log & disown
fi
