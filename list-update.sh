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
menu-update ;;
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
choix=$(whiptail --title "Raspbian Proyect HP3ICC / update HBMon2" --menu "Nota Importante: antes de iniciar la actualizacion, el proceso de actualizacion borrara por completo todas las configuraciones, al finalizar la actualizacion el servicio se reinniciara automaticamente.
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
sh -c "$(curl -fsSL https://raw.githubusercontent.com/hp3icc/emq-TE1ws/main/hbmon2-update.sh)" ;;
3)
break;
esac
done
exit 0


EOF
#
sudo cat > /tmp/menu-update <<- "EOF"
#!/bin/bash
while : ; do
choix=$(whiptail --title "Raspbian Proyect HP3ICC Menu FreeDMR" --menu "Nota Importante: solo actualice aplicaciones que esten en uso, al finalizar la actualizacion la aplicacion se reiniciara, tenga pleno dominio de las configuraciones de cada aplicacion, antes de actualizar.
" 20 50 6 \
1 " Update HBMon2 Version OA4DOA " \
2 " Update FreeDMR  " \
3 " UPGRADE LIST Update " \
4 " UPGRADE to Reuter AP Mode " \
5 " UPGRADE to FDMR-Monitor SelfService " \
6 " install LAMP " \
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
menu-up-hbmon2 ;;
2)
menu-up-fdm ;;
3)
sh -c "$(curl -fsSL https://raw.githubusercontent.com/hp3icc/emq-TE1ws/main/list-update.sh)" ;;
4)
sh -c "$(curl -fsSL https://raw.githubusercontent.com/hp3icc/emq-TE1ws/main/te1ap.sh)" ;;
5)
sh -c "$(curl -fsSL https://raw.githubusercontent.com/hp3icc/emq-TE1ws/main/selfservice-update.sh)" ;;
6)
sh -c "$(curl -fsSL https://raw.githubusercontent.com/hp3icc/emq-TE1ws/main/lamp.sh)" ;;
7)
break;
esac
done
exit 0

EOF
#
chmod +x /bin/menu*
chmod +x /bin/MENU
chmod +x /tmp/menu-update
/tmp/menu-update
