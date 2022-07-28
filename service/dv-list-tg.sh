sudo cat > /bin/menu-update <<- "EOF"
#!/bin/bash
while : ; do
choix=$(whiptail --title "Raspbian Proyect HP3ICC Menu TG List DVSwitch" --menu "Suba o Baje con las flechas del teclado y seleccione el numero de opcion, al finalizar debe actualizar la lista de tg en su DVSwitch Mobile. " 17 50 5 \
1 " List TG FreeDMR " \
2 " List TG Brandmeister  " \
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
sudo sed -i "s/www.pistar.uk/freedmr-hp.ddns.net/g"  /opt/MMDVM_Bridge/dvswitch.sh ;;
2)
sudo sed -i "s/freedmr-hp.ddns.net/www.pistar.uk/g"  /opt/MMDVM_Bridge/dvswitch.sh ;;
3)
break;
esac
done
exit 0

EOF
####
chmod +x /bin/menu-update
/bin/menu-update
