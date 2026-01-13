#!/usr/bin/sh

# Deps: amixer

case $BLOCK_BUTTON in
    1) amixer sset Master toggle ;;
esac

str() {
    echo "^c$COL_TARONJA^$1^c#444444^"
}


estat="$(amixer sget Master | tail -1)"

# mutejat?
if echo $estat | grep "\[off\]" >/dev/null; then
	str "  "
	exit 0
fi;

# no mutejat
v="$(echo $estat | tr -d '\[\]%' | awk '{print $5}')"
if [ "$v" -gt "100" ]; then str "   $v%"
elif [ "$v" -ge "50" ]; then str "   $v%"
else str "  $v%"; fi
