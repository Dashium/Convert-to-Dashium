
cat > /etc/systemd/system/rc-local.service <<EOF
[Unit]
Description=Run dashium

[Service]
Type=simple
ExecStart=/bin/bash /DashiumOS/desktop.sh

[Install]
WantedBy=multi-user.target
EOF

cp /etc/systemd/system/rc-local.service /lib/systemd/system/rc-local.service
sudo chmod 644 /etc/systemd/system/rc-local.service

sudo chmod u+x /etc/systemd/system/rc-local.service
sudo systemctl start rc-local
sudo systemctl enable rc-local


cat > /etc/systemd/system/dashiumDesktop.service <<EOF
[Unit]
Description=Run dashium Desktop

[Service]
Type=simple
ExecStart=/bin/bash /DashiumOS/desktop.sh

[Install]
WantedBy=multi-user.target
EOF

cp /etc/systemd/system/dashiumDesktop.service /lib/systemd/system/dashiumDesktop.service
sudo chmod 644 /etc/systemd/system/dashiumDesktop.service

sudo chmod u+x /etc/systemd/system/dashiumDesktop.service
sudo systemctl start dashiumDesktop
sudo systemctl enable dashiumDesktop
