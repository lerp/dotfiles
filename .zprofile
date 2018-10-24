if [[ ! $DISPLAY && $XDG_VTNR -eq 1 ]]; then
  exec startx -- :0
fi
