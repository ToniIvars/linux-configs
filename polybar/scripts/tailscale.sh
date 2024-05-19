#/bin/bash

if [ $(tailscale status | grep 'stopped' | wc -l) -gt 0 ]; then
    echo "󱗼"
else
    echo "%{F#0e0}󱗼"
fi
