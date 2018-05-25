# Ansible :: Ubuntu base system

[![Travis CI](https://img.shields.io/travis/fabschurt/ansible-role-ubuntu-base/master.svg)](https://travis-ci.org/fabschurt/ansible-role-ubuntu-base)

This is a very simple Ansible role that can be used to set up a bare Ubuntu
system.

This role is targeted at **Ubuntu LTS 18.04**, but I guess it should work with
any recent Ubuntu flavor.

Here’s a (non-exhaustive) list of the changes that it will implement:

* `src` repos will be disabled in APT sources
* package cache will be updated and all packages upgraded
* some very vital packages will be installed
* some locales will be activated/generated
* Postfix will be installed and configured as a *send-only* relay (no incoming
  mail)

## Requirements

* Ubuntu 18.04 remote host(s) with root access
* Ansible >= 2.4

## Role variables

This role is configurable with the following variables:

* `installed_packages`: a collection of packages that must be installed on the
  system
* `installed_locales`: a collection of locales that must be installed on the
  system
* `postmaster_redirect_address`: an e-mail address where *postmaster*/*root*
  e-mails will be redirected to

See the [Example playbook](#example-playbook) section below for a reference of
these variables’ default values.

The `vars/default.yml` file declare some packages and locales to be installed
by default:

```yaml
static:
  installed_packages:
    - openssh-server
    - ntp
    - mailutils
    - bash
    - bash-completion
    - vim
  installed_locales:
    - en_US.UTF-8
    - en_IE.UTF-8
    - fr_FR.UTF-8
```

## Example playbook

This is an example playbook that demonstrates how you would use the role,
provided that you’ve [installed](https://galaxy.ansible.com/intro#download) it
already. The variable values used here reflect the default values declared in
`defaults/main.yml`:

```yaml
- hosts: …
  roles:
    - role: fabschurt.ubuntu-base
      installed_packages: [] # Will be merged with `static.installed_packages`
      installed_locales: [] # Will be merged with `static.installed_locales`
      postmaster_redirect_address: root@localhost # You should really override this one
```

## License

This software package is licensed under the [MIT License](https://opensource.org/licenses/MIT).
