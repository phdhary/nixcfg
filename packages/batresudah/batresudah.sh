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
printf "batresudah started"
while true; do
  batteryLevel=$(@upower@ -i /org/freedesktop/UPower/devices/battery_BAT0 | grep percentage | grep -P -o '[0-9]+(?=%)');
  state=$(@upower@ -i /org/freedesktop/UPower/devices/battery_BAT0 | grep state | awk -F ' ' '{print $2}')
  if [ $batteryLevel -lt $lowerThreshold ] && [ $state == "discharging" ]; then
    notipai "I need more power" $batteryLevel
  fi
  if [ $batteryLevel -gt $upperThreshold ] && [ $state == "charging" ]; then
    notipai "Unplug me" $batteryLevel
  fi
  sleep 5m
done
