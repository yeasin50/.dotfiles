#!/usr/bin/env bash
set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
ROOT_DIR="$(cd "$SCRIPT_DIR/.." && pwd)"

source "$ROOT_DIR/lib/packages.sh"
source "$ROOT_DIR/lib/fonts.sh"

need() {
    ! command -v "$1" >/dev/null 2>&1
}

echo "Bootstrapping Sway..."

# --- stow ---
if need stow; then
    echo "Installing stow..."
    install_pkg stow
fi

# --- core sway stack ---
install_pkg \
    sway \
    wofi \
    swaybg \
    waybar \
    grim \
    slurp \
    wl-clipboard \
    jq 

# --- fonts ---
install_fonts

# --- apply configs ---
DOTFILES_DIR="$ROOT_DIR/dotfiles"

if [ -d "$DOTFILES_DIR" ]; then
    echo "Applying dotfiles with stow..."
    stow -d "$DOTFILES_DIR" -t "$HOME" sway
    stow -d "$DOTFILES_DIR" -t "$HOME" wofi
    stow -d "$DOTFILES_DIR" -t "$HOME" waybar
fi

echo "Done."
