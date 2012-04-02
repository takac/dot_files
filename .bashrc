EDITOR=vim

#need to add to profile
if [ -z "$PROFILE_RAN" ]; then
	PATH="/usr/local/bin:/usr/bin:/bin:$PATH"
fi

export BASH_RC_RAN="YES"

if [ -z $BASH_PROFILE_RAN ]; then
	if [ -e ~/.bash_profile ]; then
		source ~/.bash_profile
	fi
fi


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
export PROMPT_COMMAND="history -a"


# Aliases
# #######
# Alias definitions.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi


# application.  To override the alias instruction use a \ before, ie
# \rm will call the real rm not the alias.
# enable color support of ls and also add handy aliases
alias ls="ls --color"
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'

alias ss="ps -aux"
alias dot='ls .[a-zA-Z0-9_]*'
alias news="xterm -g 80x45 -e trn -e -S1 -N &"

alias c="clear"
alias m="more"
alias j="jobs"

# common misspellings
alias mroe=more
alias pdw=pwd


# Default to human readable figures
alias df='df -h'
alias du='du -h'

# Misc :)
alias less='less -r'                          # raw control characters
alias whence='type -a'                        # where, of a sort
alias grep='grep --color'                     # show differences in colour

# Some shortcuts for different directory listings
alias ls='ls -hF --color=tty'                 # classify files in colour
alias ll='ls -l'                              # long list
alias la='ls -A'                              # all but . and ..
alias l='ls -CF'                              #

alias hs='history | grep $1'



# Add an "alert" alias for long running commands.  Use like so:
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

unbold()
{
	tput rmso
}

if [ -f /unix ] ; then
clear()
{
	tput clear
}
fi

rot13()
{
	if [ $# = 0 ] ; then
		tr "[a-m][n-z][A-M][N-Z]" "[n-z][a-m][N-Z][A-M]"
>>>>>>> laptop
	else
		echo "'$1' is not a valid file"
			fi
}
<<<<<<< HEAD
=======

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

