# {{cookiecutter.project_slug}}

### Master:
- Travis CI: ![TravisCI](https://travis-ci.com/{{cookiecutter.github_handle}}/{{cookiecutter.project_slug}}.svg?branch=master)
- Github Actions: [![{{cookiecutter.project_slug}}](https://github.com/{{cookiecutter.github_handle}}/{{cookiecutter.project_slug}}/actions/workflows/push.yml/badge.svg?branch=master)](https://github.com/{{cookiecutter.github_handle}}/{{cookiecutter.project_slug}}/actions/workflows/push.yml)

### Production:
- Travis CI: ![TravisCI](https://travis-ci.com/{{cookiecutter.github_handle}}/{{cookiecutter.project_slug}}.svg?branch=production)
- Github Actions: [![{{cookiecutter.project_slug}}](https://github.com/{{cookiecutter.github_handle}}/{{cookiecutter.project_slug}}/actions/workflows/push.yml/badge.svg?branch=production)](https://github.com/{{cookiecutter.github_handle}}/{{cookiecutter.project_slug}}/actions/workflows/push.yml)

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
         - { role: {{ cookiecutter.github_handle }}.{{ cookiecutter.project_slug }} }

License
-------

MPL-2

Author Information
------------------

{{ cookiecutter.author }} <{{ cookiecutter.email }}>
