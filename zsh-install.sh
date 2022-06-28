#!/usr/bin/env bash

ANTIGEN_URL="https://github.com/zsh-users/antigen/releases/latest/download/antigen.zsh"
ZSHRC_URL="https://raw.github.com/xiaoliu-heng/zsh-install/master/zshrc"

has() {
  type "$1" > /dev/null 2>&1
}

activate() {
  env zsh
  source ~/.zshrc
}

switch_to_zsh() {
  # If this user's login shell is not already "zsh", attempt to switch.
  TEST_CURRENT_SHELL=$(expr "$SHELL" : '.*/\(.*\)')
  if [ "$TEST_CURRENT_SHELL" != "zsh" ]; then
    # If this platform provides a "chsh" command (not Cygwin), do it, man!
    if hash chsh >/dev/null 2>&1; then
      printf "Time to change your default shell to zsh!\n"
      chsh -s $(grep /zsh$ /etc/shells | tail -1)
      activate
    # Else, suggest the user do so manually.
    else
      printf "I can't change your shell automatically because this system does not have chsh.\n"
      printf "Please manually change your default shell to zsh!\n"
    fi
  else
    echo 'You are alreday using zsh, active the plugins ...'
    activate
  fi
}

install() {
  if has curl;then
    echo 'using curl to download'
    mkdir -p ~/.antigen
    curl -L $ANTIGEN_URL > ~/.antigen/antigen.zsh
    curl -L $ZSHRC_URL > ~/.zshrc
    switch_to_zsh
  elif has wget;then
    echo 'using wget to download'
    mkdir -p ~/.antigen
    wget $ANTIGEN_URL -O ~/.antigen/antigen.zsh
    wget $ZSHRC_URL -O ~/.zshrc
    switch_to_zsh
  else
    echo "You need to install wget or curl to run this script!"
    exit 1
  fi
}

if has zsh && has git;then
  install
else
  echo 'You need to install zsh and git first!'
  echo 'Mac -> brew install zsh git'
  echo 'Ubuntu/Debian -> sudo apt install zsh git'
fi
