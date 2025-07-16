#!/usr/bin/env bash

TMP_FILE="/tmp/screenshot-$(date +%s).png"


SAVE_PATH=$(zenity --file-selection --save --confirm-overwrite --filename="$HOME/Pictures/screenshot.png") || exit 1

cp "$TMP_FILE" "$SAVE_PATH"
wl-copy < "$SAVE_PATH"
notify-send -i "$SAVE_PATH" "Screenshot saved and copied!"
