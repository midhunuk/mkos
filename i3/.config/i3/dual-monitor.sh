#!/bin/bash

#Monitors
MONITORS=($(xrandr --query | grep " connected" | cut -d" " -f1))
MONITOR_COUNT=${#MONITORS[@]}

if [ "$MONITOR_COUNT" -eq 3 ]; then
    D1=${MONITORS[1]}
	D2=${MONITORS[2]}
	xrandr --output ${MONITORS[0]} --off
elif [ "$MONITOR_COUNT" -eq 2 ]; then
    D1=${MONITORS[0]}
	D2=${MONITORS[1]}
fi

if [ "$MONITOR_COUNT" -gt 1 ]; then
	xrandr --output $D1 --auto --pos 0x0 \
		--output $D2 --auto --right-of $D1 --primary
elif [ "$MONITOR_COUNT" -eq 1 ]; then
	xrandr --output ${MONITORS[0]} --auto --primary
else
	echo "No dislpay connected"
fi
