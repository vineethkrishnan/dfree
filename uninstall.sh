#!/usr/bin/env bash

set -e

INSTALL_DIR="/usr/local/lib/dfree"
BIN_DIR="/usr/local/bin"

echo "Uninstalling dfree..."

# Remove link
if [ -L "$BIN_DIR/dfree" ]; then
  sudo rm "$BIN_DIR/dfree"
fi

# Remove install directory
if [ -d "$INSTALL_DIR" ]; then
  sudo rm -rf "$INSTALL_DIR"
fi

echo "Uninstallation complete."
