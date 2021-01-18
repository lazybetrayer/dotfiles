# vim: ft=sh et

# ~/.profile: executed by the command interpreter for login shells.
# This file is not read by bash(1), if ~/.bash_profile or ~/.bash_login
# exists.
# see /usr/share/doc/bash/examples/startup-files for examples.
# the files are located in the bash-doc package.

# the default umask is set in /etc/profile; for setting the umask
# for ssh logins, install and configure the libpam-umask package.
#umask 022

[ -f $HOME/.profile.local ] && source $HOME/.profile.local

export GOPATH=$HOME/gopath
export CDPATH=.:$GOPATH/src:$GOPATH/pkg/mod
export PATH=$PATH:$HOME/sources/go/bin:$GOPATH/bin

[ -f "$HOME/.bashrc" ] && . "$HOME/.bashrc"

true
