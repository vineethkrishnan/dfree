#!/usr/bin/env bash

set -e

INSTALL_DIR="/usr/local/lib/dfree"
BIN_DIR="/usr/local/bin"

echo "Installing dfree..."

# Create install directory
sudo mkdir -p "$INSTALL_DIR"

# Copy source files
sudo cp -r src bin LICENSE README.md "$INSTALL_DIR"

# Link binary
sudo ln -sf "$INSTALL_DIR/bin/dfree" "$BIN_DIR/dfree"

echo "Installation complete! Run 'dfree' to start."
