#!/bin/bash

git pull

sudo apt remove thunderbird*
sudo apt remove telegram*

sudo apt remove printer*
sudo apt remove ubuntu-desktop

sudo apt update
sudo apt upgrade

sudo apt install git
sudo apt install openbox
sudo apt install feh
sudo apt install openssh
sudo apt install openssh-server
sudo systemctl enable ssh
sudo systemctl start ssh
sudo apt install net-tools
sudo apt install tint2

sudo apt install curl
curl -sL https://deb.nodesource.com/setup_16.x | sudo -E bash -
sudo apt install nodejs

sudo add-apt-repository ppa:deadsnakes/ppa
sudo apt update
sudo apt install python3.9
sudo apt install python3-pip
pip install --upgrade pip
pip3 --version
pip install --upgrade google-auth google-api-core google-api-python-client google-auth-httplib2 google-auth-oauthlib pytz selenium webdriver_manager urllib3 requests idna chardet certifi

sudo sh -c 'echo "deb [arch=amd64] https://dl.google.com/linux/chrome/deb/ stable main" > /etc/apt/sources.list.d/google-chrome.list'
wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | sudo apt-key add -
sudo apt-get update
sudo apt-get install google-chrome-stable
sudo apt install chromium-browser chromium-codecs-ffmpeg

sudo apt install ca-certificates fonts-liberation libappindicator3-1 libasound2 libatk-bridge2.0-0 libatk1.0-0 libc6 libcairo2 libcups2 libdbus-1-3 libexpat1 libfontconfig1 libgbm1 libgcc1 libglib2.0-0 libgtk-3-0 libnspr4 libnss3 libpango-1.0-0 libpangocairo-1.0-0 libstdc++6 libx11-6 libx11-xcb1 libxcb1 libxcomposite1 libxcursor1 libxdamage1 libxext6 libxfixes3 libxi6 libxrandr2 libxrender1 libxss1 libxtst6 lsb-release wget xdg-utils
sudo apt install ffmpeg



mkdir /DashiumOS
cp $PWD/OS/* /DashiumOS/
sudo chmod +x /DashiumOS/desktop.sh

feh --bg-scale /DashiumOS/background.png

bash /scripts/init.sh

chmod u+x /DashiumOS/*

sudo apt autoremove
sudo reboot