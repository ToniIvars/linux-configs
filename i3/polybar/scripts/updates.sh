#/bin/bash

updates=$(timeout 2 pacman -Q -u | grep -vE "\[ignorado\]|\[ignored\]" | wc -l)

if [ $? -gt 0 ]; then
	echo "%{F#ee0000}󰁈 Error"
elif [ $updates -gt 0 ]; then
	echo "%{F#ee0000}󰁈 $updates"
else
	echo ""
fi
