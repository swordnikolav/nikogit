#!/bin/bash

CURRENT=$(hyprctl activeworkspace | grep -oP 'workspace ID \K\d+')
PREVIOUS=$(hyprctl workspaces | grep '(last)' | grep -oP 'workspace ID \K\d+' | head -n1)

# Si estamos en el workspace 1 → vamos al 4
if [ "$CURRENT" = "1" ]; then
    hyprctl dispatch workspace 4
# Si estamos en el 4 → vamos al workspace anterior (casi siempre será el 1)
elif [ "$CURRENT" = "4" ]; then
    if [ -n "$PREVIOUS" ] && [ "$PREVIOUS" != "4" ]; then
        hyprctl dispatch workspace "$PREVIOUS"
    else
        hyprctl dispatch workspace 1
    fi
# En cualquier otro caso → comportamiento normal de "workspace previous"
else
    hyprctl dispatch workspace previous
fi
