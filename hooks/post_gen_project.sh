#!/bin/bash

# hooks/post_gen_project.sh
# Configures the templated profile for use.

# ANSIBLE_WORKBENCH_BRANCH_NAME_BASE:         Optional alternate base branch name.
# ANSIBLE_WORKBENCH_BRANCH_NAME_DEVELOPMENT:  Optional alternate development branch name.
# ANSIBLE_WORKBENCH_SKIP_POETRY:              Optionally set to 1 to skip installing dependencies.

# cookiecutter only script.

ANSIBLE_WORKBENCH_BRANCH_NAME_BASE="${ANSIBLE_WORKBENCH_BRANCH_NAME_BASE-"{{ cookiecutter._BRANCH_NAME_BASE }}"}"
ANSIBLE_WORKBENCH_BRANCH_NAME_DEVELOPMENT="${ANSIBLE_WORKBENCH_BRANCH_NAME_DEVELOPMENT-"{{ cookiecutter._BRANCH_NAME_DEVELOPMENT }}"}"
ANSIBLE_WORKBENCH_TEMPLATE_URL="https://github.com/niall-byrne/ansible-workbench.git"

initialize_git() {

  git init
  git checkout -b "${ANSIBLE_WORKBENCH_BRANCH_NAME_BASE}"
  git stage .
  git commit -m "build(COOKIECUTTER): initial generation"
  git symbolic-ref HEAD "refs/heads/${ANSIBLE_WORKBENCH_BRANCH_NAME_BASE}"
  git tag v0.0.0
  git checkout -b "${ANSIBLE_WORKBENCH_BRANCH_NAME_DEVELOPMENT}"
  mkdir -p files templates

}

initialize_poetry() {

  if [[ "${ANSIBLE_WORKBENCH_SKIP_POETRY}" != "1" ]]; then
    poetry install --verbose
  fi

}

update_template_values() {

  if ! grep "${ANSIBLE_WORKBENCH_TEMPLATE_URL}" .cookiecutter/cookiecutter.json; then
     # sed compatible with Linux and BSD
    sed -i.bak 's,"_template": ".*","_template": "'"${ANSIBLE_WORKBENCH_TEMPLATE_URL}"'",g' .cookiecutter/cookiecutter.json
    rm .cookiecutter/cookiecutter.json.bak
  fi

}

main() {

  update_template_values
  initialize_git
  initialize_poetry

}

main
