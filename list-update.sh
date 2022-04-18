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
sudo cat > /bin/menu-update <<- "EOF"
#!/bin/bash
while : ; do
choix=$(whiptail --title "Raspbian Proyect HP3ICC Menu FreeDMR" --menu "Nota Importante: solo actualice aplicaciones que esten en uso, al finalizar la actualizacion la aplicacion se reiniciara, tenga pleno dominio de las configuraciones de cada aplicacion, antes de actualizar.
" 17 50 5 \
1 " Update HBMon2 Version OA4DOA " \
2 " Update FreeDMR  " \
3 " UPGRADE LIST Update " \
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
sh -c "$(curl -fsSL https://raw.githubusercontent.com/hp3icc/emq-TE1ws/main/hbmon2-update.sh)" ;;
2)
sh -c "$(curl -fsSL https://raw.githubusercontent.com/hp3icc/emq-TE1ws/main/fdmr-update.sh)" ;;
3)
sh -c "$(curl -fsSL https://raw.githubusercontent.com/hp3icc/emq-TE1ws/main/list-update.sh)" ;;
4)
break;
esac
done
exit 0
EOF
#
chmod +x /bin/menu*
chmod +x /bin/MENU
menu-update
