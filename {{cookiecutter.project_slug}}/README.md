# {{cookiecutter.project_slug}}

### {{ cookiecutter._BRANCH_NAME_BASE | capitalize }} Branch CI
- GitHub Actions: [![{{cookiecutter.project_slug}}](https://github.com/{{cookiecutter.github_handle}}/{{cookiecutter.project_slug}}/actions/workflows/workflow-push.yml/badge.svg?branch={{ cookiecutter._BRANCH_NAME_BASE }})](https://github.com/{{cookiecutter.github_handle}}/{{cookiecutter.project_slug}}/actions/workflows/workflow-push.yml)

### {{ cookiecutter._BRANCH_NAME_DEVELOPMENT | capitalize }} Branch CI
- GitHub Actions: [![{{cookiecutter.project_slug}}](https://github.com/{{cookiecutter.github_handle}}/{{cookiecutter.project_slug}}/actions/workflows/workflow-push.yml/badge.svg?branch={{ cookiecutter._BRANCH_NAME_DEVELOPMENT }})](https://github.com/{{cookiecutter.github_handle}}/{{cookiecutter.project_slug}}/actions/workflows/workflow-push.yml)

{{ cookiecutter.description }}

Requirements
------------

None

Role Variables
--------------

None

Dependencies
------------

None

Example Playbook
----------------

Including an example of how to use your role (for instance, with variables passed in as parameters) is always nice for users too:

    - hosts: all
      roles:
         - { role: {{ cookiecutter.galaxy_namespace_slug }}.{{ cookiecutter.galaxy_role_slug }} }

License
-------

MPL-2

Author Information
------------------

{{ cookiecutter.author }} <{{ cookiecutter.email }}>
