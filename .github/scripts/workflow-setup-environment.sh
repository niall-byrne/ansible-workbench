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

  BRANCH_OR_TAG="$(echo "${GITHUB_REF}" | sed 's/refs\/heads\///g' | sed 's/refs\/tags\///g')"
  WORKFLOW_URL="${GITHUB_SERVER_URL}/${GITHUB_REPOSITORY}/actions/runs/${GITHUB_RUN_ID}"

  {
    echo "ANSIBLE_WORKBENCH_BRANCH_NAME_BASE=${ANSIBLE_WORKBENCH_BRANCH_NAME_BASE}"
    echo "ANSIBLE_WORKBENCH_BRANCH_NAME_DEVELOPMENT=${ANSIBLE_WORKBENCH_BRANCH_NAME_DEVELOPMENT}"
    echo "BRANCH_OR_TAG=${BRANCH_OR_TAG}"
    echo "CACHE_TTL=$(date +%d)"
    echo "NOTIFICATION=${PROJECT_NAME} [<${WORKFLOW_URL}|${BRANCH_OR_TAG}>]"
    echo "PROJECT_NAME=${PROJECT_NAME}"
    echo "TEMPLATED_NAME=${TEMPLATED_NAME}"
    echo "USER_NAME=${USER_NAME}"
    echo "WEBHOOK_URL=${WEBHOOK_URL}"
  } >> "${GITHUB_ENV}"

}

main "$@"
