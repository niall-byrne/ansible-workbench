#!/bin/bash

# .github/scripts/workflow_json_value.sh
# Create configuration for a workflow run dynamically.

# @  An array of commands to execute to generate the JSON value.

# CI only script

set -eo pipefail

main() {

  {
    echo "json_value<<EOF"
      "$@"
    echo "EOF"
  } >> "${GITHUB_OUTPUT}"

}

main "$@"


