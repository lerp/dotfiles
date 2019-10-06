#!/bin/sh

icon_play="⏵"
icon_pause="⏸"
icon_stop="⏹"
icon_prev="⏮"
icon_next="⏭"

run_command() {
    playerctl -p spotifyd $@
}

get_status() {
    run_command status
}

get_metadata() {
    run_command metadata $@
}

case "$1" in
    --song)
        icon=""
        title="$(get_metadata artist) - $(get_metadata title)"

        if [[ "$(get_status)" == "Playing" ]]; then
            icon="$icon_pause"
        elif [[ "$(get_status)" == "Paused" ]]; then
            icon="$icon_play"
        fi

        echo "$icon $title"
        ;;
    *)
        run_command $@
        ;;
esac
