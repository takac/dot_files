export PATH=$PATH:/home/tom/.powerline/scripts

# Add all highlighting to zsh syntax hightlights
ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets pattern)
# Smart case completion
zstyle ':completion:*'  matcher-list 'm:{a-z}={A-Z}'

function source_if_exists()
{
    if [ -f "$@" ]; then
        source "$@"
    else
        if [ ! -z VERBOSE ]; then
            echo "could not find $@"
        fi
    fi
}

source_if_exists ~/.bash_aliases
source_if_exists ~/.dots/till.sh
source_if_exists ~/.z-dir/z.sh
source_if_exists ~/.fzf.zsh
source_if_exists ~/.dots/ff.bash

# Hook in z jump
function precmd () {
 _z --add "$(pwd -P)"
}

# Taken from https://github.com/zsh-users/fizsh/blob/master/fizsh-dev/scripts/fizsh-miscellaneous.zsh
################################################
#
# Rebind tab so that it uses syntax-highlighting
#
# This is a bug in the syntax highlighting system (https://github.com/zsh-users/zsh-syntax-highlighting/issues/102)
# We work around it by calling all types of highlighters explictily
#
function _fizsh-expand-or-complete-and-highlight() {
  zle expand-or-complete
  _zsh_highlight_brackets_highlighter
  _zsh_highlight_main_highlighter
  _zsh_highlight_cursor_highlighter
  _zsh_highlight_pattern_highlighter
  _zsh_highlight_root_highlighter
}

zle -N _fizsh-expand-or-complete-and-highlight _fizsh-expand-or-complete-and-highlight

bindkey "^I" _fizsh-expand-or-complete-and-highlight

################################################
