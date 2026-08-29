#!/bin/bash

browser_cache="$HOME/.config/hypr/.cache/.browser"
scripts_dir="$HOME/.config/hypr/scripts"

[[ ! -f "$browser_cache" ]] && touch "$browser_cache"

candidate_browsers=(
    "librewolf"
    "brave"
    "firefox"
    "google-chrome-stable"
    "chromium"
    "vivaldi"
    "zen-browser"
    "zen"
    "opera"
    "microsoft-edge-stable"
)

# Loop through the list and append found browsers to the cache without duplicates
for browser in "${candidate_browsers[@]}"; do
    if command -v "$browser" &>/dev/null && ! grep -qx "$browser" "$browser_cache"; then
        echo "$browser" >> "$browser_cache"
    fi
done

browsers_num=$(grep -v "^default=" "$browser_cache" | grep -v "^$" | sort -u | wc -l)
default=$(grep "^default=" "$browser_cache" | head -n1 | awk -F'=' '{print $2}')

if [[ "$browsers_num" -gt 1 && -z "$default" ]]; then
    notify-send "Missing Default Browser" "You need to set a default browser. Opening kitty to set a default browser." && sleep 2
    kitty --title browser sh -c "$scripts_dir/browser.sh ch"
elif [[ "$browsers_num" -eq 1 && -z "$default" ]]; then
    existing=$(grep -v "^default=" "$browser_cache" | grep -v "^$" | head -n1)
    if [[ -n "$existing" ]]; then
        notify-send "Default browser" "Setting $existing as your default browser."
        echo "default=$existing" >> "$browser_cache"
    fi
fi

case $1 in
--reset)
    rm -f "$browser_cache"
    touch "$browser_cache"
    notify-send "Reset" "Default browser list has been reset"
    "$scripts_dir/default_browser.sh"
    ;;
esac
