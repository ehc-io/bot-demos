#!/usr/bin/env bash
### every exit != 0 fails the script
set -e
echo "Installing Python Dependencies"
apt-get update 
apt-get install -y software-properties-common
echo "Install python dependendies and other files"
apt-get install -y language-pack-en iputils-ping pkg-config tcpdump libssl-dev gcc
# YouTube-dl
curl -L https://yt-dl.org/downloads/latest/youtube-dl -o /usr/local/bin/youtube-dl
chmod a+rx /usr/local/bin/youtube-dl

# Python3.8
apt-get install -y idle-python3.8 python3-mysqldb python3-dev
apt-get install -y python3-pip
apt-get install -y python3-opencv
pip3 install selenium==4.0.0a6.post2
pip3 install bs4 lxml pillow ImageHash
pip3 install pylint 
pip3 install colorama
pip3 install black
pip3 install Cython 
pip3 install tensorflow
pip3 install psutil
pip3 install progressbar
pip3 install python-slugify
pip3 install tqdm

# Nodejs
apt-get install -y nodejs npm
