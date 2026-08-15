#!/bin/bash

# Check if tailscale is stopped or inactive
if tailscale status | grep -q 'stopped'; then
    printf '{"text": "󱗼 ", "class": "stopped", "tooltip": "Disconnected"}\n'
else
    DEVICE_IP=$(tailscale ip -4)
    DEVICE_NAME=$(tailscale status --json | jq -r '.Self.HostName')

    printf '{"text": "󱗼 ", "class": "connected", "tooltip": "%s (%s)"}\n' "$DEVICE_NAME" "$DEVICE_IP"
fi
