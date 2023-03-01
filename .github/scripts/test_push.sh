#!/bin/bash

# .github/scripts/test_push.sh
# Performs pushes against the test repository to trigger rendered workflows.

# 1:              The name of the branch you wish to push.
# 2:              Optionally set a tag you'd like to push.
# REMOTE_TOKEN:   The auth token that will be used to push.
# REMOTE_ORIGIN:  The remote repository we're pushing to. (format: "owner/repository")
# TEMPLATED_NAME: The name of the rendered test project.

# CI only script.

set -eo pipefail

add_test_commit() {
  echo "test commit" > test_file.txt
  git add test_file.txt
  git commit -m 'feat(TEST_FILE): add test file'
}

push() {
  # 1:  The branch you are pushing.
  git push "$(util_get_remote)" HEAD:"${1}" --force
}

push_tags() {
  # 1:  The tag you'd like to push

  # Don't push this tag again.
  git tag --delete 0.0.0

  # Ensure remote tag doesn't exist
  set +e
    git push --delete "$(util_get_remote)" "${1}"
  set -e

  git tag "${1}"
  git push "$(util_get_remote)" --tags
}

util_get_remote() {
  echo "https://${REMOTE_TOKEN}@github.com/${REMOTE_ORIGIN}.git"
}

main() {

  pushd "${TEMPLATED_NAME}"
    git checkout "${1}"
    if [[ -z "${2}" ]]; then
      add_test_commit
      push "${1}"
    else
      push_tags "${2}"
    fi
  popd

}

main "$@"
