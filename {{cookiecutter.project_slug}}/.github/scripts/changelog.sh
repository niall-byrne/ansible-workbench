#!/bin/bash

# .github/scripts/changelog.sh
# Generates a changelog for the specified ${BRANCH_OR_TAG}.

# BRANCH_OR_TAG:  The new git tag the changelog is being generated for.

# CI only script

set -eo pipefail

main() {

  CHANGE_LOG_CONTENT="$(npx -q conventional-changelog-cli -t "${BRANCH_OR_TAG}")"

  {
    echo "CHANGE_LOG_CONTENT<<EOF"
      echo "${CHANGE_LOG_CONTENT}"
    echo "EOF"
  } >> "${GITHUB_ENV}"

}

main "$@"
