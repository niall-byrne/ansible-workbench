#!/bin/bash

# .github/scripts/task-template-requirements.sh
# Centralized management of template requirements installs.

# CI only script

set -eo pipefail

main () {

  python -m pip install cookiecutter poetry --verbose

}

main "$@"
