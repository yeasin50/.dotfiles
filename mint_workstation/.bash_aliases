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

alias tv='tmux new-session nvim'

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

# remind 30 "sleep", downside is it can not show repeated remind
remind() {
    local mins="$1"
    shift

    [[ -z "$mins" ]] && {
        echo "Usage: remind <minutes> [message]"
        return 1
    }

    local start
    start=$(date '+%-I:%M %p')

    printf "⏰ Reminder set for %s (+%sm)\n" "$start" "$mins"

    (
        sleep "${mins}m"

        rofi -e "$(printf '⏰ %s\n\n%s' \
            "$(date '+%-I:%M %p')" \
            "${*:-Time is up!}")"
    ) >/dev/null 2>&1 & disown
}

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
  # ls -t *.mp4 | tac | while read f; do printf "file '\''%s'\''\n" "$f"; done > list.txt
  ls *.mp4 | sort -n | while read f; do printf "file '\''%s'\''\n" "$f"; done > list.txt
  echo "Merge order:"
  cat list.txt
  read -p "Proceed? (y/n): " yn
  [ "$yn" = "y" ] && ffmpeg -f concat -safe 0 -i list.txt -c copy output.mp4
}; f'



# cat=>bat
alias cat='batcat --paging=never --theme=OneHalfDark'


# copy files on description  format to put on yt markdown
# `clipfiles filename.java`
clipfiles() {
    #  Detect the correct clipboard utility based on the OS ONLY Linux tested
    local clip_cmd
    if command -v pbcopy &> /dev/null; then 
        clip_cmd=(pbcopy)                               # macOS
    elif command -v xclip &> /dev/null; then 
        clip_cmd=(xclip -selection clipboard)           # Linux (X11)
    elif command -v wl-copy &> /dev/null; then 
        clip_cmd=(wl-copy)                              # Linux (Wayland)
    elif command -v clip.exe &> /dev/null; then 
        clip_cmd=(clip.exe)                             # WSL / Windows
    else
        echo "Error: No clipboard utility found (need pbcopy, xclip, wl-copy, or clip.exe)." >&2
        return 1
    fi

    {
        for file in "$@"; do
            if [[ -f "$file" ]]; then
                local filename="${file##*/}"  
                local ext="${filename##*.}"   
                
                # If the file has no extension, default to 'text'
                [[ "$filename" == "$ext" ]] && ext="text"

                # Generate the formatted output
                echo "<details> <summary> ${filename} </summary>"
                echo ""
                echo '```'"${ext}"
                cat "$file"
                echo "" 
                echo '```'
                echo ""
                echo "</details>"
                echo ""
            else
                echo "Warning: '$file' not found or is a directory. Skipping." >&2
            fi
        done
    } | tee /dev/tty | "${clip_cmd[@]}"

    echo -e "\n✅ Success: Contents formatted and copied to clipboard!" >&2
}

# Correct typos (if any) and display the word's definition.
# cmd: `define hallo`
define() {
    local word="$1" fixed json

    [[ -z "$word" ]] && {
        echo "Usage: define <word>"
        return 1
    }

    # Try original word
    json=$(curl -s "https://api.dictionaryapi.dev/api/v2/entries/en/$word")

    if jq -e 'type=="array"' >/dev/null <<<"$json"; then
        fixed="$word"
    else
        fixed=$(curl -s "https://api.datamuse.com/sug?s=$word" \
            | jq -r '.[0].word // empty')

        [[ -z "$fixed" ]] && {
            echo "No definition found."
            return 1
        }

        printf "\nDid you mean: %s\n\n" "$fixed"
        json=$(curl -s "https://api.dictionaryapi.dev/api/v2/entries/en/$fixed")

        jq -e 'type=="array"' >/dev/null <<<"$json" || {
            echo "No definition found."
            return 1
        }
    fi

    printf "📖 %s\n" "${fixed^}"
    printf '──────────────────────────────────────────────\n\n'

    jq -r '
        .[0].meanings[:3][] |
        [
            .partOfSpeech,
            .definitions[0].definition,
            (.definitions[0].example // "")
        ] | @tsv
    ' <<<"$json" |
    while IFS=$'\t' read -r pos def ex; do
        printf " %s\n\n" "${pos^}"

        fold -s -w 72 <<<"$def" | sed 's/^/   /'

        if [[ -n "$ex" ]]; then
            printf "\n   Example\n"
            fold -s -w 68 <<<"\"$ex\"" | sed 's/^/     /'
        fi

        echo
    done
}

grammar() {
    local text="$*"

    curl -s https://api.languagetool.org/v2/check \
      -d "text=$text" \
      -d "language=en-US" |
    jq -r '
      if (.matches | length) == 0 then
        "✓ No issues found."
      else
        .matches[] |
        "• " + .message +
        (if .replacements|length>0
         then "\n  Suggestion: " + .replacements[0].value
         else ""
         end)
      end
    '
}

## For android debugging
# use `adb_charge 0` to disable charging,
# use `adb_charge 1` to enable charging
adb_charge() {
    local status="$1"

    case "$status" in
        0|1)
            adb shell dumpsys battery set ac "$1"
            adb shell dumpsys battery set usb "$1"
            adb shell dumpsys battery set wireless "$1"
            ;;
        *)
            echo "Usage: adb_charge {0|1}"
            return 1
            ;;
    esac
}


# until  it get merged https://github.com/cli/cli/pull/12942
gie() {
  local id="$1" tmp title body original
  [[ -n "$id" ]] || { echo "Usage: ghie <issue-number>"; return 1; }

  tmp=$(mktemp "${TMPDIR:-/tmp}/${id}-XXXXXX.md") || return
  trap 'rm -f "$tmp"' RETURN

  gh issue view "$id" --json title,body \
    --template '{{.title}}{{"\n---BODY---\n"}}{{.body}}' > "$tmp" || return

  original=$(cat "$tmp")
  "${GH_EDITOR:-nvim}" "$tmp" || return

  [[ -f "$tmp" ]] || return
  [[ "$(cat "$tmp")" == "$original" ]] && {
    echo "No changes; issue not updated."
    return 0
  }

  title=$(sed '/^---BODY---$/,$d' "$tmp")
  body=$(sed '1,/^---BODY---$/d' "$tmp")

  gh issue edit "$id" --title "$title" --body "$body"
}
