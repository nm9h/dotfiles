#!/bin/bash

# open site
open_site() {
    local site_name=$1
    [[ -z "$site_name" ]] && exit 0

    if [[ "$site_name" =~ ^https?:// ]]; then
        url="$site_name"
    else
        url="https://${site_name}.com"
    fi

    # Define the browsers in the order of preference
    browser_cache="$HOME/.config/hypr/.cache/.browser"
    browser=$(grep "^default=" "$browser_cache" 2>/dev/null | head -n1 | awk -F'=' '{print $2}')
    [[ -z "$browser" ]] && browser=$(grep -v "^default=" "$browser_cache" 2>/dev/null | head -n1)

    if [[ "$browser" == "firefox" || "$browser" == "librewolf" || "$browser" == "zen-browser" || "$browser" == "zen" ]]; then
        "$browser" --new-window "$url" &
    elif [[ -n "$browser" ]] && command -v "$browser" &>/dev/null; then
        "$browser" --app="$url" &
    else
        xdg-open "$url" &
    fi
}

open_site "$1"
