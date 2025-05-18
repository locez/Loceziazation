#!/bin/bash
CONFIG_FILE="$HOME/.config/alacritty/alacritty.toml"
CURRENT_OPACITY=$(grep 'opacity' $CONFIG_FILE | awk '{print $3}')

if [ "$CURRENT_OPACITY" == "0.8" ]; then
    sed -i 's/opacity = 0.8/opacity = 1.0/' $CONFIG_FILE
else
    sed -i 's/opacity = 1.0/opacity = 0.8/' $CONFIG_FILE
fi
