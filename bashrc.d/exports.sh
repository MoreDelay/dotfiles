# set PATH so it includes user's private bin if it exists
case ":$PATH:" in
	*:"$HOME/bin":*)
		;;
	*)
		PATH="$HOME/bin:$PATH"
		;;
esac

# set PATH so it includes user's private bin if it exists
case ":$PATH:" in
	*:"$HOME/.local/bin":*)
		;;
	*)
		PATH="$HOME/.local/bin:$PATH"
		;;
esac

# make sure cargo installed binaries are accessible
if [ -e $HOME/.cargo/env ]; then
	source $HOME/.cargo/env
fi


export PATH

# environment variables
export MPD_HOST=$HOME/.local/state/mpd/socket
# LIBVA_DRIVER_NAME=vdpau
export GTK_USE_PORTAL=1
export EDITOR=nvim

# make ls command print out time in iso format
export TIME_STYLE=long-iso

# fcitx5 input method
export XMODIFIERS=@im=fcitx
unset GTK_IM_MODULE
unset QT_IM_MODULE

eval "$(fzf --bash)"
# make fzf use fd
export FZF_DEFAULT_COMMAND="fd --type file --follow"

