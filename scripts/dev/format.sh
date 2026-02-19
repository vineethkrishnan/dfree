#!/usr/bin/env bash

# Format and lint script
# Usage: ./scripts/dev/format.sh

set -e

# Function to check if a command exists
command_exists() {
  command -v "$1" >/dev/null 2>&1
}

echo "Running formatters and linters..."

# check for shfmt
if command_exists shfmt; then
  echo "Running shfmt..."
  shfmt -w -i 2 -ci .
else
  echo "WARNING: shfmt not found. Skipping formatting."
  echo "Install with: brew install shfmt (macOS) or snap install shfmt (Linux)"
fi

# check for shellcheck
if command_exists shellcheck; then
  echo "Running shellcheck..."
  find . -name "*.sh" -o -name "dfree" -not -path "./.git/*" | while read -r file; do
    shellcheck "$file"
  done
else
  echo "WARNING: shellcheck not found. Skipping linting."
  echo "Install with: brew install shellcheck (macOS) or apt install shellcheck (Linux)"
fi

echo "Done."
