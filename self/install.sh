#! /bin/bash

# Install the required support programs
apt install python3 python3-pip python3-dev libffi-dev libssl-dev cargo sed \
default-libmysqlclient-dev build-essential -y
pip3 install -r requirements.txt

# fdmr-mon folder
mon_path=$(pwd)/
# Copy config file 
if [ ! -e fdmr-mon.cfg  ]; then
  if [ -e fdmr-mon_SAMPLE.cfg  ]; then
    cp fdmr-mon_SAMPLE.cfg fdmr-mon.cfg
    echo 'Config file copied successfully.'

    cd /opt/FreeDMR/
    rm /opt/FreeDMR/hotspot_proxy_v2.py
    rm /opt/FreeDMR/proxy_db.py
          cp /opt/FDMR-Monitor/proxy/* /opt/FreeDMR/ -r
      
cd /opt/FDMR-Nonitor/
  
      rm /var/www/html/* -r
      cp html/* /var/www/html/ -r
      
        chown www-data:www-data /var/www/html/ -R
     

# install log rotate file
if [ -d "/etc/logrotate.d/" ]; then
  cp utils/logrotate/fdmr_mon /etc/logrotate.d/
  echo 'fdmr_mon copied into /etc/logrotate.d/'
else
  echo '/etc/logrotate.d/ folder not found, you will need to copy fdmr_mon into your logrotate.d folder.'
  sleep 3
fi

# Copy systemd file
if [ -d "/etc/systemd/system/" ]; then
  if [ ! -e "/etc/systemd/system/fdmr_mon.service" ]; then
    cp utils/systemd/fdmr_mon.service /etc/systemd/system/
    echo 'fdmr_mon.service copied to /etc/systemd/system/'
    systemctl daemon-reload
    systemctl enable fdmr_mon.service
    echo 'fdmr_mon.service has been enabled to start after reboot'
    systemctl start fdmr_mon.service
    if [ $(systemctl show -p ActiveState --value fdmr_mon) == active ]; then
      echo 'fdmr_mon.service started successfully.'
    else
      echo 'An error was found when trying to start fdmr_mon.service.'
      echo "Run 'systemctl status fdmr_mon' for more details."
      sleep 3
    fi
  else
    echo 'fdmr_mon.service already exists in /etc/systemd/system/'
    echo "you can edit it by runnig 'nano /etc/systemd/system/fdmr_mon.service'"
    sleep 3
  fi
else
  echo '/etc/systemd/system/ folder not found, you will need to copy fdmr_mon.service into your systemd folder.'
fi
