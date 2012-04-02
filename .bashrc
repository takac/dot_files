EDITOR=vim

#need to add to profile
if [ -z "$RANPROFILE" ]; then
	PATH="/usr/local/bin:/usr/bin:/bin:$PATH"
fi


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

# If this shell is interactive, turn on programmable completion enhancements.
# Any completions you add in ~/.bash_completion are sourced last.
case $- in
   *i*) [[ -e /etc/bash_completion ]] && . /etc/bash_completion ;;
esac


# History Options
# ###############

# Don't put duplicate lines in the history.
#export HISTCONTROL="ignoredups"

export HISTCONTROL=$HISTCONTROL${HISTCONTROL+,}ignoredups
# Ignore some controlling instructions
export HISTIGNORE="[   ]*:&:bg:fg:exit"
# Ignore some controlling instructions
export HISTCONTROL=$HISTCONTROL${HISTCONTROL+,}erasedups 
# Whenever displaying the prompt, write the previous line to disk
export PROMPT_COMMAND="history -a"


# Aliases
# #######

# application.  To override the alias instruction use a \ before, ie
# \rm will call the real rm not the alias.

# Default to human readable figures
alias df='df -h'
alias du='du -h'

# Misc :)
alias less='less -r'                          # raw control characters
alias whence='type -a'                        # where, of a sort
alias grep='grep --color'                     # show differences in colour

# Some shortcuts for different directory listings
alias ls='ls -hF --color=tty'                 # classify files in colour
alias dir='ls --color=auto --format=vertical'
alias vdir='ls --color=auto --format=long'
alias ll='ls -l'                              # long list
alias la='ls -A'                              # all but . and ..
alias l='ls -CF'                              #

alias hs='history | grep $1'
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
