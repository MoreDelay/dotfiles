alias ll='ls -alF'
alias la='ls -A'
alias l='ls -F'
alias fd='/usr/bin/fd -L'
alias fdh='/usr/bin/fd -H'

alias diff=colordiff
alias vim=nvim

# if they exist, use new tools for everyday use
exists() {
    command -v "$1" >/dev/null 2>&1
}

if exists "eza"; then
    alias ls='eza -H'
fi

if exists "bat"; then
    alias cat='bat'
fi

# package is called du-dust
if exists "dust"; then
    alias du='dust'
fi
