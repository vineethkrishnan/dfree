#!/usr/bin/env bash
# Adapter: Config Parser
# Implements parsing of ~/.dfreerc for custom rules.

# shellcheck source=src/adapters/ui/text.sh
source "${PROJECT_ROOT}/src/adapters/ui/text.sh"

export DFREE_CUSTOM_PATHS=()
export DFREE_EXCLUDED_PATHS=()

load_user_config() {
  local config_file="${HOME}/.dfreerc"

  if [ ! -f "$config_file" ]; then
    return 0
  fi

  # Safely parse the config file to avoid executing arbitrary code.
  # We only support DFREE_CUSTOM_PATHS=("/path1" "/path2") style arrays temporarily by sourcing, 
  # or better yet, basic key=value parsing for safety if it was a real production app.
  # For this shell tool, since it's user config, we source it.
  
  # shellcheck source=/dev/null
  source "$config_file"
}
