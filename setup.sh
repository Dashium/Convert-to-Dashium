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

sudo apt install curl
curl -sL https://deb.nodesource.com/setup_16.x | sudo -E bash -
sudo apt install nodejs


mkdir /DashiumOS
cp $PWD/OS/* /DashiumOS/

feh --bg-scale /DashiumOS/background.png

cat > /etc/rc.local <<END \
#!/bin/sh

feh --bg-scale /DashiumOS/background.png
tint2

exit 0

END
sudo chmod +x /etc/rc.local

cat > /etc/systemd/system/rc-local.service <<END \
[Unit]
Description=/etc/rc.local compatibility service
ConditionPathExists=/etc/rc.local
After=network.target

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


cat > /etc/systemd/system/dashium.service <<END \
[Unit]
Description=Dashium service
ConditionPathExists=/DashiumOS/startup.sh
After=multi-user.target

[Service]
Type=forking
ExecStart=/DashiumOS/startup.sh
Restart=on-failure
RestartSec=5

[Install]
WantedBy=multi-user.target    
END
sudo systemctl enable dashium
systemctl start dashium.service

sudo apt autoremove
sudo reboot