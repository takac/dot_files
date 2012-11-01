#Do an refresh and update
sudo apt-get update
sudo apt-get -y upgrade

if [ -d ~/.dots ]; then
	echo ".dots directory already installed, pleased remove this directory to reinstall"
	exit 1
fi

#Check for git
command git >/dev/null 2>&1
if [ $? != 1 ]; then
	echo "Git not found, install git:"
	sudo apt-get -y install git
	command git >/dev/null 2>&1
	if [ $? != 1 ]; then
		echo "Git not found. Exiting."
		exit 1
	fi
fi

#Clone setup files
git clone https://github.com/takac/dot_files.git ~/.dots

#Install basic packages
sudo apt-get install -y $( cat ~/.dots/packages.lst )

#Create vim dirs
mkdir -p ~/.vim/tmp
mkdir -p ~/.vim/backup
mkdir -p ~/.vim/undo

#Copy vim files
cp -r ~/.dots/vim/* ~/.vim
cp ~/.dots/vimrc ~/.vimrc

#Copy bash files
cp ~/.dots/bash_aliases ~/.bash_aliases

#Copy screen config
cp ~/.dots/screenrc ~/.screenrc

#Copy meld diff script
sudo cp ~/.dots/meld-git-diff.py /usr/bin/meld-git-diff.py
#Configure git to use meld diff
git config --global diff.external /usr/bin/meld-git-diff.py
#Configure git to use color
git config --global color.ui always
#Configure git to use vim!
git config --global core.editor "vim"

#Install Oh My ZSH
if [ ! -d ~/.oh-my-zsh ]; then
	echo "Installing oh-my-zsh"
	wget --no-check-certificate https://github.com/robbyrussell/oh-my-zsh/raw/master/tools/install.sh -O - | sh
else
	echo "Oh-my-zsh already installed, remove .oh-my-zsh and retry to reinstall"
fi
#Install Z, (directory history program)
git clone git://github.com/rupa/z.git ~/.dots/z

#Configure Z with zsh
echo "" >> ~/.zshrc
echo "source ~/.bash_aliases" >> ~/.zshrc
echo "source ~/.dots/z/z.sh" >> ~/.zshrc
echo "function precmd () {" >> ~/.zshrc
echo " _z --add \"\$(pwd -P)\"" >> ~/.zshrc
echo "}" >> ~/.zshrc

#Configure Z with bash
echo ". ~/.dots/z/z.sh" >> ~/.bashrc

#Set the zsh theme to dstufft
sed -i -e 's/^plugins=.*/plugins=(git mvn debian screen)/' -e 's/^ZSH_THEME=.*/ZSH_THEME=dstufft/' ~/.zshrc


#Change default shell to zsh
USER=$( whoami )
sudo chsh -s $(which zsh) $USER

