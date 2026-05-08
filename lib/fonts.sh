#!/usr/bin/env bash

install_nerd_font() {
    if fc-list | grep -qi "FiraCode Nerd Font"; then
        echo "Nerd Font already installed"
        return
    fi

    echo "Installing Nerd Font..."

    mkdir -p "$HOME/.local/share/fonts"

    tmp="/tmp/nerdfont.zip"

    curl -fLo "$tmp" \
        https://github.com/ryanoasis/nerd-fonts/releases/latest/download/FiraCode.zip

    unzip -o "$tmp" -d "$HOME/.local/share/fonts"
    rm "$tmp"

    fc-cache -fv
}
