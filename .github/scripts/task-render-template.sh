#!/bin/bash

# .github/scripts/task-render-template.sh
# Perform automated templating.

# 1:  Optional TOML Formatting
# 2:  Optional workflow Formatting
# 3:  Git Username
# 4:  Git Email

# CI only script.

set -eo pipefail

OPTIONAL_TOML_LINTING=${1:-"1"}
OPTIONAL_WORKFLOW_LINTING=${2:-"1"}
NAME=${3:-"Pro Buddy Dev"}
EMAIL=${4:-"somedude@coolstartup.com"}

main() {

  git config --global user.name "${NAME}"
  git config --global user.email "${EMAIL}"

  echo -e "\n\n${OPTIONAL_TOML_LINTING}\n${OPTIONAL_WORKFLOW_LINTING}\n\n\n\n\n\n\n\n" | cookiecutter template/

}

main "$@"
