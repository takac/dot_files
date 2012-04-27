
alias ls="ls --color"
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'

alias ss="ps -aux"
alias dot='ls .[a-za-z0-9_]*'
alias news="xterm -g 80x45 -e trn -e -s1 -n &"

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
alias ll='ls --color -l'                              # long list
alias la='ls --color -a'                              # all but . and ..
alias l='ls --color -tl'                              #

alias hs='history | grep $1'
