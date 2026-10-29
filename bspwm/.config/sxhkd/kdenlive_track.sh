#!/bin/bash

LOG="$HOME/.local/share/kdenlive_sessions.csv"
APP="/home/yeasin/apps/kdenlive-26.04.0-x86_64.AppImage"

[ -f "$LOG" ] || echo "project,start,end,duration" > "$LOG"

START=$(date '+%F %T')
START_EPOCH=$(date +%s)

"$APP" &
PID=$!

PROJECT="Untitled"

while kill -0 "$PID" 2>/dev/null; do
    WIN=$(xdotool search --onlyvisible --pid "$PID" 2>/dev/null | head -n1)

    if [ -n "$WIN" ]; then
        TITLE=$(xdotool getwindowname "$WIN")
        # Example: "myproject.kdenlive - Kdenlive"
        PROJECT="${TITLE%% - Kdenlive*}"
    fi

    sleep 2
done

wait "$PID"

END=$(date '+%F %T')
END_EPOCH=$(date +%s)
DURATION=$((END_EPOCH - START_EPOCH))

echo "\"$PROJECT\",\"$START\",\"$END\",$DURATION" >> "$LOG"
