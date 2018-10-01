# Should be dir we are running make from
DOT_DIR=~/.dots

GIT_PROTOCOL=https

ZSH_RC=~/.zshrc
ZSH_FUNCTIONS=~/.zsh_functions
OH_MY_ZSH=~/.oh-my-zsh
BASH_ALIASES=~/.bash_aliases
BASH_RC=~/.bashrc
GIT_CONF=~/.gitconfig
POWERLINE_FONTS=~/.powerline-fonts
POWERLINE_CONF_DIR=~/.config/powerline
SCREEN_RC=~/.screenrc
TMUX_CONF=~/.tmux.conf
FONTS_DIR=~/.fonts
FONT_CONF_DIR=~/.config/fontconfig/conf.d
NEOBUNDLE=~/.vim/bundle/neobundle.vim
VIM_RC=~/.vimrc
FZF_DIR=~/.fzf
IPYTHON_CONFIG_DIR=~/.ipython/profile_default
IPYTHON_CONFIG=$(IPYTHON_CONFIG_DIR)/ipython_config.py
ZSH_SYNTAX_HIGH=$(OH_MY_ZSH)/custom/plugins/zsh-syntax-highlighting
VIRTUAL_ENV_WRAPPER=/usr/local/lib/python2.7/dist-packages/virtualenvwrapper
XDEFAULTS=~/.Xdefaults
I3_CONFIG=$(HOME)/.i3/config
I3_STATUS_CONFIG=$(HOME)/.i3status.conf

UNAME_S := $(shell uname -s)

.PHONY=fonts clean_tmux clean_vim

#TODO Fix font install

ifeq ($(UNAME_S),Darwin)
POWERLINE=$(HOME)/Library/Python/2.7/lib/python/site-packages/powerline
PIP_BIN=$(HOME)/Library/Python/2.7/bin
all: brew bash zsh git tmux screen vim ipython
zsh: /bin/zsh
pip: /usr/local/bin/pip
/usr/local/bin/pip:
	sudo easy_install pip
/usr/bin/ipython: /usr/local/bin/pip
ipython: /usr/local/bin/ipython
tmux: $(POWERLINE) $(POWERLINE_FONTS) $(TMUX_CONF)
vim: /usr/local/bin/vim
else
POWERLINE=$(HOME)/.local/lib/python2.7/site-packages/powerline
# Assumed ubuntu/debain
PIP_BIN=$(HOME)/.local/bin
all: bash zsh git tmux screen vim ipython
vim: /usr/bin/vim
zsh: /usr/bin/zsh
pip: /usr/bin/pip
ipython: /usr/bin/pip $(PIP_BIN)/ipython
# install custom fonts under Linux
tmux: /usr/bin/tmux $(POWERLINE) $(TMUX_CONF)
endif

brew: /usr/local/bin/brew

bash: /bin/bash $(BASH_ALIASES) $(BASH_RC)

$(PIP_BIN)/powerline-config:
	pip install --user powerline-status

$(PIP_BIN)/ipython:
	pip install --user ipython

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

fzf: /usr/bin/ruby $(FZF_DIR)

urxvt: /usr/bin/urxvt $(XDEFAULTS)

ipython: $(IPYTHON_CONFIG)

i3: /usr/bin/Xorg /usr/bin/i3 $(I3_CONFIG) $(I3_STATUS_CONFIG)

$(IPYTHON_CONFIG): $(IPYTHON_CONFIG_DIR)
	cp $(DOT_DIR)/ipython/ipython_config.py $(IPYTHON_CONFIG)

$(IPYTHON_CONFIG_DIR):
	mkdir -p $(IPYTHON_CONFIG_DIR)

$(FZF_DIR):
	git clone $(GIT_PROTOCOL)://github.com/junegunn/fzf $(FZF_DIR)
	sed -i '/^read /d' $(FZF_DIR)/install
	$(FZF_DIR)/install

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

$(POWERLINE): /usr/bin/python pip $(PIP_BIN)/powerline-config

$(POWERLINE_FONTS):
	git clone $(GIT_PROTOCOL)://github.com/Lokaltog/powerline-fonts $(POWERLINE_FONTS)

$(FONTS_DIR):
	mkdir -p $(FONTS_DIR)

$(FONT_CONF_DIR):
	mkdir -p $(FONT_CONF_DIR)

fonts: /usr/bin/fc-cache $(FONT_CONF_DIR)/10-powerline-symbols.conf \
	$(FONTS_DIR)/Inconsolata\ for\ Powerline.otf \
	$(FONTS_DIR)/PowerlineSymbols.otf
	fc-cache -vf $(FONTS_DIR)

$(FONT_CONF_DIR)/10-powerline-symbols.conf: $(FONT_CONF_DIR)
	cp $(POWERLINE)/font/10-powerline-symbols.conf $(FONT_CONF_DIR)/10-powerline-symbols.conf

$(FONTS_DIR)/PowerlineSymbols.otf: $(FONTS_DIR)
	cp $(POWERLINE)/font/PowerlineSymbols.otf $(FONTS_DIR)/PowerlineSymbols.otf

$(FONTS_DIR)/Inconsolata\ for\ Powerline.otf: $(FONTS_DIR)
	cp $(POWERLINE_FONTS)/Inconsolata/Inconsolata\ for\ Powerline.otf $(FONTS_DIR)/Inconsolata\ for\ Powerline.otf

$(TMUX_CONF): zsh
	cp $(DOT_DIR)/tmux/tmux.conf $(TMUX_CONF)
	#FIXME do this another way, i.e. file to source?
	echo 'export PATH=$$PATH:$(PIP_BIN)' >> $(BASH_RC)
	echo "source-file '$(POWERLINE)/bindings/tmux/powerline.conf'" >> ~/.tmux.conf

# ~/.config/powerline/themes/tmux/default.json:
# 	cp $(DOT_DIR)/tmux/powerline.json ~/.config/powerline/themes/tmux/default.json

# $(POWERLINE_CONF_DIR):
# 	mkdir ~/.config || true
# 	cp -r ~/.powerline/powerline/config_files/ ~/.config/powerline

$(SCREEN_RC):
	cp $(DOT_DIR)/screen/screenrc $(SCREEN_RC)

$(GIT_CONF):
	cp $(DOT_DIR)/git/gitconfig $(GIT_CONF)

clean: clean_tmux clean_vim
	rm -rf $(ZSH_RC) $(ZSH_FUNCTIONS) $(OH_MY_ZSH) $(BASH_RC) $(BASH_ALIASES) $(SCREEN_RC) $(GIT_CONF) $(IPYTHON_CONFIG) $(FZF_DIR)

clean_tmux:
	rm -rf $(FONT_DIR) $(FONT_CONF_DIR) $(TMUX_CONF) $(POWERLINE) $(POWERLINE_FONTS)

$(BASH_RC):
	cp $(DOT_DIR)/bash/bashrc ~/.bashrc

$(BASH_ALIASES):
	cp $(DOT_DIR)/bash/bash_aliases ~/.bash_aliases

$(OH_MY_ZSH):
	git clone $(GIT_PROTOCOL)://github.com/robbyrussell/oh-my-zsh $(OH_MY_ZSH)

$(ZSH_RC):
	cp $(OH_MY_ZSH)/templates/zshrc.zsh-template $(ZSH_RC)
	# plugins split across multiple lines
	sed -i -e '/plugins=/{N;N;N;N;s/.*/plugins=(git mvn tmux screen history-substring-search zsh-syntax-highlighting)/}' $(ZSH_RC)
	sed -i -e 's/^ZSH_THEME=.*/ZSH_THEME=darkblood/' $(ZSH_RC)
	cat >> $(ZSH_RC) < $(DOT_DIR)/zsh/extras.zsh

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
