#!/bin/sh

LIST="$HOME/.config/rofi/scripts/emoji.txt"

emoji=$(rofi -dmenu -i -p "Emoji" -theme-str 'listview { columns: 5; lines: 10; } window { width: 50%; }' < "$LIST" | awk '{print $1}')

if [ -n "$emoji" ]; then
    printf "%s" "$emoji" | xclip -selection clipboard
    sleep 0.1
    xdotool key ctrl+v
fi
