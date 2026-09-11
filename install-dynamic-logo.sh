#!/usr/bin/env bash
set -e

USER_HOME=$(eval echo ~$USER)
BIN_DIR="$USER_HOME/.local/bin"
SERVICE_FILE="$USER_HOME/.config/systemd/user/fastfetch-theme-watcher.service"

mkdir -p "$BIN_DIR" "$USER_HOME/.config/systemd/user"

# Write Colorizer
cat <<'PYEOF' >"$BIN_DIR/fastfetch-logo-colorize"
#!/usr/bin/env python3
import re, sys, os, argparse
def hex_to_rgb(h):
    h = h.lstrip('#')
    return tuple(int(h[i:i+2], 16) for i in (0, 2, 4))
def load_theme(p):
    try:
        with open(p, 'r') as f:
            return [hex_to_rgb(l.split()[-1]) for l in f if l.strip()]
    except: return None
def map_col(r, g, b, theme, mode):
    if mode == 'half':
        if (max(r, g, b) - min(r, g, b)) >= 30:
            c = theme[0] if theme else (0, 255, 255)
            return f"\x1b[38;2;{c[0]};{c[1]};{c[2]}m"
        return f"\x1b[38;2;{r};{g};{b}m"
    lum = 0.299 * r + 0.587 * g + 0.114 * b
    c = theme[0] if lum > 160 else (theme[2] if lum > 70 else theme[3]) if len(theme) > 3 else (255, 255, 255)
    return f"\x1b[38;2;{c[0]};{c[1]};{c[2]}m"
def main():
    p = argparse.ArgumentParser()
    p.add_argument("logo")
    p.add_argument("--mode", choices=['full', 'half'], default='full')
    args = p.parse_args()
    path = os.path.abspath(args.logo)
    m_path = path + (".half.master" if args.mode == 'half' else ".master")
    theme = load_theme(os.path.expanduser("~/.local/state/caelestia/theme/fastfetch"))
    if not theme: sys.exit(1)
    if not os.path.exists(m_path):
        with open(path, 'r') as f:
            content = f.read()
        with open(m_path, 'w') as out: out.write(content)
    with open(m_path, 'r') as f:
        lines = f.readlines()
    def repl(m):
        r, g, b = map(int, m.groups())
        return map_col(r, g, b, theme, args.mode)
    with open(path, 'w') as f:
        for l in lines: f.write(re.sub(r'\x1b\[38;2;(\d+);(\d+);(\d+)m', repl, l))
if __name__ == "__main__":
    main()
PYEOF

chmod +x "$BIN_DIR/fastfetch-logo-colorize"
echo "Installed fastfetch-logo-colorize in $BIN_DIR"

# Write Watcher
cat <<'BASHEOF' >"$BIN_DIR/fastfetch-theme-watcher"
#!/usr/bin/env bash
T="$HOME/.local/state/caelestia/theme/fastfetch"
D="$HOME/.config/fastfetch/"
C="$HOME/.local/bin/fastfetch-logo-colorize"
update_logos() {
    find "$D" -name "*.master" -print0 | while IFS= read -r -d '' m; do
        if [[ "$m" == *.half.master ]]; then
            "$C" "${m%.half.master}" --mode half
        else
            "$C" "${m%.master}" --mode full
        fi
    done
}
last_hash=""
while true; do
    if [ -f "$T" ]; then
        current_hash=$(md5sum "$T")
        if [ "$current_hash" != "$last_hash" ]; then
            update_logos
            last_hash="$current_hash"
        fi
    fi
    sleep 2
done
BASHEOF

chmod +x "$BIN_DIR/fastfetch-theme-watcher"
echo "Installed fastfetch-theme-watcher in $BIN_DIR"

# Write Service
printf "[Unit]\nDescription=Fastfetch Theme Logo Watcher\n\n[Service]\nExecStart=%s/fastfetch-theme-watcher\nRestart=always\n\n[Install]\nWantedBy=default.target\n" "$BIN_DIR" >"$SERVICE_FILE"
echo "Installed systemd service in $SERVICE_FILE"

systemctl --user daemon-reload
systemctl --user enable --now fastfetch-theme-watcher
echo "Service enabled and started."
echo "Installation complete."
