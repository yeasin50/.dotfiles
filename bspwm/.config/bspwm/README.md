# full config

```sh
#!/bin/bash

# appearance

bspc config border_width 1
bspc config window_gap 6
bspc config split_ratio 0.5

bspc config borderless_monocle true
bspc config gapless_monocle true

bspc config top_padding 0
bspc config bottom_padding 0
bspc config left_padding 0
bspc config right_padding 0

# autostart

killall -q sxhkd picom polybar

sxhkd &

# wallpaper first (optional but clean)

feh --bg-fill ~/Pictures/bg/window_bluish.png &

# start compositor

# picom --config ~/.config/picom/picom.conf -b &

# polybar after layout

~/.config/polybar/launch.sh &

# bspwmrc config

source ~/.config/bspwm/modules/monitors.sh
source ~/.config/bspwm/modules/appearance.sh
source ~/.config/bspwm/modules/autostart.sh

bspc config pointer_modifier mod4
bspc config pointer_action1 move
bspc config pointer_action2 resize_corner
bspc config pointer_action3 none

bspc config focus_follows_pointer false
bspc config pointer_follows_focus false
bspc config auto_raise false

# chmod +x bspwmrc modules/appearance.sh modules/autostart.sh modules/monitors.sh
```

## Updated

```sh
echo -1 | sudo tee /sys/module/usbcore/parameters/autosuspend
echo on | sudo tee /sys/bus/usb/devices/*/power/control
```

> Fixed by putting the mouse on different usb port
> `lsusb -v | grep bcdUSB`

### Current situation (summary)

- OS: Ubuntu + X11 (bspwm)
- GPU: AMD RX 5500 XT ✔ working (Mesa OK)
- `/dev/dri`: OK ✔
- OpenGL: OK ✔ (no fallback rendering)
- sxhkd: idle ✔
- Xorg: running normally (no GPU issue)
- Mouse: USB HID device on hub path
- USB autosuspend: was enabled (2) → tested/disabled
- Input stack: multiple HID interfaces (normal)
- Issue: **cursor freezes / stutter when moving between screens**

---

### What was already tried

- checked Xorg errors → irrelevant (no GPU failure)
- verified GPU drivers (amdgpu OK)
- checked OpenGL (no llvmpipe)
- checked sxhkd CPU (0%)
- checked bspwm config (no heavy loops)
- checked `xinput` devices (duplicates normal)
- checked USB topology (`lsusb -t`)
- disabled USB autosuspend (test done)
- forced USB power mode `on`
- tested compositor assumption (not root cause)
- ruled out GPU / rendering pipeline

---

### Current diagnosis

- NOT GPU / NOT Xorg / NOT WM
- NOT CPU load
- NOT sxhkd/polybar
- NOT driver crash

👉 remaining issue is:
**USB input latency from hub/controller scheduling + low-speed HID behavior**

---

### Status

- System: healthy
- Input: unstable at USB layer
- Root cause: hardware/USB routing + polling behavior (not software config)

---

### Bottom line

Everything software-side is clean.
Problem sits at **USB input path timing**, not desktop stack.
