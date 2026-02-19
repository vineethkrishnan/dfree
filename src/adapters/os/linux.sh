#!/usr/bin/env bash
# Adapter: Linux
# Implements DiskUsageProvider and SystemCleaner ports for Linux.

# shellcheck source=src/adapters/ui/text.sh
source "${PROJECT_ROOT}/src/adapters/ui/text.sh"

os_get_disk_usage() {
  # Linux uses -B1 for bytes, -H for Human readable
  # We use -H for display consistency with macOS adapter
  df -H / | tail -1 | awk '{print $2 " " $3 " " $4 " " $5}'
}

os_get_dir_size() {
  local path="$1"
  if [ -d "$path" ]; then
    # du -sb returns size in bytes
    du -sb "$path" 2>/dev/null | awk '{print $1}'
  else
    echo "0"
  fi
}

os_delete_path() {
  local path="$1"
  local simulate="$2"

  if [ ! -e "$path" ]; then
    return 0
  fi

  if [ "$simulate" == "true" ]; then
    log_info "SIMULATE: rm -rf $path"
    return 0
  fi

  rm -rf "$path"
}

os_empty_trash() {
  local simulate="$1"
  local trash_path="${HOME}/.local/share/Trash"

  if [ "$simulate" == "true" ]; then
    log_info "SIMULATE: Emptying Trash ($trash_path)"
    return 0
  fi

  if [ -d "$trash_path" ]; then
    rm -rf "${trash_path:?}/"*
  fi
}

get_system_cache_paths() {
  echo "/var/cache/apt/archives"
  echo "/var/log/journal"
  echo "${HOME}/.cache"
}

get_app_cache_paths() {
  echo "${HOME}/.npm"
  echo "${HOME}/.yarn/cache"
}
