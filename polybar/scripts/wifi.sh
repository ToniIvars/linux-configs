#/bin/bash

ssid=$(iwgetid -r | cut -c1-8)

if [ $(nmcli radio wifi) == "enabled" ]; then
	if [ $(echo "$ssid" | wc -c) -gt 0 ]; then
		echo "%{F#5b77a7}直 $ssid"
	else
		echo "%{F#fff}直"
	fi
else
	echo "%{F#555}睊"
fi
