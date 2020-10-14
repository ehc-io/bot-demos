#!/usr/bin/env bash
### every exit != 0 fails the script
set -e
wget -qO $HOME/chromedriver.zip https://chromedriver.storage.googleapis.com/85.0.4183.87/chromedriver_linux64.zip
unzip $HOME/chromedriver.zip
rm $HOME/chromedriver.zip
# cp $INST_SCRIPTS/chromedriver $HOME/
