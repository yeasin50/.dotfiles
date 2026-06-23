# ~/.dotfiles/bash/.task.bash

# Day start at hh:mm determines when the user creates and opens the task divider;
# not all human tasks should be bound by night or day; a flexible splitter.
# The default is 6:00 AM.
#
# Create tasks for each day; the file name starts with the date or any prefix.
# Simply use `task`, and it will open or create a new file.
# If I use `task x`, it will place the task
#   in the current month only if the `x`th day of the month has not passed yet;
#   otherwise, it will place it in the next month.
#
# Additionally, using `task -a "some string"` can append to the task file.

# --- Configuration ---
NOTES_DIR="$HOME/github/writings"
INBOX_DIR="$NOTES_DIR/jurnal"
DAY_START_HOUR=6
DAY_START_MIN=0


## stack todo for weeked or later
TODO="$NOTES_DIR/jurnal/todo.md"
alias todo='nvim "$TODO"'

alias  t=task

# --- Functions ---
task() {
  mkdir -p "$INBOX_DIR"

  local is_append=0
  local append_text=""
  local target_day=""
  local prefix=""

  # Parse arguments
  while [[ $# -gt 0 ]]; do
    case "$1" in
      -a|--append)
        is_append=1
        shift
        append_text="$*"
        break
        ;;
      [0-9]|[0-9][0-9])
        if [[ -z "$target_day" ]]; then
          target_day="$1"
        else
          # If a number was already provided, treat subsequent ones as part of the prefix
          prefix="${prefix}${prefix:+_}$1"
        fi
        shift
        ;;
      *)
        prefix="${prefix}${prefix:+_}$1"
        shift
        ;;
    esac
  done

  # Calculate logical "today" based on the flexible day splitter
  local current_epoch=$(date +%s)
  local current_hour=$(date +%-H)
  local current_min=$(date +%-M)
  local offset=0

  # If before the day start time, "today" is actually yesterday
  if (( current_hour < DAY_START_HOUR )) || (( current_hour == DAY_START_HOUR && current_min < DAY_START_MIN )); then
    offset=86400 # 1 day in seconds
  fi

  local logical_epoch=$((current_epoch - offset))

  local logical_day
  local logical_month
  local logical_year
  local target_date

  # Support for both GNU and BSD/macOS date commands
  if date --version >/dev/null 2>&1; then
    logical_day=$(date -d "@$logical_epoch" +%-d)
    logical_month=$(date -d "@$logical_epoch" +%-m)
    logical_year=$(date -d "@$logical_epoch" +%Y)
    target_date=$(date -d "@$logical_epoch" +%Y-%m-%d)
  else
    logical_day=$(date -r "$logical_epoch" +%-d)
    logical_month=$(date -r "$logical_epoch" +%-m)
    logical_year=$(date -r "$logical_epoch" +%Y)
    target_date=$(date -r "$logical_epoch" +%Y-%m-%d)
  fi

  # Adjust target month/year if a specific day argument (`task x`) was provided
  if [[ -n "$target_day" ]]; then
    # Base-10 arithmetic to prevent bash from treating numbers with leading zeros as octal
    local t_day=$((10#$target_day))
    local l_today=$((10#$logical_day))
    local t_month=$((10#$logical_month))
    local t_year=$logical_year

    if (( t_day < l_today )); then
      # The day has already passed this month; push to next month
      t_month=$((t_month + 1))
      if (( t_month > 12 )); then
        t_month=1
        t_year=$((t_year + 1))
      fi
    fi
    
    # Format the updated target date (YYYY-MM-DD)
    target_date=$(printf "%04d-%02d-%02d" "$t_year" "$t_month" "$t_day")
  fi

  # Determine final filename
  local filename="$target_date"
  if [[ -n "$prefix" ]]; then
    filename="${target_date}_${prefix}"
  fi

  local filepath="$INBOX_DIR/${filename}.md"
  local frontmatter_date=$(date +%d-%m-%Y)
  local frontmatter_Title=$(date "+%A %d-%m-%Y")

  # Create the file and inject frontmatter if it does not exist
  if [[ ! -f "$filepath" ]]; then
    cat > "$filepath" <<EOF
---
Author: Md. Yeasin Sheikh
Date: ${frontmatter_date}
aliases:
  - todo
tags:
  - journal
Source: github.com/yeasin50
wikilink: false
---

# TASK: ${frontmatter_Title}

EOF
    echo "Created task: $filepath"
  fi

# Execute user intent: append or open in editor
  if (( is_append == 1 )); then
    if [[ -n "$append_text" ]]; then
      echo -e "- [ ] $append_text" >> "$filepath"
      echo "Appended to task: $filepath"
    else
      echo "Error: No text provided to append. Usage: task -a <text>"
      return 1
    fi
  else
    nvim "$filepath"
  fi
}
