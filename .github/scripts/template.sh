#!/bin/bash

# .github/scripts/template.sh
# Perform automated templating.

# 1:  Optional TOML Formatting
# 2:  Git Username
# 3:  Git Email

# CI only script.

set -eo pipefail

OPTIONAL_TOML_LINTING=${1:-"1"}
NAME=${2:-"Pro Buddy Dev"}
EMAIL=${3:-"somedude@coolstartup.com"}

main() {

  git config --global user.name "${NAME}"
  git config --global user.email "${EMAIL}"

  echo -e "\n\n${OPTIONAL_TOML_LINTING}\n\n\n\n\n\n\n\n" | cookiecutter template/

}

main "$@"
