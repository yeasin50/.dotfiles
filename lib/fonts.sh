#!/usr/bin/env bash

set -e

FONT_DIR="$HOME/.local/share/fonts"

install_font() {
    name="$1"
    url="$2"

    if fc-list | grep -qi "$name"; then
        echo "$name already installed"
        return
    fi

    echo "Installing $name..."

    mkdir -p "$FONT_DIR"

    tmp="/tmp/font.zip"

    curl -fLo "$tmp" "$url"
    unzip -o "$tmp" -d "$FONT_DIR"
    rm "$tmp"
}

install_font \
  "FiraCode Nerd Font" \
  "https://github.com/ryanoasis/nerd-fonts/releases/latest/download/FiraCode.zip"

install_font \
  "JetBrains Mono Nerd Font" \
  "https://github.com/ryanoasis/nerd-fonts/releases/latest/download/JetBrainsMono.zip"

fc-cache -fv

echo "fonts done"
