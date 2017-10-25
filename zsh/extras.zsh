
# Add all highlighting to zsh syntax hightlights
ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets pattern)
# Smart case completion
zstyle ':completion:*'  matcher-list 'm:{a-z}={A-Z}'
export PATH=$PATH:/home/tom/.powerline/scripts

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
source_if_exists ~/.z-dir/z.sh
# source_if_exists ~/.fzf.zsh
source_if_exists ~/.dots/ff.bash
source_if_exists ~/.dots/fancy-ctrl-z.zsh
source_if_exists ~/.zsh_functions
source_if_exists ~/proxyconf.sh

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

if [[ $(uname -s) == Darwin ]]; then
    export PATH="$(brew --prefix coreutils)/libexec/gnubin:/usr/local/bin:$PATH"
fi
