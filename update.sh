echo 123> /bin/menu-update
sudo rm /bin/menu-update
sudo cat > /bin/menu-update <<- "EOF"
#!/bin/bash
while : ; do
choix=$(whiptail --title "Raspbian Proyect HP3ICC Menu FreeDMR" --menu "Nota Importante: solo actualice aplicaciones que esten en uso, al finalizar la actualizacion la aplicacion se reiniciara, tenga pleno dominio de las configuraciones de cada aplicacion, antes de actualizar.
" 17 50 5 \
1 " Update FDMR-Monitor OA4DOA " \
2 " Update FreeDMR  " \
3 " ADVANCE UPGRADE & INSTALL " \
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
menu-up-hbmon2 ;;
2)
menu-up-fdm ;;
3)
menu-update2 ;;
4)
break;
esac
done
exit 0

EOF
####
sudo cat > /bin/menu-update2 <<- "EOF"
#!/bin/bash
while : ; do
choix=$(whiptail --title "Raspbian Proyect HP3ICC Menu FreeDMR" --menu "Nota Importante: solo actualice aplicaciones que esten en uso, al finalizar la actualizacion la aplicacion se reiniciara, tenga pleno dominio de las configuraciones de cada aplicacion, antes de actualizar.
" 21 50 8 \
1 " UPGRADE to Reuter AP Mode " \
2 " install LAMP " \
3 " install DVSMU " \
4 " install DVSWitch TG List select " \
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
sh -c "$(curl -fsSL https://raw.githubusercontent.com/hp3icc/emq-TE1ws/main/te1ap.sh)" ;;
2)
sh -c "$(curl -fsSL https://raw.githubusercontent.com/hp3icc/emq-TE1ws/main/lamp.sh)" ;;
3)
sh -c "$(curl -fsSL https://raw.githubusercontent.com/hp3icc/DVSMU/main/emq-dvsmu.sh)" ;;
4)
sh -c "$(curl -fsSL https://raw.githubusercontent.com/hp3icc/emq-TE1ws/main/dvsTGupdate.sh)" ;;
5)
break;
esac
done
exit 0

EOF
#
sudo cat > /bin/menu-up-fdm <<- "EOF"
#!/bin/bash
while : ; do
choix=$(whiptail --title "Raspbian Proyect HP3ICC / update FreeDMR" --menu "Nota Importante: debe debe agregar todos sus obp en la opcion numero uno, ( 1-Lista de OBP )antes de iniciar la actualizacion, el proceso de actualizacion borrara por completo la carpeta /opt/FreeDMR, al finalizar la actualizacion el servicio Freedmr se reinniciara automaticamente.
" 18 55 5 \
1 " List OBP " \
2 " List Rules  " \
3 " shell extra " \
4 " Iniciar Actualizacion FreeDMR  " \
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
sudo nano /opt/obp.txt ;;
2)
sudo nano /opt/rules.txt ;;
3)
sudo nano /opt/extra-1.sh && chmod +x /opt/extra* ;;
4)
sh -c "$(curl -fsSL https://raw.githubusercontent.com/hp3icc/emq-TE1ws/main/fdmr-update.sh)" ;;
5)
break;
esac
done
exit 0


EOF
#
sudo cat > /bin/menu-up-hbmon2 <<- "EOF"
#!/bin/bash
while : ; do
choix=$(whiptail --title "Raspbian Proyect HP3ICC / update FDMR-Monitor OA4DOA" --menu "Nota Importante: antes de iniciar la actualizacion, el proceso de actualizacion borrara por completo todas las configuraciones, al finalizar la actualizacion el servicio se reinniciara automaticamente.
" 17 50 4 \
1 " shell extra " \
2 " Iniciar Actualizacion HBMon2  " \
3 " Menu Principal " 3>&1 1>&2 2>&3)
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
sudo nano /opt/extra-2.sh && chmod +x /opt/extra* ;;
2)
sh -c "$(curl -fsSL https://raw.githubusercontent.com/hp3icc/emq-TE1ws/main/selfservice-update.sh)" ;;
3)
break;
esac
done
exit 0


EOF
#
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
#####



#
chmod +x /bin/menu*
chmod +x /bin/MENU
menu-update
