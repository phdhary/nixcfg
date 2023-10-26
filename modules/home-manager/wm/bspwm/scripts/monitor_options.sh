#!/bin/sh

monitor_primary_on_EDP-1_only() {
  xrandr --output eDP1 --primary --mode 1920x1080 --pos 0x0 --rotate normal 
}

monitor_primary_on_EDP-1_with_HDMI2() {
  xrandr --output eDP1 --primary --mode 1920x1080 --pos 1920x0 --rotate normal --output DP1 --off --output HDMI1 --off --output HDMI2 --mode 1920x1080 --pos 0x0 --rotate normal
}

monitor_primary_on_HDMI2() {
  xrandr --output eDP1 --mode 1920x1080 --pos 1920x0 --rotate normal --output DP1 --off --output HDMI1 --off --output HDMI2 --primary --mode 1920x1080 --pos 0x0 --rotate normal
}

monitor_primary_on_HDMI2_only() {
  xrandr --output eDP1 --off --output DP1 --off --output HDMI1 --off --output HDMI2 --primary --mode 1920x1080 --pos 0x0 --rotate normal
}
