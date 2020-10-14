**BOT-DEMO**

This is the source code for a container image with Ubuntu 20.04 install and  Xfce4, including several libraries commonly used for webscraping:

- Selenium  
- bs4  
- lxml  
- Puppeteer  

You can manage the container via SSH, VNC and noVNC (HTML)

For image build run:

`./build.sh <image-tag-name>`

For runnuing the image:

`docker run -d -p <VNC-PORT>:5901 -p <SSH-PORT>:22 -p <noVNC-PORT>:6900
--restart unless-stopped -v <local-folder-where-your-scritps-are>:/home/ubuntu/devops bot-demos:<IMAGE-TAG-NAME>`
