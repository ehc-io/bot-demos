#!/usr/bin/env bash
### every exit != 0 fails the script
set -e

echo -e "\n------------------ startup of Xfce4 window manager ------------------"

### disable screensaver and power management
xset -dpms &
xset s noblank &
xset s off &

# start up SSH server
service ssh start

/usr/bin/startxfce4 --replace > $HOME/wm.log &
sleep 3
cat $HOME/wm.log