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

cat > /etc/rc.local <<EOF
#!/bin/sh

feh --bg-scale /DashiumOS/background.png
tint2

exit 0

EOF
sudo chmod +x /etc/rc.local

cat > /etc/systemd/system/rc-local.service <<EOF
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
EOF
sudo systemctl enable rc-local
systemctl start rc-local.service


cat > /etc/systemd/system/dashium.service <<EOF
[Unit]
Description=Dashium service
After=multi-user.target
After=network.target
After=systemd-user-sessions.service
After=network-online.target

[Service]
Type=forking
ExecStart=/DashiumOS/startup.sh
Restart=on-failure
RestartSec=5

[Install]
WantedBy=multi-user.target
EOF
chmod u+x /DashiumOS/*
sudo systemctl start dashium
sudo systemctl enable dashium

sudo apt autoremove
sudo reboot