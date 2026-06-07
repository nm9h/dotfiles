#!/bin/bash
MONITOR="eDP-1"

# Get current transform
CURRENT=$(hyprctl monitors -j | jq -r ".[] | select(.name==\"$MONITOR\") | .transform")

# Cycle through (0 → 1 → 2 → 3 → back to 0)
NEXT=$(( (CURRENT + 1) % 4 ))

# Apply the new transform
hyprctl keyword monitor "$MONITOR,preferred,auto,auto,transform,$NEXT"

