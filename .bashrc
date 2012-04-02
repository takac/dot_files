# To the extent possible under law, the author(s) have dedicated all 
# copyright and related and neighboring rights to this software to the 
# public domain worldwide. This software is distributed without any warranty. 
# You should have received a copy of the CC0 Public Domain Dedication along 
# with this software. 
# If not, see <http://creativecommons.org/publicdomain/zero/1.0/>. 

# base-files version 4.1-1

# ~/.bashrc: executed by bash(1) for interactive shells.

# The latest version as installed by the Cygwin Setup program can
# always be found at /etc/defaults/etc/skel/.bashrc

# Modifying /etc/skel/.bashrc directly will prevent
# setup from updating it.

# The copy in your home directory (~/.bashrc) is yours, please
# feel free to customise it to create a shell
# environment to your liking.  If you feel a change
# would be benifitial to all, please feel free to send
# a patch to the cygwin mailing list.

# User dependent .bashrc file

# If not running interactively, don't do anything
[[ "$-" != *i* ]] && return

# Shell Options
#
# See man bash for more options...
#
# Don't wait for job termination notification
# set -o notify
#
# Don't use ^D to exit
# set -o ignoreeof
#
# Use case-insensitive filename globbing
# shopt -s nocaseglob
#
# Make bash append rather than overwrite the history on disk
shopt -s histappend
#
# When changing directory small typos can be ignored by bash
# for example, cd /vr/lgo/apaache would find /var/log/apache
shopt -s cdspell

# Completion options
#
# These completion tuning parameters change the default behavior of bash_completion:
#
# Define to access remotely checked-out files over passwordless ssh for CVS
# COMP_CVS_REMOTE=1
#
# Define to avoid stripping description in --option=description of './configure --help'
# COMP_CONFIGURE_HINTS=1
#
# Define to avoid flattening internal contents of tar files
# COMP_TAR_INTERNAL_PATHS=1
#
# Uncomment to turn on programmable completion enhancements.
# Any completions you add in ~/.bash_completion are sourced last.
# [[ -f /etc/bash_completion ]] && . /etc/bash_completion

# History Options
#
# Don't put duplicate lines in the history.
# export HISTCONTROL=$HISTCONTROL${HISTCONTROL+,}ignoredups
#
# Ignore some controlling instructions
# HISTIGNORE is a colon-delimited list of patterns which should be excluded.
# The '&' is a special pattern which suppresses duplicate entries.
export HISTIGNORE=$'[ \t]*:&:[fb]g:exit'
export HISTIGNORE=$'[ \t]*:&:[fb]g:exit:ls' # Ignore the ls command as well
#
# Whenever displaying the prompt, write the previous line to disk
# export PROMPT_COMMAND="history -a"
export PROMPT_COMMAND="history -a; history -n" 
#will be re-written and re-read each time bash shows the prompt.

# Aliases
#
# Some people use a different file for aliases
# if [ -f "${HOME}/.bash_aliases" ]; then
#   source "${HOME}/.bash_aliases"
# fi
#
# Some example alias instructions
# If these are enabled they will be used instead of any instructions
# they may mask.  For example, alias rm='rm -i' will mask the rm
# application.  To override the alias instruction use a \ before, ie
# \rm will call the real rm not the alias.
#
# Interactive operation...
# alias rm='rm -i'
# alias cp='cp -i'
# alias mv='mv -i'
#
# Default to human readable figures
alias df='df -h'
alias du='du -h'
#
# Misc :)
alias less='less -r'                          # raw control characters
alias whence='type -a'                        # where, of a sort
alias grep='grep --color'                     # show diffeGU21 5BHrences in colour
alias egrep='egrep --color=auto'              # show differences in colour
alias fgrep='fgrep --color=auto'              # show differences in colour
#
# Some shortcuts for different directory listings
alias ls='ls -hF --color=tty'                 # classify files in colour
alias dir='ls --color=auto --format=vertical'
alias vdir='ls --color=auto --format=long'
alias ll='ls -l'                              # long list
alias la='ls -A'                              # all but . and ..
alias l='ls -CF'                              #

alias vi='vim'
export gitserver='192.168.0.101'
alias sshgit='ssh root@$gitserver'
export JAVA_HOME='/cygdrive/c/Program Files/Java/jdk1.7.0_03/'


export PATH=$NDK_ROOT:$ANDROID_SDK_ROOT/tools:$ANDROID_SDK_ROOT/platform-tools:$PATH 
export GNUMAKE=/bin/make
export EDITOR=vim
export ECONF_VERSION="5.1_osf_VMCi-G01R01C01"
export WIN_ANDROID_SDK=C:\\Users\\vmci-dev2\\Android\\android-sdk
export WIN_ANDROID_NDK=C:\\Users\\vmci-dev2\\Android\\android-ndk
export ECONF_HOME=/cygdrive/c/Filing_SW/econf_v5.1_osf_VMCi/
export ECONF_ANDROID_NDK=${ECONF_HOME}/ftapplications/ftandroidsoftphone/android-ndk-1.6_r1-windows/android-ndk-1.6_r1/
export ECONF_ANDROID_SDK=${ECONF_HOME}/ftapplications/ftandroidsoftphone/android-sdk_r04-windows/android-sdk-windows/
export CYG_ANDROID_NDK=${ECONF_HOME}/ftapplications/ftandroidsoftphone/android-ndk-1.6_r1-windows/android-ndk-1.6_r1/
export CYG_ANDROID_SDK=${ECONF_HOME}/ftapplications/ftandroidsoftphone/android-sdk_r04-windows/android-sdk-windows/
export ANDROID_SDK_ROOT=${ECONF_ANDROID_SDK}
#export ANDROID_SDK_ROOT="/cygdrive/c/Users/vmci-dev2/Android/android-sdk"
export NDK_ROOT=${ECONF_ANDROID_NDK}export
#export NDK_ROOT="/cygdrive/c/Users/vmci-dev2/Android/android-ndk"
alias gi="grep -i"
alias AED="cd ${ECONF_HOME}"
alias ANE="cd ${ECONF_ANDROID_NDK}"
alias AIB="cd ${ECONF_HOME}/integration/batchintegration"
alias rbr=". ~/.bashrc"
