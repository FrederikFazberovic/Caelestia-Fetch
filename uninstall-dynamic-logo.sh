#!/usr/bin/env bash
set -e

SYSC=fastfetch-theme-watcher
USER_HOME=$(eval echo ~$USER)
BIN_DIR="$USER_HOME/.local/bin"
SERVICE_FILE="$USER_HOME/.config/systemd/user/fastfetch-theme-watcher.service"
echo "stopping and disabling $SYSC"
systemctl --user stop $SYSC && systemctl --user disable $SYSC
echo "removing from $BIN_DIR"
rm -rf "$BIN_DIR/$SYSC"
rm -rf "$BIN_DIR/fastfetch-logo-colorize"
rm -rf "$SERVICE_FILE"
