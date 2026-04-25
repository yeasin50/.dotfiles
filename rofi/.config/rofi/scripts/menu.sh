#!/bin/bash

# Format: "Icon Name: Description"
options="📝 note: Neovim Notes
📋 kaban: Obsidian Kanban
🖥️  desktopMode: System Layout
🎥 recordMode: Screen Record
📦 vboxmode: VirtualBox
🚀 ventoryQemu: QEMU/KVM os path"

choice_row=$(echo -e "$options" | rofi -dmenu -i -p "Menu" -lines 10)

choice=$(echo "$choice_row" | awk '{print $2}' | tr -d ':')

[[ -z "$choice" ]] && exit 0

case "$choice" in
    "note")        ~/.config/rofi/scripts/rofi_note.sh ;;
    "kaban")       ~/.config/rofi/scripts/kaban.sh ;;
    "desktopMode") bash -ic desktopMode ;;
    "recordMode")  bash -ic recordMode ;;
    "vboxmode")    bash -ic vboxmode ;;
    "ventoryQemu")     bash -ic ventoryQemu ;;
esac
