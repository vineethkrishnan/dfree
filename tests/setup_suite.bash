#!/usr/bin/env bash

setup_suite() {
    # Common setup for all tests in the suite
    export PROJECT_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
    
    # Check if we are running in the test runner which sets up BATS_DIR
    if [ -z "${BATS_DIR}" ]; then
       # Fallback for manual runs/CI if needed, though test.sh handles this
       export BATS_LIB="${PROJECT_ROOT}/.bats"
    else
       export BATS_LIB="${BATS_DIR}"
    fi
}

load_lib() {
    local name="$1"
    load "${BATS_LIB}/${name}/load.bash"
}
