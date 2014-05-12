DOT_DIR=~/.dots
ZSH_RC=~/.zshrc
OH_MY_ZSH=~/.oh-my-zsh
BASH_ALIASES=~/.bash_aliases
BASH_RC=~/.bashrc
GIT_CONF=~/.gitconfig
POWERLINE=$(HOME)/.powerline
POWERLINE_FONTS=~/.powerline-fonts
POWERLINE_CONF_DIR=~/.config/powerline
TMUX_CONF=~/.tmux.conf
FONTS_DIR=~/.fonts
FONT_CONF_DIR=~/.config/fontconfig/conf.d
NEOBUNDLE=~/.vim/bundle/neobundle.vim
VIM_RC=~/.vimrc
Z_DIR=~/.z-dir
FZF_DIR=~/.fzf

.PHONY=fonts clean_tmux clean_vim

all: bash zsh git tmux screen vim z fzf

bash: /bin/bash $(BASH_ALIASES) $(BASH_RC)

zsh: /usr/bin/zsh $(OH_MY_ZSH) $(ZSH_RC)

git: /usr/bin/git $(GIT_CONF)

screen: /usr/bin/screen $(SCREEN_RC)

tmux: /usr/bin/tmux $(POWERLINE) $(POWERLINE_FONTS) fonts $(TMUX_CONF)

vim: /usr/bin/vim ~/.vim/tmp ~/.vim/backup ~/.vim/undo $(VIM_RC) $(NEOBUNDLE)

fzf: /usr/bin/ruby $(FZF_DIR)

$(FZF_DIR):
	git clone git://github.com/junegunn/fzf $(FZF_DIR)
	sed -i '/^read /d' $(FZF_DIR)/install
	$(FZF_DIR)/install

z: $(Z_DIR)

$(Z_DIR):
	git clone git://github.com/rupa/z.git $(Z_DIR)
	# Configure Z with zsh
	echo "source $(Z_DIR)/z.sh" >> ~/.zshrc
	echo "function precmd () {" >> ~/.zshrc
	echo " _z --add \"\$$(pwd -P)\"" >> ~/.zshrc
	echo "}" >> ~/.zshrc
	# Configure Z with bash
	echo ". ~/.z/z.sh" >> ~/.bashrc

$(NEOBUNDLE):
	git clone git://github.com/Shougo/neobundle.vim ~/.vim/bundle/neobundle.vim
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

$(POWERLINE):
	git clone git://github.com/Lokaltog/powerline $(POWERLINE)

$(POWERLINE_FONTS):
	git clone git://github.com/Lokaltog/powerline-fonts $(POWERLINE_FONTS)

$(FONTS_DIR):
	mkdir -p $(FONTS_DIR)

$(FONT_CONF_DIR):
	mkdir -p $(FONT_CONF_DIR)

fonts: $(FONT_CONF_DIR)/10-powerline-symbols.conf \
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
	rm -rf $(ZSH_RC) $(OH_MY_ZSH) $(BASH_RC) $(BASH_ALIASES) $(SCREEN_RC) $(GIT_CONF)

clean_tmux:
	rm -rf $(FONT_DIR) $(FONT_CONF_DIR) $(TMUX_CONF) $(POWERLINE) $(POWERLINE_FONTS) $(POWERLINE_CONF_DIR)

$(BASH_RC):
	cp $(DOT_DIR)/bash/bashrc ~/.bashrc

$(BASH_ALIASES):
	cp $(DOT_DIR)/bash/bash_aliases ~/.bash_aliases

$(OH_MY_ZSH):
	git clone git://github.com/robbyrussell/oh-my-zsh $(OH_MY_ZSH)

$(ZSH_RC):
	cp $(OH_MY_ZSH)/templates/zshrc.zsh-template $(ZSH_RC)
	sed -i -e 's/^plugins=.*/plugins=(git mvn tmux screen)/' $(ZSH_RC)
	sed -i -e 's/^ZSH_THEME=.*/ZSH_THEME=darkblood/' $(ZSH_RC)
	echo "" >> $(ZSH_RC)
	echo "source ~/.bash_aliases" >> $(ZSH_RC)
	echo "source ${DOT_DIR}/till.sh" >> $(ZSH_RC)

