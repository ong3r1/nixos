#!/bin/bash

if pgrep -f "waybar" > /dev/null; then
    # If it's running, kill it
    pkill -f waybar
else
    # If it's not running, start it
    waybar &
fi
