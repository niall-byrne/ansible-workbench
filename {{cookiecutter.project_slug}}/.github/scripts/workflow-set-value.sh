#!/bin/bash

# .github/scripts/workflow-set-value.sh
# Create configuration for a workflow run dynamically.

# @  An array of commands to execute to generate the JSON value.

# CI only script

set -eo pipefail

main() {

  {
    echo "value<<EOF"
      "$@"
    echo "EOF"
  } >> "${GITHUB_OUTPUT}"

}

main "$@"


