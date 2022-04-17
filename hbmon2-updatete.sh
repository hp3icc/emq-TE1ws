#!/bin/sh
rm -r /opt/HBMonv2/
cd /opt
git clone https://github.com/yuvelq/FDMR-Monitor.git
mv /opt/FDMR-Monitor /opt/HBMonv2
cd HBMonv2
sudo chmod +x install.sh
sudo ./install.sh
cp config_SAMPLE.py config.py
sudo chmod +x /opt/HBMonv2/monitor.py
sudo sed -i 's/FREQUENCY       = 10/FREQUENCY       = 60/' /opt/HBMonv2/config.py
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

sudo cat > /opt/HBMonv2/html/buttons.html <<- "EOF"
<!-- HBMonitor buttons HTML code -->
<a class="button"  href="index.php">&nbsp;Home&nbsp;</a>
<!--
&nbsp;
<div class="dropdown">
  <button class="dropbtn">&nbsp;Admin Area&nbsp;</button>
  <div class="dropdown-content">
    <a href="masters.php">&nbsp;Masters&nbsp;</a>
    <a href="peers.php">&nbsp;Peers&nbsp;</a>
    <a href="opb.php">&nbsp;OpenBridge&nbsp;</a>
    <a href="bridges.php">&nbsp;Bridges&nbsp;</a>
    <a href="moni.php">&nbsp;Monitor&nbsp;</a>
    <a href="sinfo.php">&nbsp;System Info&nbsp;</a>
  </div>
</div>
-->
&nbsp;
<a class="button" href="linkedsys.php">&nbsp;Linked Systems&nbsp;</a>
&nbsp;
<a class="button" href="opb.php">&nbsp;OpenBridge&nbsp;</a>
&nbsp;
<a class="button" href="statictg.php">&nbsp;Static TG&nbsp;</a>
&nbsp;
<a class="button" href="moni.php">&nbsp;Monitor&nbsp;</a>
&nbsp;
<a class="button" href="sysinfo.php">&nbsp;System Info&nbsp;</a>
&nbsp;
<a class="button" href="log.php">&nbsp;Lastheard&nbsp;</a>
</div>
&nbsp;
<a class="button" href="http://www.freedmr.uk/index.php/why-use-freedmr/"target="_blank">&nbsp;Info FreeDMR&nbsp;</a>
&nbsp;
<a class="button" href="http://www.freedmr.uk/index.php/freedmr-servers/"target="_blank">&nbsp;Info Server&nbsp;</a>
&nbsp;
<a class="button" href="http://repeater.uk.freedmr.link/status/server_status.php"target="_blank">&nbsp;Status Server&nbsp;</a>
&nbsp;
<a class="button" href="http://repeater.uk.freedmr.link/status/count.php"target="_blank">&nbsp;Ranking TG&nbsp;</a>
&nbsp;
<a class="button" href="http://www.freedmr.uk/freedmr/option-calculator-b.php"target="_blank">&nbsp;Static TG Calculator&nbsp;</a>
&nbsp;
<!--
&nbsp;
<a class="button" href="bridges.php">&nbsp;Bridges&nbsp;</a>
-->
<!-- Own buttons HTML code -->

<!-- Example of buttons dropdown HTML code -->
<!--
<p></p>
<div class="dropdown">
  <button class="dropbtn">Admin Area</button>
  <div class="dropdown-content">
    <a href="masters.php">Master&Peer</a>
    <a href="opb.php">OpenBridge</a>
    <a href="moni.php">Monitor</a>
  </div>
</div>
&nbsp;
<div class="dropdown">
  <button class="dropbtn">Reflectors</button>
  <div class="dropdown-content">
    <a target='_blank' href="#">YSF Reflector</a>
    <a target='_blank' href="#">XLX950</a>
  </div>
</div>
-->
EOF
#
sudo systemctl stop hbmon2.service 
sudo rm /opt/HBMonv2/*.json 
sudo rm /opt/HBMonv2/sysinfo/*.rrd 
sudo sh /opt/HBMonv2/sysinfo/rrd-db.sh 
#sudo systemctl start http.server-fmr.service
sudo sh /opt/HBMonv2/updateTGIDS.sh
