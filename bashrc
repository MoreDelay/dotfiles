# .bashrc

# Source global definitions

if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

# Load all settings from the directory
if [ -d ~/.bashrc.d ]; then
	for rc in ~/.bashrc.d/*; do
		if [ -f "$rc" ]; then
			# shellcheck source=/dev/null
			. "$rc"
		fi
	done
fi
unset rc

