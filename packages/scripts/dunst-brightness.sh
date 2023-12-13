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
# icons() {
#   brightness="$1"
#   if [ $brightness -eq 0 ]; then
#     echo "--icon display-brightness-off-symbolic"
#   elif [ $brightness -le 30 ]; then
#     echo "--icon display-brightness-low-symbolic"
#   elif [ $brightness -le 70 ]; then
#     echo "--icon display-brightness-medium-symbolic"
#   else
#     echo "--icon display-brightness-high-symbolic"
#   fi
# }
brightness=$(@brightnessctl@ -m | awk -F ',' '{print $4}' | sed 's/[^0-9]*//g')
dunstify -u low -r 96 -t 1000 "Backlight" -h int:value:$brightness -i display-brightness-symbolic
