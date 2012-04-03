EDITOR=vim

[[ ! -e $HOME/.vim/tmp ]] && mkdir $HOME/.vim/tmp

[[ ! -e $HOME/.vim/backup ]] && mkdir $HOME/.vim/backup

#need to add to profile
if [ -z "$PROFILE_RAN" ]; then
	PATH="/usr/local/bin:/usr/bin:/bin:$PATH"
fi

export BASH_RC_RAN="YES"

#if [ -z $BASH_PROFILE_RAN ]; then
#	if [ -e $HOME/.bash_profile ]; then
#		#source $HOME/.bash_profile
#	fi
#fi


PS1='\[\e]0;\w\a\]\n\[\e[32m\]\u@\h \[\e[33m\]\w\[\e[0m\]\n\$'

#local computer enviroment variables in this file
[[ -e ~/.local_vars ]] && source ~/.local_vars ;

# Don't wait for job termination notification
# set -o notify

# Don't use ^D to exit
set -o ignoreeof

# Use case-insensitive filename globbing
shopt -s nocaseglob

# Make bash append rather than overwrite the history on disk
shopt -s histappend

# When changing directory small typos can be ignored by bash
# for example, cd /vr/lgo/apaache would find /var/log/apache
shopt -s cdspell

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"


# If this shell is interactive, turn on programmable completion enhancements.
# Any completions you add in ~/.bash_completion are sourced last.
case $- in
	*i*) [[ -e /etc/bash_completion ]] && . /etc/bash_completion ;;
esac


# History Options
# ###############
# don't put duplicate lines in the history. See bash(1) for more options
# ... or force ignoredups and ignorespace
# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# don't put duplicate lines in the history. See bash(1) for more options
# ... or force ignoredups and ignorespace
export HISTCONTROL=$HISTCONTROL${HISTCONTROL+,}ignoredups
export HISTCONTROL=$HISTCONTROL${HISTCONTROL+,}ignorespace
# Ignore some controlling instructions
export HISTIGNORE="[   ]*:&:bg:fg:exit"
# Ignore some controlling instructions
export HISTCONTROL=$HISTCONTROL${HISTCONTROL+,}erasedups 
# Whenever displaying the prompt, write the previous line to disk


# Aliases
# #######
# Alias definitions.

if [ -f ~/.bash_aliases ]; then
	. ~/.bash_aliases
fi
eval $( dircolors -b )
LS_COLORS="$LS_COLORS:di=01;37"

# application.  To override the alias instruction use a \ before, ie
# \rm will call the real rm not the alias.
# enable color support of ls and also add handy aliases



# add an "alert" alias for long running commands.  use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if [ -f /etc/bash_completion ] && ! shopt -oq posix; then
	. /etc/bash_completion
fi


if [ -z "$HOST" ] ; then
	export HOST=${HOSTNAME}
fi



[[ -e ~/.git-completion.bash ]] && source ~/.git-completion.bash

if [ -e /usr/share/terminfo/x/xterm-256color ]; then
	export TERM='xterm-256color'
else
	export TERM='xterm-color'
fi

# Functions

# Some example functions
function settitle() { echo -ne "\e]2;$@\a\e]1;$@\a"; }
function extract()      # Handy Extract Program.
{
	if [ -f $1 ] ; then
		case $1 in
			*.tar.bz2)   tar xvjf $1     ;;
	*.tar.gz)    tar xvzf $1     ;;
	*.bz2)       bunzip2 $1      ;;
	*.rar)       unrar x $1      ;;
	*.gz)        gunzip $1       ;;
	*.tar)       tar xvf $1      ;;
	*.tbz2)      tar xvjf $1     ;;
	*.tgz)       tar xvzf $1     ;;
	*.zip)       unzip $1        ;;
	*.Z)         uncompress $1   ;;
	*.7z)        7z x $1         ;;
	*)           echo "'$1' cannot be extracted via >extract<" ;;
	esac
	else
		echo "'$1' is not a valid file"
			fi
}


#google chrome alias
alias chrome='google-chrome &1>3 /dev/null'
alias ecp='eclipse &1>3 /dev/null'

# If not running interactively, don't do anything
[ -z "$PS1" ] && return


psgrep()
{
	ps -aux | grep $1 | grep -v grep
}

#
# This is a little like `zap' from Kernighan and Pike
#

pskill()
{
	local pid

	pid=$(ps ax | grep $1 | grep -v grep | awk '{ print $1 }')
	echo -n "killing $1 (process $pid)..."
	kill -9 $pid
	echo "slaughtered."
}

term()
{
	TERM=$1
	export TERM
	tset
}

xtitle () 
{ 
	echo -n -e "\033]0;$*\007"
}

bold()
{
	tput smso
}

function unbold()
{
	tput rmso
}

if [ -f /unix ] ; then
	function clear()
	{
		tput clear
	}
fi

function chmog()
{
	if [ $# -ne 4 ] ; then
		echo "usage: chmog mode owner group file"
		return 1
	else
		chmod $1 $4
		chown $2 $4
		chgrp $3 $4
	fi
}

