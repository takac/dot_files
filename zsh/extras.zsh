if [[ $DISABLE_OH_MY_ZSH != true ]]; then
    source $ZSH/oh-my-zsh.sh
fi

setopt hist_expire_dups_first # delete duplicates first when HISTFILE size exceeds HISTSIZE
setopt hist_ignore_dups       # ignore duplicated commands history list
setopt hist_ignore_space      # ignore commands that start with space
# setopt hist_verify            # show command with history expansion to user before running it


# Add all highlighting to zsh syntax hightlights
ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets pattern)

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
source_if_exists ~/.dots/fancy-ctrl-z.zsh
source_if_exists ~/.zsh_functions
source_if_exists ~/proxyconf.sh
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
    # export PATH="$(brew --prefix coreutils)/libexec/gnubin:/usr/local/bin:/usr/local/sbin:$PATH"
    export PATH="/usr/local/opt/coreutils/libexec/gnubin:/usr/local/bin:/usr/local/sbin:$PATH"
    export PATH="/usr/local/opt/findutils/libexec/gnubin:$PATH"
    export PATH="/usr/local/opt/gnu-sed/libexec/gnubin:$PATH"
else
    export PATH=$PATH:$HOME/.local/bin
fi

export PATH=$PATH:$HOME/Downloads/google-cloud-sdk/bin/
export PATH=$HOME/.cargo/bin:$PATH
# export PATH=$PATH:/usr/local/go/bin

# very slow
if [[ $ENABLE_NVM == true ]]; then
    if command -v nvm 1>/dev/null 2>&1; then
        export NVM_DIR="$HOME/.nvm"
        [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
        [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
    fi
fi

# recommended but adds significant time to shell startup
# if command -v pyenv 1>/dev/null 2>&1; then
# eval "$(pyenv init --path)"
# fi
# Output:
# PATH="$(bash --norc -ec 'IFS=:; paths=($PATH); 
# for i in ${!paths[@]}; do 
# if [[ ${paths[i]} == "''$HOME/.pyenv/shims''" ]]; then unset '\''paths[i]'\''; 
# fi; done; 
# echo "${paths[*]}"')"
# export PATH="$HOME/.pyenv/shims:${PATH}"
# command pyenv rehash 2>/dev/null

if [[ "$PROFILE_STARTUP" == true ]]; then
    zprof
    unsetopt xtrace
    exec 2>&3 3>&-
fi

if [[ $DISABLE_ATUIN != true ]]; then
    if command -v atuin 1>/dev/null 2>&1; then
        eval "$(atuin init zsh --disable-up-arrow --disable-ctrl-r)"
    fi
fi

if [[ $DISABLE_ZOXIDE != true ]]; then
    if command -v zoxide 1>/dev/null 2>&1; then
        eval "$(zoxide init zsh)"
    fi
fi
