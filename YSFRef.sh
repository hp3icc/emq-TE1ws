#!/bin/sh
sudo apt-get update -y
sudo apt-get upgrade -y
#
sudo apt-get install git -y
sudo apt-get install python3 -y
sudo apt install python3-pip -y
sudo apt install python3 
sudo apt install python3-distutils -y
sudo apt install python3-twisted -y
sudo apt install python3-bitarray -y
sudo apt install python3-dev -y
sudo python3 get-pip.py
sudo apt install python3-websockets
sudo apt install python3-psutil
sudo apt install threading
sudo apt install queue
sudo apt install sys
sudo apt install os
sudo apt install time
sudo apt install re
sudo apt install configparser
sudo apt install datetime
sudo apt install signal
sudo apt install bisect
sudo apt install struct
sudo apt install socket
sudo apt install ansi2html
sudo apt install logrotate
sudo pip3 install ansi2html
sudo apt-get install python-pip -y
sudo apt-get install python-dev -y
sudo apt-get install rrdtool -y
#
mkdir /var/www
mkdir /var/www/html
#
cd /opt
git clone https://github.com/iu5jae/pYSFReflector.git
cd pYSFReflector/
#cp YSFReflector /usr/local/sbin/
#cp YSFReflector.ini /usr/local/etc/

cp YSFReflector /usr/local/bin/
chmod +x /usr/local/bin/YSFReflector
mkdir /etc/YSFReflector

cp YSFReflector.ini /etc/YSFReflector/
cd /etc/YSFReflector/
sudo sed -i 's/FilePath=\/var\/log/FilePath=\/var\/log\/YSFReflector/' YSFReflector.ini
sudo sed -i 's/42395/42000/' YSFReflector.ini
sudo sed -i 's/FileRotate=1/FileRotate=0/' YSFReflector.ini
cd /opt/pYSFReflector/
cp deny.db /usr/local/etc/
chmod +x /usr/local/bin/YSFReflector
cd systemd/
cp YSFReflector.service /lib/systemd/system

sudo groupadd mmdvm
sudo useradd mmdvm -g mmdvm -s /sbin/nologin
mkdir /var/log/YSFReflector
sudo chown -R mmdvm:mmdvm /var/log/YSFReflector

###############################

mkdir /opt/YSF2DMR

cd /opt/
git clone https://github.com/juribeparada/MMDVM_CM.git
sudo cp -r /opt/MMDVM_CM/YSF2DMR /opt/
cd YSF2DMR
sudo make
sudo make install
#
cd /opt/
git clone --recurse-submodules -j8 https://github.com/dg9vh/WSYSFDash
cd /opt/WSYSFDash/
sudo chown -R mmdvm /opt/WSYSFDash
#
cat > /opt/WSYSFDash/logtailer.ini <<- "EOF"
[DEFAULT]
# No need to change this line below
Host=0.0.0.0
Port=5678
# set to True if SSL will be used
Ssl=False
SslCert=/path/to/fullchain.pem
SslKey=/path/to/privkey.pem
# This defines the maximum amount of loglines to be sent on initial opening of the dashboard
MaxLines=500
# Keep this parameter synchrone to Filerotate in YSFReflector.ini - if 0 then False, if 1 then True
Filerotate=False
#True
# You can use the logtailer-Service for more than one reflector running on your system.
# To do this, just copy the [YSFReflectorN]-Section into a new one, renumber it and modify the Logdir and Prefix.
# To use this on systems with more than one reflector, it is recommended to use a real webserver to host the html-files.
[YSFReflector]
# Localtion of your YSFReflector-binary
YSFReflector_bin=/usr/local/bin/YSFReflector
Logdir=/var/log/YSFReflector/
Prefix=YSFReflector
#[YSFReflector2]
#Logdir=/var/log/YSFReflector2/
#Prefix=YSFReflector
EOF
#
cat > /lib/systemd/system/http.server-ysf.service <<- "EOF"
[Unit]
Description=Python3 http.server-ysf
After=network.target
[Service]
User=root
ExecStartPre=/bin/sleep 10
Type=simple
#User=mmdvm
#Group=mmdvm
Restart=always
# Modify for different location of Python3 or other port
ExecStart=/usr/bin/python3 -m http.server 80 --directory /opt/WSYSFDash/html
[Install]
WantedBy=multi-user.target
EOF
#
cat > /lib/systemd/system/logtailer-ysf.service <<- "EOF"
[Unit]
Description=Python3 logtailer for WSYSFDash
After=network.target
[Service]
ExecStartPre=/bin/sleep 10
Type=simple
User=mmdvm
Group=mmdvm
Restart=always
# Modify for different location of Python3 or location of files
WorkingDirectory=/opt/WSYSFDash/
ExecStart=/usr/bin/python3 /opt/WSYSFDash/logtailer.py
[Install]
WantedBy=multi-user.target
EOF
#

sudo chmod +777 /var/log
sudo mkdir /var/log/ysf2dmr
sudo mkdir /var/log/mmdvm
sudo chmod +777 /var/log/*

#####
cat > /lib/systemd/system/dmrid-ysf2dmr.service  <<- "EOF"
[Unit]
Description=DMRIDupdate YSF2DMR
Wants=network-online.target
After=syslog.target network-online.target
[Service]
User=root
#ExecStartPre=/bin/sleep 1800
ExecStart=/opt/YSF2DMR/DMRIDUpdate.sh
[Install]
WantedBy=multi-user.target
EOF
#########
cat > /lib/systemd/system/ysf2dmr.service  <<- "EOF"
[Unit]
Description=YSF2DMR Service
After=syslog.target network.target
[Service]
User=root
WorkingDirectory=/opt/YSF2DMR
ExecStartPre=/bin/sleep 30
ExecStart=/opt/YSF2DMR/YSF2DMR /opt/YSF2DMR/YSF2DMR.ini
[Install]
WantedBy=multi-user.target
EOF
############
cat > /opt/YSF2DMR/YSF2DMR.ini  <<- "EOF"
[Info]
RXFrequency=438800000
TXFrequency=438800000
Power=1
Latitude=0.0
Longitude=0.0
Height=0
Location=Panama
Description=Multi-Mode
URL=www.google.co.uk
[YSF Network]
Callsign=HP3ICC
Suffix=ND
#Suffix=RPT
DstAddress=127.0.0.1
DstPort=42000
LocalAddress=127.0.0.1
#LocalPort=42013
EnableWiresX=0
RemoteGateway=0
HangTime=1000
WiresXMakeUpper=0
# RadioID=*****
# FICHCallsign=2
# FICHCallMode=0
# FICHBlockTotal=0
# FICHFrameTotal=6
# FICHMessageRoute=0
# FICHVOIP=0
# FICHDataType=2
# FICHSQLType=0
# FICHSQLCode=0
DT1=1,34,97,95,43,3,17,0,0,0
DT2=0,0,0,0,108,32,28,32,3,8
Daemon=0
[DMR Network]
Id=714000000
#XLXFile=XLXHosts.txt
#XLXReflector=950
#XLXModule=D
StartupDstId=714
# For TG call: StartupPC=0
StartupPC=0
Address=3021.master.brandmeister.network
Port=62031
Jitter=500
EnableUnlink=0
TGUnlink=4000
PCUnlink=0
# Local=62032
Password=****************
# Options=
TGListFile=TGList-DMR.txt
Debug=0
[DMR Id Lookup]
File=/opt/YSF2DMR/DMRIds.dat
Time=24
DropUnknown=0
[Log]
# Logging levels, 0=No logging
DisplayLevel=1
FileLevel=1
FilePath=/var/log/ysf2dmr/
FileRoot=YSF2DMR
[aprs.fi]
Enable=0
AprsCallsign=HP3ICC
Server=noam.aprs2.net
#Server=euro.aprs2.net
Port=14580
Password=12345
APIKey=APIKey
Refresh=240
Description=APRS Description
EOF
###################
cat > /opt/YSF2DMR/DMRIDUpdate.sh <<- "EOF"
#! /bin/bash
###############################################################################
#
#                              CONFIGURATION
#
# Full path to DMR ID file, without final slash
DMRIDPATH=/opt/YSF2DMR
DMRIDFILE=${DMRIDPATH}/DMRIds.dat
# DMR IDs now served by RadioID.net
#DATABASEURL='https://ham-digital.org/status/users.csv'
DATABASEURL='https://www.radioid.net/static/user.csv'
#
# How many DMR ID files do you want backed up (0 = do not keep backups)
DMRFILEBACKUP=1
#
# Command line to restart MMDVMHost
RESTARTCOMMAND="systemctl restart ysf2dmr.service"
# RESTARTCOMMAND="killall MMDVMHost ; /path/to/MMDVMHost/executable/MMDVMHost /path/to/MMDVM/ini/file/MMDVM.ini"
###############################################################################
#
# Do not edit below here
#
###############################################################################
# Check we are root
if [ "$(id -u)" != "0" ]
then
        echo "This script must be run as root" 1>&2
        exit 1
fi
# Create backup of old file
if [ ${DMRFILEBACKUP} -ne 0 ]
then
        cp ${DMRIDFILE} ${DMRIDFILE}.$(date +%d%m%y)
fi
# Prune backups
BACKUPCOUNT=$(ls ${DMRIDFILE}.* | wc -l)
BACKUPSTODELETE=$(expr ${BACKUPCOUNT} - ${DMRFILEBACKUP})
if [ ${BACKUPCOUNT} -gt ${DMRFILEBACKUP} ]
then
        for f in $(ls -tr ${DMRIDFILE}.* | head -${BACKUPSTODELETE})
        do
               rm $f
        done
fi
# Generate new file
curl ${DATABASEURL} 2>/dev/null | sed -e 's/\t//g' | awk -F"," '/,/{gsub(/ /, "", $2); printf "%s\t%s\t%s\n", $1, $2, $3}' | sed -e 's/\(.\) .*/\1/g' > ${DMRIDPATH}/DMRIds.tmp
NUMOFLINES=$(wc -l ${DMRIDPATH}/DMRIds.tmp | awk '{print $1}')
if [ $NUMOFLINES -gt 1 ]
then
   mv ${DMRIDPATH}/DMRIds.tmp ${DMRIDFILE}
else
   echo " ERROR during file update "
   rm ${DMRIDPATH}/DMRIds.tmp
fi
# Restart ysf2dmr
eval ${RESTARTCOMMAND}
EOF
#######
sudo cat > /bin/menu <<- "EOF"
#!/bin/bash
while : ; do
choix=$(whiptail --title "TE1ws-Rev10d Raspbian Proyect HP3ICC Esteban Mackay 73." --menu "Suba o Baje con las flechas del teclado y seleccione el numero de opcion:" 24 58 15 \
1 " pYSFReflector " \
2 " YSF2DMR " \
3 " Salir del menu " 3>&1 1>&2 2>&3)
exitstatus=$?
#on recupere ce choix
#exitstatus=$?
if [ $exitstatus = 0 ]; then
    echo "Your chosen option:" $choix
else
    echo "You chose cancel."; break;
fi
# case : action en fonction du choix
case $choix in
1)
menu-ysf;;
2)
menu-ysf2dmr;;
3)
break;
esac
done
exit 0
EOF
##############################################
cat > /bin/menu-ysf <<- "EOF"
#!/bin/bash
while : ; do
choix=$(whiptail --title "Raspbian Proyect HP3ICC Menu YSFReflector" --menu "Suba o Baje con las flechas del teclado y seleccione el numero de opcion" 20 50 11 \
1 " Editar pYSFReflector Server " \
2 " Iniciar Reflector  " \
3 " Detener Reflector  " \
4 " Dashboard on  " \
5 " Dashboard off  " \
6 " Editar Puerto WebServer  " \
7 " Editar HTML  " \
8 " Menu Principal " 3>&1 1>&2 2>&3)
exitstatus=$?
#on recupere ce choix
#exitstatus=$?
if [ $exitstatus = 0 ]; then
    echo "Your chosen option:" $choix
else
    echo "You chose cancel."; break;
fi
# case : action en fonction du choix
case $choix in
1)
sudo nano /etc/YSFReflector/YSFReflector.ini ;;
2)
sudo systemctl stop YSFReflector.service && sudo systemctl start YSFReflector.service  && sudo systemctl enable YSFReflector.service ;;
3)
sudo systemctl stop YSFReflector.service && sudo systemctl disable YSFReflector.service ;;
4)
sudo systemctl restart logtailer-ysf.service && sudo systemctl enable logtailer-ysf.service && sudo systemctl restart http.server-ysf.service && sudo systemctl enable http.server-ysf.service ;;
5)
sudo systemctl stop logtailer-ysf.service && sudo systemctl disable logtailer-ysf.service && sudo systemctl stop http.server-ysf.service && sudo systemctl disable http.server-ysf.service ;;
6)
sudo nano /lib/systemd/system/http.server-ysf.service && sudo systemctl daemon-reload && sudo systemctl restart http.server-ysf.service ;;
7)
sudo nano /opt/WSYSFDash/html/index.html ;;
8)
break;
esac
done
exit 0
EOF
#########
cat > /bin/menu-ysf2dmr <<- "EOF"
#!/bin/bash
while : ; do
choix=$(whiptail --title "Raspbian Proyect HP3ICC Menu YSF2DMR" --menu "Suba o Baje con las flechas del teclado y seleccione el numero de opcion" 20 50 11 \
1 " Editar YSF2DMR " \
2 " Iniciar YSF2DMR " \
3 " Detener YSF2DMR " \
4 " Menu Principal " 3>&1 1>&2 2>&3)
exitstatus=$?
#on recupere ce choix
#exitstatus=$?
if [ $exitstatus = 0 ]; then
    echo "Your chosen option:" $choix
else
    echo "You chose cancel."; break;
fi
# case : action en fonction du choix
case $choix in
1)
sudo nano /opt/YSF2DMR/YSF2DMR.ini;;
2)
sudo sh /opt/YSF2DMR/DMRIDUpdate.sh && sudo systemctl enable dmrid-ysf2dmr.service;;
3)
sudo systemctl stop ysf2dmr.service && sudo systemctl stop dmrid-ysf2dmr.service && sudo systemctl disable dmrid-ysf2dmr.service;;
4)
break;
esac
done
exit 0
EOF
########
cp /bin/menu /bin/MENU
chmod +x /bin/MENU
chmod +x /bin/menu*
######
sudo chmod +777 /opt/WSYSFDash/*
sudo chmod +777 /opt/YSF2DMR/*
sudo chmod +777 /opt/YSF2DMR/YSF2DMR.ini
sudo chmod +777 /opt/MMDVM_CM/*

sudo chmod +x /opt/YSF2DMR/DMRIDUpdate.sh

sudo chmod 755 /lib/systemd/system/YSFReflector.service
sudo chmod 755 /lib/systemd/system/dmrid-ysf2dmr.service
sudo chmod 755 /lib/systemd/system/ysf2dmr.service
sudo chmod 755 /lib/systemd/system/http.server-ysf.service
sudo chmod 755 /lib/systemd/system/logtailer-ysf.service
sudo systemctl daemon-reload
