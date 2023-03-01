#!/bin/bash

# scripts/pre-commit/ansible-lint.sh
# Runs molecule to install/update the dependencies if needed, and then lints changes.

# pre-commit script.

set -eo pipefail

main() {

  # shellcheck source=./.pre-commit/.poetry-compatible.sh
  source "$(dirname -- "${BASH_SOURCE[0]}")/.poetry-compatible.sh"

  if ! git diff --exit-code HEAD -- requirements.yml; then
    run_command molecule dependency
  fi

  run_command molecule lint

}

main "$@"
