#!/bin/bash
# Use this line to create a space delimited list of applications to be installed
# while this does not work for all distros at this time, the PM will throw an error
# if the package can't be installed
packagesNeeded='neovim zsh golang-go go ccls clang-format clang'

PM=''

cd $HOME

if [ -x "$(command -v apt)" ]; then sudo apt update && sudo apt upgrade; PM='apt'; 
elif [ -x "$(command -v dnf)" ];     then sudo dnf upgrade; PM='dnf';
elif [ -x "$(command -v zypper)" ];  then sudo zypper ref && sudo zypper update; PM='zyp';
elif [ -x "$(command -v pacman)" ];  then sudo pacman -Syu; PM='pac';
else echo "FAILED TO FIND PACKAGE MANAGER"; fi


if [ -x "$(command -v apt)" ]; then sudo apt install $packagesNeeded
elif [ -x "$(command -v dnf)" ];     then sudo dnf install $packagesNeeded
elif [ -x "$(command -v zypper)" ];  then sudo zypper install $packagesNeeded
elif [ -x "$(command -v pacman)" ];  then sudo pacman -S $packagesNeeded
else echo "FAILED TO INSTALL PACKAGE: Package manager not found. You must manually install: $packagesNeeded">&2; fi

sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
	       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'


if [ -d ".config" ]; then
	echo ".config directory exists"
else
	echo ".config directory does not exist..."
	mkdir .config
fi
curl -L git.io/antigen > ~/.config/zsh-plugins/antigen.zsh

git config --global user.email "ethan2@vt.edu"
git config --gloabl user.name "Ethan Holz"
git config --global core.editor nvim

FILE1=/usr/local/bin/zsh
FILE2=/usr/bin/zsh
if [ -f "$FILE1" ]; then
	echo "$FILE1 exists."
	echo $FILE1 | sudo tee -a /etc/shells
	FILE3=$FILE1
elif [ -f "$FILE2" ]; then
	echo "$FILE2 exists."
	echo $FILE2 | sudo tee -a /etc/shells
	FILE3=$FILE2
fi
echo "Please change your shell using chsh -s $FILE3"
