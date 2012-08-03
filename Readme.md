DOT FILES
=========

Contents:

ubuntu_install.sh
--------------------------------
This is a setup file for configuring a clean ubuntu install.
To launch it run:
wget -q -O- https://raw.github.com/takac/dot_files/master/ubuntu_install.sh | sh

The ~/.dots directory must be deleted to reinstall.

.vimrc
------
Contains a lot of start up settings for vim. including color settings, syntax highlighting, history and backup file settings

This file also contains a list of commonly mispelled words, eg: teh, adn, agian etc.  

.vim/plugin/
------------
Contains the most useful vim plugins

* NERD_tree.vim
* surround.vim
* taglist.vim

.vim/ftplugin/
-------------
Contains the filetype plugin xml, which aids with xml writing and autocompletion

.vim/colors/
------------
contains color files which could be used in the .vimrc

* Monokai.vim
* Tomorrow-Night-Blue.vim
* Tomorrow-Night-Bright.vim
* Tomorrow-Night-Eighties.vim
* Tomorrow-Night.vim
* Tomorrow.vim
* molokai.vim
* solarized.vim

.bashrc
-------
This is deprecated really, as I have moved on to zsh, which has everything I already need.
File run by bash at term start.
This file contains setting for bash, bash history, autocomplete.
Some useful functions.
Other files to run at start

.bash_aliases
-------------
Contains most of the aliases to run.
If adding an alias put it here

.bash_profile
-------------
This file is probably run by bash at start, but no 100% sure

.profile
--------
Don't think this is used if bash_profile exists.

