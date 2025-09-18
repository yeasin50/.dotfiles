# Set terminal tab title
settab() {
  echo -ne "\033]0;$1\007"
}

alias cls='clear'
alias reload='source ~/.bashrc'

alias vi='nvim'

gv() {
  nohup "$HOME/apps/neovide.AppImage" "$@" >/dev/null 2>&1 &
}

alias ll='ls -lah'
alias gs='git status'


source ~/.dotfiles/bash/note_alias.bash

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


## record mode
recordMode(){
    xrandr --output DisplayPort-2 --mode 1280x1024 --pos 0x1096
    # primary  monitor
    xrandr --output HDMI-A-0 --primary --mode 1920x1080 --scale 2x2 --pos 1280x0
    # Right monitor (portrait) to the right
    # xrandr --output DisplayPort-0 --mode 1920x1080 --pos 5120x240 --rotate right
}

desktopMode(){
    xrandr --output DisplayPort-2 --mode 1280x1024 --pos 0x0
     # primary  monitor
    xrandr --output HDMI-A-0 --primary --mode 1920x1080 --scale 1x1 --pos 1280x0
    # xrandr --output HDMI-A-0 --mode 1920x1080 --scale-from 3840x2160
    # Right monitor (portrait) to the right
    # xrandr --output DisplayPort-0 --mode 1920x1080 --pos 3200x-840 --rotate right
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
