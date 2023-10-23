#!/bin/sh

mode="$1"
declare mode_flag

amount="$2"
if [ "$2" = "" ]; then
  amount=5
fi

case "$mode" in
  up|down)
    case "$mode" in
      up) mode_flag=i;
        ;;
      down) mode_flag=d;
        ;;
    esac
    @pamixer@ -$mode_flag $amount -u;
    @pamixer@ --get-volume > /tmp/xobpipevolume
    ;;
  mute)
    mode_flag=t
    is_mute=$(@pamixer@ --get-mute)
    declare volume
    if [ "$is_mute" = false ]; then
      volume="$(@pamixer@ --get-volume)!"
    else
      volume="$(@pamixer@ --get-volume)"
    fi
    @pamixer@ -$mode_flag;
    echo $volume > /tmp/xobpipevolume
    ;;
esac
