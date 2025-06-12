# ~/.dotfiles/bash/note_alias.bash

# --- Configuration ---
NOTES_DIR="$HOME/github/writings"
INBOX_DIR="$NOTES_DIR/00 - Inbox"

# --- Functions ---
note() {
  local filename="$1"

  if [[ -z "$filename" ]]; then
    echo "❌ Error: You must provide a note name. Usage: note <name>"
    return 1
  fi

  local filepath="$INBOX_DIR/${filename}.md"
  local date=$(date +%d-%m-%Y)

  mkdir -p "$INBOX_DIR"

  if [[ ! -f "$filepath" ]]; then
    cat > "$filepath" <<EOF
---
Author: Md. Yeasin Sheikh
Date: ${date}
Tags: [[in-progress]]
Source: github.com/yeasin50
---

# ${filename}
EOF

    echo "✅ Created note: $filepath"
  else
    echo "⚠️ Note already exists: $filepath"
  fi

  nvim "$filepath"
}

note-gcp() {
  local msg="$*"

  if [[ -z "$msg" ]]; then
    echo "❌ Error: Commit message required. Usage: note-gcp \"your message\""
    return 1
  fi

  git -C "$NOTES_DIR" add .

  if git -C "$NOTES_DIR" diff --cached --quiet; then
    echo "⚠️ Nothing to commit."
  else
    git -C "$NOTES_DIR" commit -m "$msg"
    git -C "$NOTES_DIR" push
    echo "✅ Notes committed and pushed with message: \"$msg\""
  fi
}

