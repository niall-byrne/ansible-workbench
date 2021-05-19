# Ansible Workbench

Ansible Role Development Environment.

(Please see the [cookiecutter documentation](https://cookiecutter.readthedocs.io/) for instructions on how to use this project template.)

##### Master Branch:
[![ansible-workbench-self-test](https://github.com/shared-vision-solutions/ansible-workbench/workflows/ansible-workbench-self-test/badge.svg?branch=master)](https://github.com/shared-vision-solutions/ansible-workbench/actions)

##### Production Branch:
[![ansible-workbench-self-test](https://github.com/shared-vision-solutions/ansible-workbench/workflows/ansible-workbench-self-test/badge.svg?branch=production)](https://github.com/shared-vision-solutions/ansible-workbench/actions)

## About

This template generates a development environment for Ansible Roles with a functional CI/CD template for both Travis CI and Github.

## Getting Started

- `pip install cookiecutter poetry`
- `cookiecutter https://github.com/shared-vision-solutions/ansible-workbench.git --checkout v0.1.0`

Give your project a name, and populate the other required template inputs.

Once the templating is finished:
- `cd <your new project director>`
- `poetry shell` (to interact with ansible and molecule inside a virtualenv)

A `master` branch will be created, allowing you to manage a separate `production` branch in [gitlabflow](https://docs.gitlab.com/ee/topics/gitlab_flow.html) style.

## License

[MPL-2](LICENSE)

## Adding / Removing Dependencies For Your Project

#### Python Dependencies:

Use the [pyproject.toml](./{{cookiecutter.project_slug}}/pyproject.toml) file to store your project dependencies in accordance with [PEP 518](https://www.python.org/dev/peps/pep-0518/) and [Poetry Dependency Management](https://python-poetry.org/docs/pyproject/#dependencies-and-dev-dependencies).

Poetry is leveraged to manage the Python dependencies:
- [Adding Python Packages with Poetry](https://python-poetry.org/docs/cli/#add)
- [Removing Python Packages With Poetry](https://python-poetry.org/docs/cli/#remove)

## Default Installed Python Packages:
| package      | Description                                  |
| ------------ | -------------------------------------------- |
| ansible      | Simple, agentless IT automation              |
| ansible-lint | Checks playbooks for practices and behaviour |
| commitizen   | Standardizes commit messages                 |
| poetry       | Python package manager                       |
| molecule     | Ansible test framework                       |
| yamllint     | Lints yaml configuration files               |

## Third Party Integrations

Integrations with the following third party services are configured during templating:

- [Github Workflows](https://docs.github.com/en/free-pro-team@latest/actions/reference/workflow-syntax-for-github-actions)
  - [workflows](./{{cookiecutter.project_slug}}/.github/workflows)
- [TravisCI](https://travis-ci.com/)
  - [.travis.yml](./{{cookiecutter.project_slug}}/.travis.yml)
