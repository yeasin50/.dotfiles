#!/bin/sh

# 1. Install tmux if missing
if ! command -v tmux >/dev/null 2>&1; then
    echo "tmux not found! Installing..."
    sudo apt-get update && sudo apt-get install -y tmux
fi

# 2. Install TPM if missing
if [ ! -d "$HOME/.tmux/plugins/tpm" ]; then
    echo "Cloning TPM..."
    git clone https://github.com/tmux-plugins/tpm "$HOME/.tmux/plugins/tpm"
fi

# 3. FIX: Use 'bindings' instead of 'bin'
# Also, don't ignore errors with '|| true' yet so you can see if it actually works
"$HOME/.tmux/plugins/tpm/bindings/install_plugins"
