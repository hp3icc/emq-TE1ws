#!/bin/sh
echo Actualizando sistema 
sudo apt-get update -y
sudo apt-get upgrade -y
sudo apt-get dist-upgrade -y
############################################
echo instalando pre-requisitos
######################################################################################################
#!/bin/sh
sudo apt-get install git -y
sudo apt-get install screen -y
sudo apt-get install gcc -y
sudo apt-get install g++ -y
sudo apt-get install make -y
sudo apt-get install cmake -y
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
sudo apt-get install python3 -y
sudo apt-get libffi-dev -y
sudo apt-get libssl-dev -y
sudo apt-get cargo -y 
sudo apt-get sed -y
sudo apt install python3-pip -y
sudo apt install python3 
sudo apt install python3-distutils -y
sudo apt install python3-twisted -y
sudo apt install python3-bitarray -y
sudo apt install python3-dev -y
sudo python3 get-pip.py
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
sudo apt install configparser
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
mkdir /var/www
mkdir /var/www/html

mkdir /var/log/ysf2dmr
mkdir /var/log/mmdvm
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

#################
echo iniciando instalacion

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
sudo chown -R mmdvm:mmdvm /var/log/YSFReflector

###############################

mkdir /opt/YSF2DMR

cd /opt/
git clone https://github.com/juribeparada/MMDVM_CM.git
sudo cp -r /opt/MMDVM_CM/YSF2DMR /opt/
cd YSF2DMR
sudo make
sudo make install

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
cat > /opt/MMDVMHost-Websocketboard/logtailer.ini <<- "EOF"
[DEFAULT]
# No need to touch this. If you want to bind it to a specific IP-address (if there are more than one interface to the
# network you can set your ip here - but default it listens on every interface
Host=0.0.0.0

# If changeing the port please change it also in the index.html-file at the parts where you find:
# new WebSocket("ws://" + window.location.hostname ...
Port=5679

# set to True if SSL will be used
Ssl=False
SslCert=/path/to/cert
SslKey=/path/to/keyfile

# This defines the maximum amount of loglines to be sent on initial opening of the dashboard
MaxLines=500

# Keep this parameter synchrone to Filerotate in MMDVM.ini/DMRHost.ini - if 0 then False, if 1 then True
Filerotate=False
#True

[MMDVMHost]
# Don't throw away the trailing slash! It is important but check logfile-location and Prefix twice :-)
Logdir=/var/log/mmdvm/

# Change this to DMRHost, if you are using DMRHost and configured this as log-prefix in the host-ini.
Prefix=MMDVMH
# if you want to have the operator-names as popup with the callsigns, set this parts = 1 and the LookupFile to
# the right position. On MMDVMHost comment out the DMRIDs.dat-line to have the DMRIds and not the callsigns in the
# logfile to have the callsigns with names transported to the dashboard.
DMR_ID_Lookup=1
DMR_ID_LookupFile=/opt/MMDVMHost/DMRIds.dat

# Location of your MMDVM.ini/DMRHost.ini or similar
MMDVM_ini=/opt/MMDVMHost/MMDVM.ini

# Localtion of your MMDVMHost/DMRHost-binary
MMDVM_bin=/opt/MMDVMHost/MMDVMHost
#/usr/local/bin/MMDVMHost

[DAPNETGateway]
# Don't throw away the trailing slash! It is important but check logfile-location and Prefix twice :-)
Logdir=/var/log/mmdvm
#/mnt/ramdisk/
Prefix=DAPNETGateway

[ServiceMonitoring]
# Here you list your Services to be monitored. Just add additional lines if needed but be sure to count them up
BinaryName1=MMDVMHost
BinaryName2=DMRGateway
BinaryName3=DGIdGateway
BinaryName4=YSF2DMR



EOF
#
cd /opt/MMDVMHost-Websocketboard/html/
sudo sed -i 's/5678/5679/' index.html
############################
cat > /lib/systemd/system/http.server-mmdvmh.service <<- "EOF"
[Unit]
Description=Python3 http.server.mmdvmhost
After=network.target

[Service]
User=root
Type=simple
#User=mmdvm
#Group=mmdvm
Restart=always
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
cd  /opt/MMDVMHost-Websocketboard/html/data/
sudo rm TG_List.csv
wget https://raw.githubusercontent.com/hp3icc/emq-TE1ws/main/TG_List.csv

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
######
cat > /bin/menu-mm-rtl <<- "EOF"
#!/bin/bash
while : ; do
choix=$(whiptail --title "Raspbian Proyect HP3ICC Menu Multimon-NG" --menu "Suba o Baje con las flechas del teclado y seleccione el numero de opcion" 20 50 11 \
1 " Editar Multimon-ng  APRS " \
2 " Iniciar APRS " \
3 " Detener APRS " \
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
sudo nano /etc/pymultimonaprs.json;;
2)
sudo systemctl restart multimon-rtl.service && sudo systemctl enable multimon-rtl.service;;
3)
sudo systemctl stop multimon-rtl.service && sudo systemctl disable multimon-rtl.service;;
4)
break;
esac
done
exit 0
EOF
###menu
sudo cat > /bin/menu <<- "EOF"
#!/bin/bash

while : ; do

choix=$(whiptail --title "TE1ws-Rev10e Raspbian Proyect HP3ICC Esteban Mackay 73." --menu "Suba o Baje con las flechas del teclado y seleccione el numero de opcion:" 24 58 15 \
1 " APRS Direwolf Analogo" \
2 " APRS Direwolf RTL-SDR " \
3 " APRS Multimon-ng " \
4 " APRS Ionosphere " \
5 " MMDVMHost " \
6 " Dvswitch " \
7 " pYSFReflector " \
8 " YSF2DMR " \
9 " HBLink Server " \
10 " FreeDMR Server " \
11 " Editar WiFi " \
12 " DDNS NoIP " \
13 " Reiniciar Raspberry " \
14 " APAGAR Raspberry " \
15 " Salir del menu " 3>&1 1>&2 2>&3)

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
menu-dw-analogo;;
2)
menu-dw-rtl;;
3)
menu-mm-rtl;;
4)
menu-ionos;;
5)
menu-mmdvm;;
6)
menu-dvs;;
7)
menu-ysf;;
8)
menu-ysf2dmr;;
9)
menu-hbl;;
10)
menu-fdmr;;
11)
menu-wifi;;
12)
menu-noip ;;
13)
sudo shutdown -r now ;;
14)
menu-apagar;;
15)
break;


esac

done
exit 0


EOF
##################################################
sudo cat > /bin/menu-fdmr <<- "EOF"
#!/bin/bash
while : ; do
choix=$(whiptail --title "Raspbian Proyect HP3ICC Menu FreeDMR" --menu "Suba o Baje con las flechas del teclado y seleccione el numero de opcion" 20 50 11 \
1 " Editar FreeDMR Server " \
2 " Editar Interlink  " \
3 " Editar HBMon2  " \
4 " Editar Puerto HTTP  " \
5 " Parrot on  " \
6 " Parrot off  " \
7 " Iniciar FreeDMR Server  " \
8 " Detener FreeDMR Server   " \
9 " Dashboard HBMon2 on " \
10 " Dashboard HBMon2 off  " \
11 " Menu Principal " 3>&1 1>&2 2>&3)
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
sudo nano /opt/FreeDMR/config/FreeDMR.cfg ;;
2)
sudo nano /opt/FreeDMR/config/rules.py ;;
3)
sudo nano /opt/HBMonv2/config.py ;;
4)
sudo nano /lib/systemd/system/http.server-fmr.service && sudo systemctl daemon-reload ;;
5)
sudo systemctl stop fdmrparrot.service && sudo systemctl start fdmrparrot.service && sudo systemctl enable fdmrparrot.service ;;
6)
sudo systemctl stop fdmrparrot.service &&  sudo systemctl disable fdmrparrot.service ;;
7)
sudo systemctl stop proxy.service && sudo systemctl start proxy.service && sudo systemctl enable proxy.service && sudo systemctl stop freedmr.service && sudo systemctl start freedmr.service && sudo systemctl enable freedmr.service ;;
8)
sudo systemctl stop freedmr.service && sudo systemctl disable freedmr.service && sudo systemctl stop proxy.service && sudo systemctl disable proxy.service ;;
9)
sudo rm /opt/HBMonv2/sysinfo/*.rrd && sudo sh /opt/HBMonv2/sysinfo/rrd-db.sh && cronedit.sh '*/5 * * * *' 'sudo /opt/HBMonv2/sysinfo/graph.sh' add && cronedit.sh '*/2 * * * *' 'sudo /opt/HBMonv2/sysinfo/cpu.sh' add && cronedit.sh '* */24 * * *' 'sudo /opt/HBMonv2/updateTGIDS.sh >/dev/null 2>&1' add && sudo systemctl stop hbmon2.service && sudo rm /opt/HBMonv2/*.json && sudo systemctl enable hbmon2.service && sudo systemctl start http.server-fmr.service && sudo systemctl enable http.server-fmr.service && sudo sh /opt/HBMonv2/updateTGIDS.sh ;;
10)
sudo systemctl stop hbmon2.service && sudo systemctl disable hbmon2.service && sudo systemctl stop http.server-fmr.service && sudo systemctl disable http.server-fmr.service && cronedit.sh '*/5 * * * *' 'sudo /opt/HBMonv2/sysinfo/graph.sh' remove && cronedit.sh '*/2 * * * *' 'sudo /opt/HBMonv2/sysinfo/cpu.sh' remove && cronedit.sh '* */24 * * *' 'sudo /opt/HBMonv2/updateTGIDS.sh >/dev/null 2>&1' remove ;;
11)
break;
esac
done
exit 0





EOF
############################
sudo cat > /lib/systemd/system/http.server-fmr.service <<- "EOF"
[Unit]
Description=Python3 http.server.fdmr
After=network.target

[Service]
User=root
Type=simple
#User=mmdvm
#Group=mmdvm
Restart=always
#ExecStartPre=/bin/sleep 30
# Modify for different location of Python3 or other port
ExecStart=php -S 0.0.0.0:80 -t /opt/HBMonv2/html/


[Install]
WantedBy=multi-user.target


EOF
#########
sudo cat > /bin/menu-hbl <<- "EOF"
#!/bin/bash

while : ; do

choix=$(whiptail --title "Raspbian Proyect HP3ICC Menu HBLink3" --menu "Suba o Baje con las flechas del teclado y seleccione el numero de opcion" 20 50 11 \
1 " Editar HBLink Server " \
2 " Editar Interlink  " \
3 " Editar HBMon  " \
4 " Parrot on  " \
5 " Parrot off  " \
6 " Iniciar HBLink Server  " \
7 " Detener HBLink Server   " \
8 " Dashboard HBMon on " \
9 " Dashboard HBMon off  " \
10 " Menu Principal " 3>&1 1>&2 2>&3)

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
sudo nano /opt/HBlink3/hblink.cfg ;;
2)
sudo nano /opt/HBlink3/rules.py ;;
3)
sudo nano /opt/HBmonitor/config.py ;;
4)
sudo systemctl stop hbparrot.service && sudo systemctl start hbparrot.service && sudo systemctl enable hbparrot.service ;;
5)
sudo systemctl stop hbparrot.service &&  sudo systemctl disable hbparrot.service ;;
6)
sudo systemctl stop hblink.service && sudo systemctl start hblink.service && sudo systemctl enable hblink.service ;;
7)
sudo systemctl stop hblink.service &&  sudo systemctl disable hblink.service && rm /var/log/hblink/* ;;
8)
sudo systemctl stop hbmon.service && sudo systemctl start hbmon.service && sudo systemctl enable hbmon.service ;;
9)
sudo systemctl stop hbmon.service && sudo systemctl disable hbmon.service && sudo rm /opt/HBmonitor/*.json ;;
10)
break;




esac

done
exit 0




EOF

######menu-wifi
cat > /bin/menu-wifi <<- "EOF"
#!/bin/bash
while : ; do
choix=$(whiptail --title "Raspbian Proyect HP3ICC Menu WiFi" --menu "Suba o Baje con las flechas del teclado y seleccione el numero de opcion" 20 50 11 \
1 " Editar redes WiFi " \
2 " Reiniciar dispositivo WiFi " \
3 " Buscar redes wifi cercanas " \
4 " Ver intensidad de WIFI  " \
5 " Menu Principal " 3>&1 1>&2 2>&3)
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
sudo nano /etc/wpa_supplicant/wpa_supplicant.conf ;;
2)
sudo ifconfig wlan0 down && sudo ifconfig wlan0 up ;;
3)
cd /tmp && sudo sudo iwlist wlan0 scan | grep ESSID | grep -o '"[^"]\+"' >> ssid.txt && nano ssid.txt && sudo rm ssid.txt ;;
4)
sudo wavemon ;;
5)
break;
esac
done
exit 0
EOF


####menu-mmdvm
cat > /bin/menu-mmdvm <<- "EOF"
#!/bin/bash
while : ; do
choix=$(whiptail --title "Raspbian Proyect HP3ICC Menu MMDVMHost" --menu "Suba o Baje con las flechas del teclado y seleccione el numero de opcion" 20 50 10 \
1 " Editar MMDVMHost " \
2 " Iniciar MMDVMHost " \
3 " Detener MMDVMHost " \
4 " Dashboard ON " \
5 " Dashboard Off " \
6 " Editar Puerto http " \
7 " Editar HTML  " \
8 " actualizar nombres de TG y sala europelink  " \
9 " actualizar nombres de TG y sala worldlink " \
10 " Menu Principal " 3>&1 1>&2 2>&3)
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
sudo nano /opt/MMDVMHost/MMDVM.ini;;
2)
sudo sh /opt/MMDVMHost/DMRIDUpdate.sh && sudo systemctl enable dmrid-mmdvm.service ;;
3)
sudo systemctl stop mmdvmh.service && sudo systemctl stop dmrid-mmdvm.service && sudo systemctl disable dmrid-mmdvm.service && sudo rm /var/log/mmdvm/MMDVMH.* ;;
4)
sudo systemctl restart logtailer-mmdvmh.service && sudo systemctl enable logtailer-mmdvmh.service && sudo systemctl restart http.server-mmdvmh.service && sudo systemctl enable http.server-mmdvmh.service ;;
5)
sudo systemctl stop logtailer-mmdvmh.service && sudo systemctl disable logtailer-mmdvmh.service && sudo systemctl stop http.server-mmdvmh.service && sudo systemctl disable http.server-mmdvmh.service ;;
6)
sudo nano /lib/systemd/system/http.server-mmdvmh.service && sudo systemctl daemon-reload ;;
7)
sudo nano /opt/MMDVMHost-Websocketboard/html/index.html ;;
8)
cd  /opt/MMDVMHost-Websocketboard/html/data/ && wget https://raw.githubusercontent.com/hp3icc/emq-TE1ws/main/TG_List.csv && sudo rm *.csv* && wget https://raw.githubusercontent.com/hp3icc/emq-TE1ws/main/TG_List.csv ;;
9)
cd  /opt/MMDVMHost-Websocketboard/html/data/ && wget https://raw.githubusercontent.com/hp3icc/emq-TE1ws/main/TG_List.csv && sudo rm *.csv* && wget https://raw.githubusercontent.com/hp3icc/emq-TE1ws/main/TG_List-WL.csv && sudo mv TG_List-WL.csv TG_List.csv;;
10)
break;
esac
done
exit 0
EOF
########menu-ysf
cat > /bin/menu-ysf <<- "EOF"
#!/bin/bash
while : ; do
choix=$(whiptail --title "Raspbian Proyect HP3ICC Menu YSFReflector" --menu "Suba o Baje con las flechas del teclado y seleccione el numero de opcion" 20 50 11 \
1 " Editar pYSFReflector Server " \
2 " Iniciar Reflector  " \
3 " Detener Reflector  " \
4 " Dashboard on  " \
5 " Dashboard off  " \
6 " Editar Puerto http  " \
7 " Editar HTML  " \
8 " Editar Dashboard  " \
9 " Menu Principal " 3>&1 1>&2 2>&3)
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
sudo nano /lib/systemd/system/http.server-ysf.service && sudo systemctl daemon-reload ;;
7)
sudo nano /opt/WSYSFDash/html/index.html ;;
8)
nano /opt/WSYSFDash/html/js/config.js ;;
9)
break;
esac
done
exit 0
EOF
##########menu-dvs
cat > /bin/menu-dvs <<- "EOF"
#!/bin/bash
while : ; do
choix=$(whiptail --title "Raspbian Proyect HP3ICC Menu DVSwitch" --menu "Nota : Debe encender Dvswitch antes de editar para utilizar." 20 60 11 \
1 " Dvswitch ON " \
2 " Dvswitch OFF  " \
3 " Editar Dvswitch Server " \
4 " Editar Puerto http  " \
5 " Dashboard on  " \
6 " Dashboard off  " \
7 " Menu Principal " 3>&1 1>&2 2>&3)
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
sudo systemctl restart analog_bridge.service && sudo systemctl restart mmdvm_bridge.service && sudo systemctl restart nxdngateway.service && sudo systemctl restart p25gateway.service && sudo systemctl restart ysfgateway.service && sudo systemctl enable analog_bridge.service && sudo systemctl enable mmdvm_bridge.service && sudo systemctl enable nxdngateway.service && sudo systemctl enable p25gateway.service && sudo systemctl enable ysfgateway.service ;;
2)
sudo systemctl stop analog_bridge.service && sudo systemctl stop mmdvm_bridge.service && sudo systemctl stop nxdngateway.service && sudo systemctl stop p25gateway.service && sudo systemctl stop ysfgateway.service && sudo systemctl disable analog_bridge.service && sudo systemctl disable mmdvm_bridge.service && sudo systemctl disable nxdngateway.service && sudo systemctl disable p25gateway.service && sudo systemctl disable ysfgateway.service ;;
3)
sudo /usr/local/dvs/dvs ;;
4)
nano /lib/systemd/system/http.server-dvs.service && sudo systemctl daemon-reload ;;
5)
sudo systemctl restart http.server-dvs.service && sudo systemctl enable http.server-dvs.service ;;
6)
sudo systemctl stop http.server-dvs.service && sudo systemctl disable http.server-dvs.service ;;
7)
break;
esac
done
exit 0
EOF
#
cat > /lib/systemd/system/http.server-dvs.service <<- "EOF"
[Unit]
Description=PHP http.server.DVS
After=network.target

[Service]
User=root
Type=simple
#User=mmdvm
#Group=mmdvm
Restart=always
#ExecStartPre=/bin/sleep 30
# Modify for different other port
ExecStart=php -S 0.0.0.0:80 -t /var/www/html

[Install]
WantedBy=multi-user.target



EOF
###menu-apagar
cat > /bin/menu-apagar <<- "EOF"
#!/bin/bash
while : ; do
choix=$(whiptail --title "Raspbian Proyect HP3ICC Esteban Mackay 73." --menu "Suba o Baje con las flechas del teclado y seleccione el numero de opcion" 11 85 3 \
1 " Iniciar apagado seguro" \
2 " Retornar  menu " 3>&1 1>&2 2>&3)
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
sudo shutdown -h now
;;
2) break;
esac
done
exit 0
EOF
#####menu-dw-analogo
cat > /bin/menu-dw-analogo <<- "EOF"
#!/bin/bash
while : ; do
choix=$(whiptail --title "Raspbian Proyect HP3ICC Menu Direwolf" --menu "Suba o Baje con las flechas del teclado y seleccione el numero de opcion" 20 55 11 \
1 " Editar Direwolf Analogo " \
2 " Iniciar APRS " \
3 " Detener APRS " \
4 " Compatibilidad Raspberry Zero " \
5 " Compatibilidad Raspberry Standard " \
6 " Menu Principal " 3>&1 1>&2 2>&3)
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
sudo nano /opt/direwolf/dw.conf;;
2)
sudo systemctl restart direwolf.service && sudo systemctl enable direwolf.service;;
3)
sudo systemctl stop direwolf.service && sudo systemctl disable direwolf.service;;
4)
sudo rm /usr/local/bin/direwolf && sudo cp /opt/direwolf/direwolf1 /usr/local/bin/direwolf && sudo chmod +x /usr/local/bin/direwolf;;
5)
sudo rm /usr/local/bin/direwolf && sudo cp /opt/direwolf/direwolf2 /usr/local/bin/direwolf && sudo chmod +x /usr/local/bin/direwolf;;
6)
break;
esac
done
exit 0
EOF
######menu-dw-rtl
cat > /bin/menu-dw-rtl <<- "EOF"
#!/bin/bash
while : ; do
choix=$(whiptail --title "Raspbian Proyect HP3ICC Menu Direwolf SDR" --menu "Suba o Baje con las flechas del teclado y seleccione el numero de opcion" 20 50 11 \
1 " Editar Direwolf SDR " \
2 " Editar RTL-SDR " \
3 " Iniciar APRS RX-IGate " \
4 " Detener APRS RX-IGate " \
5 " Compatibilidad Raspberry Zero " \
6 " Compatibilidad Raspberry Standard " \
7 " Menu Principal " 3>&1 1>&2 2>&3)
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
sudo nano /opt/direwolf/sdr.conf ;;
2)
sudo nano /opt/direwolf/rtl.sh ;;
3)
sudo systemctl restart direwolf-rtl.service && sudo systemctl enable direwolf-rtl.service;;
4)
sudo systemctl stop direwolf-rtl.service && sudo systemctl disable direwolf-rtl.service;;
5)
sudo rm /usr/local/bin/direwolf && sudo cp /opt/direwolf/direwolf1 /usr/local/bin/direwolf && sudo chmod +x /usr/local/bin/direwolf;;
6)
sudo rm /usr/local/bin/direwolf && sudo cp /opt/direwolf/direwolf2 /usr/local/bin/direwolf && sudo chmod +x /usr/local/bin/direwolf;;
7)
break;
esac
done
exit 0
EOF
#####
######menu-ysf2dmr
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

chmod +x /opt/ionsphere/ionosphere-raspberry-pi/ionosphere
chmod +x /opt/ionsphere/ionosphere-raspberry-pi/ionos.sh
chmod +777 /opt/ionsphere/ionosphere-raspberry-pi/ionos.sh
###nano /opt/ionsphere/ionosphere-raspberry-pi/config/config.yml

#####menu-ionos
cat > /bin/menu-ionos <<- "EOF"
#!/bin/bash
while : ; do
choix=$(whiptail --title "Raspbian Proyect HP3ICC Menu IonosPhere" --menu "Suba o Baje con las flechas del teclado y seleccione el numero de opcion" 20 50 11 \
1 " Editar Ionosphere  APRS " \
2 " Iniciar APRS " \
3 " Detener APRS " \
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
sudo nano /opt/ionsphere/ionosphere-raspberry-pi/config/config.yml ;;
2)
systemctl enable ionos.service && sudo systemctl restart ionos.service ;;
3)
sudo systemctl stop ionos.service && sudo systemctl disable ionos.service ;;
4)
break;
esac
done
exit 0
EOF
################################
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
ExecStart=sh /opt/ionsphere/ionosphere-raspberry-pi/ionos.sh
ExecReload=/bin/kill -HUP $MAINPID
KillMode=process
[Install]
# To make the network-online.target available
# systemctl enable systemd-networkd-wait-online.service
WantedBy=network-online.target
EOF
##########################################
###################
cat > /lib/systemd/system/dmrid-mmdvm.service  <<- "EOF"
[Unit]
Description=DMRIDupdate MMDVMHost
Wants=network-online.target
After=syslog.target network-online.target

[Service]
User=root
#ExecStartPre=/bin/sleep 1800
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
WorkingDirectory=/opt/MMDVMHost
#ExecStartPre=/bin/sleep 10
ExecStart=/opt/MMDVMHost/MMDVMHost /opt/MMDVMHost/MMDVM.ini
#ExecStart=/usr/bin/screen -S MMDVMHost -D -m /home/MMDVMHost/MMDVMHost /home/M$
ExecStop=/usr/bin/screen -S MMDVMHost -X quit

[Install]
WantedBy=multi-user.target

EOF
################
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
ExecStart=sudo direwolf -c /opt/direwolf/dw.conf
#ExecStart=/usr/bin/direwolf -t 0 -c /opt/direwolf/dw.conf
StandardOutput=syslog
StandardError=syslog
SyslogIdentifier=direwolf

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
#ExecStartPre=/bin/sleep 1800
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
#ExecStartPre=/bin/sleep 1800
ExecStart=/opt/direwolf/rtl.sh
# | direwolf -c /home/pi/direwolf/sdr.conf

[Install]
WantedBy=multi-user.target
#ExecStart= /usr/local/bin/rtl_fm -M fm -f 144.39M -p 0 -s 22050 -g 42 - | /usr/local/bin/direwolf -c /opt/direwolf/sdr.conf -r 22050 -D 1 -B 1200 -
EOF
#############

cat > /lib/systemd/system/multimon-rtl.service  <<- "EOF"
[Unit]
Description=Direwolf-RTL Service
Wants=network-online.target
After=syslog.target network-online.target

[Service]
User=root
#ExecStartPre=/bin/sleep 1800
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
WorkingDirectory=/opt/YSF2DMR
ExecStartPre=/bin/sleep 30
ExecStart=/opt/YSF2DMR/YSF2DMR /opt/YSF2DMR/YSF2DMR.ini

[Install]
WantedBy=multi-user.target

EOF
############

###############
cat > /opt/MMDVMHost/MMDVM.ini  <<- "EOF"
[General]
Callsign=HP3ICC
Id=714000000
Timeout=300
Duplex=0
ModeHang=3
#RFModeHang=10
#NetModeHang=3
Display=None
#Display=OLED
Daemon=0

[Info]
RXFrequency=431800000
TXFrequency=431800000
Power=1
# The following lines are only needed if a direct connection to a DMR master is being used
Latitude=0.0
Longitude=0.0
Height=0
Location=Panama
Description=Multi-Mode-MMDVM
URL=www.google.co.uk

[Log]
# Logging levels, 0=No logging
DisplayLevel=1
FileLevel=1
FilePath=/var/log/mmdvm
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
File=NXDN.csv
Time=24

[Modem]
# Port=/dev/ttyACM0
Port=/dev/ttyAMA0
#Port=\\.\COM4
#Protocol=uart
# Address=0x22
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
# POCSAGTXLevel=50
FMTXLevel=50
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

[UMP]
Enable=0
# Port=\\.\COM4
Port=/dev/ttyACM1

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
RemoteGateway=1
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

[POCSAG]
Enable=0
Frequency=439987500

[FM]
Enable=0
# Callsign=HP3ICC
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
AccessMode=1
COSInvert=0
RFAudioBoost=1
MaxDevLevel=90
ExtAudioBoost=1

[D-Star Network]
Enable=0
GatewayAddress=127.0.0.1
GatewayPort=20010
LocalPort=20011
# ModeHang=3
Debug=0

[DMR Network]
Enable=1
# Type may be either 'Direct' or 'Gateway'. When Direct you must provide the Master's
# address as well as the Password, and for DMR+, Options also.
Type=Direct
Address=3021.master.brandmeister.network
Port=62031
#Local=62032
Password=*********
Jitter=360
Slot1=1
Slot2=1
# Options=
# ModeHang=3
Debug=0

[System Fusion Network]
Enable=1
LocalAddress=127.0.0.1
#LocalPort=3200
GatewayAddress=europelink.pa7lim.nl
GatewayPort=42000
# ModeHang=3
Debug=0

[P25 Network]
Enable=0
GatewayAddress=127.0.0.1
GatewayPort=42020
LocalPort=32010
# ModeHang=3
Debug=0

[NXDN Network]
Enable=0
Protocol=Icom
LocalAddress=127.0.0.1
LocalPort=14021
GatewayAddress=127.0.0.1
GatewayPort=14020
# ModeHang=3
Debug=0

[POCSAG Network]
Enable=0
LocalAddress=127.0.0.1
LocalPort=3800
GatewayAddress=127.0.0.1
GatewayPort=4800
# ModeHang=3
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
# Port=modem
Port=/dev/ttyAMA0
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

cat > /bin/menu-noip  <<- "EOF"
#!/bin/bash
while : ; do
choix=$(whiptail --title "Raspbian Proyect HP3ICC Menu NoIP" --menu "Suba o Baje con las flechas del teclado y seleccione el numero de opcion" 20 50 11 \
1 " Activar NoIP " \
2 " Desactivar NoIP " \
3 " Info DDNS " \
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
cd /opt/noip/ && sudo tar vzxf noip-duc-linux.tar.gz && cd /opt/noip/noip-2.1.9-1/ && sudo make && sudo make install && cronedit.sh '*/10 * * * *' 'sudo /usr/local/bin/noip2' add ;;
2)
sudo rm -r /usr/local/bin/noip2 && sudo rm -r /usr/local/etc/no-ip2.conf && sudo rm -r /tmp/no-ip2.conf && sudo rm -r /opt/noip/noip-2.1.9-1 && cronedit.sh '*/10 * * * *' 'sudo /usr/local/bin/noip2' remove ;;
3)
cd /tmp && sudo noip2 -S &> noip.txt && nano noip.txt && sudo rm noip.txt;;
4)
break;
esac
done
exit 0


EOF
##############################
#dvswitch

cd /opt

wget http://dvswitch.org/buster

chmod +x buster

./buster

apt-get update -y

apt-get install dvswitch-server -y

cd /opt/YSFGateway/
sudo sed -i 's/42000/42500/' YSFGateway.ini
#/opt/YSFGateway/YSFGateway.ini
systemctl restart ysfgateway.service

####
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
Location=Panama
Description=MMDVM_Bridge
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
Jitter=360
Local=62032
Password=passw0rd
# for DMR+ see https://github.com/DVSwitch/MMDVM_Bridge/blob/master/DOC/DMRplus_startup_options.md
# for XLX the syntax is: Options=XLX:4009
# Options=
Slot1=0
Slot2=1
Debug=0

[System Fusion Network]
Enable=0
LocalAddress=0
LocalPort=3200
GatewayAddress=127.0.0.1
GatewayPort=4200
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
cd /home/
sudo cat > /home/requirements.txt <<- "EOF"
Twisted
dmr_utils3
bitstring
autobahn
jinja2==2.11.3

EOF
#
pip3 install setuptools wheel
pip3 install -r requirements.txt
sudo rm requirements.txt
#
cd /opt/
wget https://bootstrap.pypa.io/get-pip.py
git clone https://github.com/lz5pn/HBlink3
sudo mv /opt/HBlink3/ /opt/backup/
sudo mv /opt/backup/HBlink3/ /opt/
sudo mv /opt/backup/HBmonitor/ /opt/
sudo mv /opt/backup/dmr_utils3/ /opt/
sudo rm -r /opt/backup/
cd /opt/dmr_utils3
sudo chmod +x install.sh
sudo ./install.sh
sudo /usr/bin/python3 -m pip install --upgrade pip
sudo pip install --upgrade dmr_utils3
cd /opt/HBlink3
cp rules-SAMPLE.py rules.py
sudo sed -i 's/REPORT_CLIENTS: 127.0.0.1/REPORT_CLIENTS: */' playback.cfg
sudo sed -i 's/54100/49063/' playback.cfg
chmod +x playback.py
cp hblink-SAMPLE.cfg hblink.cfg
sudo sed -i 's/REPORT_CLIENTS: 127.0.0.1/REPORT_CLIENTS: */' hblink.cfg
sudo sed -i 's/PORT: 54000/PORT: 62030/' hblink.cfg
sudo sed -i 's/54001/54901/' hblink.cfg
sudo sed -i 's/54002/54902/' hblink.cfg
sudo sed -i 's/tmp/var\/log\/hblink/' hblink.cfg
sudo sed -i 's/s3cr37w0rd/passw0rd/' hblink.cfg
sudo sed -i 's/MASTER_PORT: 62030/MASTER_PORT: 62031/' hblink.cfg
sudo sed -i 's/54098/49062/' hblink.cfg
sudo sed -i 's/MASTER_PORT: 54100/MASTER_PORT: 49063/' hblink.cfg

#
sudo cat > /lib/systemd/system/hbparrot.service <<- "EOF"
[Unit]

Description=HB bridge all Service

After=network-online.target syslog.target

Wants=network-online.target

[Service]

StandardOutput=null

WorkingDirectory=/opt/HBlink3

RestartSec=3

ExecStart=/usr/bin/python3 /opt/HBlink3/playback.py -c /opt/HBlink3/playback.cfg

Restart=on-abort

[Install]

WantedBy=multi-user.target


EOF


#nano /lib/systemd/system/hblink.service
#Copiar este texto en el archivo
sudo cat > /lib/systemd/system/hblink.service <<- "EOF"
[Unit]
Description=Start HBlink

After=multi-user.target

[Service]
User=root
ExecStart=/usr/bin/python3 /opt/HBlink3/bridge.py

[Install]
WantedBy=multi-user.target



EOF
############
sudo rm /opt/HBlink3/*.json

###############################

### Instalar el  web monitor de HBLink.
cd /opt/HBmonitor
sudo chmod +x install.sh
sudo ./install.sh
sudo cp config_SAMPLE.py config.py
## Configurar el monitor
##nano /opt/HBmonitor/config.py
sudo cd /opt/HBmonitor/
sudo sed -i 's/8080/80/' config.py
#cp utils/hbmon.service /lib/systemd/system/
sudo cat > /lib/systemd/system/hbmon.service <<- "EOF"
[Unit]
Description=HBMonitor
# To make the network-online.target available
# systemctl enable systemd-networkd-wait-online.service

After=network-online.target syslog.target
Wants=network-online.target

[Service]
User=root
StandardOutput=null
WorkingDirectory=/opt/HBmonitor
RestartSec=3
ExecStart=/usr/bin/python3 /opt/HBmonitor/monitor.py
Restart=on-abort

[Install]
WantedBy=multi-user.target





EOF

##################
##DMRI DVS service 
cat > /lib/systemd/system/dmrid-dvs.service <<- "EOF"
[Unit]
Description=DMRIDupdate DVS
Wants=network-online.target
After=syslog.target network-online.target

[Service]
User=root
#ExecStartPre=/bin/sleep 1800
ExecStart=/opt/MMDVM_Bridge/DMRIDUpdate.sh

[Install]
WantedBy=multi-user.target
EOF
##########
#web

sudo groupadd www-data

sudo usermod -G www-data -a pi

sudo chown -R www-data:www-data /var/www/html

sudo chmod -R 775 /var/www/html
#############################
chmod +777 /var/www/web-dvs
chmod +777 /var/www/html/*
##
cat > /opt/DMRIDUpdate.sh <<- "EOF"
#! /bin/bash
###############################################################################
#
#                              CONFIGURATION
#
# Full path to DMR ID file, without final slash
DMRIDPATH=/opt
DMRIDFILE=${DMRIDPATH}/DMRIds.dat
# DMR IDs now served by RadioID.net
#DATABASEURL='https://ham-digital.org/status/users.csv'
DATABASEURL='https://www.radioid.net/static/user.csv'
#
# How many DMR ID files do you want backed up (0 = do not keep backups)
DMRFILEBACKUP=1
#
# Command line to restart MMDVMHost
RESTARTCOMMAND="systemctl restart mmdvmhost.service"
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

cp /opt/DMRIDUpdate.sh /opt/MMDVMHost/
cd /opt/MMDVMHost/
sudo sed -i 's/\/opt/\/opt\/MMDVMHost/' DMRIDUpdate.sh
sudo sed -i 's/systemctl restart mmdvmhost.service/systemctl restart mmdvmh.service/' DMRIDUpdate.sh


cp /opt/DMRIDUpdate.sh /opt/YSF2DMR/
cd /opt/YSF2DMR/
sudo sed -i 's/\/opt/\/opt\/YSF2DMR/' DMRIDUpdate.sh
sudo sed -i 's/systemctl restart mmdvmhost.service/systemctl restart ysf2dmr.service/' DMRIDUpdate.sh



cp /opt/DMRIDUpdate.sh /opt/MMDVM_Bridge/
cd /opt/MMDVM_Bridge/
sudo sed -i 's/\/opt/\/opt\/MMDVM_Bridge/' DMRIDUpdate.sh
sudo sed -i 's/systemctl restart mmdvmhost.service/systemctl restart mmdvm_bridge.service/' DMRIDUpdate.sh

sudo rm /opt/DMRIDUpdate.sh

###########################
sudo systemctl stop mmdvm_bridge.service 
sudo systemctl stop dmrid-dvs.service 
sudo systemctl stop analog_bridge.service 
sudo systemctl disable analog_bridge.service 
sudo systemctl disable mmdvm_bridge.service 
sudo systemctl disable dmrid-dvs.service
sudo systemctl disable lighttpd.service
sudo systemctl stop lighttpd.service
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
cat > /bin/cronedit.sh <<- "EOF"
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
sudo chmod +x /bin/cronedit.sh

##############
cd /opt
git clone https://gitlab.hacknix.net/hacknix/FreeDMR.git
cd FreeDMR
sudo chmod 0755 install.sh
sudo ./install.sh
mkdir config
#cp FreeDMR-SAMPLE-commented.cfg config/FreeDMR.cfg
#cp rules_SAMPLE.py config/rules.py

sudo chmod +x /opt/FreeDMR/bridge_master.py
sudo chmod +x /opt/FreeDMR/playback.py
sudo chmod +x /opt/FreeDMR/hotspot_proxy_v2.py

sudo cat > /lib/systemd/system/proxy.service <<- "EOF"
[Unit]
Description= Proxy Service 

After=syslog.target network.target


[Service]
User=root
WorkingDirectory=/opt/FreeDMR
ExecStart=/usr/bin/python3 hotspot_proxy_v2.py

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
ExecStartPre=/bin/sleep 30
#ExecStart=/usr/bin/python3 /opt/FreeDMR/bridge.py -c /opt/FreeDMR/config/FreeDMR.cfg -r /opt/FreeDMR/config/rules.py
ExecStart=/usr/bin/python3 /opt/FreeDMR/bridge_master.py -c /opt/FreeDMR/config/FreeDMR.cfg -r /opt/FreeDMR/config/rules.py
#ExecStart=/usr/bin/python3 /opt/FreeDMR/bridge_all_master.py -c /opt/FreeDMR/config/FreeDMR.cfg -r /opt/FreeDMR/config/rules.py

#bridge_all_master.py

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
#######
cd /opt
git clone https://github.com/sp2ong/HBMonv2.git
cd HBMonv2
sudo chmod +x install.sh
sudo ./install.sh
cp config_SAMPLE.py config.py
sudo chmod +x /opt/HBMonv2/monitor.py

sudo cat > /opt/HBMonv2/updateTGIDS.sh <<- "EOF"
#!/bin/bash

#sleep $[ ( $RANDOM % 1800 )  + 1 ]s

cd /opt/HBMonv2
FILE_NAME="talkgroup_ids.json"
FETCH_URL="http://downloads.freedmr.uk/downloads/talkgroup_ids.json"

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

cd /opt/HBMonv2/sysinfo/
sudo sed -i 's/var\/www\/html/opt\/HBMonv2\/html/' cpu.sh
sudo sed -i 's/var\/www\/html/opt\/HBMonv2\/html/' graph.sh

sudo chmod +x /opt/HBMonv2/sysinfo/cpu.sh
sudo chmod +x /opt/HBMonv2/sysinfo/graph.sh
sudo chmod +x /opt/HBMonv2/sysinfo/rrd-db.sh
sudo sh /opt/HBMonv2/sysinfo/rrd-db.sh
sudo chmod +x /opt/HBMonv2/updateTGIDS.sh

sudo cat > /opt/HBMonv2/html/buttons.html <<- "EOF"
<div style="width: 1100px;">
<!-- HBMonitor buttons HTML code -->
<a href="index.php"><button class="button link">&nbsp;Home&nbsp;</button></a>
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
--->
&nbsp;
<a href="masters.php"><button class="button link">&nbsp;Masters&nbsp;</button></a>
&nbsp;
<a href="peers.php"><button class="button link">&nbsp;Peers&nbsp;</button></a>
&nbsp;
<a href="opb.php"><button class="button link">&nbsp;OpenBridge&nbsp;</button></a>
&nbsp;
<a href="moni.php"><button class="button link">&nbsp;Monitor&nbsp;</button></a>
&nbsp;
<a href="sysinfo.php"><button class="button link">&nbsp;System Info&nbsp;</button></a>
&nbsp;
<a title="Lastheard long list" href="log.php"><button class="button link">&nbsp;Lastheard&nbsp;</button></a>
&nbsp;
<a href="http://www.freedmr.uk/index.php/why-use-freedmr/"target="_blank"><button class="button link">&nbsp;Info FreeDMR&nbsp;</button></a>
&nbsp;
<a href="http://www.freedmr.uk/index.php/freedmr-servers/"target="_blank"><button class="button link">&nbsp;Info Server&nbsp;</button></a>
&nbsp;
<a href="http://repeater.uk.freedmr.link/status/server_status.php"target="_blank"><button class="button link">&nbsp;Status Server&nbsp;</button></a>
&nbsp;
<a href="http://repeater.uk.freedmr.link/status/count.php"target="_blank"><button class="button link">&nbsp;Ranking TG&nbsp;</button></a>
&nbsp;
<!--
&nbsp;
<a href="bridges.php"><button class="button link">&nbsp;Bridges&nbsp;</button></a>
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
</div>
<p></p>

EOF
###

sudo cat > /lib/systemd/system/hbmon2.service <<- "EOF"
[Unit]
Description=HBMonitor
# To make the network-online.target available
# systemctl enable systemd-networkd-wait-online.service

After=network-online.target syslog.target
Wants=network-online.target

[Service]
StandardOutput=null
WorkingDirectory=/opt/HBMonv2
RestartSec=3
ExecStartPre=/bin/sleep 45
ExecStart=/usr/bin/python3 /opt/HBMonv2/monitor.py
Restart=on-abort

[Install]
WantedBy=multi-user.target

EOF
###################
sudo cat > /opt/FreeDMR/config/FreeDMR.cfg <<- "EOF"
# PROGRAM-WIDE PARAMETERS GO HERE
# PATH - working path for files, leave it alone unless you NEED to change it
# PING_TIME - the interval that peers will ping the master, and re-try registraion
#           - how often the Master maintenance loop runs
# MAX_MISSED - how many pings are missed before we give up and re-register
#           - number of times the master maintenance loop runs before de-registering a peer
#
# ACLs:
#
# Access Control Lists are a very powerful tool for administering your system.
# But they consume packet processing time. Disable them if you are not using them.
# But be aware that, as of now, the configuration stanzas still need the ACL
# sections configured even if you're not using them.
#
# REGISTRATION ACLS ARE ALWAYS USED, ONLY SUBSCRIBER AND TGID MAY BE DISABLED!!!
#
# The 'action' May be PERMIT|DENY
# Each entry may be a single radio id, or a hypenated range (e.g. 1-2999)
# Format:
# 	ACL = 'action:id|start-end|,id|start-end,....'
#		--for example--
#	SUB_ACL: DENY:1,1000-2000,4500-60000,17
#
# ACL Types:
# 	REG_ACL: peer radio IDs for registration (only used on HBP master systems)
# 	SUB_ACL: subscriber IDs for end-users
# 	TGID_TS1_ACL: destination talkgroup IDs on Timeslot 1
# 	TGID_TS2_ACL: destination talkgroup IDs on Timeslot 2
#
# ACLs may be repeated for individual systems if needed for granularity
# Global ACLs will be processed BEFORE the system level ACLs
# Packets will be matched against all ACLs, GLOBAL first. If a packet 'passes'
# All elements, processing continues. Packets are discarded at the first
# negative match, or 'reject' from an ACL element.
#
# If you do not wish to use ACLs, set them to 'PERMIT:ALL'
# TGID_TS1_ACL in the global stanza is used for OPENBRIDGE systems, since all
# traffic is passed as TS 1 between OpenBridges
[GLOBAL]
PATH: ./
PING_TIME: 10
MAX_MISSED: 3
USE_ACL: True
REG_ACL: PERMIT:ALL
SUB_ACL: DENY:1
TGID_TS1_ACL: PERMIT:ALL
TGID_TS2_ACL: PERMIT:ALL
GEN_STAT_BRIDGES: True
ALLOW_NULL_PASSPHRASE: True
ANNOUNCEMENT_LANGUAGES: en_GB,en_GB_2,en_US,es_ES,es_ES_2,fr_FR,de_DE,dk_DK,it_IT,no_NO,pl_PL,se_SE,pt_PT,CW
SERVER_ID: 0000


# NOT YET WORKING: NETWORK REPORTING CONFIGURATION
#   Enabling "REPORT" will configure a socket-based reporting
#   system that will send the configuration and other items
#   to a another process (local or remote) that may process
#   the information for some useful purpose, like a web dashboard.
#
#   REPORT - True to enable, False to disable
#   REPORT_INTERVAL - Seconds between reports
#   REPORT_PORT - TCP port to listen on if "REPORT_NETWORKS" = NETWORK
#   REPORT_CLIENTS - comma separated list of IPs you will allow clients
#       to connect on. Entering a * will allow all.
#
# ****FOR NOW MUST BE TRUE - USE THE LOOPBACK IF YOU DON'T USE THIS!!!****
[REPORTS]
REPORT: True
REPORT_INTERVAL: 60
REPORT_PORT: 4321
REPORT_CLIENTS: *
#127.0.0.1


# SYSTEM LOGGER CONFIGURAITON
#   This allows the logger to be configured without chaning the individual
#   python logger stuff. LOG_FILE should be a complete path/filename for *your*
#   system -- use /dev/null for non-file handlers.
#   LOG_HANDLERS may be any of the following, please, no spaces in the
#   list if you use several:
#       null
#       console
#       console-timed
#       file
#       file-timed
#       syslog
#   LOG_LEVEL may be any of the standard syslog logging levels, though
#   as of now, DEBUG, INFO, WARNING and CRITICAL are the only ones
#   used.
#
[LOGGER]
LOG_FILE: /var/log/FreeDMR/FreeDMR.log
LOG_HANDLERS: console-timed
LOG_LEVEL: DEBUG
LOG_NAME: HBlink

# DOWNLOAD AND IMPORT SUBSCRIBER, PEER and TGID ALIASES
# Ok, not the TGID, there's no master list I know of to download
# This is intended as a facility for other applcations built on top of
# HBlink to use, and will NOT be used in HBlink directly.
# STALE_DAYS is the number of days since the last download before we
# download again. Don't be an ass and change this to less than a few days.
[ALIASES]
TRY_DOWNLOAD: True
PATH: ./
PEER_FILE: peer_ids.json
SUBSCRIBER_FILE: subscriber_ids.json
TGID_FILE: talkgroup_ids.json
PEER_URL: https://www.radioid.net/static/rptrs.json
SUBSCRIBER_URL: https://www.radioid.net/static/users.json
TGID_URL: http://downloads.freedmr.uk/downloads/talkgroup_ids.json
STALE_DAYS: 7

#Read further repeater configs from MySQL
[MYSQL]
USE_MYSQL: False
USER: hblink
PASS: mypassword
DB: hblink
SERVER: 127.0.0.1
PORT: 3306
TABLE: repeaters

# OPENBRIDGE INSTANCES - DUPLICATE SECTION FOR MULTIPLE CONNECTIONS
# OpenBridge is a protocol originall created by DMR+ for connection between an
# IPSC2 server and Brandmeister. It has been implemented here at the suggestion
# of the Brandmeister team as a way to legitimately connect HBlink to the
# Brandemiester network.
# It is recommended to name the system the ID of the Brandmeister server that
# it connects to, but is not necessary. TARGET_IP and TARGET_PORT are of the
# Brandmeister or IPSC2 server you are connecting to. PASSPHRASE is the password
# that must be agreed upon between you and the operator of the server you are
# connecting to. NETWORK_ID is a number in the format of a DMR Radio ID that
# will be sent to the other server to identify this connection.
# other parameters follow the other system types.
#
# ACLs:
# OpenBridge does not 'register', so registration ACL is meaningless.
# OpenBridge passes all traffic on TS1, so there is only 1 TGID ACL.
# Otherwise ACLs work as described in the global stanza

[OBP-xx]
MODE: OPENBRIDGE
ENABLED: False
IP: 
PORT: 62081
NETWORK_ID: xxxx
PASSPHRASE: xxxxx
TARGET_IP: xxxxxxxxxxx
TARGET_PORT: 62081
USE_ACL: True
SUB_ACL: DENY:0-1000000
TGID_ACL: PERMIT:ALL
TGID_TS1_ACL: DENY :0-89
#DEFAULT_UA_TIMER: 15
RELAX_CHECKS: True
ENHANCED_OBP: True



# MASTER INSTANCES - DUPLICATE SECTION FOR MULTIPLE MASTERS
# HomeBrew Protocol Master instances go here.
# IP may be left blank if there's one interface on your system.
# Port should be the port you want this master to listen on. It must be unique
# and unused by anything else.
# Repeat - if True, the master repeats traffic to peers, False, it does nothing.
#
# MAX_PEERS -- maximun number of peers that may be connect to this master
# at any given time. This is very handy if you're allowing hotspots to
# connect, or using a limited computer like a Raspberry Pi.
#
# ACLs:
# See comments in the GLOBAL stanza
[MASTER-1]
MODE: MASTER
ENABLED: True
REPEAT: True
MAX_PEERS: 1
EXPORT_AMBE: False
IP: 127.0.0.1
PORT: 54000 
#54001
PASSPHRASE: passw0rd 
GROUP_HANGTIME: 3
USE_ACL: True
REG_ACL: DENY:1
SUB_ACL: DENY:1
TGID_TS1_ACL: PERMIT:ALL
TGID_TS2_ACL: PERMIT:ALL
DEFAULT_UA_TIMER: 999
SINGLE_MODE: True
VOICE_IDENT: False
TS1_STATIC:
TS2_STATIC:
DEFAULT_REFLECTOR: 0
ANNOUNCEMENT_LANGUAGE: es_ES_2
#es_ES_2
#es_ES
GENERATOR: 100
#en_GB



[EchoTest]
MODE: PEER
ENABLED: False
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
######
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

# '9990': [ 
#	{'SYSTEM': 'EchoTest', 		'TS': 2, 'TGID': 9990, 'ACTIVE':True, 'TIMEOUT': 0, 'TO_TYPE': 'NONE', 'ON': [], 'OFF': [], 'RESET': []}, 

#	],


}
if __name__ == '__main__':
    from pprint import pprint
    pprint(BRIDGES)

EOF
########
sudo cat > /opt/FreeDMR/playback.cfg <<- "EOF"
# PROGRAM-WIDE PARAMETERS GO HERE
# PATH - working path for files, leave it alone unless you NEED to change it
# PING_TIME - the interval that peers will ping the master, and re-try registraion
#           - how often the Master maintenance loop runs
# MAX_MISSED - how many pings are missed before we give up and re-register
#           - number of times the master maintenance loop runs before de-registering a peer
#
# ACLs:
#
# Access Control Lists are a very powerful tool for administering your system.
# But they consume packet processing time. Disable them if you are not using them.
# But be aware that, as of now, the configuration stanzas still need the ACL
# sections configured even if you're not using them.
#
# REGISTRATION ACLS ARE ALWAYS USED, ONLY SUBSCRIBER AND TGID MAY BE DISABLED!!!
#
# The 'action' May be PERMIT|DENY
# Each entry may be a single radio id, or a hypenated range (e.g. 1-2999)
# Format:
# 	ACL = 'action:id|start-end|,id|start-end,....'
#		--for example--
#	SUB_ACL: DENY:1,1000-2000,4500-60000,17
#
# ACL Types:
# 	REG_ACL: peer radio IDs for registration (only used on HBP master systems)
# 	SUB_ACL: subscriber IDs for end-users
# 	TGID_TS1_ACL: destination talkgroup IDs on Timeslot 1
# 	TGID_TS2_ACL: destination talkgroup IDs on Timeslot 2
#
# ACLs may be repeated for individual systems if needed for granularity
# Global ACLs will be processed BEFORE the system level ACLs
# Packets will be matched against all ACLs, GLOBAL first. If a packet 'passes'
# All elements, processing continues. Packets are discarded at the first
# negative match, or 'reject' from an ACL element.
#
# If you do not wish to use ACLs, set them to 'PERMIT:ALL'
# TGID_TS1_ACL in the global stanza is used for OPENBRIDGE systems, since all
# traffic is passed as TS 1 between OpenBridges
[GLOBAL]
PATH: ./
PING_TIME: 10
MAX_MISSED: 3
USE_ACL: True
REG_ACL: PERMIT:ALL
SUB_ACL: DENY:1
TGID_TS1_ACL: PERMIT:ALL
TGID_TS2_ACL: PERMIT:ALL
GEN_STAT_BRIDGES: False
ALLOW_NULL_PASSPHRASE: False
ANNOUNCEMENT_LANGUAGES: es_ES
SERVER_ID: 9990



# NOT YET WORKING: NETWORK REPORTING CONFIGURATION
#   Enabling "REPORT" will configure a socket-based reporting
#   system that will send the configuration and other items
#   to a another process (local or remote) that may process
#   the information for some useful purpose, like a web dashboard.
#
#   REPORT - True to enable, False to disable
#   REPORT_INTERVAL - Seconds between reports
#   REPORT_PORT - TCP port to listen on if "REPORT_NETWORKS" = NETWORK
#   REPORT_CLIENTS - comma separated list of IPs you will allow clients
#       to connect on. Entering a * will allow all.
#
# ****FOR NOW MUST BE TRUE - USE THE LOOPBACK IF YOU DON'T USE THIS!!!****
[REPORTS]
REPORT: False
REPORT_INTERVAL: 60
REPORT_PORT: 4821
REPORT_CLIENTS: 127.0.0.1


# SYSTEM LOGGER CONFIGURAITON
#   This allows the logger to be configured without chaning the individual
#   python logger stuff. LOG_FILE should be a complete path/filename for *your*
#   system -- use /dev/null for non-file handlers.
#   LOG_HANDLERS may be any of the following, please, no spaces in the
#   list if you use several:
#       null
#       console
#       console-timed
#       file
#       file-timed
#       syslog
#   LOG_LEVEL may be any of the standard syslog logging levels, though
#   as of now, DEBUG, INFO, WARNING and CRITICAL are the only ones
#   used.
#
[LOGGER]
LOG_FILE: /dev/null
LOG_HANDLERS: null
LOG_LEVEL: DEBUG
LOG_NAME: HBlink

# DOWNLOAD AND IMPORT SUBSCRIBER, PEER and TGID ALIASES
# Ok, not the TGID, there's no master list I know of to download
# This is intended as a facility for other applcations built on top of
# HBlink to use, and will NOT be used in HBlink directly.
# STALE_DAYS is the number of days since the last download before we
# download again. Don't be an ass and change this to less than a few days.
[ALIASES]
TRY_DOWNLOAD: False
PATH: ./
PEER_FILE: peer_ids.json
SUBSCRIBER_FILE: subscriber_ids.json
TGID_FILE: talkgroup_ids.json
PEER_URL: https://www.radioid.net/static/rptrs.json
SUBSCRIBER_URL: https://www.radioid.net/static/users.json
TGID_URL: http://downloads.freedmr.uk/downloads/talkgroup_ids.json
STALE_DAYS: 7

#Read further repeater configs from MySQL
[MYSQL]
USE_MYSQL: False
USER: hblink
PASS: mypassword
DB: hblink
SERVER: 127.0.0.1
PORT: 3306
TABLE: repeaters

# OPENBRIDGE INSTANCES - DUPLICATE SECTION FOR MULTIPLE CONNECTIONS
# OpenBridge is a protocol originall created by DMR+ for connection between an
# IPSC2 server and Brandmeister. It has been implemented here at the suggestion
# of the Brandmeister team as a way to legitimately connect HBlink to the
# Brandemiester network.
# It is recommended to name the system the ID of the Brandmeister server that
# it connects to, but is not necessary. TARGET_IP and TARGET_PORT are of the
# Brandmeister or IPSC2 server you are connecting to. PASSPHRASE is the password
# that must be agreed upon between you and the operator of the server you are
# connecting to. NETWORK_ID is a number in the format of a DMR Radio ID that
# will be sent to the other server to identify this connection.
# other parameters follow the other system types.
#
# ACLs:
# OpenBridge does not 'register', so registration ACL is meaningless.
# OpenBridge passes all traffic on TS1, so there is only 1 TGID ACL.
# Otherwise ACLs work as described in the global stanza
[OBP-TEST]
MODE: OPENBRIDGE
ENABLED: False
IP:
PORT: 62044
NETWORK_ID: 1
PASSPHRASE: mypass
TARGET_IP: 
TARGET_PORT: 62044
USE_ACL: True
SUB_ACL: DENY:1
TGID_ACL: PERMIT:9990
RELAX_CHECKS: False

# MASTER INSTANCES - DUPLICATE SECTION FOR MULTIPLE MASTERS
# HomeBrew Protocol Master instances go here.
# IP may be left blank if there's one interface on your system.
# Port should be the port you want this master to listen on. It must be unique
# and unused by anything else.
# Repeat - if True, the master repeats traffic to peers, False, it does nothing.
#
# MAX_PEERS -- maximun number of peers that may be connect to this master
# at any given time. This is very handy if you're allowing hotspots to
# connect, or using a limited computer like a Raspberry Pi.
#
# ACLs:
# See comments in the GLOBAL stanza
[PARROT]
MODE: MASTER
ENABLED: True
REPEAT: True
MAX_PEERS: 1
EXPORT_AMBE: False
IP: 127.0.0.1
PORT: 49061
#54915
PASSPHRASE: passw0rd
#passw0rd
GROUP_HANGTIME: 30
USE_ACL: True
REG_ACL: DENY:1
SUB_ACL: DENY:1
TGID_TS1_ACL: PERMIT:ALL
TGID_TS2_ACL: PERMIT:9990
DEFAULT_UA_TIMER: 9999
SINGLE_MODE: True
VOICE_IDENT: False
TS1_STATIC:
TS2_STATIC:9990 
DEFAULT_REFLECTOR: 0
GENERATOR: 1
ANNOUNCEMENT_LANGUAGE:es_ES

EOF
###########
cp /bin/menu /bin/MENU
chmod +x /bin/MENU
chmod +x /bin/menu*

##########################

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
        ssid="Coloque_aqui_nombre_de_red_wifi"
        psk="Coloque_aqui_la_clave_wifi"
}

network={
        ssid="WiFi-Net"
        psk="Panama310"
}
EOF
#######
################################################
#Direwolf
sudo apt-get remove --purge pulseaudio -y
sudo apt-get autoremove -y
rm -rf /home/pi/.pulse
cd /opt
	
git clone https://www.github.com/wb2osz/direwolf
cd direwolf
git checkout dev
mkdir build
cd build
sudo cmake ..
sudo make -j4
sudo make install
sudo make install-conf

sudo cp /usr/local/bin/direwolf /opt/direwolf/direwolf2
cd /tmp/
wget https://github.com/hp3icc/emq-TE1ws/raw/main/direwolf
sudo mv /tmp/direwolf /opt/direwolf/direwolf1

##########
#############
cat > /opt/direwolf/rtl.sh  <<- "EOF"
#!/bin/sh
PATH=/bin:/usr/bin:/usr/local/bin
unset LANG
rtl_fm -M fm -f 144.39M -p 0 -s 22050 -g 42 - | /usr/local/bin/direwolf -c /opt/direwolf/sdr.conf -r 22050 -D 1 -B 1200 -
EOF
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
#AGWPORT 9000
#KISSPORT 9001
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
########################
echo finalizando instalacion
sudo chown -R mmdvm:mmdvm /opt/MMDVMHost/MMDVMHost
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

sudo chmod +x /opt/HBMonv2/sysinfo/graph.sh
sudo chmod +x /opt/HBMonv2/sysinfo/cpu.sh
sudo chmod +x /usr/bin/python3
sudo chmod +x /opt/HBmonitor/monitor.py
sudo chmod +x /opt/HBlink3/playback.py
sudo chmod +x /opt/HBlink3/bridge.py
sudo chmod +x /opt/MMDVM_Bridge/DMRIDUpdate.sh
sudo chmod +x /opt/YSF2DMR/DMRIDUpdate.sh
sudo chmod +x /opt/MMDVMHost/DMRIDUpdate.sh

sudo chmod 755 /lib/systemd/system/http.server-dvs.service
sudo chmod 755 /lib/systemd/system/http.server-fmr.service
sudo chmod 755 /lib/systemd/system/freedmr.service
sudo chmod 755 /lib/systemd/system/proxy.service
sudo chmod 755 /lib/systemd/system/hbmon2.service
sudo chmod 755 /lib/systemd/system/hblink.service
sudo chmod 755 /lib/systemd/system/hbmon.service
sudo chmod 755 /lib/systemd/system/hbparrot.service
sudo chmod 755 /lib/systemd/system/YSFReflector.service
sudo chmod 755 /lib/systemd/system/monp.service
sudo chmod 755 /lib/systemd/system/dmrid-ysf2dmr.service
sudo chmod 755 /lib/systemd/system/dmrid-dvs.service
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
sudo systemctl daemon-reload

sudo systemctl enable monp.service
sudo systemctl stop rsyslog
sudo systemctl disable rsyslog
rm /var/log/syslog*
rm /var/log/*.log*
cd /tmp/
cronedit.sh '* */1 * * *' 'sudo sync ; echo 3 > /proc/sys/vm/drop_caches >/dev/null 2>&1' add
#####
cat > /tmp/completado.sh <<- "EOF"
#!/bin/bash
while : ; do
choix=$(whiptail --title "Raspbian Proyect HP3ICC Esteban Mackay 73." --menu " Precione enter (return o intro) para finalizar la instalacion y reiniciar su equipo " 11 85 3 \
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
history -c && history -w
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
sh /tmp/completado.sh
