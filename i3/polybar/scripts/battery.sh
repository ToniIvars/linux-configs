#/bin/bash

number=$(acpi -b | awk -F: '{print $2}' | awk -F, '{print $2}' | tr -d ' ,%')
state=$(acpi -b | awk -F: '{print $2}' | awk '{print $1}' | tr -d ',')

if [ $number -gt 75 ]; then
	color="%{F#0e0}"
elif [ $number -gt 40 ]; then
	color="%{F#00cc00}"
elif [ $number -gt 15 ]; then
	color="%{F#ee0}"
elif [ $number -gt 0 ]; then
	color="%{F#e00}"
fi

if [ $state == "Charging" ]; then
	echo "$color󰂄 $number%"

else
	if [ $number -gt 98 ]; then
		echo "$color󰁹 $number%"
	elif [ $number -gt 90 ]; then
		echo "$color󰂂 $number%"
	elif [ $number -gt 80 ]; then
		echo "$color󰂁 $number%"
	elif [ $number -gt 70 ]; then
		echo "$color󰂀 $number%"
	elif [ $number -gt 60 ]; then
		echo "$color󰁿 $number%"
	elif [ $number -gt 50 ]; then
		echo "$color󰁾 $number%"
	elif [ $number -gt 40 ]; then
		echo "$color󰁽 $number%"
	elif [ $number -gt 30 ]; then
		echo "$color󰁼 $number%"
	elif [ $number -gt 15 ]; then
		echo "$color󰁻 $number%"
	elif [ $number -gt 0 ]; then
		echo "$color󰁺 $number%"
	fi
fi
