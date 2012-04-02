export BASH_PROF_SET="YES"
if [ -e /usr/share/terminfo/x/xterm-256color ]; then
	export TERM='xterm-256color'
else
	export TERM='xterm-color'
fi


# if running bash
#if [ -n "$BASH_VERSION" ]; then
if [ -z $BASH_RC_SET ]; then
	# include .bashrc if it exists
	if [ -e ~/.bashrc ]; then
		source ~/.bashrc
	fi
fi
