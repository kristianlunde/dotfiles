#!/usr/bin/env bash

STATE_FILE="$HOME/.cache/hypr-mirror-state"

# Get laptop screen (should always be present)
LAPTOP=$(hyprctl monitors | grep -E "eDP" | awk '{print $2}')

if [ -z "$LAPTOP" ]; then
    echo "Laptop screen not detected."
    exit 1
fi

# Function to get external monitor name (anything not eDP)
get_external_monitor() {
    hyprctl monitors | awk '/Monitor/ {print $2}' | grep -v "^$LAPTOP$" | head -n 1
}

if [ -f "$STATE_FILE" ]; then
    echo "Switching to extended mode..."
    
    # Read saved settings
    EXTERNAL=$(grep "EXTERNAL=" "$STATE_FILE" | cut -d= -f2)
    LAPTOP_LAYOUT=$(grep "LAPTOP_LAYOUT=" "$STATE_FILE" | cut -d= -f2)
    EXTERNAL_LAYOUT=$(grep "EXTERNAL_LAYOUT=" "$STATE_FILE" | cut -d= -f2)

    # Restore saved layouts
    hyprctl keyword monitor "$LAPTOP,$LAPTOP_LAYOUT"
    hyprctl keyword monitor "$EXTERNAL,$EXTERNAL_LAYOUT"

    rm "$STATE_FILE"
else
    # Switching to mirror mode
    EXTERNAL=$(get_external_monitor)

    if [ -z "$EXTERNAL" ]; then
        echo "No external monitor detected."
        exit 1
    fi

    echo "Switching to mirror mode..."

    # Get layouts exactly as Hyprland stores them
    LAPTOP_LAYOUT=$(hyprctl monitors | grep -A4 "$LAPTOP" | grep "monitor" | awk '{print $3}' | tr -d ',')
    EXTERNAL_LAYOUT=$(hyprctl monitors | grep -A4 "$EXTERNAL" | grep "monitor" | awk '{print $3}' | tr -d ',')

    mkdir -p "$(dirname "$STATE_FILE")"
    echo "EXTERNAL=$EXTERNAL" > "$STATE_FILE"
    echo "LAPTOP_LAYOUT=$LAPTOP_LAYOUT" >> "$STATE_FILE"
    echo "EXTERNAL_LAYOUT=$EXTERNAL_LAYOUT" >> "$STATE_FILE"

    # Mirror external monitor to laptop
    hyprctl keyword monitor "$EXTERNAL,preferred,auto,1,mirror,$LAPTOP"
fi

