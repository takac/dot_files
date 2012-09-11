#!/bin/bash
alias open='nautilus'

alias ack='ack-grep'
alias fau='sudo apt-get -y upgrade'
alias fap='sudo apt-get install --force-yes -y'

alias vim='vim -p'
alias gs='git status'
alias hs='history | grep -i'

#Add color to things :D
alias ls="ls --color"
alias grep='grep --color=always'
alias fgrep='fgrep --color=always'
alias egrep='egrep --color=always'
alias ls='ls --color=always'
alias tree='tree -C'


alias ss="ps -aux"
#Show all the dot files
alias dot='ls .[a-za-z0-9_]*'
alias news="xterm -g 80x45 -e trn -e -s1 -n &"

#Helpful quickies
alias c="clear"
alias m="more"
alias j="jobs"

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
