#!/bin/bash

echo "Launching learning C workspace"

i3-msg 'workspace 1'
sleep 0.5

i3-msg 'exec okular "/mnt/g_home/Hobby/Programming/OS/The.C.Programming.Language.2Nd.Ed Prentice.Hall.Brian.W.Kernighan.and.Dennis.M.Ritchie..pdf"'
sleep 0.5

i3-msg 'workspace 2'
sleep 0.5
	
i3-msg 'exec alacritty'
sleep 0.5

i3-msg 'workspace 3'
i3-msg 'exec obsidian "/mnt/g_office/dhiastra"'
