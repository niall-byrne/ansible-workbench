#!/bin/bash

# .github/scripts/workflow-determine-pushed-commits.sh
# Retrieves the range of the commits in a push, and sets the PUSHED_COMMIT_START, PUSHED_COMMIT_REV_RANGE variables.

# ANSIBLE_WORKBENCH_PUSH_FALLBACK_INDEX:     Optionally set fallback behaviour when no changed commits are detected.  (Default is the first commit in the project.)
# ANSIBLE_WORKBENCH_PUSH_FALLBACK_REV_RANGE: Optionally set fallback behaviour when no changed commits are detected.  (Default is HEAD, all commits.)
# GITHUB_CONTEXT:                            The github action context object as an environment variable.

# CI only script

set -eo pipefail

ANSIBLE_WORKBENCH_PUSH_FALLBACK_INDEX="${ANSIBLE_WORKBENCH_PUSH_FALLBACK_INDEX-$(git rev-list --max-parents=0 HEAD)}"
ANSIBLE_WORKBENCH_PUSH_FALLBACK_REV_RANGE="${ANSIBLE_WORKBENCH_PUSH_FALLBACK_REV_RANGE-HEAD}"

fallback_behaviour() {
  echo "WARNING: Unable to determine number of changed commits."
  echo "WARNING: Fallback values are being used instead."
  PUSHED_COMMIT_START="${ANSIBLE_WORKBENCH_PUSH_FALLBACK_INDEX}"
  PUSHED_COMMIT_REV_RANGE="${ANSIBLE_WORKBENCH_PUSH_FALLBACK_REV_RANGE}"
}

main() {

  COMMIT_COUNT="$(echo "${GITHUB_CONTEXT}" | jq '.event.commits | length')"

  PUSHED_COMMIT_START="HEAD~${COMMIT_COUNT}"
  PUSHED_COMMIT_REV_RANGE="${PUSHED_COMMIT_START}..HEAD"

  echo "DEBUG: GitHub reports ${COMMIT_COUNT} commit(s) have changed."

  if [[ "${PUSHED_COMMIT_START}" == "HEAD~0" ]]; then
    fallback_behaviour
  fi

  if ! git rev-parse "${PUSHED_COMMIT_START}" >> /dev/null 2>&1; then
    fallback_behaviour
  fi

  {
    echo "PUSHED_COMMIT_REV_RANGE=${PUSHED_COMMIT_REV_RANGE}"
    echo "PUSHED_COMMIT_START=${PUSHED_COMMIT_START}"
  } >> "${GITHUB_ENV}"

}

main "$@"
