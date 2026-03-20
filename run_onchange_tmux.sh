#!/bin/sh

# Check if tmux is installed
if ! command -v tmux >/dev/null 2>&1; then
    echo "tmux not found! Installing..."
    
    # Example for Debian/Ubuntu
    sudo apt-get update
    sudo apt-get install -y tmux
fi

# Install TPM if missing
if [ ! -d "$HOME/.tmux/plugins/tpm" ]; then
  git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
fi

# Install plugins (non-interactive)
~/.tmux/plugins/tpm/bin/install_plugins >/dev/null 2>&1 || true
