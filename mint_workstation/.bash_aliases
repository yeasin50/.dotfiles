# Set terminal tab title
settab() {
  echo -ne "\033]0;$1\007"
}

alias cls='clear'
alias reload='source ~/.bashrc'

alias vi='nvim'

# alias viyt='NVIM_APPNAME=nvim.yt nvim'

alias docker-compose='podman-compose'
alias docker='podman'

gv() {
  nohup "$HOME/apps/neovide.AppImage" "$@" >/dev/null 2>&1 &
}

alias ll='ls -lah'
alias gs='git status'


alias wall='~/.config/rofi/scripts/wall_picker.sh'

## Set wall-paper and config theme
setwall() {
    if [ -z "$1" ]; then
        echo "Usage: setwall <image>"
        cowsay "no image given"
        return 1
    fi

    img="$(realpath "$1" 2>/dev/null)"

    if [ ! -f "$img" ]; then
        echo "File not found"
        cowsay "bad path"
        return 1
    fi

    feh --bg-fill "$img"
    wallust run "$img"

    # saving for bspwm restart
    sed -i "s|^WALLPAPER=.*|WALLPAPER=\"$img\"|" ~/.config/bspwm/env.sh
}


source ~/.note_alias.bash
source ~/.task.bash

alias tmuxp='tmuxinator start .'
# alias tmuxls= "tmux list-panes -a -F '#S:#W.#P - #{pane_title} - #{pane_current_command}'"

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# colored GCC warnings and errors
#export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

vboxmode() {
    echo "[*] Stopping KVM services..."
    sudo systemctl stop libvirtd virtlogd virtlockd 2>/dev/null

    echo "[*] Killing QEMU processes..."
    sudo pkill -9 qemu 2>/dev/null

    echo "[*] Removing KVM modules..."
    sudo modprobe -r kvm_intel
    sudo modprobe -r kvm

    echo "[*] Current KVM usage:"
    lsmod | grep kvm || echo "✅ KVM fully disabled"

    echo "✅ VirtualBox mode ready"
}

kvmmode() {
    sudo modprobe kvm 2>/dev/null
    sudo modprobe kvm_intel 2>/dev/null
    sudo systemctl start libvirtd 2>/dev/null
    echo "✅ KVM mode activated (for QEMU/virt-manager)"
}

recordMode() {
    vboxmode

    if [ -n "$SWAYSOCK" ]; then
        # Sway (Wayland)
        swaymsg seat '*' xcursor_theme default 68
        gsettings set org.cinnamon.desktop.interface cursor-size 68

        # Virtual 4K layout (Atomic execution)
        swaymsg 'output HDMI-A-1 mode 1920x1080 scale 0.5 pos 0 0; output DP-3 mode 1280x1024 transform 90 pos 3840 0'
        gsettings set org.gnome.desktop.interface text-scaling-factor 1.75
    else
        # Cinnamon / i3 (X11)
        gsettings set org.cinnamon.desktop.interface cursor-size 68

        # primary monitor
        xrandr --output HDMI-A-0 --primary --mode 1920x1080 --scale 2x2 --pos 0x0 
        xrandr --output DisplayPort-2 --mode 1280x1024 --pos 3840x0 --rotate right
        # gsettings set org.gnome.desktop.interface text-scaling-factor 1.75
    fi
}

desktopMode() {
    if [ -n "$SWAYSOCK" ]; then
        # Sway (Wayland)
        swaymsg seat '*' xcursor_theme default 24
        gsettings set org.cinnamon.desktop.interface cursor-size 24

        # 1080p layout (Atomic execution)
        swaymsg 'output HDMI-A-1 mode 1920x1080 scale 1 pos 0 0; output DP-3 mode 1280x1024 transform 90 pos 1920 0'

    else
        # Cinnamon / i3 (X11)
        gsettings set org.cinnamon.desktop.interface cursor-size 24

        # primary monitor
        xrandr --output HDMI-A-0 --primary --mode 1920x1080 --scale 1x1 --pos 0x0  
        xrandr --output DisplayPort-2 --mode 1280x1024 --pos 1920x0 --rotate right
    fi

    gsettings set org.gnome.desktop.interface text-scaling-factor 1.0
}




record() {
    if [ -z "$1" ]; then
        echo "Usage: hidpi_launch <app_name> [args...]"
        return 1
    fi

    # Save the app name and shift arguments
    local app="$1"
    shift

    # Set environment variables and launch

    GDK_SCALE=2 GDK_DPI_SCALE=1 GTK_THEME=Adwaita:dark "$app" "$@"
}

##  to check  how many  hours it can take for me  to edit 
## `videoinfo 2` where 2 is depnt,  default is 1
videoinfo() {
    if ! command -v ffprobe >/dev/null 2>&1; then
        echo "Not possible, ffmpeg/ffprobe not installed."
        return
    fi

    depth=${1:-1}
    total_duration=0
    total_size=0

    while IFS= read -r f; do
        duration=$(ffprobe -v error -show_entries format=duration -of csv=p=0 "$f")
        # Convert duration to integer seconds
        duration_int=${duration%.*}
        total_duration=$((total_duration + duration_int))

        size=$(stat -c%s "$f")
        total_size=$((total_size + size))
    done < <(find . -maxdepth "$depth" -type f \( -iname "*.mp4" -o -iname "*.mkv" -o -iname "*.avi" \))

    hours=$((total_duration / 3600))
    minutes=$(( (total_duration % 3600) / 60 ))
    seconds=$((total_duration % 60))
    human_size=$(numfmt --to=iec --suffix=B $total_size)

    echo "Total duration: $hours:$minutes:$seconds"
    echo "Total size: $human_size"
}


alias showKeys='screenkey -p fixed -g 1000x150+1240+1610 -s large -f "Sans Bold 40"'

alias ffmerge='f(){ 
  ls -t *.mp4 | tac | while read f; do printf "file '\''%s'\''\n" "$f"; done > list.txt
  echo "Merge order:"
  cat list.txt
  read -p "Proceed? (y/n): " yn
  [ "$yn" = "y" ] && ffmpeg -f concat -safe 0 -i list.txt -c copy output.mp4
}; f'



# cat=>bat
alias cat='batcat --paging=never --theme=OneHalfDark'
