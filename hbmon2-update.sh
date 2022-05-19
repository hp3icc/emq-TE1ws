#!/bin/sh
rm -r /opt/HBMonv2/
cd /opt
sudo git clone https://github.com/yuvelq/FDMR-Monitor
cd FDMR-Monitor
sudo chmod +x install.sh
sudo ./install.sh
sudo cp fdmr-mon_SAMPLE.cfg fdmr-mon.cfg
sudo chmod 644 fdmr-mon.cfg
sudo cp utils/logrotate/fdmr_mon /etc/logrotate.d/
sudo cp utils/systemd/fdmr_mon.service /lib/systemd/system/
#sudo sed -i 's/FREQUENCY = 10/FREQUENCY = 60/' /opt/FDMR-Monitor/fdmr-mon.cfg
#

####
sudo sed -i 's/localhost_2-day.png/localhost_1-day.png/' /opt/FDMR-Monitor/html/sysinfo.php
cd /opt/FDMR-Monitor/sysinfo/
sudo sed -i 's/var\/www\/html/opt\/FDMR-Monitor\/html/' cpu.sh
sudo sed -i 's/var\/www\/html/opt\/FDMR-Monitor\/html/' graph.sh

sudo chmod +x /opt/FDMR-Monitor/sysinfo/cpu.sh
sudo chmod +x /opt/FDMR-Monitor/sysinfo/graph.sh
sudo chmod +x /opt/FDMR-Monitor/sysinfo/rrd-db.sh
sudo sh /opt/FDMR-Monitor/sysinfo/rrd-db.sh
sudo chmod +x /opt/FDMR-Monitor/updateTGIDS.sh


#
sudo systemctl stop hbmon2.service 
sudo rm /opt/FDMR-Monitor/*.json 
sudo rm /opt/FDMR-Monitor/sysinfo/*.rrd 
sudo sh /opt/FDMR-Monitor/sysinfo/rrd-db.sh 
#sudo systemctl start http.server-fmr.service
sudo chmod +x /opt/extra-2.sh
sudo sh /opt/extra-2.sh
sudo systemctl restart fdmr_mon
