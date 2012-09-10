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

cp ~/.dots/bash_aliases ~/.bash_aliases
cp ~/.dots/screenrc ~/.screenrc

sudo cp ~/.dots/diff.py /usr/bin/diff.py

if [ ! -d ~/.oh-my-zsh ]; then
	echo "Installing oh-my-zsh"
	wget --no-check-certificate https://github.com/robbyrussell/oh-my-zsh/raw/master/tools/install.sh -O - | sh
else
	echo "Oh-my-zsh already installed, remove .oh-my-zsh and retry to reinstall"
fi
git clone git://github.com/rupa/z.git ~/.dots/z

echo "" >> ~/.zshrc
echo "source ~/.bash_aliases" >> ~/.zshrc
echo "source ~/.dots/z/z.sh" >> ~/.zshrc
echo "function precmd () {" >> ~/.zshrc
echo " _z --add \"\$(pwd -P)\"" >> ~/.zshrc
echo "}" >> ~/.zshrc

echo ". ~/.dots/z/z.sh" >> ~/.bashrc

sed -i 's/robbyrussell/dstufft/g' ~/.zshrc
USER=$( whoami )

sudo chsh -s $(which zsh) $USER

