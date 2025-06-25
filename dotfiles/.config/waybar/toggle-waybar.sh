#!/bin/bash

# Try to find Waybar's PID
PID=$(pgrep -x waybar)

if [ -n "$PID" ]; then
    # If it's running, kill it
    kill "$PID"
else
    # If it's not running, start it
    waybar &
fi
