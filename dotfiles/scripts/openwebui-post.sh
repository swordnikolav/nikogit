#!/bin/bash

# 1. Comprobar si Docker está instalado
if ! command -v docker &> /dev/null; then
    choice=$(GTK_THEME=Catppuccin-Mocha-Standard-Blue-Dark zenity --question \
        --title="Docker Not Found" \
        --text="Docker is not installed. Do you want to attempt setup?" \
        --ok-label="Install" \
        --cancel-label="Cancel")

    if [ $? -eq 0 ]; then
        chmod +x ~/.config/scripts/openwebui-postinstall.sh
        kitty -e ~/.config/scripts/openwebui-postinstall.sh
    else
        exit 1
    fi
else
    # 2. Verificar si el contenedor existe y está corriendo
    if [ "$(sudo docker ps -aq -f name=open-webui)" ]; then
        if [ ! "$(sudo docker ps -q -f name=open-webui)" ]; then
            echo "Iniciando contenedor..."
            sudo docker start open-webui
            sleep 2
        fi
    fi

    # 3. Abrir Opera
    opera --new-window "http://localhost:8080/"
fi
