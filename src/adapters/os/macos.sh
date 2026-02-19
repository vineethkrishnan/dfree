#!/usr/bin/env bash
# Adapter: MacOS
# Implements DiskUsageProvider and SystemCleaner ports for macOS.

# shellcheck source=src/adapters/ui/text.sh
source "${PROJECT_ROOT}/src/adapters/ui/text.sh"

os_get_disk_usage() {
  # macOS uses -H for human readable (powers of 1000) or -h (powers of 1024)
  # standardized output for parsing: Filesystem Size Used Avail Capacity
  df -H / | tail -1 | awk '{print $2 " " $3 " " $4 " " $5}'
}

os_get_dir_size() {
  local path="$1"
  if [ -d "$path" ]; then
    local size_kb
    size_kb=$(du -sk "$path" 2>/dev/null | awk '{print $1}')
    # Convert to bytes roughly
    echo $((size_kb * 1024))
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
  local trash_path="${HOME}/.Trash"

  if [ "$simulate" == "true" ]; then
    log_info "SIMULATE: Emptying Trash ($trash_path)"
    return 0
  fi

  if [ -d "$trash_path" ]; then
    rm -rf "${trash_path:?}/"*
  fi
}

get_system_cache_paths() {
  echo "${HOME}/Library/Caches"
  echo "${HOME}/Library/Logs"
}

get_app_cache_paths() {
  echo "${HOME}/.npm"
  echo "${HOME}/.yarn/cache"
}
