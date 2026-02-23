#!/usr/bin/env bats

setup() {
    PROJECT_ROOT="$(cd "${BATS_TEST_DIRNAME}/../.." && pwd)"
    local lib_dir="${BATS_LIB:-${PROJECT_ROOT}/.bats}"
    
    load "${lib_dir}/bats-support/load.bash"
    load "${lib_dir}/bats-assert/load.bash"
    
    source "${PROJECT_ROOT}/src/adapters/runtime/dev_caches.sh"
    
    # Create a dummy home directory with dummy cache folders
    export TEST_HOME="${BATS_TMPDIR}/dfree_dev_cache_test"
    mkdir -p "$TEST_HOME"
    export HOME="$TEST_HOME"
}

teardown() {
    rm -rf "$TEST_HOME"
}

@test "DevCaches: detects npm cache" {
    mkdir -p "${HOME}/.npm/_cacache"
    
    run get_dev_cache_paths
    assert_success
    assert_output --partial "${HOME}/.npm/_cacache"
}

@test "DevCaches: detects yarn cache" {
    mkdir -p "${HOME}/.yarn/cache"
    
    run get_dev_cache_paths
    assert_success
    assert_output --partial "${HOME}/.yarn/cache"
}

@test "DevCaches: handles missing caches gracefully" {
    # No directories created
    run get_dev_cache_paths
    assert_success
    assert_output ""
}
