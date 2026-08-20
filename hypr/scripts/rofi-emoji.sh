#!/bin/bash
# rofi-emoji.sh — Search and copy emojis to clipboard via Rofi.

data_file="$HOME/.config/hypr/scripts/.emoji_data"
[[ ! -f "$data_file" ]] && data_file="$HOME/.hyprconf/hypr/scripts/.emoji_data"

if [[ ! -f "$data_file" ]]; then
    notify-send "Emoji Error" "Emoji database not found."
    exit 1
fi

selected=$(rofi -dmenu -config ~/.config/rofi/themes/rofi-emoji.rasi -p "Emoji" < "$data_file")

if [[ -n "$selected" ]]; then
    echo "$selected" | cut -d ' ' -f 1 | tr -d '\n' | wl-copy
fi

exit 0
