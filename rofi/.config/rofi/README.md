# 🚀 Rofi Workflow

Custom Rofi-based environment control for a solo developer workflow. Integrated with Obsidian, Neovim, and system virtualization modes.

## 🎨 Theme

- **Carbonized:** Based on [yuky2020/rofi-themes](https://github.com/yuky2020/rofi-themes/blob/main/carbonized/config.rasi).

---

## 🛠️ Menu Options

### **Note Taking**

- **`note`** Quickly search or create flat `.md` notes in `~/github/writings`. Opens in **Neovim** via **Kitty**.
- **`kaban`** Project management via **Obsidian**. Filters for Kanban-specific templates and uses `obsidian://` URIs for deep-linking.

### **System Modes** (Bash Aliases)

- **`desktopMode`** Resets workspace and window layouts.
- **`recordMode`** Optimizes system for screen recording (educational content).
- **`vboxmode` / `kvmmode`** Environment prep for VirtualBox and QEMU/KVM virtualization.

---

## ⚙️ Configuration

Paths are managed centrally in `scripts/config.sh`.

- `VAULT_ROOT`: Base directory for all markdown files.
- `NOTE_DIR`: Target for general notes.
- `KANBAN_DIR`: Target for course-specific Kanban boards.

## ⚙️ AppImage Setup

To enable the `kaban` deep-linking, ensure the Obsidian AppImage is registered as a URI handler:

1. **Create Desktop Entry:**
   ```bash
   mkdir -p ~/.local/share/applications
   cat <<EOF > ~/.local/share/applications/obsidian.desktop
   [Desktop Entry]
   Name=Obsidian
   Exec=/home/yeasin/.local/bin/obsidian %u
   Terminal=false
   Type=Application
   Icon=obsidian
   MimeType=x-scheme-handler/obsidian;
   Categories=Office;
   EOF
   ```
2. registered MimeType

```
xdg-mime default obsidian.desktop x-scheme-handler/obsidian
```
