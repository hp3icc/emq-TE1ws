#!/bin/sh
sudo systemctl stop apache2
sudo systemctl disable apache2
sudo systemctl stop fdmr_mon.service
sudo systemctl stop http.server-fmr.service 
rm -r /opt/FDMR-Monitor/
cd /opt
#sudo git clone https://github.com/yuvelq/FDMR-Monitor.git
sudo git clone https://github.com/hp3icc/FDMR-Monitor.git
cd FDMR-Monitor
#git checkout Self_service_dev
sudo chmod +x install.sh
sudo ./install.sh
sudo cp fdmr-mon_SAMPLE.cfg fdmr-mon.cfg
sudo sed -i 's/RELOAD_TIME = 15/RELOAD_TIME = 1/' /opt/FDMR-Monitor/fdmr-mon.cfg
sudo chmod 644 fdmr-mon.cfg
sudo cp utils/logrotate/fdmr_mon /etc/logrotate.d/
sudo cp utils/systemd/fdmr_mon.service /lib/systemd/system/
#sudo sed -i 's/FREQUENCY = 10/FREQUENCY = 60/' /opt/FDMR-Monitor/fdmr-mon.cfg
#
sed '30 a <!--' -i /opt/FDMR-Monitor/html/sysinfo.php
sed '32 a -->' -i /opt/FDMR-Monitor/html/sysinfo.php
####
sudo sed -i 's/localhost_2-day.png/localhost_1-day.png/' /opt/FDMR-Monitor/html/sysinfo.php
cd /opt/FDMR-Monitor/sysinfo/
sudo sed -i 's/var\/www\/html/opt\/FDMR-Monitor\/html/' cpu.sh
sudo sed -i 's/var\/www\/html/opt\/FDMR-Monitor\/html/' graph.sh
sudo sed -i "s/HBMonv2/FDMR-Monitor/g"  /opt/FDMR-Monitor/sysinfo/*.sh


sudo chmod +x /opt/FDMR-Monitor/sysinfo/cpu.sh
sudo chmod +x /opt/FDMR-Monitor/sysinfo/graph.sh
sudo chmod +x /opt/FDMR-Monitor/sysinfo/rrd-db.sh
sudo sh /opt/FDMR-Monitor/sysinfo/rrd-db.sh
sudo chmod +x /opt/FDMR-Monitor/updateTGIDS.sh
#
sudo cat > /opt/FDMR-Monitor/html/buttons.php <<- "EOF"
<!-- HBMonitor buttons HTML code -->
<a class="button"  href="index.php">&nbsp;Home&nbsp;</a>
<!--
&nbsp;
<div class="dropdown">
@hp3icc
hp3icc /
emq-TE1ws
Public

Code
Issues 1
Pull requests
Actions
Projects
Wiki
Security
Insights

    Settings

emq-TE1ws/
in
main

1

#!/bin/sh

2

sudo systemctl stop fdmr_mon.service

3

rm -r /opt/FDMR-Monitor/

4

cd /opt

5

sudo git clone https://github.com/yuvelq/FDMR-Monitor

6

cd FDMR-Monitor

7

sudo chmod +x install.sh

8

sudo ./install.sh

9

sudo cp fdmr-mon_SAMPLE.cfg fdmr-mon.cfg
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
<div class="dropdown">
  <button class="dropbtn">Links</button>
  <div class="dropdown-content">
&nbsp;
<a class="button" href="linkedsys.php">&nbsp;Linked Systems&nbsp;</a>
&nbsp;
<a class="button" href="opb.php">&nbsp;OpenBridge&nbsp;</a>
&nbsp;
<a class="button" href="statictg.php">&nbsp;Static TG&nbsp;</a>
&nbsp;
</div>
</div>
&nbsp;
<div class="dropdown">
  <button class="dropbtn">Local Server</button>
  <div class="dropdown-content">
<a class="button" href="moni.php">&nbsp;Monitor&nbsp;</a>
&nbsp;
<a class="button" href="sysinfo.php">&nbsp;System Info&nbsp;</a>
&nbsp;
<a class="button" href="log.php">&nbsp;Lastheard&nbsp;</a>
&nbsp;
<a class="button" href="tgcount.php">&nbsp;TG Count&nbsp;</a>
&nbsp;
</div>
</div>
&nbsp;
<div class="dropdown">
  <button class="dropbtn">FreeDMR</button>
  <div class="dropdown-content">
&nbsp;
<a class="button" href="http://www.freedmr.uk/index.php/why-use-freedmr/"target="_blank">&nbsp;Info FreeDMR&nbsp;</a>
&nbsp;
<a class="button" href="http://www.freedmr.uk/index.php/freedmr-servers/"target="_blank">&nbsp;Info Server&nbsp;</a>
&nbsp;
<a class="button" href="http://repeater.uk.freedmr.link/status/server_status.php"target="_blank">&nbsp;Status Server&nbsp;</a>
&nbsp;
<a class="button" href="http://www.freedmr.uk/freedmr/option-calculator-b.php"target="_blank">&nbsp;Static TG Calculator&nbsp;</a>
&nbsp;
</div>
</div>
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
sudo rm /opt/FreeDMR/hotspot_proxy_v2.py
sudo rm /opt/FreeDMR/proxy_db.*
cd /opt/FreeDMR/
wget https://gitlab.hacknix.net/hacknix/FreeDMR/-/raw/master/hotspot_proxy_v2.py
sudo sed -i "s/54100/54060/g"  /opt/FreeDMR/hotspot_proxy_v2.py
chmod +x hotspot_proxy_v2.py
#
sudo rm /opt/FDMR-Monitor/*.json
sudo systemctl daemon-reload
sudo rm /opt/FDMR-Monitor/sysinfo/*.rrd 
sudo sh /opt/FDMR-Monitor/sysinfo/rrd-db.sh 
sudo systemctl start http.server-fmr.service 
sudo systemctl enable http.server-fmr.service
sudo chmod +x /opt/extra-2.sh
sudo sh /opt/extra-2.sh

sudo rm mon.db
sudo python3 mon_db.py

sudo systemctl restart fdmr_mon.service
sudo systemctl restart proxy.service
