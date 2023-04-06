export DISABLE_AUTO_UPDATE=true
export DISABLE_MAGIC_FUNCTIONS=true

DISABLE_OH_MY_ZSH=false
DISABLE_ATUIN=false
ENABLE_NVM=false


# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH
# Put at start of .zshrc
PROFILE_STARTUP=false
if [[ "$PROFILE_STARTUP" == true ]]; then
    zmodload zsh/zprof # Output load-time statistics
    # http://zsh.sourceforge.net/Doc/Release/Prompt-Expansion.html
    PS4=$'%D{%M%S%.} %N:%i> '
    exec 3>&2 2>"${XDG_CACHE_HOME:-$HOME/tmp}/zsh_statup.$$"
    setopt xtrace prompt_subst
fi
# Use for testing zsh startup
# for i in $(seq 1 10); do /usr/bin/time /bin/zsh -i -c exit; done
