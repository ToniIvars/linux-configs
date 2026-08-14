#!/bin/bash

# Check if tailscale is stopped or inactive
if tailscale status | grep -q 'stopped'; then
    printf '{"text": "󱗼 ", "class": "stopped", "tooltip": "Tailscale: Disconnected"}\n'
else
    printf '{"text": "󱗼 ", "class": "connected", "tooltip": "Tailscale: Connected"}\n'
fi
