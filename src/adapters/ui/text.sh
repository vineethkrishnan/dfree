#!/usr/bin/env bash
# Adapter: UI TextHelper
# Provides logging and formatting utilities.

# shellcheck source=src/adapters/ui/colors.sh
source "${PROJECT_ROOT}/src/adapters/ui/colors.sh"

log_info() {
  echo -e "${COLOR_BLUE}[INFO]${COLOR_RESET} $1"
}

log_success() {
  echo -e "${COLOR_GREEN}[SUCCESS]${COLOR_RESET} $1"
}

log_warn() {
  echo -e "${COLOR_YELLOW}[WARN]${COLOR_RESET} $1"
}

log_error() {
  echo -e "${COLOR_RED}[ERROR]${COLOR_RESET} $1" >&2
}

ui_header() {
  echo -e "\n${COLOR_BOLD_CYAN}=== $1 ===${COLOR_RESET}\n"
}

ui_hr() {
  echo -e "${COLOR_BOLD_BLACK}--------------------------------------------------${COLOR_RESET}"
}

# Ask for confirmation (Y/n)
# Returns 0 for yes, 1 for no
ui_confirm() {
  local prompt="$1"
  local response

  echo -ne "${COLOR_YELLOW}${prompt} [y/N] ${COLOR_RESET}"
  read -r response
  case "$response" in
    [yY][eE][sS] | [yY])
      return 0
      ;;
    *)
      return 1
      ;;
  esac
}
