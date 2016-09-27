# System-wide .bashrc file for interactive bash(1) shells.

# To enable the settings / commands in this file for login shells as well,
# this file has to be sourced in /etc/profile.

# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# Don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# For setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=200
HISTFILESIZE=0

# Disable less history
export LESSHISTFILE=/dev/null

# Check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS
shopt -s checkwinsize

# Set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
  debian_chroot=$(cat /etc/debian_chroot)
fi

# Make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# Set up a nice PS1 prompt
user_color=2
if [[ $(id -u) == 0 ]]; then
  user_color=1
fi
export PS1="\[$(tput setaf ${user_color})\]\[$(tput bold)\]\u\[$(tput sgr0)\]@\H:\[$(tput setaf 4)\]\[$(tput bold)\]\w\[$(tput sgr0)\]\\$ "

# Some useful aliases
alias la='ls -lahpX --group-directories-first --color=auto'
alias rm='rm -I --one-file-system --preserve-root'
alias grep='grep --color=auto'
alias grepr='grep -RHIn'

# Set default secure umask (not mandatory since pam_umask normally takes care of
# this, but you never know)
umask 077
