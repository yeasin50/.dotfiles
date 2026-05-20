#!/usr/bin/env bash

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
ROOT_DIR="$(cd "$SCRIPT_DIR/.." && pwd)"

source "$ROOT_DIR/lib/packages.sh"
source "$ROOT_DIR/lib/fonts.sh"

need() {
    ! command -v "$1" >/dev/null 2>&1
}

echo "Installing bspwm setup..."

# --- packages ---
if command -v pacman >/dev/null; then
    need bspwm && install_pkg bspwm
    need sxhkd && install_pkg sxhkd
    need polybar && install_pkg polybar
    need picom && install_pkg picom
    need feh && install_pkg feh
    need rofi && install_pkg rofi
    need xrandr && install_pkg xorg-xrandr
    need stow && install_pkg stow

elif command -v apt >/dev/null; then
    need bspwm && install_pkg bspwm
    need sxhkd && install_pkg sxhkd
    need polybar && install_pkg polybar
    need picom && install_pkg picom
    need feh && install_pkg feh
    need rofi && install_pkg rofi
    need xrandr && install_pkg x11-xserver-utils
    need stow && install_pkg stow
fi

# --- fonts ---
install_fonts

# --- stow configs ---
# /// TODO:  goto parent dir and stow each  one install &  stow 
# echo "Stowing configs..."
# stow -t "$HOME/.config" bspwm
# stow -t "$HOME/.config" sxhkd
# stow -t "$HOME/.config" polybar
# stow -t "$HOME/.config" picom
# stow -t "$HOME/.config" rofi

# --- permissions ---
echo "Fixing permissions..."
find "$HOME/.config/bspwm" -type f -name "*.sh" -exec chmod +x {} \;

chmod +x "$HOME/.config/bspwm/bspwmrc"
chmod +x "$HOME/.config/polybar/launch.sh"

# --- reload ---
echo "Reloading bspwm..."

if pgrep -x bspwm >/dev/null; then
    bspc wm -r || true
fi

if pgrep -x sxhkd >/dev/null; then
    pkill -USR1 -x sxhkd || true
fi

echo "bspwm setup done"
