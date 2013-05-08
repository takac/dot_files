#!/bin/bash

myip()
{
	echo "Int: $( ip a | awk '/inet / {sub(/\/.*/,""); if(!match ($2, /127\.0\.0/)){ print $2 }}')"
	echo "Ext: $(curl -s ip.appspot.com)"
}
alias open='gnome-open'

alias ack='ack-grep'
alias fau='sudo apt-get -y upgrade'
alias fap='sudo apt-get install --force-yes -y'

alias gs='git status'
alias gco='git checkout'
alias hs='history | grep -i'

#Add color to things :D
alias ls="ls --color"
alias grep='grep --color=always'
alias fgrep='fgrep --color=always'
alias egrep='egrep --color=always'
alias ls='ls --color=always'
alias tree='tree -C'


# Show all the dot files
alias dot='ls .[a-za-z0-9_]*'

# common misspellings
alias mroe=more
alias pdw=pwd


# default to human readable figures
alias df='df -h'
alias du='du -h'

# misc :)
alias less='less -r'                          # raw control characters
alias whence='type -a'                        # where, of a sort

# some shortcuts for different directory listings
alias ll='ls -l'                              # long list
alias la='ls -a'                              # all but . and ..
alias l='ls -tl'                              #
