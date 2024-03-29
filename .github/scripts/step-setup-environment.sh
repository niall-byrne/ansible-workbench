#!/bin/bash

# Configures environment variables for GitHub Actions.

# Implementation:
# Templates implementing this script must set the required environment variables in the GitHub runner's environment context.
#
# BRANCH_OR_TAG:                    The current branch or tag being tested.
# CACHE_TTL:                        A unique CACHE value that determines the cache's TTL.  (Default strategy: day of the month.)
# NOTIFICATION_LINK:                Consumed by the notification script to provide a clickable link to the workflow run in GitHub.
# PROJECT_NAME:                     The slugified name of the template project.  Should match the GitHub repository name.
# PROJECT_OWNER:                    The GitHub owner of the project.
# TEMPLATE_BRANCH_NAME_BASE:        The name of the templated repository's default branch name.  (Defaults to 'master'.)
# TEMPLATE_BRANCH_NAME_DEVELOPMENT: The name of the templated repository's development branch name.  (Defaults to 'dev'.)
# TEST_PROJECT_NAME:                The slugified name of the template when populated during testing.  Should match any test GitHub repository in use.

# CI only script.

set -eo pipefail

WORKFLOW_NAME="${WORKFLOW_NAME:-""}"

main() {

  PROJECT_NAME="ansible-workbench"
  PROJECT_OWNER="niall-byrne"
  TEST_PROJECT_NAME="flower-generator"

  TEMPLATE_BRANCH_NAME_BASE="master"
  TEMPLATE_BRANCH_NAME_DEVELOPMENT="dev"

  BRANCH_OR_TAG="$(echo "${GITHUB_REF}" | sed -E 's,refs/heads/|refs/tags/,,g')"
  WORKFLOW_URL="${GITHUB_SERVER_URL}/${GITHUB_REPOSITORY}/actions/runs/${GITHUB_RUN_ID}"

  [[ "${WORKFLOW_NAME}" != "" ]] && WORKFLOW_NAME="-${WORKFLOW_NAME}"

  {
    echo "BRANCH_OR_TAG=${BRANCH_OR_TAG}"
    echo "CACHE_TTL=$(date +%d)"
    echo "NOTIFICATION_LINK=${PROJECT_NAME}${WORKFLOW_NAME} [<${WORKFLOW_URL}|${BRANCH_OR_TAG}>]"
    echo "PROJECT_NAME=${PROJECT_NAME}"
    echo "PROJECT_OWNER=${PROJECT_OWNER}"
    echo "TEMPLATE_BRANCH_NAME_BASE=${TEMPLATE_BRANCH_NAME_BASE-master}"
    echo "TEMPLATE_BRANCH_NAME_DEVELOPMENT=${TEMPLATE_BRANCH_NAME_DEVELOPMENT-dev}"
    echo "TEST_PROJECT_NAME=${TEST_PROJECT_NAME}"
  } >> "${GITHUB_ENV}"

}

main "$@"
