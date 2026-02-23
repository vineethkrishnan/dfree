#!/usr/bin/env bats

setup() {
    PROJECT_ROOT="$(cd "${BATS_TEST_DIRNAME}/../.." && pwd)"
    local lib_dir="${BATS_LIB:-${PROJECT_ROOT}/.bats}"
    
    load "${lib_dir}/bats-support/load.bash"
    load "${lib_dir}/bats-assert/load.bash"
    
    source "${PROJECT_ROOT}/src/adapters/config/parser.sh"
    
    # Create a temporary config file for testing
    export TEST_HOME="${BATS_TMPDIR}/dfree_config_test"
    mkdir -p "$TEST_HOME"
    export HOME="$TEST_HOME"
}

teardown() {
    rm -rf "$TEST_HOME"
}

@test "ConfigParser: loads valid config file" {
    cat << 'EOF' > "${HOME}/.dfreerc"
DFREE_CUSTOM_PATHS=("/tmp/mycache1" "/tmp/mycache2")
DFREE_EXCLUDED_PATHS=("/tmp/important")
EOF

    load_user_config
    
    assert_equal "${#DFREE_CUSTOM_PATHS[@]}" "2"
    assert_equal "${DFREE_CUSTOM_PATHS[0]}" "/tmp/mycache1"
    assert_equal "${DFREE_CUSTOM_PATHS[1]}" "/tmp/mycache2"
    
    assert_equal "${#DFREE_EXCLUDED_PATHS[@]}" "1"
    assert_equal "${DFREE_EXCLUDED_PATHS[0]}" "/tmp/important"
}

@test "ConfigParser: handles missing config file gracefully" {
    # Ensure config file doesn't exist
    rm -f "${HOME}/.dfreerc"
    
    run load_user_config
    assert_success
    
    assert_equal "${#DFREE_CUSTOM_PATHS[@]}" "0"
    assert_equal "${#DFREE_EXCLUDED_PATHS[@]}" "0"
}
