#!/usr/bin/env bash

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
ROOT_DIR="$(cd "$SCRIPT_DIR/.." && pwd)"

source "$ROOT_DIR/lib/packages.sh"
source "$ROOT_DIR/lib/fonts.sh"

need() {
    ! command -v "$1" >/dev/null 2>&1
}

echo "Installing wofi..."

if command -v pacman >/dev/null; then
    need wofi && install_pkg wofi

elif command -v apt >/dev/null; then
    need wofi && install_pkg wofi
fi

install_fonts

echo "wofi done"
