killall -q sxhkd picom polybar

sxhkd &

# wallpaper first (optional but clean)
feh --bg-fill ~/Pictures/bg/window_bluish.png &

# start compositor 
 # picom --config ~/.config/picom/picom.conf -b &

# polybar after layout
~/.config/polybar/launch.sh &
