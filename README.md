# Ubuntu Base System (14.04)

[![Travis CI](https://img.shields.io/travis/rust-lang/rust.svg)](https://travis-ci.org/fabschurt/ansible-role-ubuntu-base)

This is a simple 'n' easy Ansible role that can be used to set up a bare Ubuntu
base system. It's really a bootstrap role, so it's better if it's executed as
early as possible in your configuration/provisioning workflow.

Full compatibility has been tested on **Ubuntu 14.04**, but I guess it should
work fine with later and (not too old) earlier versions too.

Basically, this role will (in order):

* install, remove and upgrade some packages (`packages` tag)
* upload some custom config files (`config` tag)
* upload default skeleton files and copy them in root's home (`skel` tag)

You can use the `--tags` option of `ansible-playbook` to apply the role partially,
using the tag names provided above. You can also use `--skip-tags=slow` to skip
slow actions, like the APT package upgrade.

It's recommended that you reboot the targeted server(s) after applying this role.

Some non-exhaustive notes about the changes that will be made:

* backports will be disabled in APT
* by default, user command history won't be dumped to `.bash_history`, which
  will always be empty
* a default `umask` value of `077` will be set for (hopefully) all the existing
  shell modes
* Postfix will be configured as *send-only*

## Requirements

* Ubuntu remote host(s) with root access
* Ansible >= 2.0

## Role variables

This role is configurable with the following variables:

* `ubuntu_base_needed_packages`: a collection of packages that have to be
  present on the system
* `ubuntu_base_unneeded_packages`: a collection of packages that have to be
  absent from the system
* `ubuntu_base_needed_locales`: a collection of locales that have to be present
  on the system
* `ubuntu_base_postmaster_redirect_address`: an e-mail address where postmaster/root
  e-mails will be redirected to
* `ubuntu_base_ntp_listening_interface`: the name of the network interface
  that `ntpd` will listen to for external communication

See the **Example playbook** section below for a reference of these variables'
default values.

## Example playbook

This is an example playbook that demonstrates how you would use the role, provided
that you've [installed](https://galaxy.ansible.com/intro#download) it already.
The variable values used here reflect the default values declared in `defaults/main.yml`:

```yaml
- hosts: servers
  roles:
    - role: fabschurt.ubuntu-base
      ubuntu_base_needed_packages:
        - openssh-server
        - ntp
        - postfix
        - colordiff
      ubuntu_base_unneeded_packages:
        - bind9-host
        - ufw
      ubuntu_base_needed_locales:
        - en_US.UTF-8
        - fr_FR.UTF-8
      ubuntu_base_postmaster_redirect_address: dev@null.net # You should really override this one
      ubuntu_base_ntp_listening_interface: eth0
```

## License

This package is licensed under the [MIT license](https://opensource.org/licenses/MIT).
