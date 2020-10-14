#!/usr/bin/env bash
### every exit != 0 fails the script
set -e
echo "Install some common tools for further installation"
apt-get update 
apt-get install -y git vim curl wget net-tools sudo apt-utils iproute2 htop
apt-get install -y unzip wget net-tools screen tmux font-manager
apt-get install -y gconf2 gconf-service libappindicator1 konsole