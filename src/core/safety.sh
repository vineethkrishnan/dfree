#!/usr/bin/env bash
# Core: Safety
# Implements safety policies for deletion.

is_safe_path() {
  local path="$1"

  # Deny root and system directories
  case "$path" in
    "/" | "/bin" | "/usr" | "/etc" | "/boot" | "/System" | "/Applications")
      return 1
      ;;
    *)
      ;;
  esac

  # Must be absolute path
  if [[ "$path" != /* ]]; then
    return 1
  fi

  # Must not be empty
  if [ -z "$path" ]; then
    return 1
  fi

  return 0
}
