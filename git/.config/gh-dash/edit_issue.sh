#!/usr/bin/env bash

# until it gets merged https://github.com/cli/cli/pull/12942
id="$1"
[[ -n "$id" ]] || { echo "Usage: edit_issue.sh <issue-number>"; exit 1; }

tmp=$(mktemp "${TMPDIR:-/tmp}/${id}-XXXXXX.md") || exit 1
trap 'rm -f "$tmp"' EXIT

gh issue view "$id" --json title,body \
    --template '{{.title}}{{"\n---BODY---\n"}}{{.body}}' > "$tmp" || exit 1

original=$(cat "$tmp")
"${GH_EDITOR:-nvim}" "$tmp" || exit 1

[[ -f "$tmp" ]] || exit 1
[[ "$(cat "$tmp")" == "$original" ]] && {
    echo "No changes; issue not updated."
    exit 0
}

title=$(sed '/^---BODY---$/,$d' "$tmp")
body=$(sed '1,/^---BODY---$/d' "$tmp")

gh issue edit "$id" --title "$title" --body "$body"
