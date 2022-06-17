#!/bin/bash

git pull

sudo apt update
sudo apt upgrade


sudo apt install git
sudo apt install openbox
sudo apt install feh

feh --bg-scale $PWD/background.png


sudo apt-get install curl
curl -sL https://deb.nodesource.com/setup_16.x | sudo -E bash -
sudo apt-get install nodejs


git clone https://github.com/Dashium/Dashium
cd Dashium
npm install


git clone https://github.com/Dashium/DashiumInstaller
bash /DashiumInstaller/setup/installALL.sh

rm -rf /DashiumInstaller


sudo apt autoremove
sudo reboot