#!/bin/bash

# This script helps automate the process of updating a role that has already been created.
# A branch "update-template" is created, with the changes required to update the role.
# Use git cherry-pick (or create a patch from this change set) to update your ansible role.

# Please be advised this is an partially automated solution, and still requires careful manual effort.

# Before getting started carefully look at your role's .cookiecutter/cookiecutter.json file.
# Compare it to the newest version of the template, and update any GitHub workflow action versions and add any
# new values that have since been included.

# Requires: https://pypi.org/project/cookiecutter-project-upgrader/

# 1:                                  The local filepath to the role you'll be upgrading.
# 2:                                  The tag or branch of this repository you'll be using to perform the upgrade.
# ANSIBLE_WORKBENCH_TEMPLATE_SOURCE   Optionally repoint to forked remote repository, or a local zip bundle for the template.
# ANSIBLE_WORKBENCH_UPDATE_BRANCH     Optionally set a a branch name that will be created to house the proposed changes.

# Experimental end-user script.

set -eo pipefail

ANSIBLE_WORKBENCH_TEMPLATE_SOURCE="${ANSIBLE_WORKBENCH_TEMPLATE_SOURCE-"https://github.com/niall-byrne/ansible-workbench.git"}"
ANSIBLE_WORKBENCH_UPDATE_BRANCH="${ANSIBLE_WORKBENCH_UPDATE_BRANCH-"update-template"}"

error() {
  echo "USAGE: ./update.sh [ROLE FOLDER] [TEMPLATE TAG or BRANCH] [--force]"
  exit 127
}

[[ -z $2 ]] && error
[[ -z $1 ]] && error

main() {

  pushd "$1" || error
  if [[ "$3" == "--force" ]]; then
    if git branch | grep "${ANSIBLE_WORKBENCH_UPDATE_BRANCH}"; then
      set +eo pipefail
      git checkout master
      git reset origin/master
      git clean -fd .
      git branch -D "${ANSIBLE_WORKBENCH_UPDATE_BRANCH}"
      rm -rf .git/cookiecutter
      set -eo pipefail
    fi
  fi

  TEMPLATE_SKIP_GIT_INIT=1 \
    TEMPLATE_SKIP_POETRY=1 \
    TEMPLATE_SKIP_PRECOMMIT=1 \
    cookiecutter_project_upgrader \
    -c .cookiecutter/cookiecutter.json \
    -b "${ANSIBLE_WORKBENCH_UPDATE_BRANCH}" \
    -u "$2" \
    -f "${ANSIBLE_WORKBENCH_TEMPLATE_SOURCE}" \
    -e "defaults" \
    -e "handlers" \
    -e "meta" \
    -e "molecule" \
    -e "tasks" \
    -e "tests" \
    -e "vars" \
    -e ".gitignore" \
    -e "pyproject.toml" \
    -e "requirements.yml" \
    -e "LICENSE" \
    -e "README.md"

  git checkout update-template

  echo -e "\n==========="
  echo -e "\nThe following files differ from the template's newest version:"
  git diff HEAD~1 --summary
  echo -e "\nPlease review these changes carefully, and exit from this shell when finished.  Nothing has been pushed or merged yet."

  bash

  popd || true

}

main "$@"
