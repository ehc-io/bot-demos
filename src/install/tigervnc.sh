#!/usr/bin/env bash

echo "Install TigerVNC server"
wget -qO- https://bintray.com/tigervnc/stable/download_file?file_path=tigervnc-1.9.0.x86_64.tar.gz | tar xz --strip 1 -C /
