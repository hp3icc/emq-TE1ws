#!/bin/sh

sudo systemctl stop mmdvmh.service
sudo systemctl stop dmrid-mmdvm.service
sudo systemctl stop logtailer-mmdvmh.service  
sudo systemctl stop http.server-mmdvmh.service

cd /opt/MMDVMHost/
sudo sed -i 's/FileRoot=MMDVMHost/FileRoot=MMDVMH/' MMDVM.ini
sudo sed -i 's/FileRotate=1/FileRotate=0/' MMDVM.ini
cd /opt/MMDVMHost-Websocketboard/
sudo sed -i 's/Prefix=MMDVMHost/Prefix=MMDVMH/' logtailer.ini
cd /opt/MMDVMHost-Websocketboard/html/
sudo sed -i 's/5678/5679/' index.html
cd /opt/MMDVMHost-Websocketboard/
sudo sed -i 's/5678/5679/' logtailer.ini

#
cat > /bin/menu-mmdvm <<- "EOF"
#!/bin/bash
while : ; do
choix=$(whiptail --title "Raspbian Proyect HP3ICC Menu MMDVMHost" --menu "Suba o Baje con las flechas del teclado y seleccione el numero de opcion" 20 50 10 \
1 " Editar MMDVMHost " \
2 " Iniciar MMDVMHost " \
3 " Detener MMDVMHost " \
4 " Dashboard ON " \
5 " Dashboard Off " \
6 " Editar Puerto WebServer " \
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
sudo nano /lib/systemd/system/http.server-mmdvmh.service && sudo systemctl daemon-reload && sudo systemctl restart http.server-mmdvmh.service ;;
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
#
sudo chmod +x /bin/menu-mmdvm
cd /tmp/
#####
cat > /tmp/completado.sh <<- "EOF"
#!/bin/bash
while : ; do
choix=$(whiptail --title "Raspbian Proyect HP3ICC Esteban Mackay 73." --menu " Precione enter (return o intro) para finalizar la instalacion y reiniciar su equipo " 11 85 3 \
1 " Iniciar Reinicio de Raspberry " 3>&1 1>&2 2>&3)
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
sudo chmod +x /tmp/completado.sh
history -c && history -w
sh /tmp/completado.sh
