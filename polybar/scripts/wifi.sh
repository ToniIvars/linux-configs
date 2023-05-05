#/bin/bash

ssid=$(iwgetid -r | cut -c1-10)

if [ $(nmcli radio wifi) == "enabled" ]; then
	if [ $(echo "$ssid" | wc -c) -gt 0 ]; then
		echo "%{F#5b77a7}󰖩 $ssid"
	else
		echo "%{F#fff}󰖩 "
	fi
else
	echo "%{F#555}󰖩 "
fi
