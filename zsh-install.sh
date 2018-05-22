#!/bin/bash
user=`whoami`
if [[ $user != 'root' ]]; then
	echo 'Your Password: ' | su root
fi

apt update
apt install curl zsh wget
cd ~
su $user
mkdir .antigen
curl -L git.io/antigen > ~/.antigen/antigen.zsh
wget https://raw.githubusercontent.com/heng19970427/zsh-install/master/zshrc -O ~/.zshrc

# If this user's login shell is not already "zsh", attempt to switch.
TEST_CURRENT_SHELL=$(expr "$SHELL" : '.*/\(.*\)')
if [ "$TEST_CURRENT_SHELL" != "zsh" ]; then
# If this platform provides a "chsh" command (not Cygwin), do it, man!
if hash chsh >/dev/null 2>&1; then
  printf "Time to change your default shell to zsh!\n"
  chsh -s $(grep /zsh$ /etc/shells | tail -1)
# Else, suggest the user do so manually.
else
  printf "I can't change your shell automatically because this system does not have chsh.\n"
  printf "Please manually change your default shell to zsh!\n"
fi
fi

env zsh
