export DOT_DIR=$(pwd)

inst=$(ls *_install.sh)
echo Install files:
for i in $inst; do
	echo $i
done

# Install basic packages
# sudo apt-get install -y $( cat ${DOT_DIR}/packages.lst )


# Copy screen config
cp ${DOT_DIR}/screenrc ~/.screenrc
