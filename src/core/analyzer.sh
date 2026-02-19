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
}
