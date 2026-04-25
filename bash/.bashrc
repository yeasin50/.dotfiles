# Loader for all bash configs in chezmoi/bash
for f in ~/.local/share/chezmoi/bash/dot_*; do
  [ -r "$f" ] && source "$f"
done
