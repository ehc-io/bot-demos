#!/usr/bin/env bash
### every exit != 0 fails the script
set -e
#
echo "Install Firefox"
apt-get install -y firefox
apt-mark hold firefox
# wget -qO $INST_SCRIPTS/firefox.tar.gz https://ftp.mozilla.org/pub/firefox/releases/62.0.3/linux-x86_64/en-US/firefox-62.0.3.tar.bz2
# bunzip2 $INST_SCRIPTS/firefox.tar.gz
# tar -xf $INST_SCRIPTS/firefox.tar.gz.out -C $HOME
# rm $INST_SCRIPTS/firefox.tar.gz.out
# ln -s $HOME/firefox/firefox-bin /usr/bin/firefox