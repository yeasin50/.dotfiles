#!/bin/sh

#  Install kitty if missing
if ! command -v kitty >/dev/null 2>&1; then
    sudo apt-get update && sudo apt-get install -y kitty
fi

# Clone themes if missing
THEME_DIR="$HOME/.config/kitty/kitty-themes"
if [ ! -d "$THEME_DIR" ]; then
    git clone --depth 1 https://github.com/dexpota/kitty-themes.git "$THEME_DIR"
fi

# symlink for the theme
# This points 'current-theme.conf' to the actual theme file
ln -sf "$THEME_DIR/themes/OneDark.conf" "$HOME/.config/kitty/current-theme.conf"