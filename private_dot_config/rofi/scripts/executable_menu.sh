#!/bin/bash

# Format: "Icon Name: Description"
options="📝 note: Neovim Notes
📋 kaban: Obsidian Kanban
🖥️  desktopMode: System Layout
🎥 recordMode: Screen Record
📦 vboxmode: VirtualBox
🚀 kvmmode: QEMU/KVM"

choice_row=$(echo -e "$options" | rofi -dmenu -i -p "Menu" -lines 10)

choice=$(echo "$choice_row" | awk '{print $2}' | tr -d ':')

[[ -z "$choice" ]] && exit 0

case "$choice" in
    "note")        ~/.config/rofi/scripts/rofi_note.sh ;;
    "kaban")       ~/.config/rofi/scripts/kaban.sh ;;
    "desktopMode") bash -ic desktopMode ;;
    "recordMode")  bash -ic recordMode ;;
    "vboxmode")    bash -ic vboxmode ;;
    "kvmmode")     bash -ic kvmmode ;;
esac
