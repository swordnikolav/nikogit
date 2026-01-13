#!/bin/sh
# final-fix-mpv-thunar.sh - Fix definitivo para Thunar quoting en MPV/Firejail
# Usa Exec=sh -c 'mpv "$1"' dummy %f (standard para single file, quoted $1)

set -e

HOME_DIR="$HOME"
DESKTOP_FILE="$HOME_DIR/.local/share/applications/mpv.desktop"
VIDEO_PATH="/home/sword/putousb/[One Pace][129-132] Drum Island 01 [1080p][FD2B4F32].mkv"

echo "🔧 Fix final para Thunar quoting..."

# 1. Actualiza .desktop con Exec estándar (quoted $1 para %f literal)
cat > "$DESKTOP_FILE" << 'EOF'
[Desktop Entry]
Exec=sh -c '/home/sword/.local/bin/mpv "$1"' dummy %f
MimeType=video/mp4;video/x-matroska;video/avi;video/quicktime;video/webm;
Name=mpv
NoDisplay=false
Type=Application
