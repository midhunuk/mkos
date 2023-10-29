#!/bin/bash
#Modify the rate of change 
delta_percentage=2

quit () {
    echo >&2 "$@"
    exit 1
}

#validating argument argument
argument_message="Argument required, + for incremtn, - for decement"
[ "$#" -eq 1 ] || quit $argument_message

#Finding the min, max, delta
max_brightness=$(cat /sys/class/backlight/intel_backlight/max_brightness)
current_brightness=$(cat /sys/class/backlight/intel_backlight/brightness)
delta_value=$(( ($delta_percentage * $max_brightness)/100))
min_brightness=$(( (5 * $max_brightness)/100))

# finding the value to change based on argument
option="${1}" 
case ${option} in 
   "+")
	  value_to_change=$(($current_brightness + $delta_value))
	  if (( value_to_change > max_brightness )); then
			quit "max brightness"
	  fi
      ;; 
   "-") 
      echo "-"
	  value_to_change=$(($current_brightness - $delta_value))
	  if (( value_to_change < min_brightness )); then
			quit "min brightness"
	  fi
      ;; 
   *)  
      quit $argument_message
      ;; 
esac 

brightnessctl -d "intel_backlight" set $value_to_change
