# Should be dir we are running make from
DOT_DIR=~/.dots

GIT_PROTOCOL=https

ZSH_RC=~/.zshrc
OH_MY_ZSH=~/.oh-my-zsh
BASH_ALIASES=~/.bash_aliases
BASH_RC=~/.bashrc
GIT_CONF=~/.gitconfig
POWERLINE=$(HOME)/.powerline
POWERLINE_FONTS=~/.powerline-fonts
POWERLINE_CONF_DIR=~/.config/powerline
SCREEN_RC=~/.screenrc
TMUX_CONF=~/.tmux.conf
FONTS_DIR=~/.fonts
FONT_CONF_DIR=~/.config/fontconfig/conf.d
NEOBUNDLE=~/.vim/bundle/neobundle.vim
VIM_RC=~/.vimrc
Z_DIR=~/.z-dir
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

ifeq ($(UNAME_S),Darwin)
all: bash zsh git tmux screen vim z ipython
zsh: /bin/zsh
ipython: /usr/local/bin/ipython
tmux: /usr/local/bin/tmux
else
all: bash zsh git tmux screen vim ipython urxvt
zsh: /usr/bin/zsh
ipython: /usr/bin/ipython
# install custom fonts under Linux
tmux: $(POWERLINE) $(POWERLINE_FONTS) $(TMUX_CONF) fonts
endif

bash: /bin/bash $(BASH_ALIASES) $(BASH_RC)

zsh: $(OH_MY_ZSH) $(ZSH_SYNTAX_HIGH) $(ZSH_RC)

git: /usr/bin/git $(GIT_CONF)

screen: /usr/bin/screen $(SCREEN_RC)

/usr/local/bin/tmux:
	brew install tmux


vim: /usr/bin/vim ~/.vim/tmp ~/.vim/backup ~/.vim/undo $(VIM_RC) $(NEOBUNDLE)

fzf: /usr/bin/ruby $(FZF_DIR)

urxvt: /usr/bin/urxvt $(XDEFAULTS)

/usr/bin/ipython:
/usr/local/bin/ipython:
	pip install ipython

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

z: $(Z_DIR)

$(Z_DIR):
	git clone $(GIT_PROTOCOL)://github.com/rupa/z.git $(Z_DIR)

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

$(POWERLINE): /usr/bin/python
	git clone $(GIT_PROTOCOL)://github.com/Lokaltog/powerline $(POWERLINE)

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

$(TMUX_CONF): $(POWERLINE_CONF_DIR) ~/.config/powerline/themes/tmux/default.json
	cp $(DOT_DIR)/tmux/tmux.conf $(TMUX_CONF)
	echo 'export PATH=$$PATH:$(POWERLINE)/scripts' >> $(BASH_RC)
	echo 'export PATH=$$PATH:$(POWERLINE)/scripts' >> $(ZSH_RC)
	echo "source-file '$(POWERLINE)/powerline/bindings/tmux/powerline.conf'" >> ~/.tmux.conf

~/.config/powerline/themes/tmux/default.json:
	cp $(DOT_DIR)/tmux/powerline.json ~/.config/powerline/themes/tmux/default.json

$(POWERLINE_CONF_DIR):
	cp -r ~/.powerline/powerline/config_files/ ~/.config/powerline

$(SCREEN_RC):
	cp $(DOT_DIR)/screen/screenrc $(SCREEN_RC)

$(GIT_CONF):
# Configure git to use meld diff
	git config --global diff.tool meld
	git config --global difftool.prompt false
# Configure git to use color
	git config --global color.ui true
# Configure git to use vim!
	git config --global core.editor "vim"
	git config --global user.name "Tom Cammann"
	git config --global user.email "cammann.tom@gmail.com"

clean: clean_tmux clean_vim
	rm -rf $(ZSH_RC) $(OH_MY_ZSH) $(BASH_RC) $(BASH_ALIASES) $(SCREEN_RC) $(GIT_CONF) $(IPYTHON_CONFIG) $(FZF_DIR)

clean_tmux:
	rm -rf $(FONT_DIR) $(FONT_CONF_DIR) $(TMUX_CONF) $(POWERLINE) $(POWERLINE_FONTS) $(POWERLINE_CONF_DIR)

$(BASH_RC):
	cp $(DOT_DIR)/bash/bashrc ~/.bashrc

$(BASH_ALIASES):
	cp $(DOT_DIR)/bash/bash_aliases ~/.bash_aliases

$(OH_MY_ZSH):
	git clone $(GIT_PROTOCOL)://github.com/robbyrussell/oh-my-zsh $(OH_MY_ZSH)

$(ZSH_RC):
	cp $(OH_MY_ZSH)/templates/zshrc.zsh-template $(ZSH_RC)
	sed -i -e 's/^plugins=.*/plugins=(git mvn tmux screen history-substring-search zsh-syntax-highlighting)/' $(ZSH_RC)
	sed -i -e 's/^ZSH_THEME=.*/ZSH_THEME=darkblood/' $(ZSH_RC)
	cat >> $(ZSH_RC) < $(DOT_DIR)/zsh/extras.zsh

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
