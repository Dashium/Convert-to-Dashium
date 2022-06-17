#!/bin/bash

git pull

sudo apt update
sudo apt upgrade

sudo apt install git
sudo apt install openbox
sudo apt install feh
sudo apt install openssh 
sudo apt install net-tools

sudo chmod +x /etc/rc.local
cat > /etc/rc.local <<END \

feh --bg-scale $PWD/background.png

END



sudo apt install curl
curl -sL https://deb.nodesource.com/setup_16.x | sudo -E bash -
sudo apt install nodejs


git clone https://github.com/Dashium/Dashium
cd Dashium
npm install


git clone https://github.com/Dashium/DashiumInstaller
bash /DashiumInstaller/setup/installALL.sh

rm -rf /DashiumInstaller


sudo apt autoremove
sudo reboot