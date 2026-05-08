#!/usr/bin/env bash

SUDO=""
if [ "$EUID" -ne 0 ]; then
    SUDO="sudo"
fi

install_pkg() {
    if command -v pacman >/dev/null; then
        $SUDO pacman -Sy --needed "$@"

    elif command -v apt >/dev/null; then
        $SUDO apt update
        $SUDO apt install -y "$@"
    fi
}
