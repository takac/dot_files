
export PROFILE_RAN="YES"

if [ -e /usr/share/terminfo/x/xterm-256color ]; then
	export TERM='xterm-256color'
else
	export TERM='xterm-color'
fi


export LANG=$(locale -uU)


# This file is not read by bash(1) if ~/.bash_profile or ~/.bash_login
# exists.
#
# if running bash
if [ -n "${BASH_VERSION}" ]; then
    if [ -f "${HOME}/.bashrc" ]; then
        source "${HOME}/.bashrc"
    fi
fi

if [ -e /usr/share/terminfo/x/xterm-256color ]; then
    export TERM='xterm-256color'
else
    export TERM='xterm-color'
fi
export LANGUAGE="en_GB:en"
export LC_MESSAGES="en_GB.UTF-8"
export LC_CTYPE="en_GB.UTF-8"
export LC_COLLATE="en_GB.UTF-8"
