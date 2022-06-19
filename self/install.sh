#! /bin/bash

# Install the required support programs
apt install python3 python3-pip python3-dev libffi-dev libssl-dev cargo sed \
default-libmysqlclient-dev build-essential -y
pip3 install -r requirements.txt

cd /opt/FDMR-Nonitor/
cp /opt/FDMR-Nonitor/fdmr-mon_SAMPLE.cfg /opt/FDMR-Nonitor/fdmr-mon.cfg
cd /opt/FreeDMR/
rm /opt/FreeDMR/hotspot_proxy_v2.py
rm /opt/FreeDMR/proxy_db.py
cp /opt/FDMR-Monitor/proxy/* /opt/FreeDMR/ -r
      
cd /opt/FDMR-Nonitor/
  
rm /var/www/html/* -r
cp /opt/FDMR-Monitor/html/* /var/www/html/ -r
      
chown www-data:www-data /var/www/html/ -R
     

cp /opt/FDMR-Nonitor/utils/logrotate/fdmr_mon /etc/logrotate.d/
cp /opt/FDMR-Nonitor/utils/systemd/fdmr_mon.service /etc/systemd/system/
systemctl daemon-reload
systemctl enable fdmr_mon.service
systemctl start fdmr_mon.service
    
