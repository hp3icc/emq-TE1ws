###menu
sudo cat > /bin/menu <<- "EOF"
#!/bin/bash

while : ; do

choix=$(whiptail --title "TE1ws-Rev: R00ab / Raspbian Proyect HP3ICC Esteban Mackay 73." --menu "Suba o Baje con las flechas del teclado y seleccione el numero de opcion:" 24 67 15 \
1 " APRS " \
2 " MMDVMHost " \
3 " Dvswitch " \
4 " pYSFReflector3 " \
5 " YSF2DMR " \
6 " FreeDMR Server " \
7 " Editar WiFi " \
8 " DDNS NoIP " \
9 " GoTTY " \
10 " Update " \
11 " Reiniciar Equipo " \
12 " Salir del menu " 3>&1 1>&2 2>&3)

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
menu-aprs;;
2)
menu-mmdvm;;
3)
menu-dvs;;
4)
menu-ysf;;
5)
menu-ysf2dmr;;
6)
menu-fdmr;;
7)
menu-wifi;;
8)
menu-noip ;;
9)
menu-web ;;
10)
sh -c "$(curl -fsSL https://raw.githubusercontent.com/hp3icc/emq-TE1ws/main/update.sh)" ;;
11)
menu-reboot ;;
12)
break;


esac

done
exit 0


EOF
#
################
sudo cat > /bin/menu-aprs <<- "EOF"
#!/bin/bash

while : ; do

choix=$(whiptail --title "Raspbian Proyect HP3ICC Menu APRS" --menu "Suba o Baje con las flechas del teclado y seleccione el numero de opcion:" 24 67 15 \
1 " APRS Direwolf Analogo" \
2 " APRS Direwolf RTL-SDR " \
3 " APRS Multimon-ng " \
4 " APRS Ionosphere " \
5 " Shell-APRS Beacon " \
6 " Salir del menu " 3>&1 1>&2 2>&3)

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
menu-bcon;;
6)
break;


esac

done
exit 0


EOF
#
###############
sudo cat > /bin/menu-bcon <<- "EOF"
#!/bin/bash
while : ; do
choix=$(whiptail --title "Raspbian Proyect HP3ICC Menu Shell-APRS Beacon" --menu "Suba o Baje con las flechas del teclado y seleccione el numero de opcion:" 23 56 13 \
1 " Editar Beacon-1 " \
2 " Editar Beacon-2 " \
3 " Editar Beacon-3 " \
4 " Editar Beacon-4 " \
5 " Start/Restart Beacon-1 " \
6 " Start/Restart Beacon-2  " \
7 " Start/Restart Beacon-3 " \
8 " Start/Restart Beacon-4 " \
9 " Stop Beacon-1  " \
10 " Stop Beacon-2   " \
11 " Stop Beacon-3 " \
12 " Stop Beacon-4 " \
13 " Menu Principal " 3>&1 1>&2 2>&3)
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
sudo nano /opt/shell-aprs/bcom1.sh ;;
2)
sudo nano /opt/shell-aprs/bcom2.sh ;;
3)
sudo nano /opt/shell-aprs/bcom3.sh ;;
4)
sudo nano /opt/shell-aprs/bcom4.sh ;;
5)
sudo systemctl stop aprsb1.service && sudo systemctl start aprsb1.service &&  sudo systemctl enable aprsb1.service ;;
6)
sudo systemctl stop aprsb2.service && sudo systemctl start aprsb2.service &&  sudo systemctl enable aprsb2.service ;;
7)
sudo systemctl stop aprsb3.service && sudo systemctl start aprsb3.service &&  sudo systemctl enable aprsb3.service ;;
8)
sudo systemctl stop aprsb4.service && sudo systemctl start aprsb4.service &&  sudo systemctl enable aprsb4.service ;;
9)
sudo systemctl stop aprsb1.service &&  sudo systemctl disable aprsb1.service ;;
10)
sudo systemctl stop aprsb2.service &&  sudo systemctl disable aprsb2.service ;;
11)
sudo systemctl stop aprsb3.service &&  sudo systemctl disable aprsb3.service ;;
12)
sudo systemctl stop aprsb4.service &&  sudo systemctl disable aprsb4.service ;;
13)
break;
esac
done
exit 0
EOF
############################
sudo cat > /bin/menu-fdmr <<- "EOF"
#!/bin/bash
while : ; do
choix=$(whiptail --title "Raspbian Proyect HP3ICC Menu FreeDMR" --menu "Suba o Baje con las flechas del teclado y seleccione el numero de opcion:" 23 56 13 \
1 " Editar FreeDMR Server " \
2 " Editar Interlink  " \
3 " Editar FDMR-Monitor  " \
4 " Editar Puerto HTTP  " \
5 " Parrot on  " \
6 " Parrot off  " \
7 " start FreeDMR Server  " \
8 " stop FreeDMR Server   " \
9 " FDMR-Monitor On&Restart " \
10 " FDMR-Monitor off  " \
11 " D-APRS Igate  " \
12 " Menu Principal " 3>&1 1>&2 2>&3)
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
sudo nano /opt/FDMR-Monitor/fdmr-mon.cfg ;;
4)
sudo nano /etc/apache2/ports.conf && systemctl restart apache2.service ;;
5)
sudo systemctl stop fdmrparrot.service && sudo systemctl start fdmrparrot.service && sudo systemctl enable fdmrparrot.service ;;
6)
sudo systemctl stop fdmrparrot.service &&  sudo systemctl disable fdmrparrot.service ;;
7)
sudo systemctl stop proxy.service && sudo systemctl start proxy.service && sudo systemctl enable proxy.service && sudo systemctl stop freedmr.service && sudo systemctl start freedmr.service && sudo systemctl enable freedmr.service ;;
8)
sudo systemctl stop freedmr.service && sudo systemctl disable freedmr.service && sudo systemctl stop proxy.service && sudo systemctl disable proxy.service && rm /var/log/FreeDMR/* ;;
9)
echo 123> /opt/FDMR-Monitor/data/123.json && sudo systemctl stop fdmr_mon.service && sudo rm /opt/FDMR-Monitor/data/* && sudo rm /opt/FDMR-Monitor/sysinfo/*.rrd && sh /opt/FDMR-Monitor/sysinfo/rrd-db.sh && cronedit.sh '*/5 * * * *' 'sh /opt/FDMR-Monitor/sysinfo/graph.sh' add && cronedit.sh '*/2 * * * *' 'sh /opt/FDMR-Monitor/sysinfo/cpu.sh' add && sudo systemctl enable fdmr_mon.service && sudo systemctl restart apache2.service && sudo systemctl enable apache2.service && sudo systemctl start fdmr_mon.service && cronedit.sh '0 3 * * *' 'rm /opt/FDMR-Monitor/data/*' add && cronedit.sh '1 3 * * *' 'sudo systemctl restart proxy.service' add ;;
10)
sudo systemctl stop fdmr_mon.service && sudo systemctl disable fdmr_mon.service && sudo systemctl stop apache2.service && sudo systemctl disable apache2.service && cronedit.sh '*/5 * * * *' 'sh /opt/FDMR-Monitor/sysinfo/graph.sh' remove && cronedit.sh '*/2 * * * *' 'sh /opt/FDMR-Monitor/sysinfo/cpu.sh' remove && cronedit.sh '0 3 * * *' 'rm /opt/FDMR-Monitor/data/*' remove && cronedit.sh '1 3 * * *' 'sudo systemctl restart proxy.service' remove ;;
11)
menu-igate ;;
12)
break;
esac
done
exit 0




EOF
######
#menu-wifi
cat > /bin/menu-wifi <<- "EOF"
#!/bin/bash
while : ; do
choix=$(whiptail --title "Raspbian Proyect HP3ICC Menu WiFi" --menu "Nota: al editar configuracion de redes Wifi conocidas, debe reiniciar el equipo, para aplicar cambios realizados." 20 75 11 \
1 " Editar redes WiFi conocidas" \
2 " Buscar redes wifi cercanas " \
3 " Ver intensidad de WIFI  " \
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
sudo nano /etc/wpa_supplicant/wpa_supplicant.conf ;;
2)
sudo iwlist wlan0 scan | grep ESSID | grep -o '"[^"]\+"' >> /tmp/ssid.txt && nano /tmp/ssid.txt && sudo rm /tmp/ssid.txt ;;
3)
sudo wavemon ;;
4)
break;
esac
done
exit 0

EOF
#
cat > /bin/menu-web <<- "EOF"
#!/bin/bash
while : ; do
choix=$(whiptail --title "Raspbian Proyect HP3ICC Web-Menu" --menu "Suba o Baje con las flechas del teclado y seleccione el numero de opcion" 20 50 11 \
1 " Habilitar Web-Menu " \
2 " Deshabilitar Web-Menu " \
3 " Editar Web-Menu " \
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
sudo systemctl stop gotty.service && sudo systemctl start gotty.service && sudo systemctl enable gotty.service;;
2)
sudo systemctl stop gotty.service && systemctl disable gotty.service ;;
3)
sudo nano /lib/systemd/system/gotty.service && sudo systemctl daemon-reload  ;;
4)
break;
esac
done
exit 0

EOF
######menu-mmdvm
cat > /bin/menu-mmdvm <<- "EOF"
#!/bin/bash
while : ; do
choix=$(whiptail --title "Raspbian Proyect HP3ICC Menu MMDVMHost" --menu "Suba o Baje con las flechas del teclado y seleccione el numero de opcion." 24 50 16 \
1 " Editar MMDVMHost " \
2 " Editar DMRGateway " \
3 " Editar YSFGateway " \
4 " Editar YSF2DMR " \
5 " Start&Restart service MMDVM " \
6 " Stop service MMDVM " \
7 " Dashboard ON " \
8 " Dashboard Off " \
9 " Editar Puerto http " \
10 " Editar HTML  " \
11 " Editar Dashboard  " \
12 " Dashboard Rooms: BM, europelink  " \
13 " Dashboard Rooms: BM, worldlink " \
14 " Dashboard Rooms: FreeDMR, europelink " \
15 " Dashboard Rooms: FreeDMR, worldlink " \
16 " Menu Principal " 3>&1 1>&2 2>&3)
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
sudo nano /opt/DMRGateway/DMRGateway.ini;;
3)
sudo nano /opt/YSFGateway2/YSFGateway.ini;;
4)
sudo nano /opt/YSF2DMRGW/YSF2DMR.ini;;
5)
sh /usr/local/bin/rpt-on.sh && sudo systemctl stop dmrid-mmdvm.service && sudo systemctl start dmrid-mmdvm.service && sudo systemctl enable dmrid-mmdvm.service && cronedit.sh '0 3 * * *' 'sh /opt/MMDVMHost/DMRIDUpdate.sh' add ;;
6)
sudo systemctl stop mmdvmh.service && sudo systemctl disable mmdvmh.service && systemctl stop ysf2dmrgw.service && sudo systemctl stop dmrgw.service && sudo systemctl stop dmrid-mmdvm.service && sudo systemctl disable dmrid-mmdvm.service && cronedit.sh '0 3 * * *' 'sh /opt/MMDVMHost/DMRIDUpdate.sh' remove && sudo rm /var/log/mmdvmh/MMDVMH.* ;;
7)
sudo systemctl restart logtailer-mmdvmh.service && sudo systemctl enable logtailer-mmdvmh.service && sudo systemctl restart http.server-mmdvmh.service && sudo systemctl enable http.server-mmdvmh.service ;;
8)
sudo systemctl stop logtailer-mmdvmh.service && sudo systemctl disable logtailer-mmdvmh.service && sudo systemctl stop http.server-mmdvmh.service && sudo systemctl disable http.server-mmdvmh.service ;;
9)
sudo nano /lib/systemd/system/http.server-mmdvmh.service && sudo systemctl daemon-reload ;;
10)
sudo nano /opt/MMDVMHost-Websocketboard/html/index.html ;;
11)
sudo nano /opt/MMDVMHost-Websocketboard/html/js/config.js ;;
12)
cd  /opt/MMDVMHost-Websocketboard/html/data/ && wget https://raw.githubusercontent.com/hp3icc/emq-TE1ws/main/TG_List.csv && sudo rm *.csv* && wget https://raw.githubusercontent.com/hp3icc/emq-TE1ws/main/TG_List.csv ;;
13)
cd  /opt/MMDVMHost-Websocketboard/html/data/ && wget https://raw.githubusercontent.com/hp3icc/emq-TE1ws/main/TG_List-WL.csv && sudo rm *.csv* && wget https://raw.githubusercontent.com/hp3icc/emq-TE1ws/main/TG_List-WL.csv && sudo mv TG_List-WL.csv TG_List.csv;;
14)
cd  /opt/MMDVMHost-Websocketboard/html/data/ && wget https://raw.githubusercontent.com/hp3icc/emq-TE1ws/main/FDMR-EURO.csv  && sudo rm *.csv* && wget https://raw.githubusercontent.com/hp3icc/emq-TE1ws/main/FDMR-EURO.csv && sudo mv FDMR-EURO.csv TG_List.csv;;
15)
cd  /opt/MMDVMHost-Websocketboard/html/data/ && wget https://raw.githubusercontent.com/hp3icc/emq-TE1ws/main/FDMR-WORLD.csv && sudo rm *.csv* && wget https://raw.githubusercontent.com/hp3icc/emq-TE1ws/main/FDMR-WORLD.csv && sudo mv FDMR-WORLD.csv TG_List.csv;;
16)
break;
esac
done
exit 0



EOF
#######menu-ysf
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
sudo nano /opt/pYSFReflector3/pysfreflector.ini ;;
2)
sudo systemctl stop YSFReflector.service && sudo systemctl start YSFReflector.service  && sudo systemctl enable YSFReflector.service ;;
3)
sudo systemctl stop YSFReflector.service && sudo systemctl disable YSFReflector.service && rm /var/log/YSFReflector/* ;;
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
1 " Encender Dvswitch " \
2 " Apagar Dvswitch " \
3 " Editar Dvswitch Server " \
4 " Cambiar Puerto http de Dashboard " \
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
sudo systemctl restart quantar_bridge.service && sudo systemctl enable quantar_bridge.service && sudo systemctl restart p25parrot.service && sudo systemctl enable p25parrot.service && sudo systemctl restart ysfparrot.service && sudo systemctl enable ysfparrot.service && sudo systemctl restart nxdnparrot.service && sudo systemctl enable nxdnparrot.service && sudo systemctl restart ircddbgatewayd.service && sudo systemctl enable ircddbgatewayd.service && sudo systemctl restart analog_bridge.service && sudo systemctl restart mmdvm_bridge.service && sudo systemctl restart nxdngateway.service && sudo systemctl restart p25gateway.service && sudo systemctl restart ysfgateway.service && sudo systemctl enable analog_bridge.service && sudo systemctl enable mmdvm_bridge.service && sudo systemctl enable nxdngateway.service && sudo systemctl enable p25gateway.service && sudo systemctl enable ysfgateway.service ;;
2)
sudo systemctl stop quantar_bridge.service && sudo systemctl disable quantar_bridge.service && sudo systemctl stop p25parrot.service && sudo systemctl disable p25parrot.service && sudo systemctl stop ysfparrot.service && sudo systemctl disable ysfparrot.service && sudo systemctl stop nxdnparrot.service && sudo systemctl disable nxdnparrot.service && sudo systemctl stop ircddbgatewayd.service && sudo systemctl disable ircddbgatewayd.service && sudo systemctl stop analog_bridge.service && sudo systemctl stop mmdvm_bridge.service && sudo systemctl stop nxdngateway.service && sudo systemctl stop p25gateway.service && sudo systemctl stop ysfgateway.service && sudo systemctl disable analog_bridge.service && sudo systemctl disable mmdvm_bridge.service && sudo systemctl disable nxdngateway.service && sudo systemctl disable p25gateway.service && sudo systemctl disable ysfgateway.service && rm /var/log/mmdvm/*;;
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
cat > /bin/menu-reboot <<- "EOF"
#!/bin/bash
while : ; do
choix=$(whiptail --title "Raspbian Proyect HP3ICC Esteban Mackay 73." --menu "Nota:  Reinicio automatico, verifica su conectividad a internet." 15 50 4 \
1 " Iniciar reinicio de equipo" \
2 " Habilitar reinicio automatico" \
3 " Deshabilitar reinicio automatico" \
4 " Retornar menu principal " 3>&1 1>&2 2>&3)
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
2)
sudo systemctl start rebooter1.service && sudo systemctl enable rebooter1.service ;;
3)
sudo systemctl stop rebooter1.service && sudo systemctl disable rebooter1.service ;;
4) break;
esac
done
exit 0

EOF
########
####menu-dw-analogo
cat > /bin/menu-dw-analogo <<- "EOF"
#!/bin/bash
while : ; do
choix=$(whiptail --title "Raspbian Proyect HP3ICC Menu Direwolf" --menu "Suba o Baje con las flechas del teclado y seleccione el numero de opcion" 20 55 11 \
1 " Editar Direwolf Analogo " \
2 " Iniciar APRS " \
3 " Detener APRS " \
4 " Compatibilidad Raspberry Zero" \
5 " Compatibilidad Raspberry B" \
6 " config Dashboard " \
7 " http port Dashbord " \
8 " Dashboard on " \
9 " Dashbord off " \
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
sudo nano /opt/direwolf/dw.conf;;
2)
sudo systemctl stop direwolf.service && sudo systemctl start direwolf.service && sudo systemctl enable direwolf.service;;
3)
sudo systemctl stop direwolf.service && sudo systemctl disable direwolf.service;;
4)
sudo rm /usr/local/bin/direwolf && sudo cp /opt/direwolf/direwolf1 /usr/local/bin/direwolf && sudo chmod +x /usr/local/bin/direwolf;;
5)
sudo rm /usr/local/bin/direwolf && sudo cp /opt/direwolf/direwolf2 /usr/local/bin/direwolf && sudo chmod +x /usr/local/bin/direwolf;;
6)
sudo nano /opt/direwolf_webstat/config.php;;
7)
sudo nano /lib/systemd/system/http.server-dw.service && sudo systemctl daemon-reload ;;
8)
sudo systemctl stop direwolf.service && cp /opt/direwolf/service2 /lib/systemd/system/direwolf.service && sudo systemctl daemon-reload && sudo systemctl start direwolf.service && sudo systemctl restart http.server-dw.service && sudo systemctl enable http.server-dw.service ;;
9)
sudo systemctl stop direwolf.service && cp /opt/direwolf/service1 /lib/systemd/system/direwolf.service && sudo systemctl daemon-reload && sudo systemctl start direwolf.service && sudo systemctl stop http.server-dw.service && sudo systemctl disable http.server-dw.service ;;
10)
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
7 " config Dashboard " \
8 " http port Dashbord " \
9 " Dashboard on " \
10 " Dashbord off " \
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
sudo nano /opt/direwolf/sdr.conf ;;
2)
sudo nano /opt/direwolf/rtl.sh ;;
3)
sudo systemctl stop direwolf-rtl.service && sudo systemctl start direwolf-rtl.service && sudo systemctl enable direwolf-rtl.service;;
4)
sudo systemctl stop direwolf-rtl.service && sudo systemctl disable direwolf-rtl.service;;
5)
sudo rm /usr/local/bin/direwolf && sudo cp /opt/direwolf/direwolf1 /usr/local/bin/direwolf && sudo chmod +x /usr/local/bin/direwolf;;
6)
sudo rm /usr/local/bin/direwolf && sudo cp /opt/direwolf/direwolf2 /usr/local/bin/direwolf && sudo chmod +x /usr/local/bin/direwolf;;
7)
sudo nano /opt/direwolf_webstat/config.php;;
8)
sudo nano /lib/systemd/system/http.server-dw.service && sudo systemctl daemon-reload ;;
9)
sudo systemctl stop direwolf-rtl.service && cp /opt/direwolf/rtl2.sh /opt/direwolf/rtl.sh && sudo chmod +x /opt/direwolf/rtl.sh && sudo systemctl start direwolf-rtl.service && sudo systemctl restart http.server-dw.service && sudo systemctl enable http.server-dw.service ;;
10)
sudo systemctl stop direwolf-rtl.service && cp /opt/direwolf/rtl1.sh /opt/direwolf/rtl.sh && sudo chmod +x /opt/direwolf/rtl.sh && sudo systemctl start direwolf-rtl.service && sudo systemctl stop http.server-dw.service && sudo systemctl disable http.server-dw.service ;;
11)
break;
esac
done
exit 0

EOF
#####
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
sudo systemctl stop dmrid-ysf2dmr.service && sudo systemctl start dmrid-ysf2dmr.service && sudo systemctl enable dmrid-ysf2dmr.service && cronedit.sh '0 3 * * *' 'sh /opt/YSF2DMR/DMRIDUpdate.sh' add ;;
3)
sudo systemctl stop dmrid-ysf2dmr.service && sudo systemctl disable dmrid-ysf2dmr.service && sudo systemctl stop ysf2dmr.service && rm /var/log/ysf2dmr/* && cronedit.sh '0 3 * * *' 'sh /opt/YSF2DMR/DMRIDUpdate.sh' remove ;;
4)
break;
esac
done
exit 0
EOF
###
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
#######################
cat > /bin/menu-noip  <<- "EOF"
#!/bin/bash
while : ; do
choix=$(whiptail --title "Raspbian Proyect HP3ICC Menu NoIP" --menu "Suba o Baje con las flechas del teclado y seleccione el numero de opcion" 20 50 11 \
1 " Activar NoIP " \
2 " Desactivar NoIP " \
3 " Info DDNS " \
4 " IP Publica " \
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
cd /opt/noip/ && sudo tar vzxf noip-duc-linux.tar.gz && cd /opt/noip/noip-2.1.9-1/ && sudo make && sudo make install && cronedit.sh '@reboot' 'sudo /usr/local/bin/noip2' add && /usr/local/bin/noip2 ;;
2)
cronedit.sh '@reboot' 'sudo /usr/local/bin/noip2' remove && sudo rm -r /usr/local/bin/noip2 && sudo rm -r /usr/local/etc/no-ip2.conf && sudo rm -r /tmp/no-ip2.conf && sudo rm -r /opt/noip/noip-2.1.9-1 ;;
3)
cd /tmp && sudo noip2 -S &> noip.txt && nano noip.txt && sudo rm noip.txt;;
4)
wget -qO- ifconfig.co/ip >> /tmp/ipgw.txt && nano /tmp/ipgw.txt && sudo rm /tmp/ipgw.txt ;;
5)
break;
esac
done
exit 0


EOF
#####################
sudo cat > /bin/menu-igate <<- "EOF"
#!/bin/bash
while : ; do
choix=$(whiptail --title "D-APRS KF7EEL / Raspbian Proyect HP3ICC Esteban Mackay 73." --menu "Suba o Baje con las flechas del teclado y seleccione el numero de opcion:" 16 65 7 \
1 " Editar igate" \
2 " Iniciar Igate " \
3 " Detener Igate " \
4 " Dashboard on " \
5 " Dashboard off " \
6 " Salir del menu " 3>&1 1>&2 2>&3)

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
nano /opt/D-APRS/gps_data.cfg ;;
2)
sudo systemctl stop daprs.service && sudo systemctl start daprs.service && sudo systemctl enable daprs.service ;;
3)
sudo systemctl stop daprs.service && sudo systemctl disable daprs.service ;;
4)
sudo systemctl stop daprs-board.service && systemctl start daprs-board.service && sudo systemctl enable daprs-board.service ;;
5)
sudo systemctl stop daprs-board.service && sudo systemctl disable daprs-board.service ;;
6)
break;
esac
done
exit 0
EOF
#
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
######

cp /bin/menu /bin/MENU
chmod +x /bin/menu*
chmod +x /bin/MENU

