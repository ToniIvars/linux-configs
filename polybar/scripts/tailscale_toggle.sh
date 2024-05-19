#/bin/bash

if [ $(tailscale status | grep 'stopped' | wc -l) -gt 0 ]; then
	sudo tailscale up
else
	sudo tailscale down
fi