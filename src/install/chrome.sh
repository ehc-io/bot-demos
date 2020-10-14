#!/usr/bin/env bash
### every exit != 0 fails the script
set -e
#
echo "Install Chromium Browser"
apt-get purge snapd
apt-get autoremove
# apt-get --fix-broken install
# 
apt-get install -y libgcc1 libmpx2 gcc-8-base xdg-utils libgbm1 libnspr4 libnss3
# This Ubuntu version uses snap store by default which for some reason has some conflicts with the chromium install
# I've downloaded a static version and forced an installation using dpkg -i
# 
tar -zxvf $INST_SCRIPTS/chromium-85.0-pkg.tar.gz -C $INST_SCRIPTS/
dpkg -i $INST_SCRIPTS/chromium-pkg/chromium-codecs-ffmpeg-extra_85.0.4183.83-0ubuntu0.18.04.2_amd64.deb \
        $INST_SCRIPTS/chromium-pkg/chromium-browser-l10n_85.0.4183.83-0ubuntu0.18.04.2_all.deb \
        $INST_SCRIPTS/chromium-pkg/chromium-browser_85.0.4183.83-0ubuntu0.18.04.2_amd64.deb
#
apt-mark hold chromium-browser
# https://packages.ubuntu.com/xenial-updates/amd64/chromium-codecs-ffmpeg-extra/download
# https://packages.ubuntu.com/xenial-updates/amd64/chromium-browser/download
# https://packages.ubuntu.com/xenial-updates/all/chromium-browser-l10n/download

