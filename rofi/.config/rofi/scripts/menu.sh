#!/bin/bash

choice=$(printf "🧭 Apps\n📝 note\n📋 kaban\n🖥️ desktopMode\n🎥 recordMode" | rofi -dmenu -i -p "Menu")

[ -z "$choice" ] && exit 0

case "$choice" in
    *Apps*)
        rofi -show drun
        ;;
    *note*)
        ~/.config/rofi/scripts/rofi_note.sh
        ;;
    *kaban*)
        ~/.config/rofi/scripts/kaban.sh
        ;;
    *desktopMode*)
        bash -ic desktopMode
        ;;
    *recordMode*)
        bash -ic recordMode
        ;;
esac
