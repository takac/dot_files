# Should be dir we are running make from
DOT_DIR=~/.dots

GIT_PROTOCOL=https

NVIM_LAZY=~/.local/share/nvim/lazy
NVIM_RC=~/.config/nvim/init.lua
NVIM_CONFIG_DIR=~/.config/nvim/
TPM_DIR=~/.tmux/plugins/tpm
EMACS_RC=~/.emacs.d/init.el
EMACS_DIR=~/.emacs.d
ZSH_RC=~/.zshrc
ZSH_FUNCTIONS=~/.zsh_functions
OH_MY_ZSH=~/.oh-my-zsh
BASH_ALIASES=~/.bash_aliases
BASH_RC=~/.bashrc
GIT_CONF=~/.gitconfig
SCREEN_RC=~/.screenrc
TMUX_CONF=~/.tmux.conf
FONTS_DIR=~/.fonts
FONT_CONF_DIR=~/.config/fontconfig/conf.d
NEOBUNDLE=~/.vim/bundle/neobundle.vim
VIM_RC=~/.vimrc
IPYTHON_CONFIG_DIR=~/.ipython/profile_default
IPYTHON_CONFIG=$(IPYTHON_CONFIG_DIR)/ipython_config.py
ZSH_SYNTAX_HIGH=$(OH_MY_ZSH)/custom/plugins/zsh-syntax-highlighting
VIRTUAL_ENV_WRAPPER=/usr/local/lib/python2.7/dist-packages/virtualenvwrapper
XDEFAULTS=~/.Xdefaults
I3_CONFIG=$(HOME)/.i3/config
I3_STATUS_CONFIG=$(HOME)/.i3status.conf

UNAME_S := $(shell uname -s)

# TODO font needed before emacs
HASKLUG_FONT_NAME=Hasklug\ Nerd\ Font\ Complete.otf
HASKLUG_FONT_URL=https://github.com/ryanoasis/nerd-fonts/raw/master/patched-fonts/Hasklig/Regular/complete/Hasklug%20Nerd%20Font%20Complete.otf

.PHONY=fonts clean_tmux clean_vim

#TODO Fix font install

ifeq ($(UNAME_S),Darwin)
SED=/usr/local/opt/gnu-sed/libexec/gnubin/sed
# PIP_BIN=$(HOME)/Library/Python/3.8/bin
TMUX=/usr/local/bin/tmux
# PYTHON3=/usr/local/bin/python3
all: brew bash zsh git tmux screen vim $(SED) find rg coreutils kitty hasklug emacs zoxide nvim node
zsh: /bin/zsh
find: /usr/local/bin/gfind
/usr/local/bin/gfind:
	brew install findutils
rg: /usr/local/bin/rg
/usr/local/bin/rg:
	brew install rg
kitty: /usr/local/bin/kitty
/usr/local/bin/kitty:
	brew install kitty

# TODO brew install urlview (for tmux-urlview)

coreutils: /usr/local/opt/coreutils/libexec/gnubin
/usr/local/opt/coreutils/libexec/gnubin:
	brew install coreutils

nvim: /usr/local/bin/nvim
/usr/local/bin/nvim:
	brew install nvim
vim: /usr/bin/vim

zoxide: /usr/local/bin/zoxide

/usr/local/bin/zoxide:
	brew install zoxide

nvm: /usr/local/opt/nvm/nvm.sh

/usr/local/opt/nvm/nvm.sh:
	brew install nvm

node: nvm ~/.nvm/versions/node/v16.*

~/.nvm/versions/node/v16.*:
	zsh -c 'export NVM_DIR="$$HOME/.nvm" && source "/usr/local/opt/nvm/nvm.sh" && nvm install 16'

hasklug: ~/Library/Fonts/$(HASKLUG_FONT_NAME)
~/Library/Fonts/Hasklug Nerd Font Complete.otf:
	curl -fsSL $(HASKLUG_FONT_URL) > ~/Library/Fonts/$(HASKLUG_FONT_NAME)

emacs: hasklug $(EMACS_RC) /Applications/Emacs.app/Contents/MacOS/Emacs

# TODO run emacs to install and then close

/Applications/Emacs.app/Contents/MacOS/Emacs:
	brew install --cask emacs
else
# Assumed ubuntu/debain
SED=/usr/bin/sed
PIP_BIN=$(HOME)/.local/bin
TMUX=/usr/bin/tmux

all: bash zsh git tmux screen vim ipython
vim: /usr/bin/vim
zsh: /usr/bin/zsh
pip: /usr/bin/pip
ipython: /usr/bin/pip $(PIP_BIN)/ipython
PYTHON3=/usr/bin/python3
# install custom fonts under Linux
endif

tmux: $(TMUX) $(TMUX_CONF)

emacs: $(EMACS_RC)

$(EMACS_RC): $(EMACS_DIR)
	cp $(DOT_DIR)/emacs/init.el $(EMACS_RC)

$(EMACS_DIR):
	mkdir -p ~/.emacs.d

clean_emacs:
	rm -rf $(EMACS_DIR)

brew: /usr/local/bin/brew

bash: /bin/bash $(BASH_ALIASES) $(BASH_RC)

$(PIP_BIN)/ipython:
	$(PYTHON3) -m pip install --user ipython

/usr/bin/cc:
	sudo apt install -y build-essential

# Build tools required to compile plugins
/usr/bin/vim: /usr/bin/cc
	sudo apt install -y vim

/usr/bin/tmux:
	sudo apt install -y tmux

/usr/bin/zsh:
	sudo apt install -y zsh

/usr/bin/pip:
	sudo apt install -y python-pip

zsh: $(OH_MY_ZSH) $(ZSH_SYNTAX_HIGH) $(ZSH_RC) $(ZSH_FUNCTIONS)

git: /usr/bin/git $(GIT_CONF)

screen: /usr/bin/screen $(SCREEN_RC)

/usr/local/bin/tmux:
	brew install tmux

/usr/local/bin/brew:
	curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install > /tmp/brew_installer
	/usr/bin/ruby /tmp/brew_installer

vim: ~/.vim/tmp ~/.vim/backup ~/.vim/undo $(VIM_RC) $(NEOBUNDLE)

urxvt: /usr/bin/urxvt $(XDEFAULTS)

ipython: $(IPYTHON_CONFIG)

i3: /usr/bin/Xorg /usr/bin/i3 $(I3_CONFIG) $(I3_STATUS_CONFIG)

$(IPYTHON_CONFIG): $(IPYTHON_CONFIG_DIR)
	cp $(DOT_DIR)/ipython/ipython_config.py $(IPYTHON_CONFIG)

$(IPYTHON_CONFIG_DIR):
	mkdir -p $(IPYTHON_CONFIG_DIR)

$(NEOBUNDLE):
	git clone $(GIT_PROTOCOL)://github.com/Shougo/neobundle.vim ~/.vim/bundle/neobundle.vim
	vim +NeoBundleInstall +qa

$(VIM_RC):
	cp $(DOT_DIR)/vim/vimrc $(VIM_RC)

~/.vim/backup:
	mkdir -p ~/.vim/backup

~/.vim/undo:
	mkdir -p ~/.vim/undo

~/.vim/tmp:
	mkdir -p ~/.vim/tmp

clean_vim:
	rm -rf ~/.vim ~/.vimrc

clean_nvim:
	rm -rf $(NVIM_CONFIG_DIR)

$(NVIM_RC):
	cp $(DOT_DIR)/neovim/init.lua $(NVIM_RC)

$(NVIM_LAZY):
	nvim +qa

$(NVIM_CONFIG_DIR):
	mkdir -p ~/.config/nvim
	mkdir -p ~/.local/share/nvim/databases/

nvim: $(NVIM_CONFIG_DIR) $(NVIM_RC) $(NVIM_LAZY)

$(FONTS_DIR):
	mkdir -p $(FONTS_DIR)

$(FONT_CONF_DIR):
	mkdir -p $(FONT_CONF_DIR)

$(TMUX_CONF): zsh ~/.tmux/plugins $(TPM_DIR)
	cp $(DOT_DIR)/tmux/tmux.conf $(TMUX_CONF)
	~/.tmux/plugins/tpm/bin/install_plugins

$(TPM_DIR):
	git clone https://github.com/tmux-plugins/tpm $(TPM_DIR)

~/.tmux/plugins:
	mkdir -p ~/.tmux/plugins

$(SCREEN_RC):
	cp $(DOT_DIR)/screen/screenrc $(SCREEN_RC)

$(GIT_CONF):
	cp $(DOT_DIR)/git/gitconfig $(GIT_CONF)

clean: clean_tmux clean_vim clean_nvim clean_emacs
	rm -rf $(ZSH_RC) $(ZSH_FUNCTIONS) $(OH_MY_ZSH) $(BASH_RC) $(BASH_ALIASES) $(SCREEN_RC) $(GIT_CONF) $(IPYTHON_CONFIG)

clean_tmux:
	rm -rf $(FONT_DIR) $(FONT_CONF_DIR) $(TMUX_CONF)

$(BASH_RC):
	cp $(DOT_DIR)/bash/bashrc ~/.bashrc

$(BASH_ALIASES):
	cp $(DOT_DIR)/bash/bash_aliases ~/.bash_aliases

$(OH_MY_ZSH):
	git clone $(GIT_PROTOCOL)://github.com/robbyrussell/oh-my-zsh $(OH_MY_ZSH)

$(ZSH_RC): $(SED)
	cp $(DOT_DIR)/zsh/before.zsh $(ZSH_RC)
	cat $(OH_MY_ZSH)/templates/zshrc.zsh-template >> $(ZSH_RC)
	cat $(DOT_DIR)/zsh/extras.zsh >> $(ZSH_RC) 
	$(SED) -i -e 's/^ZSH_THEME=.*/ZSH_THEME=darkblood/' $(ZSH_RC)
	# plugins split across multiple lines
	$(SED) -i -e '/plugins=/{N;N;N;N;s/.*/plugins=(git history-substring-search zsh-syntax-highlighting zsh-autosuggestions)/}' $(ZSH_RC)

$(ZSH_FUNCTIONS):
	cp $(DOT_DIR)/zsh/zsh_functions $(ZSH_FUNCTIONS)

$(ZSH_SYNTAX_HIGH):
	git clone https://github.com/zsh-users/zsh-syntax-highlighting.git $(ZSH_SYNTAX_HIGH)

# $(VIRTUAL_ENV_WRAPPER):
# 	sudo pip install virtualenvwrapper

$(XDEFAULTS):
	cp $(DOT_DIR)/urxvt/Xdefaults $(XDEFAULTS)
	xrdb $(XDEFAULTS)

$(I3_CONFIG):
	mkdir -p $(HOME)/.i3/
	cp $(DOT_DIR)/i3/config $(I3_CONFIG)

$(I3_STATUS_CONFIG):
	cp $(DOT_DIR)/i3/i3status.conf $(I3_STATUS_CONFIG)

$(SED):
	brew install gnu-sed

# $(PYTHON3):
# 	brew install python

