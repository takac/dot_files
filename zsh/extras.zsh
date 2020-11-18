# Add all highlighting to zsh syntax hightlights
ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets pattern)
# Smart case completion
zstyle ':completion:*'  matcher-list 'm:{a-z}={A-Z}'

function source_if_exists()
{
    if [ -f "$@" ]; then
        source "$@"
    else
        if [ ! -n VERBOSE ]; then
            echo "could not find $@"
        fi
    fi
}

# Smart case completion
zstyle ':completion:*'  matcher-list 'm:{a-z}={A-Z}'

source_if_exists ~/.bash_aliases
source_if_exists ~/.dots/till.sh
# source_if_exists ~/.dots/fancy-ctrl-z.zsh
source_if_exists ~/.zsh_functions
source_if_exists ~/Downloads/google-cloud-sdk/path.zsh.inc
source_if_exists ~/Downloads/google-cloud-sdk/completion.zsh.inc

################################################
# Colors
ESC_SEQ="\x1b["
RESET=$ESC_SEQ"39;49;00m"
RED=$ESC_SEQ"31;01m"
GREEN=$ESC_SEQ"32;01m"
YELLOW=$ESC_SEQ"33;01m"
BLUE=$ESC_SEQ"34;01m"
MAGENTA=$ESC_SEQ"35;01m"
CYAN=$ESC_SEQ"36;01m"

export EDITOR=/usr/local/bin/vim
export GPG_TTY=$(tty)

if [[ $(uname -s) == Darwin ]]; then
    export PATH="$(brew --prefix coreutils)/libexec/gnubin:/usr/local/bin:$PATH"
    export PATH=$PATH:$HOME/Library/Python/2.7/bin
else
    export PATH=$PATH:$HOME/.local/bin
fi

export PATH=$PATH:$HOME/Downloads/google-cloud-sdk/bin/
export PATH=$PATH:/usr/local/go/bin
export PATH="/usr/local/opt/libpq/bin:$PATH"

if [[ "$PROFILE_STARTUP" == true ]]; then
    zprof
    unsetopt xtrace
    exec 2>&3 3>&-
fi
export HISTSIZE=10000000
export SAVEHIST=10000000
setopt BANG_HIST                 # Treat the '!' character specially during expansion.
setopt EXTENDED_HISTORY          # Write the history file in the ":start:elapsed;command" format.
setopt INC_APPEND_HISTORY        # Write to the history file immediately, not when the shell exits.
setopt SHARE_HISTORY             # Share history between all sessions.
setopt HIST_EXPIRE_DUPS_FIRST    # Expire duplicate entries first when trimming history.
setopt HIST_IGNORE_DUPS          # Don't record an entry that was just recorded again.
setopt HIST_IGNORE_ALL_DUPS      # Delete old recorded entry if new entry is a duplicate.
setopt HIST_FIND_NO_DUPS         # Do not display a line previously found.
setopt HIST_IGNORE_SPACE         # Don't record an entry starting with a space.
setopt HIST_SAVE_NO_DUPS         # Don't write duplicate entries in the history file.
setopt HIST_REDUCE_BLANKS        # Remove superfluous blanks before recording entry.
setopt HIST_VERIFY               # Don't execute immediately upon history expansion.
setopt HIST_BEEP                 # Beep when accessing nonexistent history.
