if [ ! -d 'DashiumOS/Dashium' ];
then
  mkdir /DashiumOS/Dashium
  mkdir /DashiumOS/Dashium/apps
  cd /DashiumOS/Dashium
  git clone "https://github.com/Dashium/Dashium"
  cd Dashium
  npm setup
else
  bash /home/dashium/DashiumInstaller/setup/install_DashiumOS.sh
  cd /DashiumOS/Dashium
  npm start
fi