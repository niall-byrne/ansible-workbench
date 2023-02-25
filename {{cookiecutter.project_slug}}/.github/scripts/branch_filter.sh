#!/bin/bash

# .github/scripts/branch_filter.sh
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

  echo "match=${MATCH}" >> "${GITHUB_OUTPUT}"

}

main "$@"
