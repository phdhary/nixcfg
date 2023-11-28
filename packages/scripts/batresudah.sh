#!/bin/sh
lowerThreshold=20;
upperThreshold=90;

notipai() {
  curl \
    -H "Title: $USER@$(hostname) " \
    -H "Priority: urgent" \
    -H "Tags: smoking,moyai" \
    -d "$1 [ $2% ]" \
    ntfy.sh/phdhary_sub
}

batteryLevel=$(@upower@ -i /org/freedesktop/UPower/devices/battery_BAT0 | grep percentage | grep -P -o '[0-9]+(?=%)');
state=$(@upower@ -i /org/freedesktop/UPower/devices/battery_BAT0 | grep state | awk -F ' ' '{print $2}')

# shellcheck disable=2086,3014
if [ $batteryLevel -lt $lowerThreshold ] && [ $state == "discharging" ]; then
  notipai "I need more power" $batteryLevel
  notify-send -u critical -t 8000 "Battery low" "currently at $batteryLevel%\nyou should charge now"
fi

# shellcheck disable=2086,3014
if [ $batteryLevel -gt $upperThreshold ] && [ $state == "charging" ] || [ $batteryLevel -gt $upperThreshold ] && [ $state == "fully-charged" ]; then
  notipai "Unplug me" $batteryLevel
  notify-send "Battery full" "you can unplug the charger"
fi
