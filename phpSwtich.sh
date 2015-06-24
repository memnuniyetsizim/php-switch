#!/bin/bash

checkVersion () {
	if hash "php$1" 2>/dev/null; then
		echo "Wait for switch..."
	else
		echo "You don't have php$1 version"
		exit 1
	fi
}

echo -n "Please give php version (53, 54, 55, 56) [ENTER]: "
read version

checkVersion $version


if [ "$(whoami)" != "root" ]; then
	echo "Sorry, you are not root."
	echo -n "Did you run this with sudo? [Y\N]: "
	read ifsudo

	if [ $ifsudo != "Y" ]; then
		echo "Please run this with sudo command or change your user to root"
		exit 1;
	fi
fi

versionrealpath=$(type -p "php$version")
phppath=$(type -p "php")

if [ ! -f $versionrealpath ]; then
	echo "Can not find real path for your php executable: Please enter full path: "
	read versionrealpath
fi

sudo rm -rf $phppath
sudo ln -s $versionrealpath $phppath

echo "Link created, your current version is: "
php -v 
