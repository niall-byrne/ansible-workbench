#!/bin/bash

# .github/scripts/pushed_commit_range.sh
# Retrieves the range of the commits in a push, and sets the PUSHED_COMMIT_START environment variables.

# GITHUB_CONTEXT: The github action context object as an environment variable.

# CI only script

set -eo pipefail


get_all_commits() {
  git rev-list --max-parents=0 HEAD
}


main() {

  PUSHED_COMMIT_START="HEAD~$(echo "${GITHUB_CONTEXT}" | jq '.event.commits | length')"
  PUSHED_COMMIT_REV_RANGE="${PUSHED_COMMIT_START}..HEAD"

  if [[ "${PUSHED_COMMIT_REV_RANGE}" == "HEAD~0" ]]; then
    PUSHED_COMMIT_START="$(get_all_commits)"
    PUSHED_COMMIT_REV_RANGE="HEAD"
  fi

  if ! git rev-parse "${PUSHED_COMMIT_REV_RANGE}"; then
    PUSHED_COMMIT_START="$(get_all_commits)"
  fi

  {
    echo "PUSHED_COMMIT_REV_RANGE=${PUSHED_COMMIT_REV_RANGE}"
    echo "PUSHED_COMMIT_START=${PUSHED_COMMIT_START}"
  } >> "${GITHUB_ENV}"

}

main "$@"
