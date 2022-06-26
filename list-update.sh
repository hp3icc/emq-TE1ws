sudo cat > /bin/menu <<- "EOF"
#!/bin/bash
while : ; do
choix=$(whiptail --title "TE1ws-Rev: R00ab / Raspbian Proyect HP3ICC Esteban Mackay 73." --menu "Suba o Baje con las flechas del teclado y seleccione el numero de opcion:" 24 67 15 \
1 " APRS Direwolf Analogo" \
2 " APRS Direwolf RTL-SDR " \
3 " APRS Multimon-ng " \
4 " APRS Ionosphere " \
5 " MMDVMHost " \
6 " Dvswitch " \
7 " pYSFReflector3 " \
8 " YSF2DMR " \
9 " FreeDMR Server " \
10 " Editar WiFi " \
11 " DDNS NoIP " \
12 " GoTTY " \
13 " Update " \
14 " Reiniciar Equipo " \
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
menu-fdmr;;
10)
menu-wifi;;
11)
menu-noip ;;
12)
menu-web ;;
13)
sh -c "$(curl -fsSL https://github.com/hp3icc/emq-TE1ws/raw/main/update.sh)" ;;
14)
menu-reboot ;;
15)
break;
esac
done
exit 0
EOF
#
variable22=$(grep "EMQ-VER:" /opt/emq-ver | tail -c 5)
sudo sed -i "s/R00ab/$variable22/g"  /bin/menu
rm /bin/MENU
cp /bin/menu /bin/MENU
##
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
echo 123> /opt/FDMR-Monitor/data/123.json && sudo systemctl stop fdmr_mon.service && sudo rm /opt/FDMR-Monitor/data/* && sudo rm /opt/FDMR-Monitor/sysinfo/*.rrd && sh /opt/FDMR-Monitor/sysinfo/rrd-db.sh && cronedit.sh '*/5 * * * *' 'sh /opt/FDMR-Monitor/sysinfo/graph.sh' add && cronedit.sh '*/2 * * * *' 'sh /opt/FDMR-Monitor/sysinfo/cpu.sh' add && sudo systemctl enable fdmr_mon.service && sudo systemctl restart apache2.service && sudo systemctl enable apache2.service  && sudo systemctl start fdmr_mon.service && cronedit.sh '0 3 * * *' 'rm /opt/FDMR-Monitor/data/*' add ;;
10)
sudo systemctl stop fdmr_mon.service && sudo systemctl disable fdmr_mon.service && sudo systemctl stop apache2.service && sudo systemctl disable apache2.service && cronedit.sh '*/5 * * * *' 'sh /opt/FDMR-Monitor/sysinfo/graph.sh' remove && cronedit.sh '*/2 * * * *' 'sh /opt/FDMR-Monitor/sysinfo/cpu.sh' remove && cronedit.sh '0 3 * * *' 'rm /opt/FDMR-Monitor/data/*' remove ;;
11)
menu-igate ;;
12)
break;
esac
done
exit 0




EOF
####
#####
#

chmod +x /bin/menu*
chmod +x /bin/MENU
chmod +x /tmp/menu-update
sh -c "$(curl -fsSL https://github.com/hp3icc/emq-TE1ws/raw/main/update.sh)"
