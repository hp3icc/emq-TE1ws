sudo cat > /bin/menu-update <<- "EOF"
#!/bin/bash
while : ; do
choix=$(whiptail --title "Raspbian Proyect HP3ICC Menu FreeDMR" --menu "Nota Importante: debe debe agregar todos sus obp en la opcion numero uno, ( 1-Lista de OBP )antes de iniciar la actualizacion, el proceso de actualizacion borrara por completo la carpeta /opt/FreeDMR, al finalizar la actualizacion el servicio Freedmr se reinniciara automaticamente.
" 17 50 3 \
1 " Update HBMon2 Version OA4DOA " \
2 " Update FreeDMR  " \
3 " UPGRADE LIST  " \
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
sudo chmod +x /bin-menu*
menu-update
