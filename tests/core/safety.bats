#!/usr/bin/env bats

setup() {
    # Define PROJECT_ROOT relative to this file (tests/core/safety.bats)
    # BATS_TEST_DIRNAME gives the directory of the test file
    PROJECT_ROOT="$(cd "${BATS_TEST_DIRNAME}/../.." && pwd)"
    
    # Load libraries assuming they are in .bats/ or provided by BATS_LIB env var
    local lib_dir="${BATS_LIB:-${PROJECT_ROOT}/.bats}"
    
    load "${lib_dir}/bats-support/load.bash"
    load "${lib_dir}/bats-assert/load.bash"
    
    # Source the file to test
    source "${PROJECT_ROOT}/src/core/safety.sh"
}

@test "Safety: deny root path" {
    run is_safe_path "/"
    assert_failure
}

@test "Safety: deny system path /bin" {
    run is_safe_path "/bin"
    assert_failure
}

@test "Safety: deny relative path" {
    run is_safe_path "relative/path"
    assert_failure
}

@test "Safety: allow user cache path" {
    run is_safe_path "/home/user/.cache"
    assert_success
}

@test "Safety: deny empty path" {
    run is_safe_path ""
    assert_failure
}
