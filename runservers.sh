# OpenDSA-server
cd /vagrant/OpenDSA-server/ODSA-django
sudo kill `sudo lsof -t -i:8443`
sudo kill `sudo lsof -t -i:8001`
setsid sudo ./runserver

# OpenDSA content server
cd /vagrant/OpenDSA
sudo kill `sudo lsof -t -i:8080`
setsid ./WebServer

# OpenDSA-LTI server
cd /vagrant/OpenDSA-LTI
sudo kill `sudo lsof -t -i:9292`
setsid sudo rackup config.ru
