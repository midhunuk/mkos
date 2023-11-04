#!/usr/bin/bash

battery_status=`cat /sys/class/power_supply/BAT0/status`
battery_capacity=`cat /sys/class/power_supply/BAT0/capacity`

echo $battery_capacity
echo $battery_status
if [[ "$battery_status" == "Discharging" && "$battery_capacity" -lt "25" ]]; then
	echo "notify fired"
	notify-send -u critical "Battery Low" "Battery at $battery_capacity%"	
fi

