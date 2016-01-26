# Ubuntu Base System (14.04)

[![Travis CI](https://img.shields.io/travis/rust-lang/rust.svg)](https://travis-ci.org/fabschurt/ansible-role-ubuntu-base)

This is a simple & easy Ansible role that can be used to set up a bare Ubuntu
base system. It's really a bootstrap role, so it's better if it's executed as
early as possible in your configuration/provisioning workflow.

Basically, this role will (in order):

* install, remove and upgrade packages (`packages` tag)
* upload some custom config files (`config` tag)
* do some cleanup (`cleaning` tag)

You can use the `--tags` option of `ansible-playbook` to apply the role partially,
using the tag names provided above.

It's recommended that you reboot the targeted server(s) after applying this role.

Some non-exhaustive notes about the changes that will be made:

* backports will be disabled in APT
* an epic login `motd` will be installed
* by default, command history won't be dumped to `.bash_history`, which will
  always be empty
* a default `umask` value of `077` will be set in (hopefully) all shell modes
* Postfix will be configured as *send-only*

This role is continuously integrated on [Travis](https://travis-ci.org/fabschurt/ansible-role-ubuntu-base).
For now, it's simply syntax-checked against multiple Ansible versions, to check
for basic compatibility.

It's been tested against **Ubuntu 14.04**, but should work on earlier and later
versions, as there's nothing really 14.04-specific in there.

## Requirements

* Ubuntu remote host(s) with root access
* Ansible >= 2.0

## Role variables

This role is configurable with the following variables:

* `needed_packages`: a collection of packages that have to be present on the system
* `unneeded_packages`: a collection of packages that have to be absent from the system
* `needed_locales`: a collection of locales that have to be present on the system
* `unneeded_paths`: a collection of directory/file paths that have to be absent
  from the system (careful with that)
* `postmaster_redirect_address`: an e-mail address where postmaster/root e-mails
  will be redirected to

See the **Example playbook** section below for a reference of these variables'
default values.

## Example playbook

This is an example playbook that demonstrates how you would use the role, provided
that you've [installed](https://galaxy.ansible.com/intro#download) it already.
The variable values used here reflect the default values declared in `defaults/main.yml`:

```yaml
- hosts: servers
  roles:
    - role: ansible-role-ubuntu-base
      needed_packages:
        - openssh-server
        - ntp
        - postfix
      unneeded_packages:
        - bind9-host
      needed_locales:
        - en_US.UTF-8
        - fr_FR.UTF-8
      unneeded_paths:
        - /etc/update-motd.d/10-help-text
        - /etc/update-motd.d/50-landscape-sysinfo
        - /etc/update-motd.d/90-updates-available
        - /etc/update-motd.d/91-release-upgrade
      postmaster_redirect_address: dev@null.net # You should really override this one
```

## License

This package is licensed under the [MIT license](https://opensource.org/licenses/MIT).
