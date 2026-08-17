#!/usr/bin/env bash

set -e

THEME_ROOT="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"
THEME_NAME="${1:-}"

if [[ -z "$THEME_NAME" ]]; then
    echo "Usage: $0 <theme>"
    echo
    find "$THEME_ROOT" -mindepth 1 -maxdepth 1 -type d -printf '%f\n'
    exit 1
fi

THEME="$THEME_ROOT/$THEME_NAME"

[[ -d "$THEME" ]] || {
    echo "Theme not found: $THEME_NAME"
    exit 1
}

echo "Applying: $THEME_NAME"

# set wallpaper env
# bspwm reload gonna handle setting with feh,
WALLPAPER="$THEME/wallpaper.jpg"
sed -i "s|^WALLPAPER=.*|WALLPAPER=\"$WALLPAPER\"|" ~/.config/bspwm/env.sh

# BSPWM
cp "$THEME/bspwm.sh" "$HOME/.config/bspwm/bspwm.sh"

# Polybar
cp "$THEME/polybar.ini" "$HOME/.config/polybar/colors.ini"

# Rofi
cp "$THEME/rofi.rasi" "$HOME/.config/rofi/theme.rasi"

# btop
cp "$THEME/btop.theme" "$HOME/.config/btop/themes/current.theme"

# WezTerm
cp "$THEME/wezterm.toml" "$HOME/.config/wezterm/theme.toml"

# Reload BSPWM
bspc wm -r

# Restart Polybar
pkill polybar || true
polybar main >/dev/null 2>&1 &

echo "Applied: $THEME_NAME"
