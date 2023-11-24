#!/bin/sh

mode="$1"
amount="$2"
if [ "$2" = "" ]; then
  amount=5
fi
case "$mode" in
  up) 
    @brightnessctl@ s +$amount% -q -e;
    ;;
  down)
    @brightnessctl@ s $amount%- -q -e;
    ;;
esac
@brightnessctl@ -m | awk -F ',' '{print $4}' | sed 's/[^0-9]*//g' > /tmp/xobpipelight;
# dunstify -r 69 -t 1000 "Backlight" "$(@brightnessctl@ -m | awk -F ',' '{print $4}' | sed 's/[^0-9]*//g')%"
