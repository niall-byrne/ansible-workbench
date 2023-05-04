#!/bin/bash

# .github/scripts/task-identify-molecule-scenarios.sh
# Creates a workflow configuration value containing an array of active molecule scenarios for testing.

# CI only script

set -eo pipefail

main() {

  EXCLUDED="$(jq -rM ".ci_molecule_excluded_scenarios_regex" ".github/config/workflows/workflow-push.json")"
  SCENARIOS=()
  while IFS='' read -r SCENARIO; do SCENARIOS+=("${SCENARIO}"); done < <(find molecule/* -maxdepth 0 -type d -not -name "default" -not -name "${EXCLUDED}" -exec basename {} \;)

  source ".github/scripts/workflow-set-value.sh" jq -M --null-input "\$ARGS.positional" --args "${SCENARIOS[@]}"

}

main "$@"
