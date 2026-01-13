#!/bin/sh

# Usamos sh compatible con mksh/dash
# Filtro flexible para contar paquetes incluso con conflictos de máscaras
updates=$(doas emerge --sync | doas emerge -pauvDN @world 2>&1 | tr -d '\r' | awk '/ebuild/ && /\[/ {count++} END {print count+0}')

# Salida JSON para Waybar
printf '{"text": "%s 󰚰", "tooltip": "%s paquetes detectados"}\n' "$updates" "$updates"
