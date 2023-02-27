# Ansible Workbench

[Ansible](https://www.ansible.com/) Role Development Environment.

##### Master Branch (Follows the latest production tag):
[![ansible-workbench-self-test](https://github.com/niall-byrne/ansible-workbench/workflows/ansible-workbench-self-test/badge.svg?branch=master)](https://github.com/niall-byrne/ansible-workbench/actions)

##### Dev Branch:
[![ansible-workbench-self-test](https://github.com/niall-byrne/ansible-workbench/workflows/ansible-workbench-self-test/badge.svg?branch=dev)](https://github.com/niall-byrne/ansible-workbench/actions)

## About

This [cookiecutter](https://cookiecutter.readthedocs.io/) template generates a development environment for [Ansible Roles](https://docs.ansible.com/ansible/latest/playbook_guide/playbooks_reuse_roles.html) with comprehensive functional CI/CD for GitHub Actions.

[Poetry](https://python-poetry.org/) powers a [Python virtual environment](https://docs.python.org/3/library/venv.html) loaded with [Molecule](https://molecule.readthedocs.io/en/latest/), and [Ansible-Lint](https://ansible-lint.readthedocs.io/) allowing you to develop and test roles with a focus on quality.

**Windows Users**:
- If you are working locally with Windows, you'll need a Posix or Linux virtual environment of some kind to use this template.
- Neither Ansible, nor Ansible-Lint support this platform.

**OSX, Linux, BSD Users**:
- Please follow the [Quick Start Guide](#Quick%20Start%20Guide) below.

## Requirements
You'll need [Python](https://www.python.org/) **3.9** or later to use this template.  ([Ansible](https://www.ansible.com/) now requires this.)

## Quick Start Guide

- `pip install cookiecutter poetry`
- `cookiecutter https://github.com/niall-byrne/ansible-workbench.git`

Give your project a name, and populate the other required template inputs.

(Please read the section on [TOML Linting](#Maintaining%20your%20pyproject.toml%20File) for details on this optional tooling.) 

Once the templating is finished:
- `cd <your new project director>`
- `poetry shell` (to interact with [Ansible](https://www.ansible.com/) and [Molecule](https://molecule.readthedocs.io/en/latest/) inside a virtualenv)

You can then execute commands against the placeholder content:
- `molecule lint`
- `molecule test -s docker1`

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

### Maintaining your pyproject.toml File

The template also presents the option to create a pre-commit hook, and a GitHub workflow step to format the [pyproject.toml](./{{cookiecutter.project_slug}}/pyproject.toml) file:
- This is accomplished via the golang binary [tomll](https://github.com/pelletier/go-toml).
- This is the most robust TOML formatter I'm aware of right now.
- However, to use it, you'll need to install the binary on your locale system.

If you'd like to install it and give it a try:
- You can download the latest binary [here](https://github.com/pelletier/go-toml/releases).
- Alternatively, your OS's package manager may support this tool.
  - For example: [Ubuntu](https://manpages.ubuntu.com/manpages/jammy/man1/tomll.1.html) 
- You can also compile the tool yourself fairly easily from [source](https://github.com/pelletier/go-toml).
  - If you have go installed: `$ go install github.com/pelletier/go-toml/v2/cmd/tomll@latest`

## Pre-Commit Git Hooks
The python library [pre-commit](https://pre-commit.com/) comes installed with a few useful initial hooks:

### Default Pre-Commit Hooks:
| Hook Name          | Description                                                                                                  |
| ------------------ | ------------------------------------------------------------------------------------------------------------ |
| commit-lint        | Runs [commitizen](https://commitizen-tools.github.io/commitizen/) on your commit message to validate it.     |
| molecule-lint      | Checks your profile for best Ansible practices and behaviour.                                                |
| toml-lint          | Optionally runs [tomll](https://github.com/pelletier/go-toml) on your TOML configuration file.               |

## Third Party Integrations

Integrations with the following third party services are configured during templating:

- [GitHub Workflows](https://docs.github.com/en/free-pro-team@latest/actions/reference/workflow-syntax-for-github-actions)
  - [workflows](./{{cookiecutter.project_slug}}/.github/workflows)
