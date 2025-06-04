#!/bin/bash

# Terminate already running bar instances
killall -q polybar

# Wait until the processes have been shut down
while pgrep -u $UID -x polybar >/dev/null; do sleep 1; done

# Directory for logs
LOG_DIR="/tmp/polybar/logs"
mkdir -p "$LOG_DIR"

# Launch Polybar on each connected monitor
if type "xrandr"; then
  for mon in $(xrandr --query | grep " connected" | cut -d" " -f1); do
	  LOG_FILE="$LOG_DIR/polybar-$mon.log"
    MONITOR=$mon  polybar mybar 2>&1 | tee -a $LOG_FILE & disown

  done
else
  polybar --reload example &
fi

echo "Polybar launched..."
