#!/bin/bash

if hyprctl clients | grep -q "class: chromium"; then
    hyprctl dispatch focuswindow class:chromium
else
    uwsm app -- chromium --new-window --ozone-platform=wayland &
fi

hyprctl dispatch submap reset
