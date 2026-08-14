#/bin/bash

updates=$(timeout 2 pacman -Q -u | grep -vE "\[ignorado\]|\[ignored\]" | wc -l)

if [ $? -gt 0 ]; then
	echo "󰁈 Error"
elif [ $updates -gt 0 ]; then
	echo "󰁈 $updates"
else
	echo ""
fi
