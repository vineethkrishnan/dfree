#!/usr/bin/env bash
# Core: App
# Main application entry point logic.

# shellcheck source=src/adapters/ui/text.sh
source "${PROJECT_ROOT}/src/adapters/ui/text.sh"
# shellcheck source=src/core/analyzer.sh
source "${PROJECT_ROOT}/src/core/analyzer.sh"
# shellcheck source=src/core/cleaner.sh
source "${PROJECT_ROOT}/src/core/cleaner.sh"

app_show_help() {
  echo "Usage: dfree [OPTIONS]"
  echo ""
  echo "Options:"
  echo "  --simulate    Run in simulation mode (no deletion)"
  echo "  --version     Show version information"
  echo "  --help        Show this help message"
}

app_show_version() {
  echo "dfree version: ${DFREE_VERSION}"
}

app_start() {
  local simulate="false"

  for arg in "$@"; do
    case "$arg" in
      --simulate)
        simulate="true"
        ;;
      --version)
        app_show_version
        exit 0
        ;;
      --help)
        app_show_help
        exit 0
        ;;
      *)
        log_error "Unknown argument: $arg"
        app_show_help
        exit 1
        ;;
    esac
  done

  ui_header "dfree detected"
  
  analyze_system
  clean_system "$simulate"
}
