#!/bin/sh
rm -r /opt/HBMonv2/
cd /opt
git clone https://github.com/yuvelq/FDMR-Monitor.git
mv /opt/FDMR-Monitor /opt/HBMonv2
cd HBMonv2
sudo chmod +x install.sh
sudo ./install.sh
cp fdmr-mon_SAMPLE.cfg config.py
sudo chmod 644 config.py
sudo chmod +x /opt/HBMonv2/monitor.py
sudo sed -i 's/FREQUENCY = 10/FREQUENCY = 60/' /opt/HBMonv2/config.py
#
sudo cat > /opt/HBMonv2/updateTGIDS.sh <<- "EOF"
#!/bin/bash
#sleep $[ ( $RANDOM % 1800 )  + 1 ]s
cd /opt/HBMonv2
FILE_NAME="talkgroup_ids.json"
#FETCH_URL="http://downloads.freedmr.uk/downloads/talkgroup_ids.json"
FETCH_URL="https://freedmr.cymru/talkgroups/talkgroup_ids_json.php"
OLD_MD5=`md5sum ${FILE_NAME}`
wget -O ${FILE_NAME} ${FETCH_URL}
NEW_MD5=`md5sum ${FILE_NAME}`
if [ "$NEW_MD5" != "$OLD_MD5" ]
then
  echo "File is new, restarting"
  sync ; echo 3 > /proc/sys/vm/drop_caches && sudo systemctl restart hbmon2.service
fi
EOF
####
sudo sed -i 's/localhost_2-day.png/localhost_1-day.png/' /opt/HBMonv2/html/sysinfo.php
cd /opt/HBMonv2/sysinfo/
sudo sed -i 's/var\/www\/html/opt\/HBMonv2\/html/' cpu.sh
sudo sed -i 's/var\/www\/html/opt\/HBMonv2\/html/' graph.sh

sudo chmod +x /opt/HBMonv2/sysinfo/cpu.sh
sudo chmod +x /opt/HBMonv2/sysinfo/graph.sh
sudo chmod +x /opt/HBMonv2/sysinfo/rrd-db.sh
sudo sh /opt/HBMonv2/sysinfo/rrd-db.sh
sudo chmod +x /opt/HBMonv2/updateTGIDS.sh


#
sudo systemctl stop hbmon2.service 
sudo rm /opt/HBMonv2/*.json 
sudo rm /opt/HBMonv2/sysinfo/*.rrd 
sudo sh /opt/HBMonv2/sysinfo/rrd-db.sh 
#sudo systemctl start http.server-fmr.service
sudo sh /opt/HBMonv2/updateTGIDS.sh
sudo chmod +x /opt/extra-2.sh
sudo sh /opt/extra-2.sh
