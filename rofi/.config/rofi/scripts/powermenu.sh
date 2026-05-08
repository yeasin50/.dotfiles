#!/usr/bin/env bash

# Your original options with icons
options="  Shutdown\n回  Reboot\n  Sleep\n󰗽  Logout"


chosen=$(echo -e "$options" | rofi -dmenu -i -p "Power:" \
    -font "JetBrainsMono Nerd Font 12" \
    -theme-str 'window {width: 250px;} listview {lines: 4;}' \
    -theme-str 'element {padding: 16px;}')

case "$chosen" in
    *Shutdown) systemctl poweroff ;;
    *Reboot) systemctl reboot ;;
    *Sleep) systemctl suspend ;;
    *Logout) i3-msg exit ;;
esac
