# Taken from http://sheerun.net/2014/03/21/how-to-boost-your-vim-productivity/
# Allows switching between background and foreground task very quick
fancy-ctrl-z () {
  if [[ -n $(jobs) ]]; then
      if [[ ! $#BUFFER -eq 0 ]]; then
        zle push-input
      fi
      BUFFER="fg"
      zle accept-line
  fi
}
zle -N fancy-ctrl-z
bindkey '^Z' fancy-ctrl-z
