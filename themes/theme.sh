#!/usr/bin/env bash

# `theme folderName` to apply theme
# `theme -n themeName` create theme into new folder extracting current configs
# `theme -f themeName` override theme into themeName folder extracting current configs

set -e

THEME_ROOT="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"
THEME_NAME="${1:-}"

usage() {
    echo "Usage:"
    echo "  $0 <theme>             Apply theme"
    echo "  $0 -n <theme>          Create theme from current configs"
    echo "  $0 -f <theme>          Override theme from current configs"
    echo
    echo "available themes"
    find "$THEME_ROOT" -mindepth 1 -maxdepth 1 -type d -printf '  %f\n'
}

extract_theme() {
    local theme="$1"
    local wallpaper
    local ext

    mkdir -p "$theme"

    cp "$HOME/.config/bspwm/bspwm.sh" "$theme/bspwm.sh"
    cp "$HOME/.config/polybar/colors.ini" "$theme/polybar.ini"
    cp "$HOME/.config/rofi/theme.rasi" "$theme/rofi.rasi"
    cp "$HOME/.config/btop/themes/current.theme" "$theme/btop.theme"
    cp "$HOME/.config/wezterm/theme.toml" "$theme/wezterm.toml"

    # Wallpaper from bspwm env
    wallpaper="$(sed -n 's/^WALLPAPER=//p' "$HOME/.config/bspwm/env.sh")"
    wallpaper="${wallpaper#\"}"
    wallpaper="${wallpaper%\"}"

    if [[ -f "$wallpaper" ]]; then
        ext="${wallpaper##*.}"
        cp "$wallpaper" "$theme/wallpaper.$ext"
        echo "Wallpaper: $theme/wallpaper.$ext"
    else
        echo "Warning: wallpaper not found: $wallpaper"
    fi

    echo "Created: $(basename "$theme")"
}

create_theme() {
    local name="$1"
    local theme="$THEME_ROOT/$name"

    if [[ -d "$theme" ]]; then
        echo "Theme already exists: $name"
        exit 1
    fi

    extract_theme "$theme"
}

override_theme() {
    local name="$1"
    local theme="$THEME_ROOT/$name"

    if [[ ! -d "$theme" ]]; then
        echo "Theme not found: $name"
        exit 1
    fi

    extract_theme "$theme"
}

apply_theme() {
    local name="$1"
    local theme="$THEME_ROOT/$name"
    local wallpaper

    [[ -d "$theme" ]] || {
        echo "Theme not found: $name"
        exit 1
    }

    echo "Applying: $name"

    wallpaper="$(find "$theme" -maxdepth 1 -type f -name 'wallpaper.*' -print -quit)"

    [[ -f "$wallpaper" ]] || {
        echo "Wallpaper not found: $theme"
        exit 1
    }

    sed -i "s|^WALLPAPER=.*|WALLPAPER=\"$wallpaper\"|" \
        "$HOME/.config/bspwm/env.sh"

    # BSPWM
    cp "$theme/bspwm.sh" "$HOME/.config/bspwm/bspwm.sh"
    cp "$theme/polybar.ini" "$HOME/.config/polybar/colors.ini"
    cp "$theme/rofi.rasi" "$HOME/.config/rofi/theme.rasi"
    cp "$theme/btop.theme" "$HOME/.config/btop/themes/current.theme"
    cp "$theme/wezterm.toml" "$HOME/.config/wezterm/theme.toml"

    # Reload BSPWM
    bspc wm -r

    # Restart Polybar
    pkill polybar || true
    polybar main >/dev/null 2>&1 &

    echo "Applied: $name"
}

case "$1" in
    -n)
        [[ -n "${2:-}" ]] || {
            echo "Missing theme name"
            exit 1
        }
        create_theme "$2"
        ;;
    -f)
        [[ -n "${2:-}" ]] || {
            echo "Missing theme name"
            exit 1
        }
        override_theme "$2"
        ;;
    "")
        usage
        exit 1
        ;;
    *)
        apply_theme "$1"
        ;;
esac
