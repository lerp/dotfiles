#set background colour
exec --no-startup-id xsetroot -solid "#000000"
exec --no-startup-id feh      --bg-fill /home/james/Wallpapers/archlogo.png

#Set mod
set $mod Mod1

#Set the font
font pango:DejaVu Sans Mono 9

# Use Mouse+$mod to drag floating windows to their wanted position
floating_modifier $mod

# start a terminal
bindsym $mod+t exec i3-sensible-terminal

# kill focused window
bindsym $mod+Shift+q kill

# start dmenu (a program launcher)
bindsym $mod+d exec dmenu_run

# change focus
bindsym $mod+h focus left
bindsym $mod+j focus down
bindsym $mod+k focus up
bindsym $mod+l focus right

# move focused window
bindsym $mod+Shift+h move left
bindsym $mod+Shift+j move down
bindsym $mod+Shift+k move up
bindsym $mod+Shift+l move right

# split
bindsym $mod+s split h
bindsym $mod+i split v

# enter fullscreen mode for the focused container
bindsym $mod+f fullscreen

# Start dino file manager
bindsym $mod+Shift+f exec --no-startup-id dino

# toggle tiling / floating
bindsym $mod+space floating toggle

# move focused container to workspace
bindsym $mod+1 move container to workspace 1
bindsym $mod+2 move container to workspace 2

# reload the configuration file
bindsym $mod+Shift+c reload
# restart i3 inplace (preserves your layout/session, can be used to upgrade i3)
bindsym $mod+Shift+r restart
# exit i3 (logs you out of your X session)
bindsym $mod+Shift+e exec "i3-nagbar -t warning -m 'You pressed the exit shortcut. Do you really want to exit i3? This will end your X session.' -b 'Yes, exit i3' 'i3-msg exit'"

# 3 pixel border
new_window pixel 3

# colours                border  background text    indicator
client.focused           #556779 #556779    #FFFFFF #FFB964
client.focused_inactive  #444444 #444444    #FFFFFF #FFB964
client.unfocused         #333333 #333333    #FFFFFF #FFB964
client.urgent            #FAD07A #FAD07A    #FFFFFF #FFB964

# resize window (you can also use the mouse for that)
mode "resize" {
    bindsym h resize shrink width 10 px or 10 ppt
    bindsym j resize grow height 10 px or 10 ppt
    bindsym k resize shrink height 10 px or 10 ppt
    bindsym l resize grow width 10 px or 10 ppt

    bindsym Return mode "default"
    bindsym Escape mode "default"
}

bindsym $mod+r mode "resize"

# Start i3bar to display a workspace bar (plus the system information i3status
# finds out, if available)
bar {
    position top
    status_command i3status
    tray_output DP-0

    colors {
        background #151515
        statusline #FFFFFF
        separator  #FFFFFF

        # colours          border  background text
        focused_workspace  #556779 #556779    #FFFFFF
        active_workspace   #444444 #444444    #FFFFFF
        inactive_workspace #333333 #333333    #FFFFFF
        urgent_workspace   #FAD07A #FAD07A    #FFFFFF
    }
}
