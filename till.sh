DEFAULT_FILES=(pom.xml .git)

function t () {
	while [ 1 ]; do 
		if [ $PWD = '/' ]; then
			return
		fi
		if [ -z $1 ]; then
			for DF in "${DEFAULT_FILES[@]}"; do 
				if [ -e $DF ]; then
					return
				fi
			done
		else
			if [ -e $1 ]; then
				return
			fi
		fi
		cd ../
	done 
}
