#!/usr/bin/env bash

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

source "$SCRIPT_DIR/../lib/packages.sh"
source "$SCRIPT_DIR/../lib/fonts.sh"

need() {
    ! command -v "$1" >/dev/null 2>&1
}

echo "Installing nvim deps..."

if command -v pacman >/dev/null; then
    need nvim && install_pkg neovim
    need fzf && install_pkg fzf
    need rg && install_pkg ripgrep
    need npm && install_pkg npm

elif command -v apt >/dev/null; then
    need nvim && install_pkg neovim
    need fzf && install_pkg fzf
    need rg && install_pkg ripgrep
    need npm && install_pkg npm
fi

install_fonts

sudo npm install -g prettier 2>/dev/null || true

echo "done"
