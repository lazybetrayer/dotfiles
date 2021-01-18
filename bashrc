# vim: ft=sh et

# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

shopt -s nocaseglob

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
#HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000
HISTTIMEFORMAT='%F %T%t'

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

shopt -s autocd

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

exist() {
    type "$1" > /dev/null 2>&1
}

if [[ $TERM =~ xterm* ]]; then
    export TERM='xterm-256color'
fi

[ "$(tput colors 2>/dev/null)" = "256" ] && is256color=yes || is256color=no

. ~/.bash_prompt

if [[ $OSTYPE =~ darwin* ]]; then
    if [ -f /opt/homebrew/etc/bash_completion ]; then
        . /opt/homebrew/etc/bash_completion
    elif [ -f /usr/local/etc/bash_completion ]; then
        . /usr/local/etc/bash_completion
    fi
else
    if ! shopt -oq posix; then
        if [ -f /usr/share/bash-completion/bash_completion ]; then
            . /usr/share/bash-completion/bash_completion
        elif [ -f /etc/bash_completion ]; then
            . /etc/bash_completion
        fi
    fi
fi

# enable color support of ls and also add handy aliases
#if [ -x /usr/bin/dircolors ]; then
if exist dircolors; then
    if [ x$is256color = xyes ]; then
        test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    fi
    alias ls='ls --color=auto'
    alias dir='dir --color=auto'
    alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8
export EDITOR=vim

if [[ $OSTYPE =~ linux ]]; then
    export GTK_IM_MODULE=ibus
    export XMODIFIERS="@im=ibus"
    export QT_IM_MODULE=ibus
fi

ulimit -c unlimited

#if exist screen; then
#    a=$(screen -ls 2>/dev/null)
#    if ! echo "$a" | grep -q '^No Sockets found in'; then
#        echo ">>> screen sessions:"
#        echo "$a"
#    fi
#    unset a
#fi

if exist tmux; then
    source ~/.bash_completion_tmux.sh
    a=$(tmux ls 2>/dev/null)
    if [ -n "$a" ]; then
        echo ">>> tmux sessions:"
        echo "$a"
    fi
    unset a
fi

[ -f "$HOME/.bashrc.local" ] && . "$HOME/.bashrc.local"
