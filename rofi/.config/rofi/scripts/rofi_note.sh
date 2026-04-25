#!/bin/bash

source "$HOME/.config/rofi/scripts/config.sh"

mkdir -p "$INBOX_DIR"
mkdir -p "$TEMPLATE_DIR"

# 1. Get existing notes
matches=$(find "$INBOX_DIR" -maxdepth 1 -type f -name "*.md" -exec basename {} .md \;)

# 2. Primary Rofi menu
note_choice=$(echo -e "$matches" | rofi -dmenu -i -p "Note Name:" -lines 10)
[[ -z "$note_choice" ]] && exit 0

FILE_PATH="$INBOX_DIR/${note_choice}.md"

# 3. Template Selection (Only for NEW notes)
if [[ ! -f "$FILE_PATH" ]]; then
    template_list=$(find "$TEMPLATE_DIR" -maxdepth 1 -type f -name "*.md" -exec basename {} \;)

    if [[ -n "$template_list" ]]; then
        # Prompt for template
        selection=$(echo -e "None\n$template_list" | rofi -dmenu -i -p "Select Template (Esc to Cancel):" -lines 5)
        
        # --- THE FIX: If you press Esc here, exit WITHOUT creating the file ---
        [[ -z "$selection" ]] && exit 0

        if [[ "$selection" != "None" ]]; then
            cp "$TEMPLATE_DIR/$selection" "$FILE_PATH"
            sed -i "s/{{title}}/$note_choice/g" "$FILE_PATH"
        else
            # User selected "None", create blank note
            echo "# $note_choice" > "$FILE_PATH"
        fi
    else
        # No templates found, just create it
        echo "# $note_choice" > "$FILE_PATH"
    fi
fi

# 4. Open in Kitty/Neovim
kitty -- nvim "$FILE_PATH"
