# Ansible – Ubuntu base system

[![Travis CI](https://img.shields.io/travis/fabschurt/ansible-role-ubuntu-base.svg)](https://travis-ci.org/fabschurt/ansible-role-ubuntu-base)

This is a simple ’n’ easy Ansible role that can be used to set up a bare Ubuntu
base system. It’s really a bootstrap role, so it’s better if it’s executed as
early as possible in your configuration/provisioning workflow.

This role is targeted at **Ubuntu 16.04**, but I guess it should work on any
recent Ubuntu flavor.

Here’s a (non-exhaustive) list of the changes that will be made&nbsp;:

* backports will be disabled in APT
* by default, user command history won’t be dumped to `.bash_history`, which
  will always be empty
* a default `umask` value of `077` will be set for (hopefully) all the existing
  shell modes
* Postfix will be configured as *send-only*

## Requirements

* Ubuntu remote host(s) with root access
* Ansible >= 2.1

## Role variables

This role is configurable with the following variables&nbsp;:

* `fabschurt.ubuntu.base.deb_repo_domain`: the domain name of the main repository used by
  APT
* `fabschurt.ubuntu.base.installed_packages`: a collection of packages that have
  to be present on the system, in addition to those declared by the role
* `fabschurt.ubuntu.base.removed_packages`: a collection of packages that have
  to be absent from the system, in addition to those declared by the role
* `fabschurt.ubuntu.base.installed_locales`: a collection of locales that have to
  be present on the system, in addition to those declared by the role
* `fabschurt.ubuntu.base.postmaster_redirect_address`: an e-mail address where postmaster/root
  e-mails will be redirected to

See the **Example playbook** section below for a reference of these variables’
default values.

The following variables are declared within the role and describe what base
packages/locales are needed/unneeded&nbsp;:

```yaml
fabschurt.ubuntu.base.needed_packages: # Will be merged with `fabschurt.ubuntu.base.installed_packages`
  - openssh-server
  - ntp
  - postfix
  - mailutils
  - git
  - vim
  - bash-completion
  - screen
  - colordiff
fabschurt.ubuntu.base.unneeded_packages: # Will be merged with `fabschurt.ubuntu.base.removed_packages`
  - bind9-host
  - ufw
fabschurt.ubuntu.base.needed_locales: # Will be merged with `fabschurt.ubuntu.base.installed_locales`
  - en_US.UTF-8
  - fr_FR.UTF-8
```

## Example playbook

This is an example playbook that demonstrates how you would use the role, provided
that you’ve [installed](https://galaxy.ansible.com/intro#download) it already.
The variable values used here reflect the default values declared in `defaults/main.yml`&nbsp;:

```yaml
- hosts: servers
  roles:
    - role: fabschurt.ubuntu-base
      fabschurt.ubuntu.base.deb_repo_domain: fr.archive.ubuntu.com
      fabschurt.ubuntu.base.needed_packages: []
      fabschurt.ubuntu.base.unneeded_packages: []
      fabschurt.ubuntu.base.needed_locales: []
      fabschurt.ubuntu.base.postmaster_redirect_address: dev@null.net # You should really override this one
```

## License

This software package is licensed under the [MIT License](https://opensource.org/licenses/MIT).
