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
    *Logout)
        if pgrep -x bspwm >/dev/null; then
            bspc quit
        elif pgrep -x i3 >/dev/null; then
            i3-msg exit
        else
            cinnamon-session-quit --logout --no-prompt 2>/dev/null || \
            loginctl terminate-session "$XDG_SESSION_ID"
        fi
    ;;
esac
