#!/bin/sh

# Cargar perfiles si existen
[ -f /etc/xprofile ] && . /etc/xprofile
[ -f ~/.xprofile ] && . ~/.xprofile

# 1. Forzar variables críticas
export DISPLAY=:0

# 2. Configurar monitores (Nouveau)
xrandr --output HDMI-A-1 --mode 2560x1440 --rate 240 --primary \
       --output DP-1 --mode 1920x1080 --rate 144 --right-of HDMI-A-1 &

# 3. Dar permiso a aplicaciones locales (Soluciona el error de Telegram)
xhost +local:sword &


touch ~/.Xauthority
export XAUTHORITY=$HOME/.Xauthority
xhost +local:sword
# 4. Lanzar dwm con D-Bus
exec dbus-launch --sh-syntax --exit-with-session dwm
