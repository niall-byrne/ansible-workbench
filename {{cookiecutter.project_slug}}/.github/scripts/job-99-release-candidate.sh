#!/bin/bash

# .github/scripts/job-99-release-candidate.sh
# Evaluates if the current git reference is a release candidate.

# 1: The git reference that created the workflow flow.

# CI only script.

set -eo pipefail

MATCH="FALSE"

main() {

  if [[ "${1}" =~ ^refs/tags/[[:digit:]]+\.[[:digit:]]+\.[[:digit:]]+$ ]] &&
     [[ "${1}" != "refs/tags/0.0.0" ]]; then
    MATCH="TRUE"
  fi

  echo "release_candidate=${MATCH}" >> "${GITHUB_OUTPUT}"

}

main "$@"
