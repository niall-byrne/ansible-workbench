# Ansible Workbench

(Powered by [CICD-Tools](https://github.com/cicd-tools-org/cicd-tools).)

[Ansible](https://www.ansible.com/) role development environment powered by [Molecule](https://molecule.readthedocs.io/).

#### Master Branch (Follows the latest production tag)
[![ansible-workbench-self-test](https://github.com/niall-byrne/ansible-workbench/actions/workflows/workflow-template-test.yml/badge.svg?branch=master)](https://github.com/niall-byrne/ansible-workbench/actions/workflows/workflow-template-test.yml)

#### Dev Branch
[![ansible-workbench-self-test](https://github.com/niall-byrne/ansible-workbench/actions/workflows/workflow-template-test.yml/badge.svg?branch=dev)](https://github.com/niall-byrne/ansible-workbench/actions/workflows/workflow-template-test.yml)

## About

This [cookiecutter](https://cookiecutter.readthedocs.io/) template generates a development environment for [Ansible Roles](https://docs.ansible.com/ansible/latest/playbook_guide/playbooks_reuse_roles.html) with comprehensive [CI/CD]({{cookiecutter.project_slug}}/.github/workflows) for [GitHub Actions](https://github.com/features/actions).

[Poetry](https://python-poetry.org/) powers a [Python virtual environment](https://docs.python.org/3/library/venv.html) loaded with [Molecule](https://molecule.readthedocs.io/) and [Ansible-Lint](https://ansible-lint.readthedocs.io/) allowing you to develop and test roles with a focus on quality.

[CICD-Tools](https://github.com/cicd-tools-org/cicd-tools) provides managed CI/CD components giving you a functional pipeline from day one, and maintains the pipeline components for you.

**Windows Users**:
- If you are working locally with Windows, you'll need a Posix or Linux virtual environment of some kind to use this template.
- Neither Ansible, nor Ansible-Lint support this platform.

**OSX, Linux, BSD Users**:
- Please follow the [Quick Start Guide](#quick-start-guide) below.

## Requirements

### Mandatory
- You'll need [Python](https://www.python.org/) **3.9** or later to use this template.  ([Ansible](https://www.ansible.com/) now requires this.)

### Recommended
- A container runtime environment such as [Docker](https://www.docker.com/) or [Colima](https://github.com/abiosoft/colima) is recommended, to make use of the [configured pre-commit hooks](#pre-commit-git-hooks).
- You'll have to disable the pre-commit hooks if you choose not to follow this path.

### Optional
- An account on [Ansible Galaxy](https://galaxy.ansible.com/) is needed if you intend to publish your role.
- An account on [GitHub](https://github.com/) is needed to make use of the [CI/CD]({{cookiecutter.project_slug}}/.github/workflows).
- A configured [Slack Webhook](https://api.slack.com/messaging/webhooks) is also handy for keeping tabs on the CI/CD.

## Quick Start Guide

Open your shell, and run the following commands:
- `pip install cookiecutter poetry`
- `cookiecutter https://github.com/niall-byrne/ansible-workbench.git`

When prompted:
- Give your project a name, and populate the other required template inputs.
- See the section on [TOML Linting](#ii-maintaining-your-pyprojecttoml-file-only-needed-if-you-add-python-packages) for details on this optional tooling.
- If you plan on using [GitHub Actions](https://github.com/features/actions) with your project, consider using the Workflow Linting.

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

### 2. Python Dependencies

The [pyproject.toml]({{cookiecutter.project_slug}}/pyproject.toml) file is there to store your project's Python dependencies in accordance with [PEP 518](https://www.python.org/dev/peps/pep-0518/).

[Poetry](https://python-poetry.org/docs/managing-dependencies/) is leveraged to manage the Python dependencies:
- [Adding Python Packages with Poetry](https://python-poetry.org/docs/cli/#add)
- [Removing Python Packages With Poetry](https://python-poetry.org/docs/cli/#remove)

#### i. Default Installed Python Packages
| Package                                                | Description                                         |
|--------------------------------------------------------|-----------------------------------------------------|
| [ansible](https://pypi.org/project/ansible/)           | Simple, agentless IT automation.                    |
| [ansible-lint](https://pypi.org/project/ansible-lint/) | Checks playbooks for best practices and behaviours. |
| [commitizen](https://pypi.org/project/commitizen/)     | Standardizes commit messages.                       |
| [poetry](https://pypi.org/project/poetry/)             | Python package manager.                             |
| [pre-commit](https://pypi.org/project/pre-commit/)     | A framework for managing pre-commit hooks.          |
| [molecule](https://pypi.org/project/molecule/)         | Ansible test framework.                             |

#### ii. Maintaining your 'pyproject.toml' File (only needed if you add Python packages)

The template also presents the option to render a [pre-commit](https://pre-commit.com/) hook and a CI step to lint the [pyproject.toml]({{cookiecutter.project_slug}}/pyproject.toml) file:
- This is accomplished via the golang binary [tomll](https://github.com/pelletier/go-toml).
- This is the most robust TOML formatter I'm aware of right now.
- Use of the pre-commit hooks "as-rendered" requires you have a container runtime such as [Docker](https://www.docker.com/) installed on your system.

If you prefer to install a binary on your system:
- You can download the latest binary [here](https://github.com/pelletier/go-toml/releases).
- Alternatively, your OS's package manager may support this tool.
  - For example: [Ubuntu](https://manpages.ubuntu.com/manpages/jammy/man1/tomll.1.html)
- You can also compile the tool yourself fairly easily from [source](https://github.com/pelletier/go-toml).
  - If you have go installed: `$ go install github.com/pelletier/go-toml/v2/cmd/tomll@latest`

## Working With Ansible Workbench

A fundamental pillar of Ansible Workbench is the use of [Conventional Commits](https://www.conventionalcommits.org/).

#### 1. Why Conventional Commits?
- Following this standard has numerous advantages, but among the largest is its tight integration with [Semantic Versioning](https://semver.org/).
- The CI/CD in particular, changelog generation and release automation is made possible through adherence to this format.
- Being able to read commits from different people that conform to a standard also makes [interactive rebasing](https://git-scm.com/docs/git-rebase) relatively painless.

#### 2. Making A Conventional Commit With `commitizen`
- This tool leverages [commitizen](https://commitizen-tools.github.io/commitizen/) to enforce [Conventional Commits](https://www.conventionalcommits.org/) as well as [Semantic Versioning](https://semver.org/).
- Stage any changes as your normally would: `git add tasks/new_task_file.yml`
- Launch [commitizen](https://commitizen-tools.github.io/commitizen/): `poetry run cz c`  (See the [next section](#3-optimizing-your-workflow) to shorten that command.)
- Alternatively, you might instead opt to manually make your commits: `git commit -m "feat(NEW_TASK): added my new task file"`

#### 3. Optimizing Your Workflow

It's a bit more practical to work inside the [Poetry](https://python-poetry.org/) virtual environment itself:
- Start the virtual environment: `poetry shell`
- Stage your changes: `git add new_task_file.yml`
- Make your commit: `cz c`

It's recommended to install a container runtime such as [Docker](https://www.docker.com/) or [Colima](https://github.com/abiosoft/colima) on your system:
- This allows you to leverage the templated [pre-commit Hooks](#pre-commit-git-hooks)

#### 4. Linting Your Commits
- Commits are linted both by the [pre-commit hooks](#pre-commit-git-hooks) and the [templated GitHub CI/CD]({{cookiecutter.project_slug}}/.github/workflows).
- Tags are ALSO linted.  Please see the related section on [tagging your releases](#ii-tagging-your-releases).

#### 5. Legacy Commit Problems
- If you have legacy (non-conventional) commits in your git history, you **can** still use the CI/CD.
- See the section on [configuring the 'push' workflow](#i-basic-configuration):
  - Setting `ci_commitzen_rev_range` to: "\<my first conventional commit hash\>..HEAD" will stop failing the CI on older commits
- With this workaround in place you may still have CI failures when rebasing legacy commits that you don't fix-up.
  - To ensure the CI passes, you could [trigger a manual run](https://docs.github.com/actions/managing-workflow-runs/manually-running-a-workflow) of the workflow.

## Writing Molecule Tests with Ansible Workbench
There are 3 example [Molecule scenarios](https://molecule.readthedocs.io/getting-started/#molecule-scenarios) created during templating:

| Scenario Name                                                                    | Description                                                                                               |
|----------------------------------------------------------------------------------|-----------------------------------------------------------------------------------------------------------|
| [default]({{cookiecutter.project_slug}}/molecule/default/molecule.yml)           | Intended as a configuration reference and for use in linting and caching dependencies.                    |
| [docker1]({{cookiecutter.project_slug}}/molecule/docker1/molecule.yml)           | An example using Molecule's [docker](https://github.com/ansible-community/molecule-plugins) driver.       |
| [hostmachine1]({{cookiecutter.project_slug}}/molecule/hostmachine1/molecule.yml) | An example using Molecule's [delegated](https://molecule.readthedocs.io/configuration/#delegated) driver. |

### 1. The Recommended Molecule Scenario Workflow

#### i. Try To Avoid Modifying the Default Scenario

It's recommended to avoid modifying the [default]({{cookiecutter.project_slug}}/molecule/default/molecule.yml) scenario, to make the most of the [rendered CI/CD]({{cookiecutter.project_slug}}/.github/workflows).
- [Molecule](https://molecule.readthedocs.io/) actually supports different [requirements.yml]({{cookiecutter.project_slug}}/requirements.yml) files for each scenario you create, however to optimize dependency caching the CI will try to cache the dependencies using this [default]({{cookiecutter.project_slug}}/molecule/default/molecule.yml) scenario.
- We recommend keeping one set of requirements in the [requirements.yml]({{cookiecutter.project_slug}}/requirements.yml) file to speed up CI execution.

#### ii. Build Your Own Test Scenarios with Molecule

To add tests to your role, create new scenarios with Molecule:
- `poetry run molecule init scenario my_scenario`

#### iii. Add Your New Scenarios to CI/CD

If you are using the rendered [GitHub CI/CD]({{cookiecutter.project_slug}}/.github/workflows/workflow-push.yml), you can tweak which scenarios are executed by the CI via the [workflow configuration]({{cookiecutter.project_slug}}/.github/config/workflows/workflow-push.json).  Name your workflow with reference to the regex specified in the `ci_molecule_excluded_scenarios_regex` key.

You could of course also modify the [workflow]({{cookiecutter.project_slug}}/.github/workflows/workflow-push.yml) itself for more fine-tuned control.

### 2. The Recommended Ansible Galaxy Settings

Connections to the [Ansible Galaxy](https://galaxy.ansible.com/) API can sometimes time out, unfortunately.

#### i. Cache Your Dependencies

In your Molecule Scenario file set the dependency option `force: false` as shown [here]({{cookiecutter.project_slug}}/molecule/default/molecule.yml).

In concert with this setting, it's also strongly recommended to avoid modifying the [default]({{cookiecutter.project_slug}}/molecule/default/molecule.yml) Molecule scenario:
- This will also help you get the most speed out of the default CI/CD configuration.
- All of this assumes that your role always uses the same set of dependencies.  Multiple sets of requirements for different scenarios is supported by Molecule, but will impact CI execution speed due to inefficient caching.

#### ii. Set a Generous Timeout Value

In your Molecule Scenario file set the dependency option `timeout: 120` as shown [here]({{cookiecutter.project_slug}}/molecule/default/molecule.yml).

## Pre-Commit Git Hooks
The python library [pre-commit](https://pre-commit.com/) is installed during templating with a few useful initial hooks.

### What are these hooks for?

These hooks are your quality controls, there to help you avoid senseless time-wasting mistakes.

These hooks are deeply integrated with [CICD-Tools](https://github.com/cicd-tools-org/cicd-tools) and are executed TWICE for all commits:
1. Whenever you make a commit locally to your project.
2. Whenever you push a commit to GitHub. (The CI/CD will ALSO execute the check.)

### Containerization and Pre-Commit

These hooks all rely on 3rd party software to perform different types of static analysis on your code:
- Some of this software can be managed by [pre-commit](https://pre-commit.com/) itself (Especially if it's Python based.)
- Other steps require the use of binaries that you may not be familiar with.  (See the [complete list](#default-pre-commit-hooks) in the next section.)

To simplify the process of seamlessly installing these 3rd party tools we leverage containers:
- [CICD-Tools](https://github.com/cicd-tools-org/cicd-tools) provides several vetted binaries via its own [container](https://github.com/cicd-tools-org/cicd-tools/blob/master/.cicd-tools/container/Dockerfile).
- There are additional binary tools configured to run in 3rd party containers following this same paradigm.

**For this reason we strongly recommend installing a container runtime such as [Docker](https://www.docker.com/) or [Colima](https://github.com/abiosoft/colima) on your development machine.**

If you do NOT wish to use a container runtime, please see the section on [removing pre-commit hooks](#deactivating-pre-commit-hooks).

### Default Pre-Commit Hooks
| Hook Name                   | Description                                                                                                            |
|-----------------------------|------------------------------------------------------------------------------------------------------------------------|
| check-jsonschema            | Runs [check-jsonschema](https://check-jsonschema.readthedocs.io) to confirm the CI/CD configuration files are correct. |
| commitizen                  | Runs [commitizen](https://commitizen-tools.github.io/commitizen/) on your commit message to validate it.               |
| format-shell                | Runs [shfmt](https://github.com/mvdan/sh) to format your shell scripts.                                                |
| format-toml                 | Runs [tomll](https://github.com/pelletier/go-toml) to format your TOML configuration files.                            |
| lint-ansible                | Runs [ansible-lint](https://github.com/ansible/ansible-lint) to check for Ansible best practices and behaviours.       |
| lint-github-workflow        | Optionally runs [actionlint](https://github.com/rhysd/actionlint) on all GitHub workflows.                             |
| lint-github-workflow-header | Optionally runs a shell script to lint GitHub workflow headers.                                                        |
| lint-markdown               | Runs [markdown-lint](https://github.com/davidanson/markdownlint) on your Markdown files.                               |
| lint-shell                  | Runs [shellcheck](https://www.shellcheck.net/) to lint all shell scripts.                                              |
| spelling-commit-message     | Runs [vale](https://github.com/errata-ai/vale) on your git commit messages to check for spelling errors.               |
| spelling-markdown           | Runs [vale](https://github.com/errata-ai/vale) on your Markdown files to check for spelling errors.                    |
| yamllint                    | Runs [yamllint](https://yamllint.readthedocs.io/) on all YAML files.                                                   |

#### Pre-Commit Hook Definitions
- The [CICD-Tools pre-commit hooks](https://github.com/cicd-tools-org/pre-commit) provide base configuration.
- The [cookiecutter pre-commit hooks](.pre-commit-config.yaml) overrides these hooks for development of the template itself.
- The [project pre-commit hooks]({{cookiecutter.project_slug}}/.pre-commit-config.yaml) overrides these hooks in projects you create with this template.

#### Deactivating Pre-Commit Hooks
If you wish to remove or deactivate a particular hook remove its reference from these TWO places in your project:
1. Find and remove the hook's definition in the [.pre-commit-config.yaml]({{cookiecutter.project_slug}}/.pre-commit-config.yaml) file.
2. Find and remove the hook's integration in the [CI/CD workflow definition]({{cookiecutter.project_slug}}/.github/workflows/workflow-push.yml) file.

### Configuring The Pre-Commit Hooks
| Hook Name                   | Exe Source         | Configuration File(s)                                                                                                                        |
|-----------------------------|--------------------|----------------------------------------------------------------------------------------------------------------------------------------------|
| check-jsonschema            | pre-commit         | [.pre-commit-config.yaml]({{cookiecutter.project_slug}}/.pre-commit-config.yaml)                                                             |
| commitizen                  | poetry/pre-commit  | [pyproject.toml]({{cookiecutter.project_slug}}/pyproject.toml)                                                                               |
| format-shell                | CICD-Tools         | [.pre-commit-config.yaml]({{cookiecutter.project_slug}}/.pre-commit-config.yaml)                                                             |
| format-toml                 | CICD-Tools         | None                                                                                                                                         |
| lint-ansible                | poetry             | [.ansible-lint]({{cookiecutter.project_slug}}/.ansible-lint)                                                                                 |
| lint-github-workflow        | CICD-Tools         | [actionlint.yaml]({{cookiecutter.project_slug}}/.cicd-tools/configuration/actionlint.yaml)                                                   |
| lint-github-workflow-header | shell              | [lint-github-workflow-header.sh]({{cookiecutter.project_slug}}/.cicd-tools/boxes/bootstrap/pre-commit/lint-github-workflow-header.sh)        |
| lint-markdown               | 3rd party          | [.markdownlint.yml]({{cookiecutter.project_slug}}/.markdownlint.yml)                                                                         |
| lint-shell                  | CICD-Tools         | [.pre-commit-config.yaml]({{cookiecutter.project_slug}}/.pre-commit-config.yaml)                                                             |
| spelling-commit-message     | CICD-Tools         | [.vale.ini]({{cookiecutter.project_slug}}/.vale.ini), [vocab lists]({{cookiecutter.project_slug}}/.vale/Vocab/{{cookiecutter.project_slug}}) |
| spelling-markdown           | CICD-Tools         | [.vale.ini]({{cookiecutter.project_slug}}/.vale.ini), [vocab lists]({{cookiecutter.project_slug}}/.vale/Vocab/{{cookiecutter.project_slug}}) |
| yamllint                    | pre-commit         | [.yamllint.yml]({{cookiecutter.project_slug}}/.yamllint.yml)                                                                                 |

## Using Ansible Workbench with GitHub

This project has deep integration with [CICD-Tools](https://github.com/cicd-tools-org/cicd-tools) which provides managed, reusable CI/CD components.  This allows you to focus on your project, while befitting from the extensive quality control tools this integration provides.

At this time CICD-Tools has chosen to focus exclusively on [GitHub Actions](https://github.com/features/actions) Perhaps eventually other CI platforms will be supported, but for now to get the most out of this project it's recommended to use the GitHub platform.

### 1. An Overview of the CI/CD

#### i. Push Workflow Sequence

Whenever you push to GitHub, the [Push Workflow]({{cookiecutter.project_slug}}/.github/workflows/workflow-push.yml) is triggered.

1. The configuration in [workflow-push.json]({{cookiecutter.project_slug}}/.github/config/workflows/workflow-push.json) is read by the workflow.
   - Customize this file to modify workflow parameters without having to modify the workflow itself.
2. The active Molecule Scenarios are identified
3. The repository is scanned for any checked in secrets.
4. The documentation is checked for any invalid HTML links.
5. Ansible Lint is run to validate the role.
6. The Molecule Scenarios are tested.
7. The Pre-Commit hooks themselves are tested to ensure they are still working.  (i.e. Do bad commits still fail correctly?)
8. The commit messages are linted.
9. The CI then executes the configured Pre-Commit hooks for the repository against all files, ensuring the integrity of the code base.
   - Read the [pre-commit section](#default-pre-commit-hooks) for details on which checks are included.
10. If you have pushed a tag conforming to [Semantic Versioning](https://semver.org/), the workflow creates a release for you with an automated changelog.

#### ii. Release Workflow Sequence

If you have created something you want to share with the Ansible community, there is an included automated release process which enables you to publish your role to both on [GitHub](https://docs.github.com/repositories/releasing-projects-on-github/about-releases) and [Ansible Galaxy](https://galaxy.ansible.com/):

1. The [Push Workflow](#i-push-workflow-sequence) will respond to a pushed [Semantic Versioned](https://semver.org/) tag by creating a draft GitHub release with an automatically generated changelog.
2. Edit this release on GitHub to your liking and then "publish" it.
3. If you have created the required [GitHub Secrets](#ii-github-secrets) and configured your role's [metadata]({{cookiecutter.project_slug}}/meta/main.yml) correctly, your role will now automatically be published to [Ansible Galaxy](https://galaxy.ansible.com/).

For more details please read section on [creating a release](#4-creating-a-release).

### 2. Setting Up Your Project on GitHub

#### i. Creating Your Repository on GitHub

The values you've entered into the [cookiecutter template](cookiecutter.json) determine what your repository should be named, and who it should be owned by.
- Create a repository in GitHub using the `github_handle` you specified, and the `project_slug` name that was created during templating from the project name you input.
- If you want to change the `project_name` or `github_handle` value because of this, you should run cookiecutter again.
- If you don't remember the `project_slug` value, the file [.cookiecutter/cookiecutter.json]({{cookiecutter.project_slug}}/.cookiecutter/cookiecutter.json) will be templated in your role's repository with all the values you entered during templating.

#### ii. Connecting Your New Repository

Connect your new remote repository and push:
- Checkout the `master` branch: `git checkout master`
- Add the new remote origin: `git remote add origin git@github.com:\<your_github_handle\>/\<your_project_slug\>.git`
- Push to the new remote origin: `git push -u origin master`

### 3. Configuring Your Workflow

#### i. Basic Configuration

To make working with the CI/CD easy to get started with, there is configuration that is templated with sensible defaults.  This gives you a low complexity option for modifying several common workflow settings.

The configuration files will be created in the [.github/config]({{cookiecutter.project_slug}}/.github/config) folder:
- [gaurav-nelson-github-action-markdown-link-check.json]({{cookiecutter.project_slug}}/.github/config/actions/gaurav-nelson-github-action-markdown-link-check.json) is used to customize the [documentation](https://github.com/gaurav-nelson/github-action-markdown-link-check) step of the workflow.
- [workflow-publish-to-galaxy.json]({{cookiecutter.project_slug}}/.github/config/workflows/workflow-publish-to-galaxy.json) is used to customize the publish workflow.  (This is the workflow that runs whenever a release is published from your GitHub repository)
- [workflow-push.json]({{cookiecutter.project_slug}}/.github/config/workflows/workflow-push.json) is used to customize the push workflow.  (This is the workflow that runs on each git "push" to your GitHub repository.)

There are also JSON schemas available [here]({{cookiecutter.project_slug}}/.github/config/schemas/workflows) to help you understand all settings, and ensure your configuration stays consistent.

#### ii. GitHub Secrets

You'll need to create some [secrets](https://docs.github.com/actions/security-guides/encrypted-secrets) to enable the full functionality of your CI/CD.

To make the most out of your [CI/CD]({{cookiecutter.project_slug}}/.github/workflows), create the following secrets:
- `SLACK_WEBHOOK`:  This optional secret value should contain a [Slack Webhook](https://api.slack.com/messaging/webhooks) you've configured to get status updates on how your commit is proceeding through the CI/CD.
  - The verbosity of this integration can be controlled by setting the `ci_verbose_notifications` setting in [this]({{cookiecutter.project_slug}}/.github/config/workflows/workflow-push.json) rendered configuration file.
  - See this documentation on how to create a [Slack Webhook](https://api.slack.com/messaging/webhooks) for your team.
  - If you do not wish to use CI/CD notifications, simply leave this secret unset.
- `GALAXY_API_KEY`:  This optional secret value can be created from the API key found on your [Ansible Galaxy](https://galaxy.ansible.com/) account page, and enables automated publishing to Galaxy.
  - If you do not wish to publish your role, simply leave this secret unset.

### 4. Creating a Release

If you have created something you want to share with the Ansible community, there is an included automated release process which enables you to publish your role to both on [GitHub](https://docs.github.com/repositories/releasing-projects-on-github/about-releases) and [Ansible Galaxy](https://galaxy.ansible.com/).

#### i. Prerequisites

Release generation depends in part on your use of [Conventional Commits](https://www.conventionalcommits.org/) to format each individual commit to your code base.
- Please see the section on [working with Ansible Workbench](#working-with-ansible-workbench) for more details.

#### ii. Tagging Your Releases
Tag your release with [Semantic Versioning](https://semver.org/).  (Avoid prefixing a 'v' or 'version' to your tag.)
- It's recommended to use [commitizen](https://commitizen-tools.github.io/commitizen/) to manage the process of updating versions, and ensuring tags are in the correct format.
  - To "bump" your release: `poetry run cz bump`
- If you are managing this process manually, take care to ensure the `version` field is updated inside your [pyproject.toml]({{cookiecutter.project_slug}}/pyproject.toml) file.

#### iii. Publishing Your Release to GitHub
- Push your new semantic conforming tag to GitHub, and ensure the CI passes: `git push --tags`  
- The CI will create a `draft` release for you with a changelog on GitHub.
  - The changelog is generated in accordance with [this](.cicd-tools/configuration/changelog.json) configuration file.
  - Customize this file according to it's [JSON Schema](https://github.com/conventional-changelog/conventional-changelog-config-spec/blob/master/versions/2.2.0/schema.json)
- Review it and if all is well, `edit` and then `publish` the release on GitHub.

#### iv. Publishing Your Release to Ansible Galaxy
- If you have configured a [secret](#ii-github-secrets) for Ansible Galaxy more automation will now begin **after** you've published your GitHub release.
- The [release workflow]({{cookiecutter.project_slug}}/.github/workflows/workflow-publish-to-galaxy.yml) will be triggered, and will publish your release automatically to [Ansible Galaxy](https://galaxy.ansible.com/).

## License

[MPL-2](LICENSE)
