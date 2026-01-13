# Firejail profile for mpv (RESTABLECIDO CON TODAS TUS RUTAS + RESUME)
quiet
include mpv.local
include globals.local

# --- 1. PERSISTENCIA (RESUME) ---
# Esto permite que los archivos de "watch_later" sobrevivan al cierre
noblacklist ${HOME}/.config/mpv
noblacklist ${HOME}/.local/state/mpv
mkdir ${HOME}/.config/mpv/watch_later
whitelist ${HOME}/.config/mpv/watch_later
whitelist ${HOME}/.config/mpv

# --- 2. TUS RUTAS PERSONALES (RESTABLECIDAS) ---
# Aquí están todas las carpetas que tenías en tu config original
whitelist ${HOME}/Descargas
whitelist ${HOME}/Videos
whitelist ${HOME}/Pez
whitelist ${HOME}/putousb
whitelist ${HOME}/Pelis
whitelist ${HOME}/Capturas
# Por si tienes archivos en la raíz de tu usuario
whitelist ${HOME}

# --- 3. SCRIPTS Y COMPATIBILIDAD ---
include allow-lua.inc
include allow-python2.inc
include allow-python3.inc
noblacklist ${HOME}/.config/youtube-dl
noblacklist ${HOME}/.config/yt-dlp
noblacklist ${HOME}/.netrc

# --- 4. BLOQUEOS DE SEGURIDAD ---
blacklist /usr/libexec
include disable-common.inc
include disable-devel.inc
include disable-exec.inc
include disable-interpreters.inc
include disable-programs.inc
include disable-shell.inc

# --- 5. INCLUDES DE SISTEMA ---
include whitelist-common.inc
include whitelist-player-common.inc
include whitelist-usr-share-common.inc
include whitelist-var-common.inc

# --- 6. SEGURIDAD DEL SANDBOX ---
apparmor
caps.drop all
netfilter
nonewprivs
noroot
nou2f
protocol unix,inet,inet6,netlink
seccomp
seccomp.block-secondary
tracelog

# --- 7. HARDWARE Y BINARIOS ---
# Mantenemos acceso a la GPU y drivers
private-bin env,mpv,python*,waf,youtube-dl,yt-dlp
private-dev

dbus-user none
dbus-system none
restrict-namespaces
