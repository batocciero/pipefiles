#!/usr/bin/env bash

# Start the Ubuntu_cmd
Ubuntu_cmd_update() {
  sudo apt update
  sudo apt upgrade -y
  sudo apt clean
  sudo apt autoclean
  sudo apt autoremove -y

  [ -x "$(command -v flatpak)" ] && \
    flatpak update

  [ -x "$(command -v snap)" ] && \
    sudo snap refresh

  [ -x "$(command -v brew)" ] && \
    brew update && brew upgrade
}
