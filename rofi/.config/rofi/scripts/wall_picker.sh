#!/usr/bin/env bash

WALL_DIR="/home/yeasin/Pictures/bg"

selected=$(find "$WALL_DIR" -maxdepth 1 -type f \( -iname "*.jpg" -o -iname "*.png" -o -iname "*.jpeg" -o -iname "*.webp" \) -exec basename {} \; | while read -r file; do
    echo -en "$file\0icon\x1f$WALL_DIR/$file\n"
done | rofi -dmenu -i -p "󰸉 Wallpapers" -theme-str '
    window { width: 60%; }
    listview { columns: 4; lines: 3; flow: horizontal; }
    element { orientation: vertical; padding: 10px; }
    element-icon { size: 150px; }
    element-text { horizontal-align: 0.1; }')

if [[ -n "$selected" ]]; then
    img="$WALL_DIR/$selected"
    
    # feh --bg-fill "$IMAGE"
    feh --bg-fill "$img"
    wallust run "$img"

    # saving for bspwm restart
    sed -i "s|^WALLPAPER=.*|WALLPAPER=\"$img\"|" ~/.config/bspwm/env.sh
    bspc wm -r && pkill -USR1 -x sxhkd
    cowsay "theme updated"
fi
