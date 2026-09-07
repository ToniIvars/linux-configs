#/bin/bash

updates=$(timeout 2 pacman -Q -u | grep -vE "\[ignorado\]|\[ignored\]" | wc -l)

if [ $? -gt 0 ]; then
	printf "󰁈\u2002Error"
elif [ $updates -gt 0 ]; then
	printf "󰁈\u2002$updates"
else
	echo ""
fi
