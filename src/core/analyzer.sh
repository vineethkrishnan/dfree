#!/usr/bin/env bash
# Core: Analyzer
# Orchestrates gathering of stats.

# shellcheck source=src/adapters/ui/text.sh
source "${PROJECT_ROOT}/src/adapters/ui/text.sh"

analyze_system() {
  ui_header "System Analysis"

  log_info "Scanning disk usage..."
  os_get_disk_usage

  log_info "Scanning Docker usage..."
  docker_get_usage

  log_info "Scanning Developer Caches..."
  local dev_caches=()
  local line
  while IFS= read -r line; do
    [ -z "$line" ] && continue
    dev_caches+=("$line")
  done <<< "$(get_dev_cache_paths)"
  
  for cache in "${dev_caches[@]}"; do
    local size
    size=$(os_get_dir_size "$cache")
    size=$((size / 1048576)) # roughly MB
    echo "  - ${cache}: ${size}MB"
  done
  
  if [ "${#DFREE_CUSTOM_PATHS[@]}" -gt 0 ]; then
    log_info "Scanning Custom Paths (from config)..."
    for path in "${DFREE_CUSTOM_PATHS[@]}"; do
      if [ -d "$path" ]; then
        local size
        size=$(os_get_dir_size "$path")
        size=$((size / 1048576))
        echo "  - ${path}: ${size}MB"
      fi
    done
  fi
}
