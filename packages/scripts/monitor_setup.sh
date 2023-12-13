#!/bin/sh

choices=(
"Laptop only"
"primary on Laptop + HDMI"
"HDMI only"
"primary on HDMI + Laptop"
"Mirror"
)

selected=$(printf '%s\n' "${choices[@]}" | rofi -dmenu -no-custom -p "monitor setup  " -matching fuzzy -i)
test "$selected" = "" && exit

case "$selected" in
  "${choices[0]}") 
    xrandr --output eDP1 --primary --mode 1920x1080 --pos 0x0 --rotate normal --output HDMI2 --off --output HDMI1 --off
  ;;
  "${choices[1]}") 
    xrandr --output eDP1 --primary --mode 1920x1080 --pos 1920x0 --rotate normal --output DP1 --off --output HDMI1 --off --output HDMI2 --mode 1920x1080 --pos 0x0 --rotate normal
  ;;
  "${choices[2]}") 
    xrandr --output eDP1 --off --output DP1 --off --output HDMI1 --off --output HDMI2 --primary --mode 1920x1080 --pos 0x0 --rotate normal
  ;;
  "${choices[3]}") 
    xrandr --output eDP1 --mode 1920x1080 --pos 1920x0 --rotate normal --output DP1 --off --output HDMI1 --off --output HDMI2 --primary --mode 1920x1080 --pos 0x0 --rotate normal
  ;;
  "${choices[4]}") 
    xrandr --output eDP1 --primary --mode 1920x1080 --pos 0x0 --rotate normal 
  ;;
esac

nitrogen --restore
