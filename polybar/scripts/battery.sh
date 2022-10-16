#/bin/bash

number=$(acpi -b | awk -F: '{print $2}' | awk -F, '{print $2}' | tr -d ' ,%')
state=$(acpi -b | awk -F: '{print $2}' | awk '{print $2}' | tr -d ',')

if [ $number -gt 75 ]; then
	color="%{F#0e0}"
elif [ $number -gt 40 ]; then
	color="%{F#00cc00}"
elif [ $number -gt 15 ]; then
	color="%{F#ee0}"
elif [ $number -gt 0 ]; then
	color="%{F#e00}"
fi

if [ $state == "charging" ]; then
	echo "$color $number%"

else
	if [ $number -gt 75 ]; then
		echo "$color $number%"
	elif [ $number -gt 40 ]; then
		echo "$color $number%"
	elif [ $number -gt 15 ]; then
		echo "$color $number%"
	elif [ $number -gt 0 ]; then
		echo "$color $number%"
	fi
fi
