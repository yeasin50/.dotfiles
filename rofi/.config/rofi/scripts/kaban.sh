#!/bin/bash

# 1. Load dynamic paths
source "$HOME/.config/rofi/scripts/config.sh"

mkdir -p "$KANBAN_DIR"

# 2. Get list of existing notes (flat - no subfolders)
matches=$(find "$KANBAN_DIR" -maxdepth 1 -type f -name "*.md" -exec basename {} .md \;)

# 3. Primary Rofi selection
note_choice=$(echo -e "$matches" | rofi -dmenu -i -p "Course Note:" -lines 10)
[[ -z "$note_choice" ]] && exit 0

FILE_PATH="$KANBAN_DIR/${note_choice}.md"

# 4. Handle New Note with Template Selection
if [[ ! -f "$FILE_PATH" ]]; then
    # Look for templates containing "kanban-plugin" YAML
    kanban_templates=$(grep -l "kanban-plugin" "$TEMPLATE_DIR"/*.md 2>/dev/null | xargs -I {} basename {} .md)

    if [[ -n "$kanban_templates" ]]; then
        # Prompt for template
        template_choice=$(echo -e "Blank\n$kanban_templates" | rofi -dmenu -i -p "Select Kanban Template (Esc to Cancel):" -lines 5)
        
        # Exit if user hits Esc (Cancel creation)
        [[ -z "$template_choice" ]] && exit 0

        if [[ "$template_choice" != "Blank" ]]; then
            cp "$TEMPLATE_DIR/${template_choice}.md" "$FILE_PATH"
            # Auto-replace title placeholder
            sed -i "s/{{title}}/$note_choice/g" "$FILE_PATH"
        else
            # Create a basic default Kanban YAML if "Blank" is selected
            echo -e "---\nkanban-plugin: basic\n---\n\n# $note_choice" > "$FILE_PATH"
        fi
    else
        # Fallback if no templates exist
        echo -e "---\nkanban-plugin: basic\n---\n\n# $note_choice" > "$FILE_PATH"
    fi
fi

# 5. OPEN: Generate Dynamic Obsidian URI
# Using the SUBDIR variable ensures the link never breaks if you rename the folder
REL_PATH="$KANBAN_SUBDIR/${note_choice}.md"

# URL encode the path so spaces (like in "40 - Course") don't break the URI
ENCODED_PATH=$(python3 -c "import urllib.parse; print(urllib.parse.quote('$REL_PATH'))")

# Trigger Obsidian jump via xdg-open
xdg-open "obsidian://open?vault=${VAULT_NAME}&file=${ENCODED_PATH}"
