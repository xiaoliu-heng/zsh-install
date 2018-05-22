#!/bin/bash
user=`whoami`
if [[  != 'root' ]]; then
	echo 'Your Password: ' | su root
fi

sudo apt update
sudo apt install curl zsh wget
cd ~
su $user
mkdir .antigen
curl -L git.io/antigen > ~/.antigen/antigen.zsh
wget https://raw.githubusercontent.com/heng19970427/zsh-install/master/zshrc -O ~/.zshrc
chsh -s /bin/zsh
zsh
echo "done"
