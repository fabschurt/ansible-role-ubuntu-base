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

# Check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS
shopt -s checkwinsize

# Make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# Set up a nice PS1 prompt
user_color=2
if [[ $(id -u) == 0 ]]; then
  user_color=1
fi
export PS1="\[$(tput setaf ${user_color})\]\[$(tput bold)\]\u\[$(tput sgr0)\]@\H:\[$(tput setaf 4)\]\[$(tput bold)\]\w\[$(tput sgr0)\]> "

# Some useful aliases
alias sudo='sudo '
alias supersaiyan='sudo -i -u root'
alias la='ls -lahpX --group-directories-first --color=auto'
alias rm='rm -I --one-file-system --preserve-root'
alias grepr='grep -RHIin'

# Sensible defaults for some core utilities
export LESS='--chop-long-lines --hilite-search --jump-target=.5 --ignore-case --RAW-CONTROL-CHARS --tabs=2'
export GREP_OPTIONS='--color=auto'

# Set default secure umask
umask 077
