#!/usr/bin/bash
### every exit != 0 fails the script
set -e

# should also source $STARTUPDIR/generate_container_user
source $HOME/.bashrc

# start up SSH server
sudo service ssh start
echo -e "\n\n------------------ ssh started ------------------"
echo 
## write correct window size to chrome properties
$STARTUPDIR/chrome-init.sh

## resolve_vnc_connection
VNC_IP=$(ip addr show eth0 | grep -Po 'inet \K[\d.]+')

## change vnc password
echo -e "\n------------------ change VNC password to blank ------------------"
(echo $VNC_PW && echo $VNC_PW) | vncpasswd
# echo | vncpasswd -f ~/.vnc/vncpasswd

websockify -D --web=/usr/share/novnc/ --cert=/etc/ssl/novnc.pem $NO_VNC_PORT $VNC_IP:$VNC_PORT &
vncserver -kill :1 || rm -rfv /tmp/.X*-lock /tmp/.X11-unix || echo "remove old vnc locks to be a reattachable container"
vncserver $DISPLAY -depth $VNC_COL_DEPTH -geometry $VNC_RESOLUTION

# Starting Window Manager
$STARTUPDIR/wm_startup.sh
#
## log connect options
echo -e "\n\n------------------ VNC environment started ------------------"
echo -e "\nVNCSERVER started on DISPLAY= $DISPLAY \n\t=> connect via VNC viewer with $VNC_IP:$VNC_PORT $VNC_RESOLUTION"

echo -e "\n------------------ $HOME/.vnc/*$DISPLAY.log ------------------"

tail -f $HOME/.vnc/*$DISPLAY.log