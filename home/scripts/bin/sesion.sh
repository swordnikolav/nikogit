#!/bin/sh 
# Script para desplegar un menu el power del so.
SESION=$(printf " Apagar\\n Reiniciar\\n Bloquear\\n Salir" | dmenu -i -fn "mononoki:size=10:style=Regular" -nb "#1e1e1e" -nf "#777777" -sb "#1e1e1e" -sf "#ffffff" -p " Sesión:") 
case $SESION in 
	" Apagar") doas shutdown -h now;; 
	" Reiniciar") doas shutdown -r now;;
	" Bloquear") slock;;
	" Salir") xdotool key "super+shift+e";; 
	*) ;; 
esac
