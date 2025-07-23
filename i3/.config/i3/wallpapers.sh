#!/bin/bash

#Wallpapers
wallpapers_dir=/mnt/workspace/wallpapers-master

#Monitors
MONITORS=($(xrandr --query | grep " connected" | cut -d" " -f1))
MONITOR_COUNT=${#MONITORS[@]}

if [ "$MONITOR_COUNT" -gt 1 ]; then
	wallpapers=($(find "$wallpapers_dir" -type f | shuf -n 2))
	feh --no-fehbg --bg-scale "${wallpapers[0]}" "${wallpapers[1]}"
else
	wallpaper=$(find "$wallpapers_dir" -type f | shuf -n 1)
	feh --no-fehbg --bg-scale "$random_wallpaper"
fi
