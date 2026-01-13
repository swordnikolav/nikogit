#!/bin/sh
# ~/.config/sway/launch-sway.sh

# Crear runtime dir si no existe
export XDG_RUNTIME_DIR=/run/user/$(id -u)
mkdir -p "$XDG_RUNTIME_DIR"
chmod 700 "$XDG_RUNTIME_DIR"

# Lanzar sway dentro de dbus-run-session (si no hay uno activo)
if [ -z "$DBUS_SESSION_BUS_ADDRESS" ]; then
    exec dbus-run-session sway --unsupported-gpu "$@"
else
    exec sway --unsupported-gpu "$@"
fi
