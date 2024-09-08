# set PATH so it includes user's private bin if it exists
case ":$PATH:" in
	*:"$HOME/bin":*)
		;;
	*)
		echo add "$HOME/bin" to "$PATH"
		PATH="$HOME/bin:$PATH"
		;;
esac

# set PATH so it includes user's private bin if it exists
case ":$PATH:" in
	*:"$HOME/.local/bin":*)
		;;
	*)
		echo add "$HOME/.local/bin" to "$PATH"
		PATH="$HOME/.local/bin:$PATH"
		;;
esac

# set PATH so it includes user's private cargo bin if it exists
case ":$PATH:" in
	*:"$HOME/.cargo/bin":*)
		;;
	*)
		echo add "$HOME/.cargo/bin" to "$PATH"
		PATH="$HOME/.cargo/bin:$PATH"
		;;
esac

export PATH

# environment variables
export MPD_HOST=$HOME/.mpd/socket
# LIBVA_DRIVER_NAME=vdpau
export GTK_USE_PORTAL=1
export EDITOR=nvim

# make ls command print out time in iso format
export TIME_STYLE=long-iso

# fcitx5 input method
export XMODIFIERS=@im=fcitx
unset GTK_IM_MODULE
unset QT_IM_MODULE
