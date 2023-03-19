#!/bin/bash
batterylevel=$(acpi -b | awk '/Battery 1/ {sub(/%,/,X,$4);print $4}')

if [ $batterylevel == 58 ]
then
        echo "working"
fi
