#!/bin/bash

git pull

sudo apt update
sudo apt upgrade

sudo apt install git
sudo apt install openbox
sudo apt install feh
sudo apt install openssh 
sudo apt install net-tools
sudo apt install tint2

mkdir /DashiumOS
cp $PWD/OS/* /DashiumOS/

feh --bg-scale /DashiumOS/background.png
tint2

cat > /etc/rc.local <<END \

feh --bg-scale /DashiumOS/background.png
tint2
exit 0

END
sudo chmod +x /etc/rc.local

cat > /etc/systemd/system/rc-local.service <<END \
[Unit]
Description=/etc/rc.local compatibility service
ConditionPathExists=/etc/rc.local

[Service]
Type=forking
ExecStart=/etc/rc.local start
TimeoutSec=0
StandardOutput=tty
RemainAfterExit=yes
SysVStartPriority=99

[Install]
WantedBy=multi-user.target    
END
sudo systemctl enable rc-local
systemctl start rc-local.service


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