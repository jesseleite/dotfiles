#!/bin/bash

if hyprctl clients | grep -q "$1"; then
    hyprctl dispatch focuswindow class:.*$1.*
else
    uwsm app -- $@
fi

hyprctl dispatch submap reset
