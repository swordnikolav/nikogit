#!/bin/sh
set -e
HOME_DIR="$HOME"
DESKTOP_FILE="$HOME_DIR/.local/share/applications/mpv.desktop"
VIDEO_PATH="/home/sword/putousb/[One Pace][129-132] Drum Island 01 [1080p][FD2B4F32].mkv"
echo "🔧 Fix final para Thunar..."
mkdir -p "$HOME_DIR/.local/share/applications"
cat > "$DESKTOP_FILE" << EOF
[Desktop Entry]
Exec=sh -c "/home/sword/.local/bin/mpv \\"$1\\"" dummy %f
MimeType=video/mp4;video/x-matroska;video/avi;video/quicktime;video/webm;
Name=mpv
NoDisplay=false
Type=Application
EOF
sed -i "s|/home/sword|$HOME_DIR|g" "$DESKTOP_FILE"
echo "✅ .desktop actualizado"
update-desktop-database "$HOME_DIR/.local/share/applications/" 2>/dev/null || true
killall thunar 2>/dev/null || true
echo "✅ Thunar recargado"
echo "🧪 Test manual --version:"
~/.local/bin/mpv --version | head -3
echo "🧪 Test video manual:"
~/.local/bin/mpv "$VIDEO_PATH" 2>&1 | grep -q "Exiting" || echo "✅ Video OK"
echo "🎉 Listo! Doble-click en Thunar."
