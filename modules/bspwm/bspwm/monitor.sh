#!/bin/bash

INTERNAL_MONITOR="eDP-1"
EXTERNAL_MONITOR="HDMI-2"

# on first load setup default workspaces
if [[ $(xrandr -q | grep "${EXTERNAL_MONITOR} connected") ]]; then
  bspc monitor "$INTERNAL_MONITOR" -d 1 2 3 4 5
  bspc monitor "$EXTERNAL_MONITOR" -d 6 7 8 9 10
  bspc wm -O  "$INTERNAL_MONITOR" "$EXTERNAL_MONITOR"
else
  bspc monitor "$INTERNAL_MONITOR" -d 1 2 3 4 5 6 7 8 9 10
fi
