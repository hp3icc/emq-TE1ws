#! /bin/bash

# Install the required support programs
cd /opt/FDMR-Monitor/
apt install python3 python3-pip python3-dev libffi-dev libssl-dev cargo sed \
default-libmysqlclient-dev build-essential -y
pip3 install -r requirements.txt

cd /opt/FDMR-Monitor/
cp /opt/FDMR-Monitor/fdmr-mon_SAMPLE.cfg /opt/FDMR-Monitor/fdmr-mon.cfg
cd /opt/FreeDMR/
sudo systemctl stop proxy.service
#sudo rm /opt/FreeDMR/hotspot_proxy_v2.py
sudo rm /opt/FreeDMR/proxy_db.*
#cp /opt/FDMR-Monitor/proxy/* /opt/FreeDMR/ -r
cp /opt/FDMR-Monitor/proxy/hotspot_proxy_v2.py /opt/FreeDMR/hotspot_proxy_v2.py
cp /opt/FDMR-Monitor/proxy/proxy.cfg /opt/FreeDMR/proxy.cfg
cp /opt/FDMR-Monitor/proxy/proxy_db.py /opt/FreeDMR/proxy_db.py
      
cd /opt/FDMR-Monitor/
  
sudo rm -r /var/www/html/ 
cp -r /opt/FDMR-Monitor/html/ /var/www/ 
      
sudo chown www-data:www-data /var/www/html/ -R
     

cp /opt/FDMR-Monitor/utils/logrotate/fdmr_mon /etc/logrotate.d/
#cp /opt/FDMR-Monitor/utils/systemd/fdmr_mon.service /etc/systemd/system/
echo 123> /etc/systemd/system/fdmr_mon.service
sudo rm /etc/systemd/system/fdmr_mon.service
#
cat > /lib/systemd/system/fdmr_mon.service  <<- "EOF"
[Unit]
Description=FDMR Monitor
# To make the network-online.target available
# systemctl enable systemd-networkd-wait-online.service

#After=network-online.target syslog.target
#Wants=network-online.target

[Service]
User=root
Type=simple
Restart=always
RestartSec=3
StandardOutput=null
WorkingDirectory=/opt/FDMR-Monitor
ExecStartPre=/bin/sh -c 'until ping -c1 noip.com; do sleep 1; done;'
ExecStart=python3 /opt/FDMR-Monitor/monitor.py
Restart=on-abort

[Install]
WantedBy=multi-user.target


EOF
#
sudo sed -i '166 s/hotpink/#ad02fd/g'   /var/www/html/css/styles.php
sudo sed -i '217 s/color:white/color:black/'  /var/www/html/css/styles.php
sudo sed -i "251d" /var/www/html/css/styles.php
sed '250 a    <?php echo THEME_COLOR."\\n";?>' -i /var/www/html/css/styles.php

sed '21 a # For custom color, select: pro' -i /opt/FDMR-Monitor/fdmr-mon.cfg

sed '24 a COLOR_TEXT = #d2c564' -i /opt/FDMR-Monitor/fdmr-mon.cfg 
sed '25 a COLOR_1 = #c68034' -i /opt/FDMR-Monitor/fdmr-mon.cfg  
sed '26 a COLOR_2 = #7f5224' -i /opt/FDMR-Monitor/fdmr-mon.cfg
sed '27 a COLOR_BACKGROUND = 5a5958' -i /opt/FDMR-Monitor/fdmr-mon.cfg

sed '45 a   $cd1 = strtolower($config["GLOBAL"]["COLOR_1"]);' -i /var/www/html/include/config.php  
sed '46 a   $cd2 = strtolower($config["GLOBAL"]["COLOR_2"]);' -i /var/www/html/include/config.php  
sed '47 a   $cd3 = strtolower($config["GLOBAL"]["COLOR_TEXT"]);' -i /var/www/html/include/config.php 
sed '48 a   $cd3 = strtolower($config["GLOBAL"]["COLOR_TEXT"]);' -i /var/www/html/include/config.php
sed '49 a   $cd4 = strtolower($config["GLOBAL"]["COLOR_BACKGROUND"]);' -i /var/www/html/include/config.php 

sed '66 a   } elseif ($theme == "pro") {' -i /var/www/html/include/config.php  
sed '67 a     $tc = "background-image: linear-gradient(to bottom, $cd1 0%, $cd2 100%);color:$cd3;";' -i /var/www/html/include/config.php  



#
sudo systemctl daemon-reload
#systemctl enable fdmr_mon.service
#systemctl start fdmr_mon.service
    
python3 mon_db.py --create
python3 mon_db.py --update
