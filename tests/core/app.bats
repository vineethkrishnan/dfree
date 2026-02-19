#!/usr/bin/env bats

setup() {
    # Define PROJECT_ROOT relative to this file (tests/core/app.bats)
    PROJECT_ROOT="$(cd "${BATS_TEST_DIRNAME}/../.." && pwd)"

    local lib_dir="${BATS_LIB:-${PROJECT_ROOT}/.bats}"
    
    load "${lib_dir}/bats-support/load.bash"
    load "${lib_dir}/bats-assert/load.bash"
    
    DFREE_BIN="${PROJECT_ROOT}/bin/dfree"
}

@test "App: --help displays usage" {
    run "${DFREE_BIN}" --help
    assert_success
    assert_output --partial "Usage: dfree"
}

@test "App: --version displays version" {
    run "${DFREE_BIN}" --version
    assert_success
    assert_output --partial "dfree version:"
}

@test "App: unknown argument fails" {
    run "${DFREE_BIN}" --unknown
    assert_failure
    assert_output --partial "Unknown argument"
}
