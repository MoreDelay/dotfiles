# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
# ignoreboth: ignorespace and ignoredups
# ignorespace: lines beginning with space are not saved to history
# ignoredups: a command that is the same as the previous command is not
# saved a second time
# erasedups: if the same command is already present in history, delete it
# and save only the most recent one
HISTCONTROL=ignoreboth:erasedups

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=10000
HISTFILESIZE=20000

# save history immediately and load too to share with all sessions
PROMPT_COMMAND="history -a;history -c;history -r;$PROMPT_COMMAND"

last_semicolon=$(echo "${PROMPT_COMMAND}" | awk '{print substr($0,length,1)}')

if [[ "$last_semicolon" != ";" ]]
then
    PROMPT_COMMAND="${PROMPT_COMMAND};__prompt_command"
else
    PROMPT_COMMAND="${PROMPT_COMMAND}__prompt_command"
fi

__prompt_command() {
    local EXIT="$?"  # This needs to be first
    PS1=""

    local CReset='\[\e[0m\]'

    local CBlack='\[\e[0;30m\]'
    local CRed='\[\e[0;31m\]'
    local CGreen='\[\e[0;32m\]'
    local CYellow='\[\e[1;33m\]'
    local CBlue='\[\e[1;34m\]'
    local CMagenta='\[\e[0;35m\]'
    local CCyan='\[\e[0;36m\]'

    # user name and host
    PS1+="${CCyan}\u@\h${CReset}:"

    # directory
    PS1+="${CBlue}\w${CReset}"

    # prompt symbol
    # show return code if it is not 0
    if [[ $EXIT != 0 ]]; then
        # PS1+=" ${CRed}$EXIT$ ${CReset}"
        PS1+="${CRed}$ ${CReset}"
    else
        PS1+="$ "
    fi

}
