#!/bin/sh

#  install everything via apt
sudo apt-get update
sudo apt-get install -y \
    kitty \
    fzf \
    zoxide \
    ripgrep \
    fd-find \
    neovim \
    curl \
    git \
    xclip

# 2. Ensure Bash-it is there (Since it's not in apt)
if [ ! -d "$HOME/.bash_it" ]; then
    git clone --depth=1 https://github.com/Bash-it/bash-it.git "$HOME/.bash_it"
    "$HOME/.bash_it/install.sh" --silent
fi
