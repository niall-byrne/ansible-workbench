#!/bin/bash

# .github/scripts/task-use-poetry.sh
# Centralized management of poetry installs.

# CI only script

set -eo pipefail

install_poetry() {

  python -m pip install poetry --verbose

}

install_project() {

  poetry install --verbose

}

main () {

  case $1 in
    install-poetry)
      install_poetry
      ;;
    install-project)
      install_project
      ;;
    *)
      echo "Invalid option."
      exit 127
      ;;
  esac

}

main "$@"
