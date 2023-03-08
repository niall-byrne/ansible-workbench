#!/bin/bash

# .github/scripts/workflow-setup-environment.sh
# Configures environment variables for GitHub Workflows.

# CI only script.

set -eo pipefail

main() {

  PROJECT_NAME="{{ cookiecutter.project_slug }}"
  USER_NAME="{{ cookiecutter.github_handle }}"

  BRANCH_OR_TAG="$(echo "${GITHUB_REF}" | sed 's/refs\/heads\///g' | sed 's/refs\/tags\///g')"
  WORKFLOW_URL="${GITHUB_SERVER_URL}/${GITHUB_REPOSITORY}/actions/runs/${GITHUB_RUN_ID}"

  {
    echo "BRANCH_OR_TAG=${BRANCH_OR_TAG}"
    echo "CACHE_TTL=$(date +%d)"
    echo "NOTIFICATION=${PROJECT_NAME} [<${WORKFLOW_URL}|${BRANCH_OR_TAG}>]"
    echo "PROJECT_NAME=${PROJECT_NAME}"
    echo "USER_NAME=${USER_NAME}"
    echo "WEBHOOK_URL=${WEBHOOK_URL}"
  } >> "${GITHUB_ENV}"

}

main "$@"
