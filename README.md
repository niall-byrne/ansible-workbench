# Ansible Workbench

[Ansible](https://www.ansible.com/) role development environment powered by [Molecule](https://molecule.readthedocs.io/).

##### Master Branch (Follows the latest production tag):
[![ansible-workbench-self-test](https://github.com/niall-byrne/ansible-workbench/workflows/ansible-workbench-self-test/badge.svg?branch=master)](https://github.com/niall-byrne/ansible-workbench/actions)

##### Dev Branch:
[![ansible-workbench-self-test](https://github.com/niall-byrne/ansible-workbench/workflows/ansible-workbench-self-test/badge.svg?branch=dev)](https://github.com/niall-byrne/ansible-workbench/actions)

## About

This [cookiecutter](https://cookiecutter.readthedocs.io/) template generates a development environment for [Ansible Roles](https://docs.ansible.com/ansible/latest/playbook_guide/playbooks_reuse_roles.html) with comprehensive [templated CI/CD]({{cookiecutter.project_slug}}/.github/workflows) for [GitHub Actions](https://github.com/features/actions).

[Poetry](https://python-poetry.org/) powers a [Python virtual environment](https://docs.python.org/3/library/venv.html) loaded with [Molecule](https://molecule.readthedocs.io/) and [Ansible-Lint](https://ansible-lint.readthedocs.io/) allowing you to develop and test roles with a focus on quality.

**Windows Users**:
- If you are working locally with Windows, you'll need a Posix or Linux virtual environment of some kind to use this template.
- Neither Ansible, nor Ansible-Lint support this platform.

**OSX, Linux, BSD Users**:
- Please follow the [Quick Start Guide](#Quick-Start-Guide) below.

## Requirements
- You'll need [Python](https://www.python.org/) **3.9** or later to use this template.  ([Ansible](https://www.ansible.com/) now requires this.)

## Optional Requirements
- An account on [Ansible Galaxy](https://galaxy.ansible.com/) is recommended if you intend to publish your role.
- An account on [GitHub](https://github.com/) is recommended to make use of the [templated CI/CD]({{cookiecutter.project_slug}}/.github/workflows).
- A configured [Slack Webhook](https://api.slack.com/messaging/webhooks) is also recommended for keeping tabs on the CI/CD.

## Quick Start Guide

- `pip install cookiecutter poetry`
- `cookiecutter https://github.com/niall-byrne/ansible-workbench.git`

Give your project a name, and populate the other required template inputs.

(Please read the section on [TOML Linting](#ii-Maintaining-your-pyprojecttoml-File) for details on this optional tooling.) 

Once the templating is finished:
- `cd <your new project directory>`
- `poetry shell` (to interact with [Ansible](https://www.ansible.com/) and [Molecule](https://molecule.readthedocs.io/) inside a virtualenv)

You can then interact with the [example role]({{cookiecutter.project_slug}}) and [Molecule scenarios]({{cookiecutter.project_slug}}/molecule):
- `molecule lint`
- `molecule test -s docker1`

**More importantly:** you can now build off this existing scaffolding to develop your own high quality Ansible role.

## Managing Dependencies For Your Project

### 1. Ansible Galaxy Dependencies

Modify the templated [requirements.yml]({{cookiecutter.project_slug}}/requirements.yml) file to add or remove the external [roles](https://docs.ansible.com/ansible/latest/playbook_guide/playbooks_reuse_roles.html) or [collections](https://docs.ansible.com/ansible/latest//collections_guide/index.html#collections-index) your role requires.

### 2. Python Dependencies:

The [pyproject.toml]({{cookiecutter.project_slug}}/pyproject.toml) file is there to store your project's Python dependencies in accordance with [PEP 518](https://www.python.org/dev/peps/pep-0518/).

[Poetry](https://python-poetry.org/docs/pyproject/#dependencies-and-dev-dependencies) is leveraged to manage the Python dependencies:
- [Adding Python Packages with Poetry](https://python-poetry.org/docs/cli/#add)
- [Removing Python Packages With Poetry](https://python-poetry.org/docs/cli/#remove)

#### i. Default Installed Python Packages:
| package                                                | Description                                  |
| -------------------------------------------------------| -------------------------------------------- |
| [ansible](https://pypi.org/project/ansible/)           | Simple, agentless IT automation              |
| [ansible-lint](https://pypi.org/project/ansible-lint/) | Checks playbooks for practices and behaviour |
| [commitizen](https://pypi.org/project/commitizen/)     | Standardizes commit messages                 |
| [poetry](https://pypi.org/project/poetry/)             | Python package manager                       |
| [pre-commit](https://pypi.org/project/pre-commit/)     | A framework for managing pre-commit hooks    |
| [molecule](https://pypi.org/project/molecule/)         | Ansible test framework                       |
| [yamllint](https://pypi.org/project/yamllint/)         | Lints yaml configuration files               |

#### ii. Maintaining your 'pyproject.toml' File

The template also presents the option to render a [pre-commit](https://pre-commit.com/) hook and a GitHub workflow step to format the [pyproject.toml]({{cookiecutter.project_slug}}/pyproject.toml) file:
- This is accomplished via the golang binary [tomll](https://github.com/pelletier/go-toml).
- This is the most robust TOML formatter I'm aware of right now.
- However, it requires installing the binary on your local system.

If you'd like to install it and give it a try:
- You can download the latest binary [here](https://github.com/pelletier/go-toml/releases).
- Alternatively, your OS's package manager may support this tool.
  - For example: [Ubuntu](https://manpages.ubuntu.com/manpages/jammy/man1/tomll.1.html) 
- You can also compile the tool yourself fairly easily from [source](https://github.com/pelletier/go-toml).
  - If you have go installed: `$ go install github.com/pelletier/go-toml/v2/cmd/tomll@latest`

## Working With Ansible Workbench

A fundamental pillar of Ansible Workbench is the use of [Conventional Commits](https://www.conventionalcommits.org/).

#### 1. Why Conventional Commits?
- Following this standard has numerous advantages, but among the largest is its tight integration with [Semantic Versioning](https://semver.org/).
- For the Ansible Workbench CI/CD in particular, [changelog generation]({{cookiecutter.project_slug}}/.github/scripts/job-99-create-changelog.sh) and [release automation]({{cookiecutter.project_slug}}/.github/workflows/workflow-publish-to-galaxy.yml) is made possible through adherence to this format.
- Being able to read commits from different people that conform to common standard also makes [interactive rebasing](https://git-scm.com/book/en/v2/Git-Tools-Rewriting-History) relatively painless.

#### 2. Making A Conventional Commit With Commitizen
- Ansible Workbench leverages [commitizen](https://commitizen-tools.github.io/commitizen/) to enforce [Conventional Commits](https://www.conventionalcommits.org/) as well as [Semantic Versioning](https://semver.org/).
- Stage any changes as your normally would: `git add tasks/new_task_file.yml`
- Launch [commitizen](https://commitizen-tools.github.io/commitizen/): `poetry run cz c`  (See the [next section](#iii-Optimizing-Your-Workflow) to shorten that command.)
- Alternatively, you might instead opt to manually make your commits: `git commit -m "feat(NEW_TASK_FILE): my new task file"`

#### 3. Optimizing Your Workflow
- It's a bit more practical to work inside the [Poetry](https://python-poetry.org/) virtual environment itself:
- Start the virtual environment: `poetry shell`
- Stage your changes: `git add tasks/new_task_file.yml`
- Make your commit: `cz c`

#### 4. Linting Your Commits
- Commits are linted both by the [pre-commit hooks](#Pre-Commit-Git-Hooks) and the [templated GitHub CI/CD]({{cookiecutter.project_slug}}/.github/workflows).
- Tags are ALSO linted.  Please see the related section on [tagging your releases](#ii-Tagging-Your-Releases).

#### 5. Legacy Commit Problems
- If you have legacy (non-conventional) commits in your git history, you **can** still use the templated CI/CD.
- Please see the section on [configuring the 'push' workflow](#Push-Workflow-Configuration).
  - One approach is setting `ci_commitzen_rev_range` to: "<my first conventional commit hash>..HEAD"
- With this workaround in place you may still have CI failures if rebasing legacy commits that you don't rename.
  - To ensure the CI passes, you could [trigger a manual run](https://docs.github.com/en/actions/managing-workflow-runs/manually-running-a-workflow) of the workflow.

## Writing Molecule Tests with Ansible Workbench
There are 3 example [Molecule scenarios](https://molecule.readthedocs.io/en/stable/configuration.html#scenario) created during templating:

| Scenario Name                                                                        | Description                                                                                                                |
| ------------------------------------------------------------------------------------ | -------------------------------------------------------------------------------------------------------------------------- |
| [default]({{cookiecutter.project_slug}}/molecule/default/molecule.yml)             | Intended as a configuration reference and for use in linting and caching dependencies.                                     |
| [docker1]({{cookiecutter.project_slug}}/molecule/docker1/molecule.yml)             | An example using Molecule's [docker](https://github.com/ansible-community/molecule-plugins) driver.                        |
| [hostmachine1]({{cookiecutter.project_slug}}/molecule/hostmachine1/molecule.yml)   | An example using Molecule's [delegated](https://molecule.readthedocs.io/en/stable/configuration.html#delegated) driver.    |

### 1. The Recommended Molecule Scenario Workflow

#### i. Try To Avoid Modifying the Default Scenario

It's recommended to avoid modifying the [default]({{cookiecutter.project_slug}}/molecule/default/molecule.yml) scenario, to make the most of the [rendered CI/CD]({{cookiecutter.project_slug}}/.github/workflows).

#### ii. Build Your Own Test Scenarios with Molecule

To add tests to your role, create new scenarios with Molecule:
- `poetry run molecule init scenario my_scenario`

#### iii. Add Your New Scenarios to CI/CD

If you are using the rendered [GitHub CI/CD]({{cookiecutter.project_slug}}/.github/workflows/workflow-push.yml), make sure to add your new scenario to the list that are tested in the `molecule_test` step.

### 2. The Recommended Ansible Galaxy Settings

Connections to the [Ansible Galaxy](https://galaxy.ansible.com/) API can sometimes time out, unfortunately.

#### i. Cache Your Dependencies

In your Molecule Scenario file set the dependency option `force: false` as shown [here]({{cookiecutter.project_slug}}/molecule/default/molecule.yml).

In concert with this setting, it's also strongly recommended to avoid modifying the [default]({{cookiecutter.project_slug}}/molecule/default/molecule.yml) Molecule scenario:
- You'll only download dependencies the first time they are needed, or [when they change]({{cookiecutter.project_slug}}/.pre-commit/molecule-lint.sh).
- This will also help you get the most speed out of the default CI/CD configuration.

#### ii. Set a Generous Timeout Value

In your Molecule Scenario file set the dependency option `timeout: 120` as shown [here]({{cookiecutter.project_slug}}/molecule/default/molecule.yml).

## Pre-Commit Git Hooks
The python library [pre-commit](https://pre-commit.com/) is installed during templating with a few useful initial hooks.

### Included Pre-Commit Hooks:
| Hook Name                                                                      | Description                                                                                                                                                                          |
| ----------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| [commit-lint]({{cookiecutter.project_slug}}/.pre-commit/commit-lint.sh)     | Runs [commitizen](https://commitizen-tools.github.io/commitizen/) on your commit message to validate it.                                                                                |
| [molecule-lint]({{cookiecutter.project_slug}}/.pre-commit/molecule-lint.sh) | Runs [ansible-lint](https://ansible-lint.readthedocs.io/) and [yamllint](https://yamllint.readthedocs.io/en/stable/) to checks your role for best Ansible practices and behaviour.      |
| [toml-lint]({{cookiecutter.project_slug}}/.pre-commit/toml-lint.sh)         | Optionally runs [tomll](https://github.com/pelletier/go-toml) on your TOML configuration file.                                                                                          |

## Using GitHub with Ansible Workbench

The majority of time spent developing this project has centered on making the [templated GitHub workflows]({{cookiecutter.project_slug}}/.github/workflows) as useful and as robust as possible.  

Perhaps eventually other CI platforms will be supported, but for now to get the most out of Ansible Workbench, it's recommended to use this platform.

### 1. Create Your New Role's Repository on GitHub

#### i. Creating Your Repository on GitHub

The values you've entered into the [cookiecutter template](cookiecutter.json) determine what your repository should be named, and who it should be owned by.
- Create a repository in GitHub using the `github_handle` you specified, and the `project_slug` name that was created during templating.
- If you want to change the `project_name` or `github_handle` value because of this, you should run cookiecutter again.
- If you don't remember the `project_slug` value, the file [.cookiecutter/cookiecutter.json]({{cookiecutter.project_slug}}/.cookiecutter/cookiecutter.json) will be templated in your role's repository with all the values you entered during templating.

#### ii. Connecting Your New Repository

Connect your new remote repository and push:
- Checkout the `master` branch: `git checkout master`
- Add the new remote origin: `git remote add origin git@github.com:github_handle/project_slug.git`
- Push to the new remote origin: `git push -u origin master`

### 2. Setting Up Your CI/CD

Once you've created your repository on GitHub, you'll be able to take advantage of the included templated CI/CD for [GitHub Actions](https://github.com/features/actions).

#### i. Creating Secrets for Your Workflows

You'll need to create some [secrets](https://docs.github.com/en/actions/security-guides/encrypted-secrets) to enable the full functionality of your CI/CD.

To make the most out of your [templated CI/CD]({{cookiecutter.project_slug}}/.github/workflows), create the following secrets:
- `SLACK_WEBHOOK`:  This secret value can optionally be set to a [Slack Webhook](https://api.slack.com/messaging/webhooks) you can configure to get status updates on how your commit is proceeding through the CI/CD. 
  - The verbosity of this integration can be controlled by setting the `VERBOSE_NOTIFICATIONS` environment variable to 1 in [this]({{cookiecutter.project_slug}}/.github/workflows/workflow-push.yml) workflow.
  - See this documentation on how to create a [Slack Webhook](https://api.slack.com/messaging/webhooks) for your team.
- `GALAXY_API_KEY`:  This secret API key can be found on your [Ansible Galaxy](https://galaxy.ansible.com/) account page, and enables automated publishing to Galaxy.
  - If you do not wish to publish your role, simply leave this secret unset. 

#### iii. An Overview of the CI/CD

##### First Stage

| step                   | description                                                                                                                                                                                   |
| ---------------------- | --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| **commit_lint_test**   | Runs [commitizen](https://commitizen-tools.github.io/commitizen/) on all changed commits.                                                                                                     |
| **documentation_test** | Runs [this](https://github.com/gaurav-nelson/github-action-markdown-link-check) action on all markdown http links to ensure they are correct and return a 200 response.                       |
| **security_test**      | Runs [trufflehog](https://github.com/trufflesecurity/trufflehog) on the repository to ensure no secrets have been checked in.                                                                 |
| **toml_lint_test**     | Optionally (if requested during templating) runs [tomll](https://github.com/pelletier/go-toml) on your [toml](https://pip.pypa.io/en/stable/reference/build-system/pyproject-toml/) files.    |
| **yaml_lint_test**     | Runs [yamllint](https://github.com/adrienverge/yamllint) on all [GitHub Workflow files]({{cookiecutter.project_slug}}/.github/workflows) to ensure they are consistently formatted.           |

##### Second Stage:

| step                   | description                                                                           |
| ---------------------- | ------------------------------------------------------------------------------------- |
| **molecule_lint_test**      | Runs [molecule lint]({{cookiecutter.project_slug}}/molecule/default/molecule.yml) on the default scenario to ensure Ansible best practices. |
| **molecule_test**      | Runs [molecule test](https://molecule.readthedocs.io/en/latest/usage/#valid-actions) on each molecule [scenario](https://molecule.readthedocs.io/en/latest/configuration/#scenario) found [here]({{cookiecutter.project_slug}}/molecule).|

##### Third Stage:

| step                   | description                                                                           |
| ---------------------- | ------------------------------------------------------------------------------------- |
| **create_release**      | If you have pushed a [Semantic Versioning](https://semver.org/) conforming tag, the workflow creates a release for you with a change log.  |

#### iv. Configuring Your CI/CD

To make working with the CI/CD easy to get started with, there is configuration that will be templated with some customizable defaults.

Your workflow configuration files will be created at [.github/config]({{cookiecutter.project_slug}}/.github/config):
- [gaurav-nelson-github-action-markdown-link-check.json]({{cookiecutter.project_slug}}/.github/config/actions/gaurav-nelson-github-action-markdown-link-check.json) is used to customize the [documentation_test](https://github.com/gaurav-nelson/github-action-markdown-link-check) step of the workflow.
- [push.json]({{cookiecutter.project_slug}}/.github/config/workflows/workflow-push.json) is used to customize the push workflow itself.  (This is the workflow that runs on each git "push" to your GitHub repository.)

##### Push Workflow Configuration

The following values are exposed in the [push.json]({{cookiecutter.project_slug}}/.github/config/workflows/workflow-push.json) configuration file:
- "ci_commitzen_rev_range": Optionally allows you to specify the range commitizen will respect when examining pushed commits.
- "ci_molecule_excluded_scenarios_regex":  Allows you to specify a regex that will prevent certain molecule scenarios from being run by the CI/CD.
- "ci_molecule_test_platforms":  Allows you to specify an array of [GitHub Action Platforms](https://docs.github.com/en/actions/using-github-hosted-runners/about-github-hosted-runners#supported-runners-and-hardware-resources) your role will be linted and tested with.
- "ci_python_versions":  Allows you to specify an array of Python versions your role will be tested on.
- "ci_trufflehog_extra_scan_args": Optionally allows you to pass extra arguments to [trufflehog](https://github.com/trufflesecurity/trufflehog) during scans.

### 3. Creating a Release

If you have created something you want to share with the Ansible community, there is an included automated release process which enables you to publish your role to both on [GitHub](https://docs.github.com/en/repositories/releasing-projects-on-github/about-releases) and [Ansible Galaxy](https://galaxy.ansible.com/).

#### i. Prerequisites
- Release generation depends in part on your use of [Conventional Commits](https://www.conventionalcommits.org/) to format each individual commit to your code base
- Please see the section on [working with Ansible Workbench](#Working-With-Ansible-Workbench) for more details.

#### ii. Tagging Your Releases
Tag your release with [Semantic Versioning](https://semver.org/).  (Avoid prefixing a 'v' or 'version' to your tag.)
- It's recommended to use [commitizen](https://commitizen-tools.github.io/commitizen/) to manage the process of updating versions, and ensuring tags are in the correct format.
  - To "bump" your release: `poetry run cz bump`
- If you are managing this process manually, take care to ensure the `version` field is updated inside your [pyproject.toml]({{cookiecutter.project_slug}}/pyproject.toml) file.

#### iii. Publishing Your Release to GitHub
- Push your new semantic conforming tag to GitHub, and ensure the CI passes: `git push --tags`  
- The CI will create a `draft` release for you with a changelog on GitHub.
- Review it and if all is well, `edit` and then `publish` the release on GitHub.

#### iv. Publishing Your Release to Ansible Galaxy
- If you have configured a [secret](#2-Setting-Up-Your-CICD) for Ansible Galaxy more automation will now begin **after** you've published your GitHub release.
- The [release workflow]({{cookiecutter.project_slug}}/.github/workflows/workflow-publish-to-galaxy.yml) will be triggered, and will publish your release automatically to [Ansible Galaxy](https://galaxy.ansible.com/). 

## License

[MPL-2](LICENSE)