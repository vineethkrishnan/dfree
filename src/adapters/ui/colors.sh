#!/usr/bin/env bash
# Adapter: UI Colors
# Provides ANSI color codes for terminal output.

# Reset
export COLOR_RESET='\033[0m'

# Regular Colors
export COLOR_BLACK='\033[0;30m'
export COLOR_RED='\033[0;31m'
export COLOR_GREEN='\033[0;32m'
export COLOR_YELLOW='\033[0;33m'
export COLOR_BLUE='\033[0;34m'
export COLOR_PURPLE='\033[0;35m'
export COLOR_CYAN='\033[0;36m'
export COLOR_WHITE='\033[0;37m'

# Bold
export COLOR_BOLD='\033[1m'
export COLOR_BOLD_RED='\033[1;31m'
export COLOR_BOLD_GREEN='\033[1;32m'
export COLOR_BOLD_YELLOW='\033[1;33m'
export COLOR_BOLD_BLUE='\033[1;34m'
export COLOR_BOLD_PURPLE='\033[1;35m'
export COLOR_BOLD_CYAN='\033[1;36m'
export COLOR_BOLD_WHITE='\033[1;37m'

ui_color_print() {
  local color="$1"
  local text="$2"
  echo -e "${color}${text}${COLOR_RESET}"
}
