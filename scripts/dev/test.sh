#!/usr/bin/env bash
# Test Runner
# Downloads and runs bats-core if not present.

set -e

PROJECT_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/../.." && pwd)"
TEST_DIR="${PROJECT_ROOT}/tests"
BATS_DIR="${PROJECT_ROOT}/.bats"

# Install bats if missing
if [ ! -d "${BATS_DIR}" ]; then
  echo "Installing bats-core..."
  mkdir -p "${BATS_DIR}"
  git clone --depth 1 https://github.com/bats-core/bats-core.git "${BATS_DIR}/bats-core"
  git clone --depth 1 https://github.com/bats-core/bats-support.git "${BATS_DIR}/bats-support"
  git clone --depth 1 https://github.com/bats-core/bats-assert.git "${BATS_DIR}/bats-assert"
fi

export PATH="${BATS_DIR}/bats-core/bin:${PATH}"

echo "Running tests..."
bats "${TEST_DIR}/core"
