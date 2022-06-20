#! /bin/bash

# Install the required support programs
cd /opt/FDMR-Monitor/
apt install python3 python3-pip python3-dev libffi-dev libssl-dev cargo sed \
default-libmysqlclient-dev build-essential -y
pip3 install -r requirements.txt

cd /opt/FDMR-Monitor/
cp /opt/FDMR-Monitor/fdmr-mon_SAMPLE.cfg /opt/FDMR-Monitor/fdmr-mon.cfg
cd /opt/FreeDMR/
sudo rm /opt/FreeDMR/hotspot_proxy_v2.py
sudo rm /opt/FreeDMR/proxy_db.*
cp /opt/FDMR-Monitor/proxy/* /opt/FreeDMR/ -r
      
cd /opt/FDMR-Monitor/
  
sudo rm -r /var/www/html/ 
cp -r /opt/FDMR-Monitor/html/ /var/www/ 
      
sudo chown www-data:www-data /var/www/html/ -R
     

cp /opt/FDMR-Monitor/utils/logrotate/fdmr_mon /etc/logrotate.d/
cp /opt/FDMR-Monitor/utils/systemd/fdmr_mon.service /etc/systemd/system/
sudo systemctl daemon-reload
#systemctl enable fdmr_mon.service
#systemctl start fdmr_mon.service
    
python3 mon_db.py --create
python3 mon_db.py --update
