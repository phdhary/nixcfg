#!/bin/sh
xrandr --output eDP-1 --off --output DP-1 --off --output HDMI-1 --off --output HDMI-2 --primary --mode 1920x1080 --pos 0x0 --rotate normal

EXTERNAL_MONITOR="HDMI-2"

bspc monitor "$EXTERNAL_MONITOR" -d 1 2 3 4 5 6 7 8 9 10
bspc wm -O  "$EXTERNAL_MONITOR" "$INTERNAL_MONITOR" 
