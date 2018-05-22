#!/bin/bash

if [[ `whoami` != 'root' ]]; then
	echo 'Your Password: ' | su root
fi

sudo apt update
sudo apt install curl zsh wget
cd ~
mkdir .antigen
curl -L git.io/antigen > ~/.antigen/antigen.zsh
wget 
