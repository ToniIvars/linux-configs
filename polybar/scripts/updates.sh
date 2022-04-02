#/bin/bash

updates_error=$(timeout 1 pacman -Q -u 2>&1 | grep "error" | wc -l)
updates=$(timeout 2 pacman -Q -u | wc -l)

if [ $updates_error -gt 0 ]; then
	echo "%{F#ee0000} Error"
elif [ $updates -gt 0 ]; then
	echo "%{F#ee0000} $updates"
else
	echo ""
fi