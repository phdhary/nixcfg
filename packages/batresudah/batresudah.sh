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
while true; do
  batteryLevel=$(acpi - b | head -1 | grep -P -o '[0-9]+(?=%)');
  isCharging=$(acpi -b | head -1 | grep -c "Charging")
  if [ $batteryLevel -lt $lowerThreshold ] && [ $isCharging -eq 0 ]; then
    notipai "I need more power" $batteryLevel
  fi
  if [ $batteryLevel -gt $upperThreshold ] && [ $isCharging -eq 1 ]; then
    notipai "Unplug me" $batteryLevel
  fi
  sleep 5m
done
