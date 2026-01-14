#!/bin/sh

PREV_FILE="/tmp/hypr_prev_ws"
CURR_FILE="/tmp/hypr_curr_ws"

# Leer el destino (workspace anterior)
TARGET=$(cat "$PREV_FILE" 2>/dev/null)
# Leer el actual
ACTUAL=$(cat "$CURR_FILE" 2>/dev/null)

# Si tenemos un destino y es distinto al actual, saltamos
if [ -n "$TARGET" ] && [ "$TARGET" != "$ACTUAL" ]; then
    hyprctl dispatch workspace "$TARGET"
fi
