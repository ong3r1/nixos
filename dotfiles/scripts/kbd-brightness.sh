#!/usr/bin/env bash

DEV="tpacpi::kbd_backlight"

curr=$(brightnessctl --device="$DEV" g)
max=$(brightnessctl --device="$DEV" m)

# If at max → go to 0, else → +1 step
if [ "$curr" -ge "$max" ]; then
    brightnessctl --device="$DEV" set 0
else
    brightnessctl --device="$DEV" set +1
fi
