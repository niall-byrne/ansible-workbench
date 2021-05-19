#!/bin/bash

initialize_git() {
  git init
  git checkout -b master
  git stage .
  git commit -m "build(COOKIECUTTER): initial generation"
  git symbolic-ref HEAD refs/heads/master
  git tag v0.0.0
  git checkout -b production
  git checkout master
  mkdir -p files templates
}

initialize_poetry() {
  if [[ -z "$(poetry env list)" ]]; then
    poetry install
  fi
}

update_template_values() {
  # Compatible with Linux and BSD sed
  sed -i.bak 's/ansible-workbench\//https:\/\/github.com\/Shared-Vision-Solutions\/ansible-workbench.git/' .cookiecutter/cookiecutter.json
  rm .cookiecutter/cookiecutter.json.bak
}

main() {
  update_template_values
  initialize_git
  initialize_poetry
}

main
