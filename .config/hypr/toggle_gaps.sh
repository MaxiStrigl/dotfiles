#!/bin/bash

# Get current gap in value
current_gap_in=$(hyprctl getoption general:gaps_in | grep -oP '\d+' | head -n 1)
# Get current gap out value
current_gap_out=$(hyprctl getoption general:gaps_out | grep -oP '\d+' | head -n 1)

echo "Current gaps in value: $current_gap_in"
echo "Current gaps out value: $current_gap_out"

current_rounding=$(hyprctl getoption decorations:rounding | grep -oP '(?<=value: )\d+' | head -n 1)

echo "Current rounding value: $current_rounding"

if [ "$current_gap_in" == "0" ] && [ "$current_gap_out" == "0" ]; then
    echo "Gaps are currently 0, setting to 10"
    hyprctl keyword general:gaps_in 5
    hyprctl keyword general:gaps_out 20
    hyprctl keyword decoration:rounding 10
    hyprctl keyword cursor:inactive_timeout 0
else
    echo "Gaps are currently non-zero, setting to 0"
    hyprctl keyword general:gaps_in 0
    hyprctl keyword general:gaps_out 0
    hyprctl keyword decoration:rounding 0
    hyprctl keyword cursor:inactive_timeout 3
fi
