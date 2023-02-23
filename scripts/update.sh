#!/bin/bash

# This script helps automate the process of updating a role that has already been created.
# A branch "update-template" is created, with the changes required to update the workflow.
# Use git cherry-pick (or create a patch from this change set) to update your ansible role.

# Requires: https://pypi.org/project/cookiecutter-project-upgrader/

# 1:      The path to the role folder you'll be upgrading.
# 2:      The tag or branch of this repository you'll be using to perform the upgrade.

# Development only script.

set -eo pipefail

ANSIBLE_WORKBENCH_TEMPLATE_URL="https://github.com/niall-byrne/ansible-workbench.git"

error() {
  echo "USAGE: ./update.sh [ROLE FOLDER] [TEMPLATE TAG or BRANCH]"
  exit 127
}

[[ -z $2 ]] && error
[[ -z $1 ]] && error

main() {

  pushd "$1" || error
    cookiecutter_project_upgrader                                         \
      -c .cookiecutter/cookiecutter.json                                  \
      -b "update-template"                                                \
      -u "$2"                                                             \
      -f "${ANSIBLE_WORKBENCH_TEMPLATE_URL}"                              \
      -e "defaults"                                                       \
      -e "handlers"                                                       \
      -e "meta"                                                           \
      -e "molecule"                                                       \
      -e "tasks"                                                          \
      -e "tests"                                                          \
      -e "vars"                                                           \
      -e ".gitignore"                                                     \
      -e "pyproject.toml"                                                 \
      -e "requirements.yml"                                               \
      -e ".travis.yml"                                                    \
      -e "LICENSE"                                                        \
      -e "README.md"

    git checkout update-template
  popd || true

}

main "$@"
