#!/bin/bash

# .github/scripts/job-50-test-precommit.sh
# Performs tests on the pre-commit hooks.

# 1:              The name of a pre-commit test scenario. (See 'main' below.)
# TEMPLATED_NAME: The name of the rendered test project.

# CI only script.

set -eo pipefail

test_commit_lint() {
  util_git_reset
  touch empty_file.txt
  git stage empty_file.txt
  git commit -m 'test - pre-commit: improperly formatted commit' || exit 0
  util_fail_test
}

test_molecule_lint() {
  util_git_reset
  echo "" >> tasks/main.yml
  git stage tasks/main.yml
  git commit -m 'test(PRE-COMMIT): fail due to ansible-lint' > error.log 2>&1 || grep "empty-lines" error.log > /dev/null && exit 0
  util_fail_test
}

test_toml_lint_1() {
  util_git_reset
  sed -i.bak 's/authors =/    authors = /g' pyproject.toml
  git stage pyproject.toml
  git commit -m 'test(PRE-COMMIT): fail due to tomll' || exit 0
  util_fail_test
}

test_toml_lint_2() {
  util_git_reset
  sed -i.bak 's/python = ">=.*,<4.0/python = ">=3.9.0,<5.0/g' pyproject.toml
  git stage pyproject.toml
  git commit -m 'test(PRE-COMMIT): upgrade python without issue'
}

test_workflow_lint() {
  util_git_reset
  find .github -type f -name '*.yml' -exec sed -i.bak 's/ubuntu-latest/non-existent-os/g' {} \;
  git stage .github
  git commit -m 'test(PRE-COMMIT): fail due to actionlint' || exit 0
}

util_fail_test() {
  echo "This commit should have failed."
  exit 127
}

util_git_reset() {
  git reset HEAD
  git clean -fd
  git checkout .
}

main() {

  pushd "${TEMPLATED_NAME}"
    case $1 in
      commit-lint)
        test_commit_lint
        ;;
      molecule-lint)
        test_molecule_lint
        ;;
      toml-lint-1)
        test_toml_lint_1
        ;;
      toml-lint-2)
        test_toml_lint_2
        ;;
      workflow-lint)
        test_workflow_lint
        ;;
      *)
        echo "Invalid test scenario."
        exit 127
        ;;
    esac
  popd

}

main "$@"
