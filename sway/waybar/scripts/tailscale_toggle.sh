#!/bin/bash

if tailscale status | grep -q 'stopped'; then
    sudo tailscale up
else
    sudo tailscale down
fi
