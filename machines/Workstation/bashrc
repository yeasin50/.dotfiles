#!/bin/bash

# Desktop
# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color|*-256color) color_prompt=yes;;
esac



# Function: Trim path to max 16 chars (shows last 2 segments if long)
get_trimmed_path() {
    local p="${PWD/#$HOME/~}"
    if [ ${#p} -gt 16 ]; then
        # Grab last 2 directory segments (e.g., ...share/chezmoi)
        echo "...$(echo "$p" | rev | cut -d'/' -f1,2 | rev)" | cut -c1-16
    else
        echo "$p"
    fi
}

# Function: Get Git Branch and Status
get_git_info() {
    if git rev-parse --is-inside-work-tree >/dev/null 2>&1; then
        local branch=$(git branch --show-current)
        local status=$(git status --porcelain | wc -l)
        local icon="✔"
        # If there are changes, show count and ✗
        [ "$status" -ne 0 ] && icon="✗:$status"
        echo " [ $branch $icon ]"
    fi
}

# The Main Prompt Function
prompt_command() {
    local EXIT="$?"
    local SYMBOL="❯"
    
    # Color coding
    local G="\[\e[1;32m\]" # Green (User@Host)
    local B="\[\e[1;34m\]" # Blue (Path)
    local Y="\[\e[1;33m\]" # Yellow (Git)
    local P="\[\e[1;35m\]" # Purple (Arrow)
    local R="\[\e[1;31m\]" # Red (Error)
    local W="\[\e[0m\]"    # White/Reset

    # Turn arrow red if last command failed
    [ $EXIT != 0 ] && SYMBOL="$R$SYMBOL" || SYMBOL="$P$SYMBOL"

    # Line 1: user@host:path [git branch status]
    # Line 2: The Input Arrow
    PS1="\n$G\u@\h$W:$B\$(get_trimmed_path)$Y\$(get_git_info)$W\n$SYMBOL $W"
}

# Set the prompt
PROMPT_COMMAND=prompt_command


# Alias definitions.
if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# for tmuxinator
export EDITOR=nvim

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi


if [ -f ~/.bash_secrets ]; then
  source ~/.bash_secrets
fi

if [ -f ~/.bashrc_env ]; then
  source ~/.bashrc_env
fi

if [ -f ~/.bash_theme ]; then
  source ~/.bash_theme
fi

# If not running interactively, don't do anything
case $- in
	*i*) ;;
	*) return ;;
esac

# just like to use vim keybindings
# set -o vi

export PATH=$PATH:/usr/local/bin
export PATH="$HOME/apps/blender-4.5.2-linux-x64:$PATH"

# Zoxide (Smart cd)
if command -v zoxide >/dev/null 2>&1; then
    eval "$(zoxide init bash)"
    alias cd='z'
fi
