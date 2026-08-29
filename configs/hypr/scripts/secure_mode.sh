#!/bin/bash

# secure mode conains a nature wallpaper.

if command -v awww >/dev/null 2>&1; then
    ENGINE="awww"
elif command -v swww >/dev/null 2>&1; then
    ENGINE="swww"
else
    notify-send "Wallpaper Error" "No wallpaper daemon found."
    exit 1
fi

scripts_dir="$HOME/.config/hypr/scripts"
cache_dir="$HOME/.config/hypr/.cache"
Wallpaper="$HOME/.config/hypr/Wallpaper/crime.jpg"

if [[ ! -f "$Wallpaper" ]]; then
    # Fallback to first available wallpaper
    Wallpaper=$(find "$HOME/.config/hypr/Wallpaper" -maxdepth 1 -type f \( -iname "*.jpg" -o -iname "*.png" \) | head -n1)
fi

[[ -z "$Wallpaper" || ! -f "$Wallpaper" ]] && exit 1

# Transition config
FPS=30
TYPE="left"
DURATION=0.2
BEZIER=".28,.58,.99,.37"
AWWW_PARAMS="--transition-fps $FPS --transition-type $TYPE --transition-duration $DURATION --transition-bezier $BEZIER"

if ! pgrep -x "${ENGINE}-daemon" >/dev/null; then
    ${ENGINE}-daemon &>/dev/null &
    disown
    sleep 0.5
fi

${ENGINE} img "$Wallpaper" $AWWW_PARAMS

ln -sf "$Wallpaper" "$cache_dir/current_wallpaper.png"

baseName="$(basename "$Wallpaper")"
echo "${baseName%.*}" > "$cache_dir/.wallpaper"

sleep 0.5
"$scripts_dir/wallcache.sh" &
"$scripts_dir/pywal.sh"
