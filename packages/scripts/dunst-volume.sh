#!/bin/sh

mode="$1"
declare mode_flag

amount="$2"
if [ "$2" = "" ]; then
  amount=5
fi

icons() {
  volume="$1"
  if [ $volume -eq 0 ]; then
    echo "--icon audio-volume-muted-symbolic"
  elif [ $volume -le 30 ]; then
    echo "--icon audio-volume-low-symbolic"
  elif [ $volume -le 70 ]; then
    echo "--icon audio-volume-medium-symbolic"
  else
    echo "--icon audio-volume-high-symbolic"
  fi
}

case "$mode" in
  up|down)
    case "$mode" in
      up) mode_flag=i;
        ;;
      down) mode_flag=d;
        ;;
    esac
    @pamixer@ -$mode_flag $amount -u;
    volume=$(@pamixer@ --get-volume)
    dunstify -u low -r 69 -t 1000 "Volume" -h int:value:$volume $(icons $volume)
    ;;
  mute)
    mode_flag=t
    is_mute=$(@pamixer@ --get-mute)
    volume=$(@pamixer@ --get-volume)
    if [ "$is_mute" = false ]; then
      flag=$(icons 0)
    else
      flag="-h int:value:$volume $(icons $volume)"
    fi
    @pamixer@ -$mode_flag;
    dunstify -u low -r 69 -t 1000 "Volume" $flag
    ;;
esac
