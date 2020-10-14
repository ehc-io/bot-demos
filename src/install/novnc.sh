#!/usr/bin/env bash
### every exit != 0 fails the script
set -e

echo "Install noVNC - HTML5 based VNC viewer"
#
# Include packages
sudo apt -y install novnc websockify python-numpy
  
# Generate Cert - this cert can be substituted with a public cert
sudo cp $INST_SCRIPTS/novnc.pem /etc/ssl
sudo chmod 644 /etc/ssl/novnc.pem