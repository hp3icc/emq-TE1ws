#!/bin/sh
echo Actualizando sistema 
apt-get update -y
apt-get upgrade -y
apt-get dist-upgrade -y
############################################
echo instalando pre-requisitos
######################################################################################################
#!/bin/sh
apt-get install sudo -y
sudo apt-get purge needrestart -y
sudo apt-get install wget -y
sudo apt-get install git -y
sudo apt-get install screen -y
sudo apt-get install gcc -y
sudo apt-get install g++ -y
sudo apt-get install make -y
sudo apt-get install cmake -y
sudo apt-get install musl-dev -y
sudo apt-get install python2 -y

update-alternatives --install /usr/bin/python python /usr/bin/python3 1

sudo apt-get install libasound2-dev -y
sudo apt-get install libudev-dev -y
sudo apt-get install libusb-1.0-0-dev -y
sudo apt-get install libgps-dev -y
sudo apt-get install libx11-dev -y
sudo apt-get install libfftw3-dev -y
sudo apt-get install libpulse-dev -y
sudo apt-get install build-essential -y
sudo apt-get install alsa-utils -y
sudo apt-get install rsyslog -y
sudo apt-get install logrotate -y
sudo apt-get install gpsd -y
sudo apt-get install qt4-qmake -y
sudo apt-get install libtool -y
sudo apt-get install autoconf -y
sudo apt-get install automake -y
sudo apt-get install python-pkg-resources -y
sudo apt-get install sox -y
sudo apt-get install git-core -y
sudo apt-get install libi2c-dev -y
sudo apt-get install i2c-tools -y
sudo apt-get install lm-sensors -y
sudo apt-get install wiringpi -y
sudo apt-get install chkconfig -y
sudo apt-get install wavemon -y
sudo apt-get install libffi-dev -y
sudo apt-get install libssl-dev -y
sudo apt-get install cargo -y 
sudo apt-get install sed -y
sudo apt install python3-pip -y
sudo apt install python3-distutils -y
sudo apt install python3-dev -y
sudo apt install python3-websockets
sudo apt install python3-psutil
sudo apt-get install python3-serial
sudo apt install python3-gpiozero -y
sudo apt-get install gpsd gpsd-clients python-gps -y
sudo apt install socket
sudo apt install threading
sudo apt install queue
sudo apt install sys
sudo apt install os
sudo apt install time
sudo apt install re
sudo apt install datetime
sudo apt install signal
sudo apt install datetime
sudo apt install bisect
sudo apt install struct
sudo apt install ansi2html
sudo apt install logrotate
sudo pip3 install ansi2html
sudo apt-get install python-pip -y
sudo apt-get install python-dev -y
sudo apt-get install rrdtool -y

##################
sudo cat > /opt/emq-ver <<- "EOF"
EMQ-VER:  20.8x
EOF
#########
sh -c "$(curl -fsSL https://raw.githubusercontent.com/hp3icc/emq-TE1ws/main/menu.sh)"
variable22=$(grep "EMQ-VER:" /opt/emq-ver | tail -c 5)
sudo sed -i "s/R00ab/$variable22/g"  /bin/menu
########################
sudo cat > /opt/obp.txt <<- "EOF"
 
#Coloque abajo su lista de obp y peer


EOF
####################
cd /home/
wget https://bootstrap.pypa.io/get-pip.py
sudo python3 get-pip.py
sudo cat > /home/requirements.txt <<- "EOF"
autobahn
jinja2==2.11.3
bitstring>=3.1.5
bitarray>=0.8.1
Twisted>=16.3.0
dmr_utils3>=0.1.19
configparser>=3.0.0
aprslib>=0.6.42
tinydb
pynmea2
maidenhead
requests
libscrc
flask
folium
mysql-connector
resettabletimer>=0.7.0
setproctitle


EOF
#
pip3 install setuptools wheel
pip3 install -r requirements.txt
sudo rm requirements.txt
sudo rm get-pip.py
#

mkdir /var/www
mkdir /var/www/html

mkdir /var/log/ysf2dmr
mkdir /var/log/mmdvm
mkdir /var/log/direwolf
mkdir /var/log/mmdvmh
mkdir /var/log/DMRGateway
mkdir /var/log/FreeDMR
mkdir /var/log/hblink
mkdir /var/log/YSFReflector
sudo chmod +777 /var/log
sudo chmod +777 /var/log/*

cat > /etc/default/gpsd  <<- "EOF"
USBAUTO="False"
DEVICES="/dev/ttyACM0"
START_DAEMON="true"
GPSD_OPTIONS="-n"
GPSD_SOCKET="/var/run/gpsd.sock"

EOF

sudo gpsd /dev/ttyACM0 -F /var/run/gpsd.sock
####################
echo iniciando instalacion

cd /opt
git clone https://github.com/iu5jae/pYSFReflector3.git
cd pYSFReflector3/
sudo chmod +x /opt/pYSFReflector3/*.py
sudo chmod +x /opt/pYSFReflector3/YSFReflector
#sudo sed -i 's/mmdvm/YSFReflector/' /opt/pYSFReflector3/pysfreflector.ini
sudo sed -i 's/0.0.0.0//' /opt/pYSFReflector3/pysfreflector.ini
sudo sed -i 's/pysfreflector/pYSFReflector3/' /opt/pYSFReflector3/pysfreflector.ini
sudo sed -i 's/enable = 0/enable = 1/' /opt/pYSFReflector3/pysfreflector.ini
sudo sed -i 's/aprs.grupporadiofirenze.net/noam.aprs2.net/' /opt/pYSFReflector3/pysfreflector.ini
sudo sed -i 's/ssid = -10/ssid = -7/' /opt/pYSFReflector3/pysfreflector.ini
sudo sed -i "s/FileLevel=1/FileLevel=0/g" /opt/pYSFReflector3/pysfreflector.ini
sudo sed -i "s/list = 1,9,50/list = /g" /opt/pYSFReflector3/pysfreflector.ini
sudo sed -i "s/default = 50/default = /g" /opt/pYSFReflector3/pysfreflector.ini
sudo sed -i "s/local = 1/local = /g" /opt/pYSFReflector3/pysfreflector.ini
sudo sed -i "s/prefix = 1/prefix = 0/g" /opt/pYSFReflector3/pysfreflector.ini
sudo sed -i "s/Timeout = 190/Timeout = 240/g" /opt/pYSFReflector3/pysfreflector.ini
#
sudo cat > /lib/systemd/system/YSFReflector.service <<- "EOF"
[Unit]
Description=YSFReflector
After=multi-user.target

[Service]
User=root
#ExecStartPre=/bin/sleep 30
ExecStart=/usr/bin/python3 /opt/pYSFReflector3/YSFReflector /opt/pYSFReflector3/pysfreflector.ini

[Install]
WantedBy=multi-user.target

EOF
###


sudo groupadd mmdvm
sudo useradd mmdvm -g mmdvm -s /sbin/nologin
sudo chown -R mmdvm:mmdvm /var/log/YSFReflector

###############################

mkdir /opt/YSF2DMR

cd /opt/
git clone https://github.com/juribeparada/MMDVM_CM.git
sudo cp -r /opt/MMDVM_CM/YSF2DMR /opt/
cd YSF2DMR
sudo make
sudo make install
sudo cp -r /opt/YSF2DMR/ /opt/YSF2DMRGW
wget -O /opt/YSF2DMRGW/TGList-DMR.txt http://freedmr-hp.ddns.net/downloads/TGList_BM.txt
sudo chmod +x /opt/YSF2DMRGW/*

sudo apt-get install zip gzip tar -y

cd /opt/
wget https://github.com/hp3icc/emq-TE1ws/raw/main/rtl-sdr-te1ws.zip
sudo unzip rtl-sdr-te1ws.zip
sudo rm rtl-sdr-te1ws.zip
cd rtl-sdr/
sudo mkdir build
cd build
cmake ../ -DINSTALL_UDEV_RULES=ON
sudo make
sudo make install
sudo ldconfig
sudo cp /opt/rtl-sdr/rtl-sdr.rules /etc/udev/rules.d

cd /opt/
git clone https://github.com/asdil12/kalibrate-rtl.git
cd kalibrate-rtl/
sudo chmod +x bootstrap
sudo chmod +x configure
./bootstrap
./configure
sudo make
sudo make install

##################################################################
#multimon-ng
cd /opt
git clone https://github.com/EliasOenal/multimon-ng.git
cd multimon-ng/
mkdir build
cd build
cmake ..
make
sudo make install

cd /opt
git clone https://github.com/asdil12/pymultimonaprs.git
cd pymultimonaprs
sudo python2 setup.py install

############################################################################################
#web
cd /opt/
git clone --recurse-submodules -j8 https://github.com/dg9vh/MMDVMHost-Websocketboard
sudo chown -R mmdvm:mmdvm /opt/MMDVMHost-Websocketboard
#
sudo sed '264 a <!--' -i /opt/MMDVMHost-Websocketboard/html/index.html 
sudo sed '266 a -->' -i /opt/MMDVMHost-Websocketboard/html/index.html 

sudo sed -i "s/\`Custom-Headline-Text\`/\`Websocket-Based\`/g"  /opt/MMDVMHost-Websocketboard/html/js/config.js
sudo sed -i "s/about = 1/about = 0/g" /opt/MMDVMHost-Websocketboard/html/js/config.js
sudo sed -i "s/currtx = 1/currtx = 0/g" /opt/MMDVMHost-Websocketboard/html/js/config.js
sudo sed -i "s/qso = 1/qso = 0/g" /opt/MMDVMHost-Websocketboard/html/js/config.js
sudo sed -i "s/dapnet = 1/dapnet = 0/g" /opt/MMDVMHost-Websocketboard/html/js/config.js

sudo sed -i "s/DGIdGateway/YSFGateway/g" /opt/MMDVMHost-Websocketboard/logtailer.ini
sudo sed -i "s/BinaryName5/#BinaryName5/g" /opt/MMDVMHost-Websocketboard/logtailer.ini
sudo sed -i 's/Logdir=\/mnt\/ramdisk/Logdir=\/var\/log\/mmdvmh/' /opt/MMDVMHost-Websocketboard/logtailer.ini
sudo sed -i 's/5678/5679/' /opt/MMDVMHost-Websocketboard/logtailer.ini
sudo sed -i 's/Filerotate=True/Filerotate=False/' /opt/MMDVMHost-Websocketboard/logtailer.ini
sudo sed -i 's/etc\/MMDVM/opt\/MMDVMHost/' /opt/MMDVMHost-Websocketboard/logtailer.ini
sudo sed -i 's/usr\/local\/bin/opt\/MMDVMHost/' /opt/MMDVMHost-Websocketboard/logtailer.ini
sudo sed -i 's/Prefix=MMDVM/Prefix=MMDVMH/' /opt/MMDVMHost-Websocketboard/logtailer.ini
#
cd /opt/MMDVMHost-Websocketboard/html/
sudo sed -i 's/5678/5679/' /opt/MMDVMHost-Websocketboard/html/index.html
sudo sed -i 's/<span class="navbar-brand float:center"><script type="text\/javascript">document.write(customHeadlineText);<\/script><\/span>/<span style="color: #808080;" class="navbar-brand float:center"><script type="text\/javascript">document.write(customHeadlineText);<\/script><\/span>/g'  /opt/MMDVMHost-Websocketboard/html/index.html
sudo sed -i 's/<script type="text\/javascript">document.write(customText);<\/script>/<span style="color: #3cff33;"><script type="text\/javascript">document.write(customText);<\/script>/g'  /opt/MMDVMHost-Websocketboard/html/index.html
sudo sed -i 's/This is an example/MMDVMHost Dashboard/' /opt/MMDVMHost-Websocketboard/html/js/config.js
sudo sed -i 's/you can use all html-tags and multiline-text./MMDVMHost-Websocketboard by DG9VH/' /opt/MMDVMHost-Websocketboard/html/js/config.js
sudo sed -i 's/<span class="navbar-brand float:right">Websocket-Based<\/span>/<span style="color: #808080;" <li>Temperature: <span id="cputemp"><\/span> °C<\/li>/g'  /opt/MMDVMHost-Websocketboard/html/index.html
sudo sed -i 's/<a class="navbar-brand" href="#">MMDVM-Dashboard by DG9VH<\/a>/<h6 style="text-align: center;"><span style="color: #808080;"><a style="color: #808080;" href="https:\/\/github.com\/hp3icc\/emq-TE1ws\/" target="_blank">emq-te1ws Raspbian Proyect by hp3icc<\/a> copyright 2018-YK00<\/span><\/h6>/g'  /opt/MMDVMHost-Websocketboard/html/index.html
variable2=$(date +'%Y' | tail -c 5)
sudo sed -i "s/YK00/$variable2/g"  /opt/MMDVMHost-Websocketboard/html/index.html

############################
cat > /lib/systemd/system/http.server-mmdvmh.service <<- "EOF"
[Unit]
Description=Python3 http.server.mmdvmhost
After=network.target

[Service]
User=root
ExecStartPre=/bin/sleep 30
# Modify for different location of Python3 or other port
ExecStart=/usr/bin/python3 -m http.server 80 --directory /opt/MMDVMHost-Websocketboard/html

[Install]
WantedBy=multi-user.target


EOF
#
cat > /lib/systemd/system/logtailer-mmdvmh.service <<- "EOF"
[Unit]
Description=Python3 logtailer for MMDVMDash
After=network.target

[Service]
Type=simple
User=mmdvm
Group=mmdvm
Restart=always
ExecStartPre=/bin/sleep 30
# Modify for different location of Python3 or other port
WorkingDirectory=/opt/MMDVMHost-Websocketboard/
ExecStart=/usr/bin/python3 /opt/MMDVMHost-Websocketboard/logtailer.py

[Install]
WantedBy=multi-user.target


EOF
#
cd /opt/
git clone --recurse-submodules -j8 https://github.com/dg9vh/WSYSFDash
cd /opt/WSYSFDash/
sudo chown -R mmdvm /opt/WSYSFDash
#
sudo sed -i "s/\/usr\/local\/bin\/YSFReflector/\/opt\/pYSFReflector3\/YSFReflector/g" /opt/WSYSFDash/logtailer.ini
sudo sed -i "s/Filerotate=True/Filerotate=False/g" /opt/WSYSFDash/logtailer.ini
sudo sed -i "s/YSFReflector1/mmdvm/g" /opt/WSYSFDash/logtailer.ini
#
cat > /lib/systemd/system/http.server-ysf.service <<- "EOF"
[Unit]
Description=Python3 http.server-ysf
After=network.target

[Service]
User=root
ExecStartPre=/bin/sleep 45
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
wget -O /opt/MMDVMHost-Websocketboard/html/data/TG_List.csv https://raw.githubusercontent.com/hp3icc/emq-TE1ws/main/TG_List.csv
#
cat > /lib/systemd/system/rebooter1.service  <<- "EOF"
[Unit]
Description=Rebooter
#Wants=network-online.target
#After=syslog.target network-online.target

[Service]
User=root
ExecStart=/usr/local/bin/rebooter1.sh

[Install]
WantedBy=default.target

EOF
####################################

cd /boot
sudo sed -i 's/console=serial0,115200 //' cmdline.txt

sudo systemctl stop serial-getty@ttyAMA0.service
sudo systemctl stop bluetooth.service
sudo systemctl disable serial-getty@ttyAMA0.service
sudo systemctl disable bluetooth.service

sudo sed -i 's/#dtparam=i2c_arm=on/dtparam=i2c_arm=on/' config.txt
sudo sed -i 's/dtparam=audio=on/#dtparam=audio=on/' config.txt

echo "enable_uart=1" >> config.txt
echo "dtoverlay=pi3-disable-bt" >> config.txt
echo "dtparam=spi=on" >> config.txt

##################
cat > /lib/systemd/system/monp.service  <<- "EOF"
[Unit]
Description=sudo modprobe i2c-dev
#Wants=network-online.target
#After=syslog.target network-online.target
[Service]
User=root
#ExecStartPre=/bin/sleep 1800
ExecStart=sudo modprobe i2c-dev
[Install]
WantedBy=multi-user.target
EOF

##########
cd /opt
git clone https://github.com/IZ7BOJ/direwolf_webstat.git
#cd /opt/direwolf_webstat
sudo sed -i "s/144.800  VHF Port/144.390MHz VHF APRS/g" /opt/direwolf_webstat/config.php 
sudo sed -i "s/0,1/0/g" /opt/direwolf_webstat/config.php 
#
sudo cat > /lib/systemd/system/http.server-dw.service <<- "EOF"
[Unit]
Description=PHP http.server.DW
After=network.target

[Service]
User=root
#ExecStartPre=/bin/sleep 30
# Modify for different other port
ExecStart=php -S 0.0.0.0:80 -t /opt/direwolf_webstat/

[Install]
WantedBy=multi-user.target

EOF
##############################
cat > /usr/local/bin/rpt-on.sh <<- "EOF"
#!/bin/bash
#TI4OP Oscar, [1/25/2022 12:51 PM]
if [ "$(grep "Duplex=" /opt/MMDVMHost/MMDVM.ini | tail -c 2 | grep '1')" != "" ]; then
# echo "rpt"
sudo systemctl enable mmdvmh.service

else
#  echo "gateway"
sudo systemctl disable mmdvmh.service

fi
EOF
#
sudo chmod +x /usr/local/bin/rpt-on.sh
#########################
cd /opt
git clone https://github.com/g4klx/MMDVMHost.git
cd MMDVMHost/
sudo make
sudo make install
git clone https://github.com/hallard/ArduiPi_OLED
cd ArduiPi_OLED
sudo make
cd /opt/MMDVMHost/
make clean
sudo make -f Makefile.Pi.OLED 

groupadd mmdvm 
useradd mmdvm -g mmdvm -s /sbin/nologin 
chown mmdvm /var/log/

#############################################################################################################################################################
cd /opt/	
git clone https://github.com/g4klx/DMRGateway.git
cd DMRGateway
sudo make clean
sudo make
sudo make install

##########

sudo cat > /usr/local/bin/rebooter1.sh <<- "EOF"
#!/bin/bash
sleep 180
while :
do
SERVER=noip.com

ping -c1 ${SERVER} > /dev/null

if [ $? != 0 ]
then
#
sudo reboot

fi


  sleep 60
done

EOF
#
cat > /lib/systemd/system/http.server-dvs.service <<- "EOF"
[Unit]
Description=PHP http.server.DVS
After=network.target

[Service]
User=root
#ExecStartPre=/bin/sleep 30
# Modify for different other port
ExecStart=php -S 0.0.0.0:80 -t /var/www/dvs/
[Install]
WantedBy=multi-user.target



EOF
#
########ionosphere
mkdir /opt/ionsphere 
cd /opt/ionsphere 
wget https://github.com/cceremuga/ionosphere/releases/download/v1.0.0-beta1/ionosphere-raspberry-pi.tar.gz
tar vzxf ionosphere-raspberry-pi.tar.gz

cd /opt/ionsphere/ionosphere-raspberry-pi

cat > /opt/ionsphere/ionosphere-raspberry-pi/ionos.sh <<- "EOF"
#!/bin/sh
PATH=/bin:/usr/bin:/usr/local/bin
unset LANG
/opt/ionsphere/ionosphere-raspberry-pi/ionosphere
EOF

sudo chmod +x /opt/ionsphere/ionosphere-raspberry-pi/ionosphere
sudo chmod +x /opt/ionsphere/ionosphere-raspberry-pi/ionos.sh
chmod +777 /opt/ionsphere/ionosphere-raspberry-pi/ionos.sh
###nano /opt/ionsphere/ionosphere-raspberry-pi/config/config.yml

#########
cat > /lib/systemd/system/ionos.service <<- "EOF"
[Unit]
Description=Ionphere-RTL Service
Wants=network-online.target
After=syslog.target network-online.target
[Service]
User=root
Type=simple
Restart=always
RestartSec=3
StandardOutput=null
WorkingDirectory=/opt/ionsphere/ionosphere-raspberry-pi
#ExecStartPre=/bin/sleep 30
ExecStartPre=/bin/sh -c 'until ping -c1 noip.com; do sleep 1; done;'
ExecStart=sh /opt/ionsphere/ionosphere-raspberry-pi/ionos.sh
ExecReload=/bin/kill -HUP $MAINPID
KillMode=process
[Install]
# To make the network-online.target available
# systemctl enable systemd-networkd-wait-online.service
WantedBy=network-online.target
EOF
##########################################
sudo cat > /opt/extra-1.sh <<- "EOF"
######################################################################
# Coloque en este archivo, cualquier instruccion shell adicional que # 
# quierre se realice al finalizar la actualizacion.                  #
######################################################################
 
  


EOF
# 
cp /opt/extra-1.sh /opt/extra-2.sh
cp /opt/extra-1.sh /opt/extra-3.sh
cp /opt/extra-1.sh /opt/extra-4.sh
cp /opt/extra-1.sh /opt/extra-5.sh
cp /opt/extra-1.sh /opt/extra-6.sh
sudo chmod +x /opt/extra-*
###################
cat > /lib/systemd/system/dmrid-mmdvm.service  <<- "EOF"
[Unit]
Description=DMRIDupdate MMDVMHost
Wants=network-online.target
After=syslog.target network-online.target

[Service]
User=root
#ExecStartPre=/bin/sleep 1800
ExecStartPre=/bin/sh -c 'until ping -c1 noip.com; do sleep 1; done;'
ExecStart=/opt/MMDVMHost/DMRIDUpdate.sh

[Install]
WantedBy=multi-user.target

EOF
###################
cat > /lib/systemd/system/mmdvmh.service  <<- "EOF"
[Unit]
Description=MMDVM Host Service
After=syslog.target network.target

[Service]
User=root
Type=simple
Restart=always
RestartSec=3
StandardOutput=null
WorkingDirectory=/opt/MMDVMHost
#ExecStartPre=/bin/sleep 10
ExecStartPre=/bin/sh -c 'until ping -c1 noip.com; do sleep 1; done;'
ExecStart=/opt/MMDVMHost/MMDVMHost /opt/MMDVMHost/MMDVM.ini
ExecStop=/usr/bin/screen -S MMDVMHost -X quit

[Install]
WantedBy=multi-user.target

EOF
#
cat > /lib/systemd/system/dmrgw.service  <<- "EOF"
[Unit]
Description=DMRGateway Service
After=syslog.target network.target
 
[Service]
User=root
Type=simple
Restart=always
RestartSec=3
StandardOutput=null
WorkingDirectory=/opt/DMRGateway
#ExecStartPre=/bin/sleep 10
ExecStartPre=/bin/sh -c 'until ping -c1 noip.com; do sleep 1; done;'
ExecStart=/usr/local/bin/DMRGateway /opt/DMRGateway/DMRGateway.ini
ExecStop=/usr/bin/screen -S DMRGateway -X quit
 
[Install]
WantedBy=multi-user.target
 
EOF
###############
cat > /lib/systemd/system/direwolf.service  <<- "EOF"
[Unit]
Description=DireWolf is a software "soundcard" modem/TNC and APRS decoder
Documentation=man:direwolf
AssertPathExists=/opt/direwolf/dw.conf

[Unit]
Description=Direwolf Service
#Wants=network-online.target
After=sound.target syslog.target
#network-online.target

[Service]
User=root
Type=simple
Restart=always
RestartSec=3
StandardOutput=null
ExecStart=sudo direwolf -c /opt/direwolf/dw.conf

[Install]
WantedBy=multi-user.target

EOF
#####
cat > /lib/systemd/system/dmrid-ysf2dmr.service  <<- "EOF"
[Unit]
Description=DMRIDupdate YSF2DMR
Wants=network-online.target
After=syslog.target network-online.target

[Service]
User=root
#ExecStartPre=/bin/sleep 60
ExecStartPre=/bin/sh -c 'until ping -c1 noip.com; do sleep 1; done;'
ExecStart=/opt/YSF2DMR/DMRIDUpdate.sh

[Install]
WantedBy=multi-user.target

EOF
#########
cat > /lib/systemd/system/direwolf-rtl.service  <<- "EOF"
[Unit]
Description=Direwolf-RTL Service
Wants=network-online.target
After=syslog.target network-online.target

[Service]
User=root
Type=simple
Restart=always
RestartSec=3
StandardOutput=null
ExecStartPre=/bin/sh -c 'until ping -c1 noip.com; do sleep 1; done;'
ExecStart=/opt/direwolf/rtl.sh
# | direwolf -c /home/pi/direwolf/sdr.conf

[Install]
WantedBy=multi-user.target
#ExecStart= /usr/local/bin/rtl_fm -M fm -f 144.39M -p 0 -s 22050 -g 42 - | /usr/local/bin/direwolf -c /opt/direwolf/sdr.conf -r 22050 -D 1 -B 1200 -
EOF
#############

cat > /lib/systemd/system/multimon-rtl.service  <<- "EOF"
[Unit]
Description=Multimon-RTL Service
Wants=network-online.target
After=syslog.target network-online.target

[Service]
User=root
Type=simple
Restart=always
RestartSec=3
StandardOutput=null
ExecStartPre=/bin/sh -c 'until ping -c1 noip.com; do sleep 1; done;'
ExecStart=sudo pymultimonaprs

[Install]
WantedBy=multi-user.target
EOF
#####################
cat > /lib/systemd/system/ysf2dmr.service  <<- "EOF"
[Unit]
Description=YSF2DMR Service
After=syslog.target network.target

[Service]
User=root
Type=simple
Restart=always
RestartSec=3
StandardOutput=null
WorkingDirectory=/opt/YSF2DMR
#ExecStartPre=/bin/sleep 30
ExecStartPre=/bin/sh -c 'until ping -c1 noip.com; do sleep 1; done;'
ExecStart=/opt/YSF2DMR/YSF2DMR /opt/YSF2DMR/YSF2DMR.ini

[Install]
WantedBy=multi-user.target

EOF
###########################
cat > /lib/systemd/system/ysf2dmrgw.service  <<- "EOF"
[Unit]
Description=YSF2DMRGW Service
After=syslog.target network.target

[Service]
User=root
Type=simple
Restart=always
RestartSec=3
StandardOutput=null
WorkingDirectory=/opt/YSF2DMRGW
#ExecStartPre=/bin/sleep 30
ExecStartPre=/bin/sh -c 'until ping -c1 noip.com; do sleep 1; done;'
ExecStart=/opt/YSF2DMRGW/YSF2DMR /opt/YSF2DMRGW/YSF2DMR.ini

[Install]
WantedBy=multi-user.target

EOF
###########################
cat > /opt/MMDVMHost/MMDVM.ini  <<- "EOF"
[General]
# Coloque su indicativo
Callsign=HP3ICC
# Coloque su DMRID de 7 digitos mas 2 digitos para su conexion
Id=000000000
Timeout=300
Duplex=0
ModeHang=10
#RFModeHang=10
#NetModeHang=3
Display=None
#Display=OLED
#Display=Nextion
Daemon=0

[Info]
# Colocar frecuencia 9 digitos sin puntos
RXFrequency=433400000
TXFrequency=433400000
Power=1
# The following lines are only needed if a direct connection to a DMR master is being used
Latitude=0.0
Longitude=0.0
Height=0
Location=Panama
Description=emq-TE1ws-MMDVM
URL=https://github.com/hp3icc/emq-TE1ws

[Log]
# Logging levels, 0=No logging
DisplayLevel=1
FileLevel=1
FilePath=/var/log/mmdvmh
FileRoot=MMDVMH
FileRotate=0

[CW Id]
Enable=0
Time=10
# Callsign=

[DMR Id Lookup]
File=/opt/MMDVMHost/DMRIds.dat
Time=24

[NXDN Id Lookup]
File=/opt/MMDVMHost/NXDN.csv
Time=24

[Modem]
# Valid values are "null", "uart", "udp", and (on Linux) "i2c"
Protocol=uart
# The port and speed used for a UART connection
# UARTPort=\\.\COM4
# UARTPort=/dev/ttyACM0
UARTPort=/dev/ttyAMA0
UARTSpeed=115200
#460800
# The port and address for an I2C connection
I2CPort=/dev/i2c
I2CAddress=0x22
# IP parameters for UDP connection
ModemAddress=192.168.2.100
ModemPort=3334
LocalAddress=192.168.2.1
LocalPort=3335

TXInvert=1
RXInvert=0
PTTInvert=0
TXDelay=100
RXOffset=0
TXOffset=0
DMRDelay=0
RXLevel=50
TXLevel=50
RXDCOffset=0
TXDCOffset=0
RFLevel=50
# CWIdTXLevel=50
# D-StarTXLevel=50
DMRTXLevel=50
YSFTXLevel=50
# P25TXLevel=50
# NXDNTXLevel=50
# M17TXLevel=50
# POCSAGTXLevel=50
# FMTXLevel=50
# AX25TXLevel=50
RSSIMappingFile=RSSI.dat
UseCOSAsLockout=0
Trace=0
Debug=0

[Transparent Data]
Enable=0
RemoteAddress=127.0.0.1
RemotePort=40094
LocalPort=40095
# SendFrameType=0

[D-Star]
Enable=0
Module=C
SelfOnly=0
AckReply=1
AckTime=750
AckMessage=0
ErrorReply=1
RemoteGateway=0
# ModeHang=10
WhiteList=

[DMR]
Enable=1
Beacons=0
BeaconInterval=60
BeaconDuration=3
ColorCode=1
SelfOnly=0
EmbeddedLCOnly=1
DumpTAData=0
# Prefixes=234,235
# Slot1TGWhiteList=
# Slot2TGWhiteList=
CallHang=3
TXHang=4
# ModeHang=10
# OVCM Values, 0=off, 1=rx_on, 2=tx_on, 3=both_on, 4=force off
# OVCM=0

[System Fusion]
Enable=1
LowDeviation=0
SelfOnly=0
TXHang=4
RemoteGateway=0
# ModeHang=10

[P25]
Enable=0
NAC=293
SelfOnly=0
OverrideUIDCheck=0
RemoteGateway=0
TXHang=5
# ModeHang=10

[NXDN]
Enable=0
RAN=1
SelfOnly=0
RemoteGateway=0
TXHang=5
# ModeHang=10

[M17]
Enable=0
CAN=0
SelfOnly=0
TXHang=5
# ModeHang=10

[POCSAG]
Enable=0
Frequency=439987500

[FM]
Enable=0
# Callsign=G4KLX
CallsignSpeed=20
CallsignFrequency=1000
CallsignTime=10
CallsignHoldoff=0
CallsignHighLevel=50
CallsignLowLevel=20
CallsignAtStart=1
CallsignAtEnd=1
CallsignAtLatch=0
RFAck=K
ExtAck=N
AckSpeed=20
AckFrequency=1750
AckMinTime=4
AckDelay=1000
AckLevel=50
# Timeout=180
TimeoutLevel=80
CTCSSFrequency=88.4
CTCSSThreshold=30
# CTCSSHighThreshold=30
# CTCSSLowThreshold=20
CTCSSLevel=20
KerchunkTime=0
HangTime=7
# AccessMode values are:
#   0 - Carrier access with COS
#   1 - CTCSS only access without COS
#   2 - CTCSS only access with COS
#   3 - CTCSS only access with COS to start, then carrier access with COS
AccessMode=1
# LinkMode=1 to remove almost all of the logic control
LinkMode=0
COSInvert=0
NoiseSquelch=0
SquelchThreshold=30
# SquelchHighThreshold=30
# SquelchLowThreshold=20
RFAudioBoost=1
MaxDevLevel=90
ExtAudioBoost=1
# ModeHang=10

[AX.25]
Enable=0
TXDelay=300
RXTwist=6
SlotTime=30
PPersist=128
Trace=1

[D-Star Network]
Enable=0
#LocalAddress=127.0.0.1
#LocalPort=20011
GatewayAddress=127.0.0.1
GatewayPort=20010
# ModeHang=3
Debug=0

[DMR Network]
Enable=1
# habilitar , o deshabilitar todas las lineas de 'Direct' o 'Gateway'
# quitando los simbolos # segun su tipo de conexion.
#
# Configuracion Gateway , habilita DMRGateway, conexion multiples server dmr.
# configuracion Direct , habilita conexion directa a un solo server dmr.
#
#########################################################
#       Gateway   -    Multiples Server - DMRGateway    #
#########################################################
Type=Gateway
LocalAddress=127.0.0.1
LocalPort=62034
RemoteAddress=127.0.0.1
RemotePort=62033
#
#########################################################
#       Direct    -     single server                   #
#########################################################
#Type=Direct
#RemoteAddress=198.211.36.245
#RemotePort=62031
#Password=passw0rd
#
#########################################################
Jitter=500
Slot1=1
Slot2=1
# No active linea de Option para TG estaticos, si utiliza BM,TGIF,DMR-Central
# Puede activar linea de option de selfcare FDMR-Mon y colocar su propia contraseña o 
# utilizar linea de options con opciones de tg estaticos
#Options=PASS=abc123
#Options=TS2=714,7144;DIAL=0;VOICE=0;LANG=es_ES;SINGLE=0;TIMER=10;
# ModeHang=3
Debug=0


[System Fusion Network]
Enable=1
# habilitar , o deshabilitar todas las lineas de 'Direct' o 'Gateway'
# quitando los simbolos # segun su tipo de conexion.
#
# Configuracion Gateway , habilita YSFGateway, WiresXCommandPassthrough.
# configuracion Direct , habilita conexion directa a un solo server YSF.
#
#########################################################
#       Gateway mode  -    Multiples Server - DMRGateway    #
#########################################################
#
#LocalAddress=127.0.0.1
#LocalPort=3330
#GatewayAddress=127.0.0.1
#GatewayPort=4330
#
#########################################################
#       Direct mode   -    Multiples Server - DMRGateway    #
#########################################################
#
GatewayAddress=europelink.pa7lim.nl
GatewayPort=42000
#
##########################################################
# ModeHang=3
Debug=0

[P25 Network]
Enable=0
#LocalAddress=127.0.0.1
#LocalPort=32010
GatewayAddress=127.0.0.1
GatewayPort=42020
# ModeHang=3
Debug=0

[NXDN Network]
Enable=0
Protocol=Icom
#LocalAddress=127.0.0.1
#LocalPort=14021
GatewayAddress=127.0.0.1
GatewayPort=14020
# ModeHang=3
Debug=0

[M17 Network]
Enable=0
#LocalAddress=127.0.0.1
#LocalPort=17011
GatewayAddress=127.0.0.1
GatewayPort=17010
# ModeHang=3
Debug=0

[POCSAG Network]
Enable=0
#LocalAddress=127.0.0.1
#LocalPort=3800
GatewayAddress=127.0.0.1
GatewayPort=4800
# ModeHang=3
Debug=0

[FM Network]
Enable=0
# Protocol=USRP
#LocalAddress=127.0.0.1
#LocalPort=3810
GatewayAddress=127.0.0.1
GatewayPort=4810
PreEmphasis=1
DeEmphasis=1
TXAudioGain=1.0
RXAudioGain=1.0
# ModeHang=3
Debug=0

[AX.25 Network]
Enable=0
Port=/dev/ttyp7
Speed=9600
Debug=0

[TFT Serial]
# Port=modem
Port=/dev/ttyAMA0
Brightness=50

[HD44780]
Rows=2
Columns=16

# For basic HD44780 displays (4-bit connection)
# rs, strb, d0, d1, d2, d3
Pins=11,10,0,1,2,3

# Device address for I2C
I2CAddress=0x20

# PWM backlight
PWM=0
PWMPin=21
PWMBright=100
PWMDim=16

DisplayClock=1
UTC=0

[Nextion]
Port=modem
#Port=/dev/ttyAMA0
Brightness=50
DisplayClock=1
UTC=0
#Screen Layout: 0=G4KLX 2=ON7LDS
ScreenLayout=2
IdleBrightness=20

[OLED]
Type=3
Brightness=1
Invert=0
Scroll=0
Rotate=1
Cast=0
LogoScreensaver=0

[LCDproc]
Address=localhost
Port=13666
#LocalPort=13667
DimOnIdle=0
DisplayClock=1
UTC=0

[Lock File]
Enable=0
File=/tmp/MMDVM_Active.lck

[Remote Control]
Enable=0
Address=127.0.0.1
Port=7642


EOF
########
cat > /opt/DMRGateway/DMRGateway.ini  <<- "EOF"
[General]
Timeout=10
# RFTimeout=10
# NetTimeout=7
RptAddress=127.0.0.1
RptPort=62034
LocalAddress=127.0.0.1
LocalPort=62033
RuleTrace=0
Daemon=0
Debug=0

[Log]
# Logging levels, 0=No logging
DisplayLevel=1
FileLevel=1
FilePath=.
FileRoot=DMRGateway
FileRotate=1

[Voice]
Enabled=1
Language=es_ES
Directory=./Audio

[Info]
Latitude=0.0
Longitude=0.0
Height=0
Location=DMR Gateway
Description=Multi-Mode DMRGateway
URL=https://github.com/hp3icc/emq-TE1ws

[XLX Network]
#DMRID 7 DIGIT ONLY
Id=1234567 
Enabled=0
File=/opt/DMRGateway/XLXHosts.txt
Port=62030
Password=passw0rd
ReloadTime=60
# Local=3351
Slot=2
TG=6
Base=64000
Startup=HP3
Relink=10
Debug=0
#Allow user linking control using Private Calls
UserControl=1
#Override default module for startup reflector
Module=A

# BrandMeister
[DMR Network 1]
#Id=000000000
Enabled=1
Name=BrandMeister
Address=3021.master.brandmeister.network
Port=62031
TGRewrite0=2,1000001,2,1,999999
PCRewrite=2,1000001,2,1,999999
PassAllPC=1
PassAllPC=2
Password=passw0rd
Location=1
Debug=0

# FreeDMR
[DMR Network 2]
#Id=000000000
Enabled=1
Name=FreeDMR
TGRewrite0=2,2000001,2,1,999999
PCRewrite=2,2000001,2,1,999999
# Puede activar linea de options de selfcare y colocar su propia contraseña o 
# utilizar linea de options con opciones de tg estaticos 
Options="PASS=abc123"
#Options="TS2=714,7144;DIAL=0;VOICE=0;LANG=es_ES;SINGLE=1;TIMER=10;"
Address=198.211.36.245
Password=passw0rd
Port=62031
Location=0
Debug=0


# TGIF Network
[DMR Network 3]
#Id=000000000
Enabled=1
Name=TGIF_Network
TGRewrite0=2,3000001,2,1,999999
PCRewrite=2,3000001,2,1,999999
#Options=
Address=tgif.network
Password=passw0rd
Port=62031
Location=0
Debug=0

# DMR Central
[DMR Network 4]
#Id=000000000
Enabled=1
Name=DMR Central
Address=dmr.pa7lim.nl
Port=55555
TGRewrite0=2,4000001,2,1,999999
PCRewrite=2,4000001,2,1,999999
#Options=
Password=passw0rd
Location=0
Debug=0

# FreeStar Network
[DMR Network 5]
#Id=000000000
Enabled=1
Name=FreeStar
Address=es.freestar.network
Port=62031
TGRewrite0=2,5000001,2,1,999999
PCRewrite=2,5000001,2,1,999999
Options="TS2=7144;DIAL=0;VOICE=0;LANG=0;SINGLE=0;TIMER=10;"
Password=passw0rd
Location=0
Debug=0


[GPSD]
Enable=0
Address=127.0.0.1
Port=2947

[APRS]
Enable=0
Address=127.0.0.1
Port=8673
Description=APRS Description
Suffix=3

[Dynamic TG Control]
Enabled=1
Port=3769

[Remote Control]
Enable=0
Address=127.0.0.1
Port=7643


EOF
#########
cat > /opt/YSF2DMR/YSF2DMR.ini  <<- "EOF"
[Info]
RXFrequency=438800000
TXFrequency=438800000
Power=1
Latitude=0.0
Longitude=0.0
Height=0
Location=YSF2DMR Link
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
#XLXFile=/opt/DMRGateway/XLXHosts.txt
#XLXReflector=HP3
#XLXModule=D
StartupDstId=714
# For TG call: StartupPC=0
StartupPC=0
Address=127.0.0.1
Port=54102
Jitter=500
EnableUnlink=0
TGUnlink=4000
PCUnlink=0
# Local=62032
Password=passw@rd

# No active linea de Option para TG estaticos, si utiliza BM,TGIF,DMR-Central
# Puede activar linea de option de selfcare FDMR-Mon y colocar su propia contraseña o 
# utilizar linea de options con opciones de tg estaticos
#Options=PASS=abc123
#Options=TS2=714;DIAL=0;VOICE=0;LANG=es_ES;SINGLE=0;TIMER=10;

TGListFile=/opt/YSF2DMRGW/TGList-DMR.txt
Debug=0

[DMR Id Lookup]
File=/opt/MMDVMHost/DMRIds.dat
Time=24
DropUnknown=0

[Log]
# Logging levels, 0=No logging
DisplayLevel=1
FileLevel=1
FilePath=/var/log/ysf2dmr/
FileRoot=YSF2DMR2

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
cat > /opt/YSF2DMRGW/YSF2DMR.ini  <<- "EOF"
[Info]
RXFrequency=438800000
TXFrequency=438800000
Power=1
Latitude=0.0
Longitude=0.0
Height=0
Location=YSF2DMRGW
Description=Multi-Mode
URL=www.google.co.uk

[YSF Network]
Callsign=HP3ICC
Suffix=ND
#Suffix=RPT
DstAddress=127.0.0.1
DstPort=42400
LocalAddress=127.0.0.1
LocalPort=42018
EnableWiresX=1
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
Id=000000000
#XLXFile=/opt/DMRGateway/XLXHosts.txt
#XLXReflector=HP3
#XLXModule=D
StartupDstId=9
# For TG call: StartupPC=0
StartupPC=0
Address=freedmr-hp.ddns.net
Port=62031
Jitter=500
EnableUnlink=0
TGUnlink=4000
PCUnlink=0
# Local=62032
Password=passw0rd

# No active linea de Option para TG estaticos, si utiliza BM,TGIF,DMR-Central
# Puede activar linea de option de selfcare FDMR-Mon y colocar su propia contraseÃ±a o 
# utilizar linea de options con opciones de tg estaticos
Options=PASS=abc123
#Options=TS2=714;DIAL=0;VOICE=0;LANG=es_ES;SINGLE=0;TIMER=10;

TGListFile=/opt/YSF2DMRGW/TGList-DMR.txt
Debug=0

[DMR Id Lookup]
File=/opt/MMDVMHost/DMRIds.dat
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

cat > /etc/pymultimonaprs.json  <<- "EOF"
{
        "callsign": "HP3ICC-10",
        "passcode": "12345",
        "gateway": ["igates.aprs.fi:14580","noam.aprs2.net:14580"],
        "preferred_protocol": "any",
        "append_callsign": true,
        "source": "rtl",
        "rtl": {
                "freq": 144.390,
                "ppm": 0,
                "gain": 24,
                "offset_tuning": false,
                "device_index": 0
        },
        "alsa": {
                "device": "default"
        },
        "beacon": {
                "lat": 8.5212,
                "lng": -80.3598,
                "table": "/",
                "symbol": "r",
                "comment": "APRS RX-IGATE / Raspbian Proyect by hp3icc",
                "status": {
                        "text": "",
                        "file": false
                },
                "weather": false,
                "send_every": 300,
                "ambiguity": 0
        }
}
EOF
#######
cat > /opt/ionsphere/ionosphere-raspberry-pi/config/config.yml  <<- "EOF"
rtl:
  path: "rtl_fm"
  frequency: "144.390M"
  gain: "49.6"
  ppm-error: "0"
  squelch-level: "0"
  sample-rate: "22050"
  additional-flags: ""
multimon:
  path: "multimon-ng"
  additional-flags: ""
beacon:
  enabled: false
  call-sign: ""
  interval: 30m
  comment: ""
handlers:
- id: "4967ade5-7a97-416f-86bf-6e2ae8a5e581"
  name: "stdout"
- id: "b67ac5d5-3612-4618-88a9-a63d36a1777c"
  name: "aprsis"
  options:
    enabled: true
    server: "igates.aprs.fi:14580"
    call-sign: "HP3ICC-10"
    passcode: "12345"
    filter: ""
EOF

###############################################
sudo mkdir /opt/noip
cd /opt/noip/
wget https://www.noip.com/client/linux/noip-duc-linux.tar.gz
tar vzxf noip-duc-linux.tar.gz
cd noip-2.1.9-1
sudo make

#########
#dvswitch

cd /opt

wget http://dvswitch.org/buster
sudo chmod +x buster
./buster
apt-get update -y
apt-get install dvswitch-server -y
#############
sudo cat > /usr/local/dvs/dvs <<- "EOF"
#!/bin/bash

#===================================
SCRIPT_VERSION="Menu Script v.1.61"
SCRIPT_AUTHOR="HL5KY"
SCRIPT_DATE="11/06/2020"
#===================================

source /var/lib/dvswitch/dvs/var.txt

if [ "$1" != "" ]; then
    case $1 in
        -v|-V|--version) echo "dvs "$SCRIPT_VERSION; exit 0 ;;
        -a|-A|--author) echo "dvs "$SCRIPT_AUTHOR; exit 0 ;;
        -d|-D|--date) echo "dvs "$SCRIPT_DATE; exit 0 ;;
          *) echo "Unknown parameter passed: $1"; exit 1 ;;
    esac
fi

#--------------------------------------------------------------------

clear

# After upgrading, if [there is dvsm.basic] -> meaning setting is Advanced Macro Configuration
if [ -e ${AB}dvsm.basic ]; then
#    if there is not character "Advanced" in dvsm.macro -> updated & upgraded and dvsm.macro is brand new
        if [[ -z `grep "Advanced" ${AB}dvsm.macro` ]]; then
                sudo \cp -f ${adv}dvsm.macro ${AB}dvsm.macro
        fi
fi


if [ -e /var/lib/dvswitch/dvs/var.old ]; then
clear
sudo \mv -f /var/lib/dvswitch/dvs/var.old /var/lib/dvswitch/dvs/var.txt
source /var/lib/dvswitch/dvs/var.txt
fi


if [ ! -e ${lan}language.txt ]; then
clear
sudo \cp -f ${lan}english.txt ${lan}language.txt
source /var/lib/dvswitch/dvs/var.txt
fi


if [ "$startup_lan" != "73" ]; then

clear

update_var startup_lan 73

	if (whiptail --title " Change Language Settings " --yesno "\

           Do you want to change Language settings now ?


           You can do it later. The menu is under <Tools>
	" 12 70); then
	${DVS}language.sh; exit 0
	fi
fi


#--------------------------------------------------------------------

OPTION=$(whiptail --title " $T010 " --menu "\
                                           $SCRIPT_VERSION\n
\n
" 14 110 6 \
"01 $T011     " "$T012" \
"02 $T013     " "$T014" \
"03 $T015     " "$T016" \
"04 $T023     " "$T024" \
"05 $T017     " "$T018" \
"06 $T019     " "$T020" 3>&1 1>&2 2>&3)

if [ $? != 0 ]; then
clear;
exit 0
fi

case $OPTION in
01\ *)sudo ${DVS}init_config.sh ;;
02\ *)sudo ${DVS}adv_config_menu.sh ;;
03\ *)sudo ${DVS}tools_menu.sh ;;
04\ *)sh -c "$(curl -fsSL https://raw.githubusercontent.com/hp3icc/emq-TE1ws/main/service/dv-list-tg.sh)" ;;
05\ *)sudo ${DVS}credits.sh ;;
06\ *)exit 0
esac

#exit 0

EOF
###
cd /tmp/
wget https://raw.githubusercontent.com/hp3icc/DVSwitch-Mobile-TG-List/main/lang.sh
sudo chmod +x lang.sh
sh lang.sh
###
sudo sed -i "s/default_dmr_server=Brandmeister/default_dmr_server=FreeDMR/g"  /var/lib/dvswitch/dvs/var.txt
sudo sed -i "s/other1_name=/other1_name=FreeDMR/g"  /var/lib/dvswitch/dvs/var.txt
sudo sed -i "s/other1_address=/other1_address=freedmr-hp.ddns.net/g"  /var/lib/dvswitch/dvs/var.txt
sudo sed -i "s/other1_password=/other1_password=passw0rd/g"  /var/lib/dvswitch/dvs/var.txt
sudo sed -i "s/other1_port=/other1_port=62031/g"  /var/lib/dvswitch/dvs/var.txt

sudo sed -i "s/other2_name=/other2_name=DMR-Central/g"  /var/lib/dvswitch/dvs/var.txt
sudo sed -i "s/other2_address=/other2_address=dmr.pa7lim.nl/g"  /var/lib/dvswitch/dvs/var.txt
sudo sed -i "s/other2_password=/other2_password=passw0rd/g"  /var/lib/dvswitch/dvs/var.txt
sudo sed -i "s/other2_port=/other2_port=55555/g"  /var/lib/dvswitch/dvs/var.txt
sudo sed -i "s/42000/42500/g" /opt/YSFGateway/YSFGateway.ini
sudo sed -i "s/42001/43001/g" /opt/YSFGateway/YSFGateway.ini
sudo sed -i "s/RptPort=3200/RptPort=3230/g" /opt/YSFGateway/YSFGateway.ini
sudo sed -i "s/LocalPort=4200/LocalPort=4230/g" /opt/YSFGateway/YSFGateway.ini
sudo mkdir /var/www/dvs
sudo mv /var/www/html/* /var/www/dvs/
sudo sed -i 's/www\/html/www\/dvs/g' /usr/local/sbin/update-config.sh
sudo sed -i 's/www\/html/www\/dvs/g' /var/lib/dpkg/info/dvswitch*

sudo sed -i "s/Language=en_US/Language=es_ES/g" /opt/NXDNGateway/NXDNGateway.ini
sudo sed -i "s/Language=en_US/Language=es_ES/g" /opt/P25Gateway/P25Gateway.ini 
####
wget -O /lib/systemd/system/analog_bridge.service https://raw.githubusercontent.com/hp3icc/emq-TE1ws/main/service/analog_bridge.service
wget -O /lib/systemd/system/mmdvm_bridge.service https://raw.githubusercontent.com/hp3icc/emq-TE1ws/main/service/mmdvm_bridge.service
wget -O /lib/systemd/system/ysfgateway.service https://raw.githubusercontent.com/hp3icc/emq-TE1ws/main/service/ysfgateway.service
wget -O /lib/systemd/system/ysfparrot.service https://raw.githubusercontent.com/hp3icc/emq-TE1ws/main/service/ysfparrot.service
wget -O /lib/systemd/system/nxdngateway.service https://raw.githubusercontent.com/hp3icc/emq-TE1ws/main/service/nxdngateway.service
wget -O /lib/systemd/system/nxdnparrot.service https://raw.githubusercontent.com/hp3icc/emq-TE1ws/main/service/nxdnparrot.service
wget -O /lib/systemd/system/p25gateway.service https://raw.githubusercontent.com/hp3icc/emq-TE1ws/main/service/p25gateway.service
wget -O /lib/systemd/system/p25parrot.service https://raw.githubusercontent.com/hp3icc/emq-TE1ws/main/service/p25parrot.service
wget -O /lib/systemd/system/quantar_bridge.service https://raw.githubusercontent.com/hp3icc/emq-TE1ws/main/service/quantar_bridge.service
wget -O /lib/systemd/system/ircddbgatewayd.service https://raw.githubusercontent.com/hp3icc/emq-TE1ws/main/service/ircddbgatewayd.service
wget -O /lib/systemd/system/md380-emu.service https://raw.githubusercontent.com/hp3icc/emq-TE1ws/main/service/md380-emu.service
#
cat > /opt/MMDVM_Bridge/MMDVM_Bridge.ini  <<- "EOF"
[General]
Callsign=N0CALL
Id=1234567
Timeout=300
Duplex=0

[Info]
RXFrequency=147000000
TXFrequency=147000000
Power=1
Latitude=8.5211
Longitude=-80.3598
Height=0
Location=DVSwitch Server
Description=MMDVM DVSwitch
URL=https://groups.io/g/DVSwitch

[Log]
# Logging levels, 0=No logging, 1=Debug, 2=Message, 3=Info, 4=Warning, 5=Error, 6=Fatal
DisplayLevel=1
FileLevel=2
FilePath=/var/log/mmdvm
FileRoot=MMDVM_Bridge

[DMR Id Lookup]
File=/var/lib/mmdvm/DMRIds.dat
Time=24

[NXDN Id Lookup]
File=/var/lib/mmdvm/NXDN.csv
Time=24

[Modem]
Port=/dev/null
RSSIMappingFile=/dev/null
Trace=0
Debug=0

[D-Star]
Enable=0
Module=B

[DMR]
Enable=0
ColorCode=1
EmbeddedLCOnly=1
DumpTAData=0

[System Fusion]
Enable=0

[P25]
Enable=0
NAC=293

[NXDN]
Enable=0
RAN=1
Id=12345

[D-Star Network]
Enable=0
GatewayAddress=127.0.0.1
GatewayPort=20010
LocalPort=20011
Debug=0

[DMR Network]
Enable=0
Address=hblink.dvswitch.org
Port=62031
Jitter=500
Local=62032
Password=passw0rd
# for DMR+ see https://github.com/DVSwitch/MMDVM_Bridge/blob/master/DOC/DMRplus_startup_options.md
# for XLX the syntax is: Options=XLX:4009
# No active linea de Option para TG estaticos, si utiliza BM,TGIF,DMR-Central
# Puede activar linea de option de selfcare FDMR-Mon y colocar su propia contraseña o 
# utilizar linea de options con opciones de tg estaticos
#Options=PASS=abc123
#Options=TS2=714,7144;DIAL=0;VOICE=0;LANG=es_ES;SINGLE=0;TIMER=10;
Slot1=0
Slot2=1
Debug=0

[System Fusion Network]
Enable=0
LocalAddress=0
LocalPort=3230
GatewayAddress=127.0.0.1
GatewayPort=4230
Debug=0

[P25 Network]
Enable=0
GatewayAddress=127.0.0.1
GatewayPort=42020
LocalPort=32010
Debug=0

[NXDN Network]
Enable=0
#LocalAddress=127.0.0.1
Debug=0
LocalPort=14021
GatewayAddress=127.0.0.1
GatewayPort=14020
EOF
####
cd /opt/
git clone https://github.com/hp3icc/D-APRS.git
#

sudo cat > /lib/systemd/system/daprs.service <<- "EOF"
[Unit]
Description=Data bridge APRS
After=network-online.target syslog.target
Wants=network-online.target

[Service]
StandardOutput=null
WorkingDirectory=/opt/D-APRS
RestartSec=3
ExecStart=/usr/bin/python3 /opt/D-APRS/gps_data.py
Restart=on-abort

[Install]
WantedBy=multi-user.target

EOF
#
sudo cat > /lib/systemd/system/daprs-board.service <<- "EOF"
[Unit]
Description=Dashboard D-APRS
After=network-online.target syslog.target
Wants=network-online.target

[Service]
StandardOutput=null
WorkingDirectory=/opt/D-APRS/dashboard
RestartSec=3
ExecStart=/usr/bin/python3 /opt/D-APRS/dashboard/dashboard.py -c /opt/D-APRS/gps_data.cfg
Restart=on-abort

[Install]
WantedBy=multi-user.target
EOF
###############################
cat > /opt/MMDVMHost/DMRIDUpdate.sh <<- "EOF"
#! /bin/bash
###############################################################################
#
#                              CONFIGURATION
#
# Full path to DMR ID file, without final slash
DMRIDPATH=/opt/MMDVMHost
DMRIDFILE=${DMRIDPATH}/DMRIds.dat
# DMR IDs now served by RadioID.net
DATABASEURL='https://ham-digital.org/status/users.csv'
#DATABASEURL='https://www.radioid.net/static/user.csv'
#
# How many DMR ID files do you want backed up (0 = do not keep backups)
DMRFILEBACKUP=1
#
# Command line to restart MMDVMHost
RESTARTCOMMAND="sudo systemctl restart mmdvmh.service && sudo systemctl restart dmrgw.service && sudo systemctl restart ysfgw.service && sudo systemctl restart ysf2dmrgw.service"
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
sh /opt/XLXHostsupdate.sh
wget -O /opt/MMDVMHost/NXDN.csv https://www.radioid.net/static/nxdn.csv
wget -O /opt/YSFGateway2/YSF_Hosts.txt wget http://www.pistar.uk/downloads/YSF_Hosts.txt
wget -O /opt/YSFGateway2/FCS_Hosts.txt wget http://www.pistar.uk/downloads/FCS_Hosts.txt
wget -O /opt/YSF2DMRGW/TGList-DMR.txt http://freedmr-hp.ddns.net/downloads/TGList_BM.txt
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
###
cat > /opt/XLXHostsupdate.sh  <<- "EOF"
#! /bin/bash
###############################################################################
#
# XLXHostsupdate.sh
#
# Copyright (C) 2016 by Tony Corbett G0WFV
# Copyright (C) 2017 by Jonathan Naylor G4KLX
#
# Adapted to YSFHosts by Paul Nannery KC2VRJ on 6/28/2016 with all crdeit 
# to G0WFV for the orignal script.
#
# This program is free software; you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation; either version 2 of the License, or
# (at your option) any later version.
# 
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
# 
# You should have received a copy of the GNU General Public License
# along with this program; if not, write to the Free Software
# Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
#
###############################################################################
#
# On a Linux based system, such as a Raspberry Pi, this script will perform all  
# the steps required to maintain the XLXHosts.txt (or similar) file for you.
#
# It is designed to run from crontab and will download the XLXHosts from the 
# master XLX DMR Master database and optionally keep a backup of previously
# created files for you.
#
# It will also prune the number of backup files according to a value specified
# by you in the configuration below.
#
# To install in root's crontab use the command ...
#
#     sudo crontab -e
#
# ... and add the following line to the bottom of the file ...
#
#     0  0  *  *  *  /path/to/script/XLXHostsupdate.sh /path/to/XLXHosts.txt 1>/dev/null 2>&1
#
# ... where:
#           /path/to/script/ should be replaced by the path to this script.
#           /path/to/XLXHosts.txt should be replaced by the path to XLX hosts file
#
###############################################################################
#
#                              CONFIGURATION
#
# first argument as path to XLXHosts.txt.
# default so script's directory if empty

if [ -n "$1" ] ; then
  XLXHOSTS="$1"
else
  XLXHOSTS="$(dirname $0)/DMRGateway/XLXHosts.txt"
fi

echo "Updating $XLXHOSTS ..."

# How many XLXHosts files do you want backed up (0 = do not keep backups) 
XLXHOSTSFILEBACKUP=1

###############################################################################
#
# Do not edit below here
#
###############################################################################

# Check we are root
if [ "$(id -u)" != "0" ]; then
	echo "This script must be run as root" 1>&2
	exit 1
fi

# Create backup of old file
if [ ${XLXHOSTSFILEBACKUP} -ne 0 ]; then
	cp ${XLXHOSTS} ${XLXHOSTS}.$(date +%d%m%y)
fi

# Prune backups
BACKUPCOUNT=$(ls ${XLXHOSTS}.* | wc -l)
BACKUPSTODELETE=$(expr ${BACKUPCOUNT} - ${XLXHOSTSFILEBACKUP})

if [ ${BACKUPCOUNT} -gt ${XLXHOSTSFILEBACKUP} ]; then
	for f in $(ls -tr ${XLXHOSTS}.* | head -${BACKUPSTODELETE}); do
		rm -f $f
	done
fi

# Generate XLXHosts.txt file
curl http://xlxapi.rlx.lu/api.php?do=GetXLXDMRMaster | awk '
BEGIN {
	print "# The format of this file is:"
	print "# XLX Number;host;default"
}
/^XLX/ {
	reflector=4004
	if ($1 == "XLX004")
		reflector=4001
	if ($1 == "XLX235")
		reflector=4001
	if ($1 == "XLX268")
		reflector=4005
	if ($1 == "XLX284")
		reflector=4002
	if ($1 == "XLX313")
		reflector=4001
	if ($1 == "XLX359")
		reflector=4002
	if ($1 == "XLX389")
		reflector=4017
	if ($1 == "XLX518")
		reflector=4006
	if ($1 == "XLX755")
		reflector=4011
	if ($1 == "XLX886")
		reflector=4003
	if ($1 == "XLX950")
		reflector=4005
	printf "%s;%s;%d\n", substr($1,4), substr($2,1,length($2)-1), reflector
}' > ${XLXHOSTS}

exit 0
EOF
#
sudo chmod +x /opt/XLXHostsupdate.sh
###
cat > /opt/YSF2DMR/DMRIDUpdate.sh <<- "EOF"
#! /bin/bash
###############################################################################
#
#                              CONFIGURATION
#
# Full path to DMR ID file, without final slash
DMRIDPATH=/opt/MMDVMHost
DMRIDFILE=${DMRIDPATH}/DMRIds.dat
# DMR IDs now served by RadioID.net
DATABASEURL='https://ham-digital.org/status/users.csv'
#DATABASEURL='https://www.radioid.net/static/user.csv'
#
# How many DMR ID files do you want backed up (0 = do not keep backups)
DMRFILEBACKUP=1
#
# Command line to restart MMDVMHost
RESTARTCOMMAND="sudo systemctl restart ysf2dmr.service"
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
sh /opt/XLXHostsupdate.sh
wget -O /opt/MMDVMHost/NXDN.csv https://www.radioid.net/static/nxdn.csv
wget -O /opt/YSF2DMRGW/TGList-DMR.txt http://freedmr-hp.ddns.net/downloads/TGList_BM.txt
sh /opt/XLXHostsupdate.sh
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
###
cp /opt/MMDVMHost/DMRIDUpdate.sh /opt/MMDVMHost/DMRIDUpdate2.sh
sudo chmod +x /opt/MMDVMHost/DMRIDUpdate.sh
sudo chmod +x /opt/MMDVMHost/DMRIDUpdate2.sh
###
cp /opt/YSF2DMR/DMRIDUpdate.sh /opt/YSF2DMR/DMRIDUpdate2.sh
sudo chmod +x /opt/YSF2DMR/DMRIDUpdate.sh
sudo chmod +x /opt/YSF2DMR/DMRIDUpdate2.sh
###########################
sudo systemctl daemon-reload

sudo systemctl disable lighttpd.service
sudo systemctl stop lighttpd.service

sudo systemctl stop analog_bridge.service
sudo systemctl stop mmdvm_bridge.service
sudo systemctl stop nxdngateway.service
sudo systemctl stop p25gateway.service
sudo systemctl stop ysfgateway.service
sudo systemctl stop quantar_bridge.service
sudo systemctl stop ircddbgatewayd.service
sudo systemctl stop p25parrot.service
sudo systemctl stop ysfparrot.service
sudo systemctl stop nxdnparrot.service

sudo systemctl disable analog_bridge.service
sudo systemctl disable mmdvm_bridge.service
sudo systemctl disable nxdngateway.service
sudo systemctl disable p25gateway.service
sudo systemctl disable ysfgateway.service
sudo systemctl disable quantar_bridge.service
sudo systemctl disable ircddbgatewayd.service
sudo systemctl disable p25parrot.service
sudo systemctl disable ysfparrot.service
sudo systemctl disable nxdnparrot.service

rm /var/log/mmdvm/*
##########################
cd /opt/
cp -r /opt/YSFGateway/ /opt/YSFGateway2/
cd /opt/YSFGateway2/
sudo chmod +x *
sudo sed -i "s/# YSF2DMRAddress=127.0.0.1/YSF2DMRAddress=127.0.0.1/g"  /opt/YSFGateway2/YSFGateway.ini
sudo sed -i "s/# YSF2DMRPort=42013/YSF2DMRPort=42013/g"  /opt/YSFGateway2/YSFGateway.ini
sudo sed -i "s/3230/3330/g"  /opt/YSFGateway2/YSFGateway.ini
sudo sed -i "s/Suffix=RPT/# Suffix=RPT/g"  /opt/YSFGateway2/YSFGateway.ini
sudo sed -i "s/# Suffix=ND/Suffix=ND/g"  /opt/YSFGateway2/YSFGateway.ini
sudo sed -i "s/4230/4330/g"  /opt/YSFGateway2/YSFGateway.ini
sudo sed -i "s/42013/42018/g"  /opt/YSFGateway2/YSFGateway.ini
sudo sed -i "s/42500/42400/g"  /opt/YSFGateway2/YSFGateway.ini
sudo sed -i "s/43001/44001/g"  /opt/YSFGateway2/YSFGateway.ini
sudo sed -i "s/# YSF2DMRAddress=127.0.0.1/YSF2DMRAddress=127.0.0.1/g"  /opt/YSFGateway2/YSFGateway.ini
sudo sed -i "s/# YSF2DMRPort=42013/YSF2DMRPort=42013/g"  /opt/YSFGateway2/YSFGateway.ini
sudo sed -i "s/6073/6075/g"  /opt/YSFGateway2/YSFGateway.ini
sudo sed -i "s/YSFGateway/YSFGateway2/g"  /opt/YSFGateway2/YSFGateway.ini
sudo sed -i "s/Iceberg/Panama/g"  /opt/YSFGateway2/YSFGateway.ini
sudo sed -i "s/DVSwitch/YSFGateway/g"  /opt/YSFGateway2/YSFGateway.ini
sudo sed -i "s/# Startup=Alabama-Link/Startup=EUROPELINK/g"  /opt/YSFGateway2/YSFGateway.ini
sudo sed -i "s/WiresXCommandPassthrough=0/WiresXCommandPassthrough=1/g"  /opt/YSFGateway2/YSFGateway.ini
sudo sed -i "s/Enable=1/Enable=0/g"  /opt/YSFGateway2/YSFGateway.ini
sudo sed -i "s/var\/lib\/mmdvm\/YSFHosts.txt/opt\/YSFGateway2\/YSF_Hosts.txt/g"  /opt/YSFGateway2/YSFGateway.ini
sudo sed -i "s/var\/lib\/mmdvm\/FCSRooms.txt/opt\/YSFGateway2\/FCS_Hosts.txt/g"  /opt/YSFGateway2/YSFGateway.ini
sudo sed -i "s/N0CALL/HP3ICC/g"  /opt/YSFGateway2/YSFGateway.ini
###################
cat > /lib/systemd/system/ysfgw.service  <<- "EOF"
[Unit]
Description=YSF Gateway 2 Service
# Description=Place this file in /lib/systemd/system
# Description=N4IRS 01/17/2020

#After=netcheck.service
#Requires=netcheck.service

[Service]
User=root
Type=simple
Restart=always
RestartSec=3
StandardOutput=null
WorkingDirectory=/opt/YSFGateway2

ExecStartPre=/bin/sh -c 'until ping -c1 noip.com; do sleep 1; done;'
ExecStart=/opt/YSFGateway2/YSFGateway /opt/YSFGateway2/YSFGateway.ini


[Install]
WantedBy=multi-user.target


EOF
####

###########################
cat > /etc/modprobe.d/raspi-blacklist.conf <<- "EOF"
blacklist snd_bcm2835
# blacklist spi and i2c by default (many users don't need them)
#blacklist spi-bcm2708
#blacklist i2c-bcm2708
blacklist snd-soc-pcm512x
blacklist snd-soc-wm8804
# dont load default drivers for the RTL dongle
blacklist dvb_usb_rtl28xxu
blacklist rtl_2832
blacklist rtl_2830
EOF
################################
cd /usr/share/alsa/
sudo sed -i 's/defaults.ctl.card 0/defaults.ctl.card 1/' alsa.conf
sudo sed -i 's/defaults.pcm.card 0/defaults.pcm.card 1/' alsa.conf
###################################
cat > /usr/local/bin/cronedit.sh <<- "EOF"
cronjob_editor () {
# usage: cronjob_editor '<interval>' '<command>' <add|remove>

if [[ -z "$1" ]] ;then printf " no interval specified\n" ;fi
if [[ -z "$2" ]] ;then printf " no command specified\n" ;fi
if [[ -z "$3" ]] ;then printf " no action specified\n" ;fi

if [[ "$3" == add ]] ;then
    # add cronjob, no duplication:
    ( sudo crontab -l | grep -v -F -w "$2" ; echo "$1 $2" ) | sudo crontab -
elif [[ "$3" == remove ]] ;then
    # remove cronjob:
    ( sudo crontab -l | grep -v -F -w "$2" ) | sudo crontab -
fi
}
cronjob_editor "$1" "$2" "$3"


EOF
sudo chmod +x /usr/local/bin/cronedit.sh

##############
cd /opt
git clone https://gitlab.hacknix.net/hacknix/FreeDMR.git
cd FreeDMR
mkdir config
sudo chmod +x /opt/FreeDMR/install.sh
./install.sh
sudo chmod +x /opt/FreeDMR/*.py
sudo cat > /opt/conf.txt <<- "EOF"
 
[D-APRS]
MODE: MASTER
ENABLED: True
REPEAT: True
MAX_PEERS: 1
EXPORT_AMBE: False
IP:
PORT: 54101
PASSPHRASE: passw@rd
GROUP_HANGTIME: 5
USE_ACL: True
REG_ACL: DENY:1
SUB_ACL: DENY:1
TGID_TS1_ACL: PERMIT:ALL
TGID_TS2_ACL: PERMIT:ALL
DEFAULT_UA_TIMER: 60
SINGLE_MODE: True
VOICE_IDENT: False
TS1_STATIC:
TS2_STATIC:
DEFAULT_REFLECTOR: 0
ANNOUNCEMENT_LANGUAGE: es_ES
GENERATOR: 1
ALLOW_UNREG_ID: True
PROXY_CONTROL: False
override_ident_tg:
 
[LINKS]
MODE: MASTER
ENABLED: True
REPEAT: True
MAX_PEERS: 5
EXPORT_AMBE: False
IP:
PORT: 54102
PASSPHRASE: passw@rd
GROUP_HANGTIME: 5
USE_ACL: True
REG_ACL: DENY:1
SUB_ACL: DENY:1
TGID_TS1_ACL: PERMIT:ALL
TGID_TS2_ACL: PERMIT:ALL
DEFAULT_UA_TIMER: 60
SINGLE_MODE: True
VOICE_IDENT: False
TS1_STATIC:
TS2_STATIC:
DEFAULT_REFLECTOR: 0
ANNOUNCEMENT_LANGUAGE: es_ES
GENERATOR: 1
ALLOW_UNREG_ID: True
PROXY_CONTROL: False
override_ident_tg:
 
[EchoTest]
MODE: PEER
ENABLED: True
LOOSE: True
EXPORT_AMBE: False
IP: 
#127.0.0.1
PORT: 49060
MASTER_IP: 127.0.0.1
MASTER_PORT: 49061
PASSPHRASE: passw0rd
CALLSIGN: ECHOTEST
RADIO_ID: 9990
RX_FREQ: 449000000
TX_FREQ: 444000000
TX_POWER: 25
COLORCODE: 1
SLOTS: 3
LATITUDE: 38.0000
LONGITUDE: -095.0000
HEIGHT: 75
LOCATION: Local Parrot
DESCRIPTION: This is a cool repeater
URL: www.w1abc.org
SOFTWARE_ID: 20170620
PACKAGE_ID: MMDVM_HBlink
GROUP_HANGTIME: 3
OPTIONS:
#TS2=9990;DIAL=0;VOICE=0;TIMER=0
USE_ACL: True
SUB_ACL: DENY:1
TGID_TS1_ACL: DENY:ALL
TGID_TS2_ACL: PERMIT:9990
TS1_STATIC:
TS2_STATIC:9990
DEFAULT_REFLECTOR: 0
ANNOUNCEMENT_LANGUAGE: en_GB
GENERATOR: 0
DEFAULT_UA_TIMER: 999
SINGLE_MODE: True
VOICE_IDENT: False
 
EOF
##
sudo sed -i 's/ALLOW_NULL_PASSPHRASE: True/ALLOW_NULL_PASSPHRASE: False/' /opt/FreeDMR/FreeDMR-SAMPLE.cfg
sudo sed -i 's/PASSPHRASE:/PASSPHRASE: passw0rd/' /opt/FreeDMR/FreeDMR-SAMPLE.cfg
sudo sed -i 's/ALLOW_NULL_PASSPHRASE: passw0rd False/ALLOW_NULL_PASSPHRASE: False/' /opt/FreeDMR/FreeDMR-SAMPLE.cfg

cp /opt/FreeDMR/FreeDMR-SAMPLE.cfg /opt/
cd /opt/
cat FreeDMR-SAMPLE.cfg conf.txt obp.txt >> /opt/FreeDMR/config/FreeDMR.cfg
#sudo sed -i 's/REPORT_CLIENTS: 127.0.0.1/REPORT_CLIENTS: */' /opt/FreeDMR/config/FreeDMR.cfg
sudo sed -i 's/file-timed/console-timed/' /opt/FreeDMR/config/FreeDMR.cfg
sudo sed -i 's/INFO/DEBUG/' /opt/FreeDMR/config/FreeDMR.cfg
sudo sed -i 's/freedmr.log/\/var\/log\/FreeDMR\/FreeDMR.log/' /opt/FreeDMR/config/FreeDMR.cfg
sudo sed -i 's/ANNOUNCEMENT_LANGUAGE: en_GB/ANNOUNCEMENT_LANGUAGE: es_ES/' /opt/FreeDMR/config/FreeDMR.cfg
sudo sed -i 's/VOICE_IDENT: True/VOICE_IDENT: False/' /opt/FreeDMR/config/FreeDMR.cfg
sudo sed -i 's/100/60/' /opt/FreeDMR/config/FreeDMR.cfg
sudo sed -i 's/54100/54060/' /opt/FreeDMR/hotspot_proxy_v2.py
sudo sed -i "s/TGID_URL:/#TGID_URL:/g"  /opt/FreeDMR/config/FreeDMR.cfg 
sed '37 a TGID_URL: https://freedmr.cymru/talkgroups/talkgroup_ids_json.php' -i /opt/FreeDMR/config/FreeDMR.cfg 
sed '43 a TOPO_FILE: topography.json' -i /opt/FreeDMR/config/FreeDMR.cfg 

rm /opt/FreeDMR/conf.txt
cd /opt/FreeDMR/
mv loro.cfg /opt/FreeDMR/playback.cfg
sudo sed -i 's/54915/49061/' /opt/FreeDMR/playback.cfg
#sudo sed -i "121,129d" /opt/FreeDMR/playback.cfg
#
sed '14 a VALIDATE_SERVER_IDS: True' -i /opt/FreeDMR/config/FreeDMR.cfg
sed '105 a override_ident_tg:' -i /opt/FreeDMR/config/FreeDMR.cfg
sudo sed -i "56,63d" /opt/FreeDMR/config/FreeDMR.cfg
#
sudo cat > /lib/systemd/system/proxy.service <<- "EOF"
[Unit]
Description= Proxy Service 

After=multi-user.target


[Service]
User=root
Type=simple
Restart=always
RestartSec=3
StandardOutput=null
#ExecStartPre=/bin/sh -c 'until ping -c1 noip.com; do sleep 1; done;'
#WorkingDirectory=/opt/FreeDMR
ExecStart=/usr/bin/python3 /opt/FreeDMR/hotspot_proxy_v2.py -c /opt/FreeDMR/proxy.cfg

[Install]
WantedBy=multi-user.target

EOF
#########
sudo cat > /lib/systemd/system/freedmr.service <<- "EOF"
[Unit]
Description=FreeDmr
After=multi-user.target

[Service]
User=root
Type=simple
Restart=always
RestartSec=3
StandardOutput=null
ExecStartPre=/bin/sh -c 'until ping -c1 noip.com; do sleep 1; done;'
ExecStart=/usr/bin/python3 /opt/FreeDMR/bridge_master.py -c /opt/FreeDMR/config/FreeDMR.cfg -r /opt/FreeDMR/config/rules.py

[Install]
WantedBy=multi-user.target

EOF
###
sudo cat > /lib/systemd/system/fdmrparrot.service <<- "EOF"
[Unit]

Description=Freedmr Parrot

After=network-online.target syslog.target

Wants=network-online.target

[Service]

StandardOutput=null

WorkingDirectory=/opt/FreeDMR

RestartSec=3

ExecStart=/usr/bin/python3 /opt/FreeDMR/playback.py -c /opt/FreeDMR/playback.cfg
#/usr/bin/python3 /opt/HBlink3/playback.py -c /opt/HBlink3/playback.cfg

Restart=on-abort

[Install]

WantedBy=multi-user.target

EOF
#######lamp
sudo apt install mariadb-server php libapache2-mod-php php-zip php-mbstring php-cli php-common php-curl php-xml php-mysql -y

sudo apt install apache2 -y

systemctl restart mariadb
systemctl enable mariadb
#sudo mysql_secure_installation  --host=localhost --port=3306
echo "DROP USER emqte1@localhost" | /usr/bin/mysql -u root
echo "DROP DATABASE selfcare" | /usr/bin/mysql -u root

newUser='emqte1'
newDbPassword=''
newDb='selfcare'
host=localhost
#host='%'

# MySQL 5.7 and earlier versions
#commands="CREATE DATABASE \`${newDb}\`;CREATE USER '${newUser}'@'${host}' IDENTIFIED BY '${newDbPassword}';GRANT USAGE ON *.* TO '${newUser}'@'${host}' IDENTIFIED BY '${newDbPassword}';GRANT ALL privileges ON \`${newDb}\`.* TO '${newUser}'@'${host}' IDENTIFIED BY '${newDbPassword}';FLUSH PRIVILEGES;"

# MySQL 8 and higher versions
commands="CREATE DATABASE \`${newDb}\`;CREATE USER '${newUser}'@'${host}' IDENTIFIED BY '${newDbPassword}';GRANT USAGE ON *.* TO '${newUser}'@'${host}';GRANT ALL ON \`${newDb}\`.* TO '${newUser}'@'${host}';FLUSH PRIVILEGES;"

#cho "${commands}" | /usr/bin/mysql -u root -p
echo "${commands}" | /usr/bin/mysql -u root
#fdmr-monitor
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
sudo sed -i 's/FREQUENCY = 10/FREQUENCY = 120/' /opt/FDMR-Monitor/fdmr-mon_SAMPLE.cfg
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
    <?php if(!PRIVATE_NETWORK){echo '<a class="button" href="selfservice.php">SelfService</a>';}?>
    <a class="button" href="login.php">Login</a>
    <?php 
    if(isset($_SESSION["auth"], $_SESSION["callsign"], $_SESSION["h_psswd"]) and $_SESSION["auth"]){
      echo '<a class="button" href="devices.php">Devices</a>';
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
<a class="button" href="http://www.freedmr.uk/server_test.php"target="_blank">&nbsp;Status Server&nbsp;</a>
&nbsp;
<a class="button" href="http://www.freedmr.uk/index.php/world-wide-talk-groups/"target="_blank">&nbsp;World Wide Talk Groups&nbsp;</a>
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

sudo systemctl daemon-reload

sudo chmod +x /opt/extra-2.sh
sudo sh /opt/extra-2.sh
sudo sed -i "s/root/emqte1/g"  /opt/FDMR-Monitor/fdmr-mon_SAMPLE.cfg
sudo sed -i "s/test/selfcare/g"  /opt/FDMR-Monitor/fdmr-mon_SAMPLE.cfg
sudo sed -i "s/PRIVATE_NETWORK = True/PRIVATE_NETWORK = False/g"  /opt/FDMR-Monitor/fdmr-mon_SAMPLE.cfg
sudo sed -i "s/TGID_URL =/#TGID_URL =/g"  /opt/FDMR-Monitor/fdmr-mon_SAMPLE.cfg
sed '63 a TGID_URL = https://freedmr.cymru/talkgroups/talkgroup_ids_json.php' -i /opt/FDMR-Monitor/fdmr-mon_SAMPLE.cfg
sed '64 a #TGID_URL = https://freedmr.cymru/talkgroups/talkgroup_ids_flags_json.php' -i /opt/FDMR-Monitor/fdmr-mon_SAMPLE.cfg
sudo rm /opt/FDMR-Monitor/data/*
cd /opt/FDMR-Monitor/
sudo rm /opt/FDMR-Monitor/install.sh
wget https://raw.githubusercontent.com/hp3icc/emq-TE1ws/main/self/install.sh
sudo chmod +x /opt/FDMR-Monitor/install.sh
#
sh /opt/FDMR-Monitor/install.sh
sudo sh /opt/extra-2.sh
#####################
sudo sed -i "s/root/emqte1/g"  /opt/FreeDMR/hotspot_proxy_v2.py
sudo sed -i "s/54100/54060/g"  /opt/FreeDMR/hotspot_proxy_v2.py
sudo sed -i "s/test/selfcare/g"  /opt/FreeDMR/hotspot_proxy_v2.py
sudo sed -i "s/\/freedmr.cfg/\/config\/FreeDMR.cfg/g"  /opt/FreeDMR/hotspot_proxy_v2.py
sudo sed -i "s/test/selfcare/g"  /opt/FreeDMR/proxy_db.py
sudo sed -i "s/root/emqte1/g"  /opt/FreeDMR/proxy_db.py
#
sudo sed -i "s/root/emqte1/g"  /opt/FreeDMR/proxy.cfg
sudo sed -i "s/54100/54060/g"  /opt/FreeDMR/proxy.cfg
sudo sed -i "s/test/selfcare/g"  /opt/FreeDMR/proxy.cfg
#################
#sh /opt/FDMR-Monitor/sysinfo/rrd-db.sh
#rm /opt/FDMR-Monitor/sysinfo/*.rrd 
sh /opt/FDMR-Monitor/sysinfo/rrd-db.sh
#sed '33 a <!--' -i /var/www/html/sysinfo.php
#sed '35 a -->' -i /var/www/html/sysinfo.php

cp -r /opt/FDMR-Monitor/sysinfo/ /var/www/html/sysinfo/

systemctl stop apache2
systemctl disable apache2
#########
sudo cat > /opt/FreeDMR/config/rules.py <<- "EOF"
'''
THIS EXAMPLE WILL NOT WORK AS IT IS - YOU MUST SPECIFY YOUR OWN VALUES!!!

In FreeDMR, the rules file should be *empty* unless you have static routing required. Please see the 
documentation for more details.

This file is organized around the "Conference Bridges" that you wish to use. If you're a c-Bridge
person, think of these as "bridge groups". You might also liken them to a "reflector". If a particular
system is "ACTIVE" on a particular conference bridge, any traffid from that system will be sent
to any other system that is active on the bridge as well. This is not an "end to end" method, because
each system must independently be activated on the bridge.

The first level (e.g. "WORLDWIDE" or "STATEWIDE" in the examples) is the name of the conference
bridge. This is any arbitrary ASCII text string you want to use. Under each conference bridge
definition are the following items -- one line for each HBSystem as defined in the main HBlink
configuration file.

    * SYSTEM - The name of the sytem as listed in the main hblink configuration file (e.g. hblink.cfg)
        This MUST be the exact same name as in the main config file!!!
    * TS - Timeslot used for matching traffic to this confernce bridge
        XLX connections should *ALWAYS* use TS 2 only.
    * TGID - Talkgroup ID used for matching traffic to this conference bridge
        XLX connections should *ALWAYS* use TG 9 only.
    * ON and OFF are LISTS of Talkgroup IDs used to trigger this system off and on. Even if you
        only want one (as shown in the ON example), it has to be in list format. None can be
        handled with an empty list, such as " 'ON': [] ".
    * TO_TYPE is timeout type. If you want to use timers, ON means when it's turned on, it will
        turn off afer the timout period and OFF means it will turn back on after the timout
        period. If you don't want to use timers, set it to anything else, but 'NONE' might be
        a good value for documentation!
    * TIMOUT is a value in minutes for the timout timer. No, I won't make it 'seconds', so don't
        ask. Timers are performance "expense".
    * RESET is a list of Talkgroup IDs that, in addition to the ON and OFF lists will cause a running
        timer to be reset. This is useful   if you are using different TGIDs for voice traffic than
        triggering. If you are not, there is NO NEED to use this feature.
'''

BRIDGES = {

 '9990': [ 
	{'SYSTEM': 'EchoTest', 		'TS': 2, 'TGID': 9990, 'ACTIVE':True, 'TIMEOUT': 0, 'TO_TYPE': 'NONE', 'ON': [], 'OFF': [], 'RESET': []}, 

	],


}
if __name__ == '__main__':
    from pprint import pprint
    pprint(BRIDGES)

EOF
#######
sudo cat > /opt/rules.txt <<- "EOF"
 
BRIDGES = {
 
 '9990': [ 
{'SYSTEM': 'EchoTest',          'TS': 2, 'TGID': 9990, 'ACTIVE':True, 'TIMEOUT': 0, 'TO_TYPE': 'NONE', 'ON': [], 'OFF': [], 'RESET': []}, 
 
],
 
 
 
}
if __name__ == '__main__':
    from pprint import pprint
    pprint(BRIDGES)
 
  
 
EOF
###################
sudo timedatectl set-timezone America/Panama
#####
sudo cat > /boot/wpa_supplicant.conf <<- "EOF"
ctrl_interface=DIR=/var/run/wpa_supplicant GROUP=netdev
update_config=1
country=PA
##################################################################
# 							         #
#  Favor tomar como referencia, las dos redes wifi  que aparecen #
#  abajo, puede editar con los datos de su red wifi o agregar un #
#  network nuevo, por cada red wifi nueva que quiera almacenar.  #
#  							         #
#  Raspbian proyect by HP3ICC, 73.			         #
#							         #
##################################################################
network={
        key_mgmt=NONE
}

network={
        ssid="Coloque_aqui_nombre_de_red_wifi"
        psk="Coloque_aqui_la_clave_wifi"
}

network={
        ssid="WiFi-Net"
        psk="Panama310"
}
EOF
################################################
#Direwolf
cd /opt/
	
git clone https://www.github.com/wb2osz/direwolf
cd direwolf
git checkout dev
mkdir build && cd build
cmake ..
make -j4
sudo make install
make install-conf

sudo cp /usr/local/bin/direwolf /opt/direwolf/direwolf2
cd /opt/direwolf
wget https://github.com/hp3icc/emq-TE1ws/raw/main/direwolf1
#############
sudo cat > /opt/direwolf/service1 <<- "EOF"
[Unit]
Description=DireWolf is a software "soundcard" modem/TNC and APRS decoder
Documentation=man:direwolf
AssertPathExists=/opt/direwolf/dw.conf

[Unit]
Description=Direwolf Service
#Wants=network-online.target
After=sound.target syslog.target
#network-online.target

[Service]
User=root
Type=simple
Restart=always
RestartSec=3
StandardOutput=null
ExecStart=sudo direwolf -c /opt/direwolf/dw.conf

[Install]
WantedBy=multi-user.target

EOF
##
sudo cat > /opt/direwolf/service2 <<- "EOF"
[Unit]
Description=DireWolf is a software "soundcard" modem/TNC and APRS decoder
Documentation=man:direwolf
AssertPathExists=/opt/direwolf/dw.conf

[Unit]
Description=Direwolf Service
#Wants=network-online.target
After=sound.target syslog.target
#network-online.target

[Service]
User=root
Type=simple
Restart=always
RestartSec=3
StandardOutput=null
ExecStart=sudo direwolf -l /var/log/direwolf -c /opt/direwolf/dw.conf

[Install]
WantedBy=multi-user.target

EOF
###
cat > /opt/direwolf/rtl.sh  <<- "EOF"
#!/bin/sh
PATH=/bin:/usr/bin:/usr/local/bin
unset LANG
rtl_fm -M fm -f 144.39M -p 0 -s 22050 -g 42 - | /usr/local/bin/direwolf -c /opt/direwolf/sdr.conf -r 22050 -D 1 -B 1200 -
EOF
#
cat > /opt/direwolf/rtl1.sh  <<- "EOF"
#!/bin/sh
PATH=/bin:/usr/bin:/usr/local/bin
unset LANG
rtl_fm -M fm -f 144.39M -p 0 -s 22050 -g 42 - | /usr/local/bin/direwolf -c /opt/direwolf/sdr.conf -r 22050 -D 1 -B 1200 -
EOF
#
cat > /opt/direwolf/rtl2.sh  <<- "EOF"
#!/bin/sh
PATH=/bin:/usr/bin:/usr/local/bin
unset LANG
rtl_fm -M fm -f 144.39M -p 0 -s 22050 -g 42 - | /usr/local/bin/direwolf -l /var/log/direwolf -c /opt/direwolf/sdr.conf -r 22050 -D 1 -B 1200 -
EOF
#
sudo chmod +x /opt/direwolf/rtl.sh
#
cat > /opt/direwolf/sdr.conf <<- "EOF"
#############################################################
#                                                           #
#       Configuration file for DireWolf                     #
#                                                           #
#         Linux version setting by hp3icc                   #
#                                                           #
#                emq-TE1ws                                  #
#                                                           #
#        configuration for SDR read-only IGate.             #
#############################################################
ADEVICE null null
CHANNEL 0
MYCALL HP3ICC-10
PBEACON sendto=IG delay=0:40 every=30 symbol="/r" lat=08^31.27N long=080^21.59W comment="SDR APRS RX-IGATE / Raspbian Proyect by hp3icc"
# First you need to specify the name of a Tier 2 server.
# The current preferred way is to use one of these regional rotate addresses:
#       noam.aprs2.net          - for North America
#       soam.aprs2.net          - for South America
#       euro.aprs2.net          - for Europe and Africa
#       asia.aprs2.net          - for Asia
#       aunz.aprs2.net          - for Oceania
IGSERVER  igates.aprs.fi:14580
#noam.aprs2.net
# You also need to specify your login name and passcode.
# Contact the author if you can't figure out how to generate the passcode.
IGLOGIN HP3ICC-10 12345
# That's all you need for a receive only IGate which relays
# messages from the local radio channel to the global servers.
#
#AGWPORT 8000
#KISSPORT 8001
EOF
###
cat > /opt/direwolf/dw.conf <<- "EOF"
#############################################################
#                                                           #
#       Configuration file for DireWolf                     #
#                                                           #
#         Linux version setting by hp3icc                   #
#                                                           #
#                emq-TE1ws                                  #
#                                                           #
#############################################################
#############################################################
#                                                           #
#               FIRST AUDIO DEVICE PROPERTIES               #
#               (Channel 0 + 1 if in stereo)                #
#                                                           #
#############################################################
ADEVICE plughw:1,0
#ADEVICE null null
# ADEVICE - plughw:1,0
# ADEVICE UDP:7355 default
# Number of audio channels for this souncard:  1 or 2.
#
ACHANNELS 1
#############################################################
#                                                           #
#               CHANNEL 0 PROPERTIES                        #
#                                                           #
#############################################################
CHANNEL 0
MYCALL HP3ICC-10
MODEM 1200
#MODEM 1200 1200:2200
#MODEM 300  1600:1800
#MODEM 9600 0:0
#
#MODEM 1200 E+ /3
#
#
# If not using a VOX circuit, the transmitter Push to Talk (PTT)
# DON'T connect it directly!
#
# For the PTT command, specify the device and either RTS or DTR.
# RTS or DTR may be preceded by "-" to invert the signal.
# Both can be used for interfaces that want them driven with opposite polarity.
#
# COM1 can be used instead of /dev/ttyS0, COM2 for /dev/ttyS1, and so on.
#
#PTT CM108
#PTT COM1 RTS
#PTT COM1 RTS -DTR
#PTT /dev/ttyUSB0 RTS
#PTT /dev/ttyUSB0 DTR
#PTT GPIO 25
#PTT GPIO 26
# The Data Carrier Detect (DCD) signal can be sent to the same places
# as the PTT signal.  This could be used to light up an LED like a normal TNC.
#DCD COM1 -DTR
#DCD GPIO 24
#pin18 (GPIO 24) - (cathode) LED (anode) - 270ohm resistor - 3.3v
#DCD GPIO 13
#############################################################
#                                                           #
#               VIRTUAL TNC SERVER PROPERTIES               #
#                                                           #
#############################################################
#
# Dire Wolf acts as a virtual TNC and can communicate with
# client applications by different protocols:
#
#       - the "AGW TCPIP Socket Interface" - default port 8000
#       - KISS protocol over TCP socket - default port 8001
#       - KISS TNC via pseudo terminal   (-p command line option)
#
#Setting to 0 disables UI-proto only AGW and TCP-KISS ports
AGWPORT 8000
KISSPORT 8001
#KISSPORT 0
#
# It is sometimes possible to recover frames with a bad FCS.
# This applies to all channels.
#       0  [NONE] - Don't try to repair.
#       1  [SINGLE] - Attempt to fix single bit error.  (default)
#       2  [DOUBLE] - Also attempt to fix two adjacent bits.
#       ... see User Guide for more values and in-depth discussion.
#
#FIX_BITS 0
#Enable fixing of 1 bits and use generic AX25 heuristics data (not APRS heuristi$
#FIX_BITS 1 AX25
#
#############################################################
#                                                           #
#               BEACONING PROPERTIES                        #
#                                                           #
#############################################################
#GPSD
#TBEACON symbol="/v" comment="HP3ICC-9 / APRS TRACKER / Raspbian Proyect by hp3icc" via=WIDE2-2
#SMARTBEACONING 28 0:30 12 0:1800 0:30 15 45 via=WIDE2-2
#
#PBEACON delay=0:05 every=30 symbol="/r" lat=08^31.27N long=080^21.59W comment="APRS DIGI-IGATE / Raspbian Proyect by hp3icc" via=WIDE2-2
#PBEACON sendto=IG delay=0:40 every=30 symbol="/r" lat=08^31.27N long=080^21.59W comment="APRS DIGI-IGATE / Raspbian Proyect by hp3icc"
#############################################################
#                                                           #
#               DIGIPEATER PROPERTIES                       #
#                                                           #
#############################################################
DIGIPEAT 0 0 ^WIDE[3-7]-[1-7]$|^TEST$ ^WIDE[12]-[12]$ TRACE
FILTER 0 0 t/poimqstunw
#############################################################
#                                                           #
#               INTERNET GATEWAY                            #
#                                                           #
#############################################################
# First you need to specify the name of a Tier 2 server.
# The current preferred way is to use one of these regional rotate addresses:
#       noam.aprs2.net          - for North America
#       soam.aprs2.net          - for South America
#       euro.aprs2.net          - for Europe and Africa
#       brazil.d2g.com
#
#IGSERVER igates.aprs.fi:14580
#IGSERVER noam.aprs2.net:14580
#IGSERVER cx2sa.net:14580

#IGLOGIN HP3ICC-10  12345
IGTXVIA 0 WIDE2-2
#WIDE1-1,WIDE2-1
#WIDE2-2
#
#
#IGFILTER b/HP3ICC-5
#IGFILTER p/HP
#m/600
#
FILTER IG 0 t/p
#poimqstunw
IGTXLIMIT 6 10
#
EOF
##############
sh -c "$(curl -fsSL https://raw.githubusercontent.com/hp3icc/shell-aprs/main/shell.sh)"

###########
cd /tmp/
sudo bash -c "$(wget -O - https://raw.githubusercontent.com/hp3icc/emq-TE1ws/main/gotty.sh)"
#
sudo cat > /lib/systemd/system/gotty.service <<- "EOF"
[Unit]
Description=GoTTY
After=multi-user.target

[Service]
User=root
Environment=TERM=xterm-256color
ExecStartPre=/bin/sleep 40
ExecStart=gotty -p "8022" -w -c "pi:Panama507" menu

[Install]
WantedBy=multi-user.target

EOF
#
sudo chown -R mmdvm:mmdvm /opt/MMDVMHost/MMDVMHost

cp /bin/menu /bin/MENU
sudo chmod +x /bin/MENU
sudo chmod +x /bin/menu*

sudo chmod +777 /opt/*
sudo chmod +777 /opt/MMDVMHost-Websocketboard/*
sudo chmod +777 /opt/WSYSFDash/*
sudo chmod +777 /opt/direwolf/*
sudo chmod +777 /opt/direwolf/dw.conf
sudo chmod +777 /opt/direwolf/sdr.conf
sudo chmod +777 /opt/direwolf/src/*
sudo chmod +777 /opt/MMDVMHost/*
sudo chmod +777 /opt/MMDVMHost/MMDVM.ini
sudo chmod +777 /opt/YSF2DMR/*
sudo chmod +777 /opt/YSF2DMR/YSF2DMR.ini
sudo chmod +777 /opt/ionsphere/*
sudo chmod +777 /opt/ionsphere/ionosphere-raspberry-pi/config/config.yml
sudo chmod +777 /opt/pymultimonaprs/* 
sudo chmod +777 /opt/multimon-ng/*
sudo chmod +777 /opt/kalibrate-rtl/*
sudo chmod +777 /opt/YSFClients/*
sudo chmod +777 /opt/MMDVM_CM/*
sudo chmod +777 /opt/MMDVM_Bridge/*
sudo chmod +777 /opt/MMDVM_Bridge/MMDVM_Bridge.ini
sudo chmod +777 /etc/pymultimonaprs.json
sudo chmod +777 /opt/D-APRS/user_settings.txt

sudo chmod +x /opt/FDMR-Monitor/sysinfo/graph.sh
sudo chmod +x /opt/FDMR-Monitor/sysinfo/cpu.sh
sudo chmod +x /usr/bin/python3
sudo chmod +x /opt/HBmonitor/monitor.py
sudo chmod +x /opt/YSF2DMR/DMRIDUpdate.sh
sudo chmod +x /opt/MMDVMHost/DMRIDUpdate.sh
sudo chmod +x /opt/D-APRS/*.py
sudo chmod +x /opt/D-APRS/dashboard/*.py
sudo chmod +x /usr/local/bin/rebooter1.sh

sudo chmod 755 /lib/systemd/system/daprs-board.service
sudo chmod 755 /lib/systemd/system/rebooter1.service
sudo chmod 755 /lib/systemd/system/gotty.service
sudo chmod 755 /usr/local/bin/rebooter1.sh
sudo chmod 755 /lib/systemd/system/daprs.service
sudo chmod 755 /lib/systemd/system/http.server-dvs.service
sudo chmod 755 /lib/systemd/system/http.server-fmr.service
sudo chmod 755 /lib/systemd/system/freedmr.service
sudo chmod 755 /lib/systemd/system/proxy.service
sudo chmod 755 /lib/systemd/system/fdmr_mon.service
sudo chmod 755 /lib/systemd/system/hbmon.service
sudo chmod 755 /lib/systemd/system/hbparrot.service
sudo chmod 755 /lib/systemd/system/YSFReflector.service
sudo chmod 755 /lib/systemd/system/monp.service
sudo chmod 755 /lib/systemd/system/dmrid-ysf2dmr.service
sudo chmod 755 /lib/systemd/system/dmrid-mmdvm.service
sudo chmod 755 /lib/systemd/system/mmdvmh.service
sudo chmod 755 /lib/systemd/system/direwolf.service
sudo chmod 755 /lib/systemd/system/direwolf-rtl.service
sudo chmod 755 /lib/systemd/system/multimon-rtl.service
sudo chmod 755 /lib/systemd/system/ionos.service
sudo chmod 755 /lib/systemd/system/ysf2dmr.service
sudo chmod 755 /lib/systemd/system/http.server-mmdvmh.service
sudo chmod 755 /lib/systemd/system/logtailer-mmdvmh.service
sudo chmod 755 /lib/systemd/system/http.server-ysf.service
sudo chmod 755 /lib/systemd/system/logtailer-ysf.service
sudo chmod 755 /lib/systemd/system/dmrgw.service
sudo systemctl daemon-reload

sudo systemctl enable monp.service
sudo systemctl stop rsyslog
sudo systemctl disable rsyslog
sudo systemctl stop webproxy.service
sudo systemctl disable webproxy.service
sudo systemctl enable gotty.service
sudo systemctl disable netcheck.service
sudo systemctl disable systemd-networkd-wait-online.service
sudo systemctl disable dphys-swapfile-back.service
mv /lib/systemd/system/dphys-swapfile.service /lib/systemd/system/dphys-swapfile-back.service
rm /var/log/syslog*
rm /var/log/*.log*
cd /tmp/

(crontab -l; echo "* */1 * * * sync ; echo 3 > /proc/sys/vm/drop_caches >/dev/null 2>&1")|awk '!x[$0]++'|crontab -
#####
cat > /tmp/completado.sh <<- "EOF"
#!/bin/bash
while : ; do
choix=$(whiptail --title "Raspbian Proyect HP3ICC Esteban Mackay 73." --menu " Precione enter (return o intro) para finalizar la instalacion y reiniciar" 11 85 3 \
1 " Iniciar Reinicio de equipo " 3>&1 1>&2 2>&3)
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
sudo reboot
;;
esac
done
exit 0
EOF
###
sudo chmod +x /tmp/completado.sh
##
sudo update-rc.d dphys-swapfile remove
sudo chmod -x /etc/init.d/dphys-swapfile
sudo dphys-swapfile swapoff
sudo swapoff -a
sudo rm /var/swap
sudo dphys-swapfile uninstall
cd /etc/
sudo sed -i 's/CONF_SWAPSIZE=100/CONF_SWAPSIZE=0/' dphys-swapfile
##
history -c && history -w
sh /tmp/completado.sh
