#!/usr/bin/env bash
# Core: Cleaner
# Orchestrates cleanup.

# shellcheck source=src/adapters/ui/text.sh
source "${PROJECT_ROOT}/src/adapters/ui/text.sh"
# shellcheck source=src/core/safety.sh
source "${PROJECT_ROOT}/src/core/safety.sh"

clean_system() {
  local simulate="$1"

  ui_header "Cleanup Process"

  if [ "$simulate" == "true" ]; then
    log_warn "RUNNING IN SIMULATION MODE (No files will be deleted)"
  fi

  if ui_confirm "Prune Docker system (images, containers, networks)?"; then
    log_info "Pruning Docker..."
    docker_prune_system "$simulate"
  else
    log_info "Skipping Docker cleanup."
  fi

  local cache_paths=()
  local line
  while IFS= read -r line; do
    [ -z "$line" ] && continue
    cache_paths+=("$line")
  done <<< "$(get_system_cache_paths)"

  for path in "${cache_paths[@]}"; do
    if is_safe_path "$path"; then
      if ui_confirm "Clean system cache at ${path}?"; then
        os_delete_path "$path" "$simulate"
      fi
    else
      log_warn "Skipping unsafe path: $path"
    fi
  done

  local dev_caches=()
  while IFS= read -r line; do
    [ -z "$line" ] && continue
    dev_caches+=("$line")
  done <<< "$(get_dev_cache_paths)"

  for path in "${dev_caches[@]}"; do
    if is_safe_path "$path"; then
      if ui_confirm "Clean developer cache at ${path}?"; then
        os_delete_path "$path" "$simulate"
      fi
    else
      log_warn "Skipping developer cache: $path"
    fi
  done
  
  if [ "${#DFREE_CUSTOM_PATHS[@]}" -gt 0 ]; then
    for path in "${DFREE_CUSTOM_PATHS[@]}"; do
      if is_safe_path "$path"; then
        if ui_confirm "Clean custom path at ${path}?"; then
          os_delete_path "$path" "$simulate"
        fi
      else
        log_warn "Skipping unsafe custom path: $path"
      fi
    done
  fi

  if ui_confirm "Empty Trash?"; then
    os_empty_trash "$simulate"
  fi

  log_success "Cleanup complete."
}
