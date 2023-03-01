#!/bin/bash

# scripts/test.sh
# Templates and builds the example role with default values for testing.

# Development only script.

OPTIONAL_TOML_LINTING=1

set -eo pipefail

main() {

  rm -rf ../flower-generator

  pushd ..
      echo -e "\n\n${OPTIONAL_TOML_LINTING}\n\n\n\n\n\n\n\n" | cookiecutter ansible-workbench
      cd flower-generator
    echo -e "\nExit from this shell when finished testing ..."
    bash
  popd

}

main "$@"
