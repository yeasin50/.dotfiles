
# --- Display setup FIRST ---
xrandr \
  --output HDMI-A-0 --mode 1920x1080 --pos 0x0 \
  --output DisplayPort-2 --mode 1280x1024 --rotate right --pos 1920x0



# --- bspwm monitors (MUST match xrandr names) ---
bspc monitor HDMI-A-0 -d 1 2 3
bspc monitor DisplayPort-2 -d 4 5 6

