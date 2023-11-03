#!/bin/bash
wallpaper=$(find ~/Pictures/wallpapers -type f | shuf -n1)
swaybg -i $wallpaper -m fill &
OLD_PID=$!
while true; do
    sleep 300
	wallpaper=$(find ~/Pictures/wallpapers -type f | shuf -n1)
    swaybg -i $wallpaper -m fill &
    NEXT_PID=$!
    sleep 5
    kill $OLD_PID
    OLD_PID=$NEXT_PID
done
