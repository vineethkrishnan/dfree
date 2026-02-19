#!/usr/bin/env bash
# Boot: Bootstrap
# Responsible for detecting OS and loading appropriate adapters.

OS_TYPE="$(uname -s)"
case "$OS_TYPE" in
  Linux*)
    # shellcheck source=src/adapters/os/linux.sh
    source "${PROJECT_ROOT}/src/adapters/os/linux.sh"
    ;;
  Darwin*)
    # shellcheck source=src/adapters/os/macos.sh
    source "${PROJECT_ROOT}/src/adapters/os/macos.sh"
    ;;
  *)
    echo "Unsupported OS: $OS_TYPE"
    exit 1
    ;;
esac

# shellcheck source=src/adapters/runtime/docker.sh
source "${PROJECT_ROOT}/src/adapters/runtime/docker.sh"

# shellcheck source=src/boot/version.sh
source "${PROJECT_ROOT}/src/boot/version.sh"

# shellcheck source=src/core/app.sh
source "${PROJECT_ROOT}/src/core/app.sh"

main() {
  app_start "$@"
}
