# This Dockerfile is used to build an headles vnc image based on Ubuntu

FROM ubuntu:20.04

# MAINTAINER "admin@xfactory.local"
ENV REFRESHED_AT 2020-10-09

## Connection ports for controlling the UI:
# VNC port:5901
# noVNC webport, connect via https://[IP]:6980/vnc_auto.html?password=XXXXXXXXX
ENV DISPLAY :1
ENV VNC_PORT 5901
ENV NO_VNC_PORT 6900
EXPOSE $VNC_PORT $NO_VNC_PORT

ENV HOME /home/ubuntu
ENV STARTUPDIR $HOME/headless
WORKDIR $HOME

### Envrionment config
ENV DEBIAN_FRONTEND noninteractive
ENV NO_VNC_HOME $HOME/noVNC
ENV VNC_COL_DEPTH 16
ENV VNC_RESOLUTION 1024x768
ENV VNC_PW h34dl355

### Add all install scripts for further steps
ENV INST_SCRIPTS $HOME/install
ADD ./src/install/ $INST_SCRIPTS/
ADD ./src/configs/ $CONFIGS/

## install xfactory tools
RUN $INST_SCRIPTS/tools.sh
RUN $INST_SCRIPTS/ohmyz.sh

## install firefox and geckodriver
RUN $INST_SCRIPTS/firefox.sh
RUN $INST_SCRIPTS/gecko-copy.sh

## install chromium-browser and chromedriver
RUN $INST_SCRIPTS/chrome.sh
RUN $INST_SCRIPTS/chrome-driver-copy.sh

### Install xvnc-server & noVNC - HTML5 based VNC viewer
RUN $INST_SCRIPTS/tigervnc.sh
RUN $INST_SCRIPTS/novnc.sh

## Install xfce UI
RUN $INST_SCRIPTS/xfce_ui.sh

# provide ssh access
RUN apt-get update && apt-get install -y openssh-server
RUN mkdir /var/run/sshd
RUN echo 'root:h34dl355' | chpasswd
RUN sed -i 's/PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config
# SSH login fix. Otherwise user is kicked off after login
RUN sed 's@session\s*required\s*pam_loginuid.so@session optional pam_loginuid.so@g' -i /etc/pam.d/sshd
ENV NOTVISIBLE "in users profile"
RUN echo "export VISIBLE=now" >> /etc/profile
EXPOSE 22

# Seeting users and SSH Keys
RUN echo 'X11Forwarding yes' >> /etc/ssh/sshd_config
RUN echo 'X11UseLocalhost no' >> /etc/ssh/sshd_config
RUN mkdir /root/.ssh
# RUN cp $INST_SCRIPTS/authorized_keys /root/.ssh
RUN useradd -m -s /bin/bash ubuntu
RUN adduser ubuntu sudo
RUN echo "ubuntu:h34dl355" | sudo chpasswd
# RUN mkdir /home/ubuntu/.ssh
# RUN cp $INST_SCRIPTS/authorized_keys /home/ubuntu/.ssh
# private and public keys
RUN cp -fr $CONFIGS/.ssh /home/ubuntu
RUN sed -i '/%sudo\tALL=(ALL:ALL) ALL/a ubuntu\tALL=(ALL) NOPASSWD: ALL' /etc/sudoers

# Personalization files
# RUN cp -fr $CONFIGS/* /home/ubuntu
RUN cp $CONFIGS/linux-desktop.jpg /usr/share/backgrounds/xfce
RUN cp $CONFIGS/tie-fighter.jpg /usr/share/backgrounds/xfce
RUN cp $CONFIGS/neptune-skyes.jpg /usr/share/backgrounds/xfce
RUN cp $CONFIGS/pier.jpg /usr/share/backgrounds/xfce
RUN cp -fvr $CONFIGS/.idlerc /home/ubuntu
RUN cp -fvr $CONFIGS/.local /home/ubuntu
RUN cp -fvr $CONFIGS/.config /home/ubuntu

## Oh-my-zsh
RUN cp $CONFIGS/.zshrc /home/ubuntu

# Sublime Install
RUN $INST_SCRIPTS/sublime-install.sh 
# RUN $INST_SCRIPTS/hyper-install.sh

### configure startup
RUN $INST_SCRIPTS/libnss_wrapper.sh
ADD ./src/scripts $STARTUPDIR
RUN $INST_SCRIPTS/set_user_permission.sh $STARTUPDIR $HOME

# Install Python Dependencies
RUN $INST_SCRIPTS/coding.sh

# bootstrap
USER ubuntu

# fixing home folder permissions
RUN sudo chown -R ubuntu:ubuntu /home/ubuntu
RUN sudo chmod -R 755 /home/ubuntu

# cleanup
RUN sudo rm -rf /var/lib/apt/lists/*

ENTRYPOINT ["/home/ubuntu/headless/vnc_startup.sh"]
CMD ["--tail-log"]
