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

  # Check explicitly excluded paths
  if [ "${#DFREE_EXCLUDED_PATHS[@]}" -gt 0 ]; then
    for excluded in "${DFREE_EXCLUDED_PATHS[@]}"; do
      # Note: Basic string matching; a robust implementation would use realpath
      if [[ "$path" == "$excluded"* ]]; then
        return 1
      fi
    done
  fi

  return 0
}
