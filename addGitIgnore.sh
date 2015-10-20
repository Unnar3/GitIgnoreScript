#!/bin/bash
# My first script

# Check that we are in a folder with a .gitignore file
if [ ! -f .gitignore ]; then
    echo "File not found!"
    exit 1
fi

# MY_PATH="`dirname \"$0\"`"              # relative
MY_PATH="$(dirname "$(readlink -f "$0")")"
if [ -z "$MY_PATH" ] ; then
  exit 1  # fail
fi

echo "my path: "$MY_PATH

for i in "$@"; do

	if [ "$i" == "--options" ]; then
		OUTPUT="$(ls $MY_PATH"/gitignore")"
		echo "${OUTPUT}"
		OUTPUT="$(ls $MY_PATH"/gitignore/Global")"
		echo "${OUTPUT}"
		exit 1
	fi


	if [ -f $MY_PATH"/gitignore/"$i".gitignore" ]; then
		echo "found "$i
		if ! grep -Fxq "# "$i .gitignore; then
			echo "hmmmmm"
			echo " " >> .gitignore
			echo "##############################################" >> .gitignore
			echo "# "$i >> .gitignore
			echo "##############################################" >> .gitignore
			echo " " >> .gitignore
			cat $MY_PATH"/gitignore/"$i".gitignore" >> .gitignore
		else
			echo $i".gitignore already added"
		fi


	elif [ -f $MY_PATH"/gitignore/Global/"$i".gitignore" ]; then
		echo "found "$i
		if ! grep -Fxq "# "$i .gitignore; then
			echo " " >> .gitignore
			echo "##############################################" >> .gitignore
			echo "# "$i >> .gitignore
			echo "##############################################" >> .gitignore
			echo " " >> .gitignore
			cat $MY_PATH"/gitignore/Global/"$i".gitignore" >> .gitignore
		else
			echo $i".gitignore already added"
		fi

	else
		echo "did not find "$i
	fi

done
