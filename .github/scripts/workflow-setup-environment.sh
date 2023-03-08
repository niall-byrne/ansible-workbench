#!/bin/bash

# .github/scripts/workflow-setup-environment.sh
# Configures environment variables for GitHub Workflows.

# CI only script.

set -eo pipefail

main() {

  ANSIBLE_WORKBENCH_BRANCH_NAME_BASE="master"
  ANSIBLE_WORKBENCH_BRANCH_NAME_DEVELOPMENT="dev"
  PROJECT_NAME="ansible-workbench"
  USER_NAME="niall-byrne"
  TEMPLATED_NAME="flower-generator"
  VERBOSE_NOTIFICATIONS="${VERBOSE_NOTIFICATIONS:-0}"

  {
    echo "ANSIBLE_WORKBENCH_BRANCH_NAME_BASE=${ANSIBLE_WORKBENCH_BRANCH_NAME_BASE}"
    echo "ANSIBLE_WORKBENCH_BRANCH_NAME_DEVELOPMENT=${ANSIBLE_WORKBENCH_BRANCH_NAME_DEVELOPMENT}"
    echo "PROJECT_NAME=${PROJECT_NAME}"
    echo "USER_NAME=${USER_NAME}"
    echo "TEMPLATED_NAME=${TEMPLATED_NAME}"
    echo "VERBOSE_NOTIFICATIONS=${VERBOSE_NOTIFICATIONS}"
  } >> "${GITHUB_ENV}"

}

main "$@"
