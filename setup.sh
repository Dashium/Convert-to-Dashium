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

cat > ~/.bashrc <<EOF
# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

PS1='\[\e[1;36m\]DashiumOS \[\e[1;36m\]\u \[\e[0m\]@ \[\e[1;36m\]\W \[\e[0m\] > '

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# colored GCC warnings and errors
#export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi
EOF

mkdir /DashiumOS
cp $PWD/OS/* /DashiumOS/
sudo chmod +x /DashiumOS/desktop.sh

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
Description=rc.local compatibility service
After=multi-user.target

[Service]
Restart=on-failure
ExecStart=/DashiumOS/desktop.sh
Type=simple
RestartSec=1

[Install]
WantedBy=multi-user.target
EOF
chmod u+x /etc/systemd/system/rc-local.service
sudo systemctl start rc-local
sudo systemctl enable rc-local

cat > /etc/systemd/system/dashiumDesktop.service <<EOF
[Unit]
Description=Dashium Desktop service
After=multi-user.target

[Service]
Type=forking
ExecStart=/DashiumOS/desktop.sh
Restart=on-failure
RestartSec=5

[Install]
WantedBy=multi-user.target
EOF

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
sudo systemctl start dashiumDesktop
sudo systemctl enable dashiumDesktop

sudo apt autoremove
sudo reboot