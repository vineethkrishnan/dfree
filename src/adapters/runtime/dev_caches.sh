#!/usr/bin/env bash
# Adapter: Dev Caches
# Implements detection of developer caches like npm, yarn, pip, cargo.

get_dev_cache_paths() {
  local paths=()

  # npm cache
  if [ -d "${HOME}/.npm/_cacache" ]; then
    paths+=("${HOME}/.npm/_cacache")
  elif [ -d "${HOME}/.npm" ]; then
    paths+=("${HOME}/.npm")
  fi

  # yarn cache
  if [ -d "${HOME}/.yarn/cache" ]; then
    paths+=("${HOME}/.yarn/cache")
  elif [ -d "${HOME}/Library/Caches/Yarn" ]; then
    paths+=("${HOME}/Library/Caches/Yarn")
  fi

  # pip cache
  if [ -d "${HOME}/.cache/pip" ]; then
    paths+=("${HOME}/.cache/pip")
  elif [ -d "${HOME}/Library/Caches/pip" ]; then
    paths+=("${HOME}/Library/Caches/pip")
  fi

  # cargo cache
  if [ -d "${HOME}/.cargo/registry/cache" ]; then
    paths+=("${HOME}/.cargo/registry/cache")
  fi

  for p in "${paths[@]}"; do
    echo "$p"
  done
}
