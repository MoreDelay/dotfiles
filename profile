# ~/.profile: executed by the command interpreter for login shells.
# This file is not read by bash(1), if ~/.bash_profile or ~/.bash_login
# exists.
# see /usr/share/doc/bash/examples/startup-files for examples.
# the files are located in the bash-doc package.

# the default umask is set in /etc/profile; for setting the umask
# for ssh logins, install and configure the libpam-umask package.
#umask 022

# make sure bashrc is loaded for all interactive sessions
# otherwise just load the exports
if [ -n "$BASH_VERSION" ] && [ -n "$PS1" ]; then
	if [ -f "$HOME/.bashrc" ]; then
		. "$HOME/.bashrc"
	fi
elif [ -e "$HOME/.bashrc.d/exports.sh" ]; then
	. "$HOME/.bashrc.d/exports.sh"
fi
