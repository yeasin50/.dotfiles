#!/usr/bin/env bash

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
ROOT_DIR="$(cd "$SCRIPT_DIR/.." && pwd)"

source "$ROOT_DIR/lib/packages.sh"
source "$ROOT_DIR/lib/fonts.sh"

need() {
    ! command -v "$1" >/dev/null 2>&1
}

install_fonts() {
    :
}

install_emojis() {
    local emoji_file="$HOME/.config/rofi/scripts/emoji.txt"

    mkdir -p "$(dirname "$emoji_file")"

    if [ ! -f "$emoji_file" ]; then
        echo "Downloading emoji list..."
        curl -fsSL https://unicode.org/Public/emoji/latest/emoji-test.txt \
            | grep '; fully-qualified' \
            | cut -d'#' -f2 \
            | sed 's/^[[:space:]]*//' \
            > "$emoji_file"
    fi
    chmod +x "$HOME/.config/rofi/scripts/"*.sh
}

echo "Installing rofi..."

if command -v pacman >/dev/null; then
    need rofi && install_pkg rofi
    need curl && install_pkg curl
elif command -v apt >/dev/null; then
    need rofi && install_pkg rofi
    need curl && install_pkg curl
fi

install_fonts
install_emojis

echo "rofi done"
