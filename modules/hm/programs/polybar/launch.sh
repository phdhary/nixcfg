#!/usr/bin/env bash

# Terminate already running bar instances
# If all your bars have ipc enabled, you can use 
polybar-msg cmd quit
# Otherwise you can use the nuclear option:
# killall -q polybar

declare INTERNAL_MONITOR
declare EXTERNAL_MONITOR

if [ "$(pidof bspwm)" != "" ]; then
  INTERNAL_MONITOR="main_top_bspwm"
  EXTERNAL_MONITOR="external_top_bspwm"
elif [ "$(pidof i3)" != "" ]; then
  INTERNAL_MONITOR="main_top_i3"
  EXTERNAL_MONITOR="external_top_i3"
fi

echo "---" | tee -a /tmp/polybar_"$INTERNAL_MONITOR".log
polybar --reload "$INTERNAL_MONITOR" 2>&1 | tee -a /tmp/polybar_"$INTERNAL_MONITOR".log & disown

if [[ $(xrandr -q | grep "HDMI-2 connected") ]]; then
  echo "---" | tee -a /tmp/polybar_"$EXTERNAL_MONITOR".log
  polybar --reload "$EXTERNAL_MONITOR" 2>&1 | tee -a /tmp/polybar_"$EXTERNAL_MONITOR".log & disown
fi
