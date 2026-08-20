#!/usr/bin/env bash
# ─────────────────────────────────────────────────────────────────────────────
# wlogout.sh — wlogout launcher with monitor-aware layout (clean version)
# ─────────────────────────────────────────────────────────────────────────────

# Toggle: kill if already running
if pgrep -x "wlogout" > /dev/null; then
    pkill -x "wlogout"
    exit 0
fi

CONF_DIR="$HOME/.hyprconf/wlogout"
STYLE="${1:-2}"

wLayout="$CONF_DIR/layout_${STYLE}"
wlTmplt="$CONF_DIR/style_${STYLE}.css"

# Fallback if missing
if [[ ! -f "$wLayout" || ! -f "$wlTmplt" ]]; then
    echo "ERROR: wlogout style $STYLE not found, falling back to style 2"
    STYLE=2
    wLayout="$CONF_DIR/layout_${STYLE}"
    wlTmplt="$CONF_DIR/style_${STYLE}.css"
fi

# ── Monitor resolution & scale (focused) ──────────────────────────────────────
MON_JSON=$(hyprctl -j monitors 2>/dev/null)

x_mon=$(echo "$MON_JSON" | jq -r '.[] | select(.focused==true) | .width' 2>/dev/null | head -n1)
y_mon=$(echo "$MON_JSON" | jq -r '.[] | select(.focused==true) | .height' 2>/dev/null | head -n1)
scale_val=$(echo "$MON_JSON" | jq -r '.[] | select(.focused==true) | .scale' 2>/dev/null | head -n1)

[[ -z "$x_mon" || "$x_mon" == "null" || "$x_mon" == "0" ]] && x_mon="1920"
[[ -z "$y_mon" || "$y_mon" == "null" || "$y_mon" == "0" ]] && y_mon="1080"
[[ -z "$scale_val" || "$scale_val" == "null" || "$scale_val" == "0" ]] && scale_val="1"

case "$STYLE" in
    *1)
        wlColms=6
        export mgn=$(awk -v y="$y_mon" -v s="$scale_val" 'BEGIN { printf "%d", (y * 0.28 / s) }')
        export hvr=$(awk -v y="$y_mon" -v s="$scale_val" 'BEGIN { printf "%d", (y * 0.23 / s) }')
        ;;
    2|*)
        wlColms=2
        export x_mgn=$(awk -v x="$x_mon" -v s="$scale_val" 'BEGIN { printf "%d", (x * 0.35 / s) }')
        export y_mgn=$(awk -v y="$y_mon" -v s="$scale_val" 'BEGIN { printf "%d", (y * 0.25 / s) }')
        export x_hvr=$(awk -v x="$x_mon" -v s="$scale_val" 'BEGIN { printf "%d", (x * 0.32 / s) }')
        export y_hvr=$(awk -v y="$y_mon" -v s="$scale_val" 'BEGIN { printf "%d", (y * 0.20 / s) }')
        ;;
esac

# ── Font size ─────────────────────────────────────────────────────────────────
export fntSize=$(awk -v y="$y_mon" -v s="$scale_val" 'BEGIN { f = int(y * 0.02 / s); if (f < 12) f = 12; printf "%d", f }')

# ── Border radius from Hyprland ───────────────────────────────────────────────
hypr_border=$(hyprctl getoption "decoration:rounding" 2>/dev/null \
    | awk '/^int:/{print $2}' | head -n1)

hypr_border="${hypr_border:-10}"

export active_rad=$((hypr_border * 5))
export button_rad=$((hypr_border * 8))

# ── Generate CSS ──────────────────────────────────────────────────────────────
colors_file="$CONF_DIR/colors.css"
[[ ! -f "$colors_file" ]] && colors_file="$HOME/.cache/wal/colors-waybar.css"

if [[ -f "$colors_file" ]]; then
    wlStyle="$(cat "$colors_file" "$wlTmplt" | envsubst)"
else
    wlStyle="$(envsubst < "$wlTmplt")"
fi

# ── Launch wlogout ────────────────────────────────────────────────────────────
wlogout -b "$wlColms" -c 0 -r 0 -m 0 \
    --layout "$wLayout" \
    --css <(echo "$wlStyle") \
    --protocol layer-shell

# ── Optional debug (enable with DEBUG=1 ./wlogout.sh) ─────────────────────────
if [[ "$DEBUG" == "1" ]]; then
    echo "Resolution: ${x_mon}x${y_mon}"
    echo "Scale: $scale_val"
    echo "x_mgn: $x_mgn | y_mgn: $y_mgn"
    echo "x_hvr: $x_hvr | y_hvr: $y_hvr"
fi
