
sudo cat > /bin/menu-update0 <<- "EOF"
#!/bin/bash
while : ; do
choix=$(whiptail --title "Raspbian Proyect HP3ICC Menu FreeDMR" --menu "Nota Importante: solo actualice aplicaciones que esten en uso, al finalizar la actualizacion la aplicacion se reiniciara, tenga pleno dominio de las configuraciones de cada aplicacion, antes de actualizar.
" 17 50 5 \
1 " Update FreeDMR & FDMR-Monitor OA4DOA " \
2 " ADVANCE UPGRADE & INSTALL " \
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
sh -c "$(curl -fsSL https://gitlab.com/hp3icc/fdmr/-/raw/main/update.sh)" ;;
2)
menu-update2 ;;
3)
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
5 " install Shell-Beacon " \
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
sh -c "$(curl -fsSL https://raw.githubusercontent.com/hp3icc/emq-TE1ws/main/te1ap.sh)" ;;
2)
sh -c "$(curl -fsSL https://raw.githubusercontent.com/hp3icc/emq-TE1ws/main/lamp.sh)" ;;
3)
sh -c "$(curl -fsSL https://raw.githubusercontent.com/hp3icc/DVSMU/main/emq-dvsmu.sh)" ;;
4)
sh -c "$(curl -fsSL https://raw.githubusercontent.com/hp3icc/emq-TE1ws/main/dvsTGupdate.sh)" ;;
5)
sh -c "$(curl -fsSL https://raw.githubusercontent.com/hp3icc/emq-TE1ws/main/beacon-update.sh)" ;;
6)
break;
esac
done
exit 0

EOF
#
sudo cat > /bin/menu-update <<- "EOF"
#!/bin/bash
while : ; do
choix=$(whiptail --title "Raspbian Proyect HP3ICC / update FDMR-Monitor OA4DOA" --menu "Nota Importante: antes de iniciar la actualizacion, el proceso de actualizacion borrara por completo todas las configuraciones, al finalizar la actualizacion el servicio se reinniciara automaticamente.
" 17 50 4 \
1 " Update FreeDMR " \
2 " Update FDMR-Monitor  " \
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
menu-up-fdm ;;
2)
menu-up-fdmon ;;
3)
break;
esac
done
exit 0


EOF
#

###############################################################

sudo chmod +x /bin/menu*
menu-update0
