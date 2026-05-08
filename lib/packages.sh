install_pkg() {
    if command -v pacman >/dev/null; then
        sudo pacman -Sy --needed "$@"

    elif command -v apt >/dev/null; then
        sudo apt install -y "$@"
    fi
}
