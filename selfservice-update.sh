#!/bin/sh
sudo systemctl stop fdmr_mon.service
sudo systemctl stop http.server-fmr.service
sudo systemctl disable http.server-fmr.service
rm -r /opt/FDMR-Monitor/
#
sudo apt install -y apache2 apache2-utils
systemctl restart apache2
sudo systemctl enable apache2
sudo apt install mariadb-server mariadb-client -y
systemctl start mariadb
systemctl enable mariadb
sudo mysql_secure_installation
#
cd /opt
sudo git clone https://github.com/yuvelq/FDMR-Monitor.git
cd FDMR-Monitor
sudo git checkout Self_Service
sudo chmod +x install.sh
#sudo ./install.sh
#sudo cp fdmr-mon_SAMPLE.cfg fdmr-mon.cfg
sudo sed -i 's/RELOAD_TIME = 15/RELOAD_TIME = 1/' /opt/FDMR-Monitor/fdmr-mon_SAMPLE.cfg
#sudo cp utils/logrotate/fdmr_mon /etc/logrotate.d/
rm /etc/logrotate.d/fdmr_mon
rm /lib/systemd/system/fdmr_mon.service
#sudo cp utils/systemd/fdmr_mon.service /lib/systemd/system/
sudo sed -i 's/FREQUENCY = 10/FREQUENCY = 60/' /opt/FDMR-Monitor/fdmr-mon_SAMPLE.cfg
sudo chmod 644 /opt/FDMR-Monitor/fdmr-mon_SAMPLE.cfg
sed '33 a <!--' -i /opt/FDMR-Monitor/html/sysinfo.php
sed '35 a -->' -i /opt/FDMR-Monitor/html/sysinfo.php
####
sudo sed -i 's/localhost_2-day.png/localhost_1-day.png/' /opt/FDMR-Monitor/html/sysinfo.php
cd /var/www/html/sysinfo/
#sudo sed -i 's/var\/www\/html/opt\/FDMR-Monitor\/html/' cpu.sh
#sudo sed -i 's/var\/www\/html/opt\/FDMR-Monitor\/html/' graph.sh
sudo sed -i "s/HBMonv2/FDMR-Monitor/g"  /opt/FDMR-Monitor/sysinfo/*.sh


sudo chmod +x /opt/FDMR-Monitor/sysinfo/cpu.sh
sudo chmod +x /opt/FDMR-Monitor/sysinfo/graph.sh
sudo chmod +x /opt/FDMR-Monitor/sysinfo/rrd-db.sh

#sudo chmod +x /opt/FDMR-Monitor/updateTGIDS.sh
#
sudo cat > /opt/FDMR-Monitor/html/buttons.php <<- "EOF"
<!-- HBMonitor buttons HTML code -->
<a class="button" href="index.php">Home</a>
&nbsp;
<div class="dropdown">
  <button class="dropbtn">Links</button>
  <div class="dropdown-content">
&nbsp;
<a class="button" href="linkedsys.php">Linked Systems</a>

<a class="button" href="statictg.php">Static TG</a>

<a class="button" href="opb.php">OpenBridge</a>
&nbsp;
</div>
</div>
<div class="dropdown">
  <button class="dropbtn">Self Service</button>
  <div class="dropdown-content">
    <?php if(!PRIVATE_NETWORK){echo '<a href="selfservice.php">SelfService</a>';}?>
    <a class="button" href="login.php">Login</a>
    <?php 
    if(isset($_SESSION["auth"], $_SESSION["callsign"], $_SESSION["h_psswd"]) and $_SESSION["auth"]){
      echo '<a href="devices.php">Devices</a>';
    }
    ?>
  </div>
</div>
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
<a class="button" href="bridges.php">Bridges</a>
-->

<!-- Example of buttons dropdown HTML code -->
<!--
<div class="dropdown">
  <button class="dropbtn">Admin Area</button>
  <div class="dropdown-content">
    <a href="masters.php">Master&Peer</a>
    <a href="opb.php">OpenBridge</a>
    <a href="moni.php">Monitor</a>
  </div>
</div>

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

#sudo sed -i "s/opt\/FreeDMR\/freedmr.cfg/opt\/FreeDMR\/config\/FreeDMR.cfg/g"  /opt/FDMR-Monitor/install.sh

#sudo rm /opt/FDMR-Monitor/*.json
sudo systemctl daemon-reload

sudo chmod +x /opt/extra-2.sh
sudo sh /opt/extra-2.sh
cd /opt/FDMR-Monitor
#sudo ./install.sh
#####################
sudo cat > /opt/FDMR-Monitor/install.sh <<- "EOF"
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
  else
    echo 'fdmr-mon_SAMPLE.cfg not found, exiting.'
    exit 1
  fi
else
  echo 'Config file alredy exists.'
fi
# Create a new branch and copy proxy files
read -p 'Do you want to create a new FreeDMR branch and copy the Proxy files into it? [Y/n]: ' branch
branch=${branch:-y}
if [ "${branch,,}" == 'y' ]; then
  valid=''
  for i in {1..3}; do
    read -p 'Insert the path to FreeDMR folder e.g. /opt/FreeDMR/: ' p2fdmr
    if [ -z "$p2fdmr" ] | [ ! -d "$p2fdmr" ]; then
      echo "Path to FreeDMR folder: '${p2fdmr}' not found, try again."
      if [ $i -eq 3 ]; then
        echo 'To many errors, skipping this.'
      fi
    else
      valid=yes
      break $i
    fi
  done
  if [ ! -z $valid ]; then
    cd $p2fdmr
    if [ "$(git branch --list Self_Service)" ]; then
      git checkout Self_Service
      cp ${mon_path}proxy/* $p2fdmr -r
      echo 'Self_Service branch already exists, proxy files copied successfully'
    else
      git checkout master
      echo 'Creating new branch: Self_Service'
      git checkout -b Self_Service
      cp ${mon_path}proxy/* $p2fdmr -r
      echo "Proxy files copied into $p2fdmr successfully."
    fi
  fi
fi
rm -r /var/www/html/
cp -r /opt/FDMR-Monitor/html/ /var/www/

# Configure database
read -p 'Do you want to configure Self Service database and create tables? [Y/n]: ' db_conf
db_conf=${db_conf:-y}
if [ "${db_conf,,}" == 'y' ]; then
  db_info () {
    if [ $1 == 'DB_USERNAME' ]; then
      stm='Insert database username:'
      local loop=1
    elif [  $1 == 'DB_SERVER' ]; then
      stm='Insert database server host e.g. localhost:'
      local loop=1
    elif [ $1 ==  'DB_NAME' ]; then
      stm='Insert database name:'
      local loop=1
    elif [ $1 == 'DB_PASSWORD' ]; then
      read -p 'Insert database password, for no password leave it blank: ' input
      local loop=0
    else
      echo "invalid value: $1"
      return
    fi
    if [ $loop -eq 1 ]; then
      for i in {1..3}; do
        echo -n "${stm} " ; read input
        if [ -z $input ]; then
          echo 'invalid value, try again.'
          if [ $i -eq 3 ]; then
            echo 'Invalid Value, exiting'
            exit 1
          fi
        else
          break $i
        fi
      done
    fi
    sed -i "s/\(^$1 *= *\).*/\1$input/" fdmr-mon.cfg
  }
  # Define the keys of the options to modify
  db_items=('DB_NAME' 'DB_SERVER' 'DB_USERNAME' 'DB_PASSWORD')
  for i in ${!db_items[@]}; do
    db_info ${db_items[$i]}
  done
  #Create and update database tables
  python3 mon_db.py --create
  python3 mon_db.py --update
fi

# install log rotate file
  cp utils/logrotate/fdmr_mon /etc/logrotate.d/
  
# Copy systemd file
    cp utils/systemd/fdmr_mon.service /etc/systemd/system/
    systemctl daemon-reload
    systemctl enable fdmr_mon.service
    
   # systemctl start fdmr_mon.service
    

EOF

chmod +x /opt/FDMR-Monitor/install.sh
sh /opt/FDMR-Monitor/install.sh
#################
#sh /opt/FDMR-Monitor/sysinfo/rrd-db.sh
rm /opt/FDMR-Monitor/sysinfo/*.rrd 
sh /opt/FDMR-Monitor/sysinfo/rrd-db.sh
#sed '33 a <!--' -i /var/www/html/sysinfo.php
#sed '35 a -->' -i /var/www/html/sysinfo.php

cp -r /opt/FDMR-Monitor/sysinfo/ /var/www/html/sysinfo/

sudo rm mon.db
sudo python3 mon_db.py
sudo systemctl restart fdmr_mon.service
#sudo systemctl enable fdmr_mon.service
