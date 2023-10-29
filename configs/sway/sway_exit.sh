#!/bin/bash

RESP=$(cat <<EOF | fzf
Logout
Sleep
Reboot
Shutdown
EOF
);

case "$RESP" in
	Logout)
		swaymsg exit
		;;
	Sleep)
		systemctl suspend
		;;
	Reboot)
		systemctl reboot
		;;
	Shutdown)
		systemctl poweroff
		;;
	*)
		exit 1
esac
