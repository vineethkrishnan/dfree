#!/usr/bin/env bash
# Adapter: Docker
# Implements ContainerEngine port.

# shellcheck source=src/adapters/ui/text.sh
source "${PROJECT_ROOT}/src/adapters/ui/text.sh"

docker_available() {
  command -v docker >/dev/null 2>&1
}

docker_get_usage() {
  if ! docker_available; then
    echo "Docker not installed"
    return
  fi

  docker system df --format '{{.Type}}: {{.Size}} ({{.Reclaimable}})'
}

docker_prune_system() {
  local simulate="$1"

  if ! docker_available; then
    log_warn "Docker not found, skipping docker cleanup."
    return
  fi

  if [ "$simulate" == "true" ]; then
    log_info "SIMULATE: docker system prune -f"
    return
  fi

  docker system prune -f
}
