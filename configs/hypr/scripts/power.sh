#!/bin/bash

case $1 in
    --poweroff)
        "$HOME/.config/hypr/scripts/uptime.sh"
        "$HOME/.config/hypr/scripts/notification.sh" logout
        sleep 0.5
        systemctl poweroff --now
        ;;
    --reboot)
        "$HOME/.config/hypr/scripts/uptime.sh"
        "$HOME/.config/hypr/scripts/notification.sh" logout
        sleep 0.5
        systemctl reboot --now
        ;;
    --logout)
        "$HOME/.config/hypr/scripts/uptime.sh"
        "$HOME/.config/hypr/scripts/notification.sh" logout
        sleep 0.5
        hyprctl dispatch exit 1
        ;;
    --lock)
        sleep 0.1
        hyprlock
        ;;
esac
