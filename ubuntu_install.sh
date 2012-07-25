#Do an refresh and update
#sudo apt-get update
#sudo apt-get upgrade

#Check for git
command git >/dev/null 2>&1
if [ $? != 0 ]; then
	echo "Git not found, install git:"
	sudo apt-get install git
	command git >/dev/null 2>&1
	if [ $? != 0 ]; then
		echo "Git not found. Exiting."
		exit 1
	fi
fi

#Clone setup files
git clone https://github.com/takac/dot_files.git ~/.dots

#Install basic packages
sudo apt-get install $( cat ~/.dots/packages.lst )

#Create vim dirs
mkdir -p ~/.vim/tmp
mkdir -p ~/.vim/backup
mkdir -p ~/.vim/undo
#Copy vim files
cp -r ~/.dots/vim ~/.vim
cp ~/.dots/vimrc ~/.vimrc

cp ~/.dots/bash_aliases ~/.bash_aliases
cp ~/.dots/screenrc ~/.screenrc

wget --no-check-certificate https://github.com/robbyrussell/oh-my-zsh/raw/master/tools/install.sh -O - | sh

git clone git://github.com/rupa/z.git ~/.dots/z

echo "source ~/.bash_aliases" >> ~/.zshrc
echo ". ~/.dot/z/z.sh" >> ~/.zshrc
echo "function precmd () {" >> ~/.zshrc
echo " _z --add \"$(pwd -P)\"" >> ~/.zshrc
echo "}" >> ~/.zshrc

echo ". ~/.dot/z/z.sh" >> ~/.bashrc

sed -i 's/robbyrussell/dstufft/g' ~/.zshrc
