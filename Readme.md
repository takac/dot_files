DOT FILES
=========

Prerequites:

    # Install required packages
    sudo apt-get install -y git zsh screen vim tmux rxvt-unicode-256color ruby ipython make python-pip xorg

    # Set defualt editor to vim
    sudo update-alternatives --set editor /usr/bin/vim.basic

    # make password-less sudo by adding NOPASSWD and
    # Defaults env_keep="http_proxy https_proxy ftp_proxy"
    sudo visudo

    # set default shell
    chsh -s /bin/zsh

Install process:

    make

Set the editor to vim:



Config for:
- bash
- git
- fzf    (https://github.com/junegunn/fzf)
- screen
- tmux   (with powerline)
- vim    (with additional plugins)
- z
- zsh    (with oh-my-zsh)


Extras:

- Inconsolata.otf
    - Font file for powerline fonts
- packages.lst
    - List of debian/ubuntu packages
- till.sh
    - Useful script to move to root dirs
- sudoers.edit
    - Basic config on editting sudoers
- spotify.sh
    - Script for getting spotify songs
