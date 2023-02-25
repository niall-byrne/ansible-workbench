#!/bin/bash

# .github/scripts/prune_test_releases.sh
# Remove existing releases on the test repository.

# GITHUB_TOKEN:   The token used to authorize the call.
# REMOTE_ORIGIN:  The git remote repository name (organization/repo).
# TEST_PUSH_TAG:  The tag name to clean up.

# CI only script.

set -eo pipefail

check_releases() {
  gh release view -R "${REMOTE_ORIGIN}" "${TEST_PUSH_TAG}"
}

main() {

  while check_releases; do
    sleep 0.5
    gh release delete -R "${REMOTE_ORIGIN}" -y "${TEST_PUSH_TAG}"
  done

}

main "$@"
