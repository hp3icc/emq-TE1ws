sudo systemctl stop http.server-fmr.service
sudo systemctl stop hbmon2.service
sudo systemctl disable hbmon2.service
sudo systemctl stop tgcount.service
sudo systemctl disable tgcount.service
rm -r /opt/HBMonv2/
rm -r /opt/TG_Count/
rm /lib/systemd/system/tgcount.service
rm /lib/systemd/system/hbmon2.service

cronedit.sh '*/5 * * * *' 'sudo /opt/HBMonv2/sysinfo/graph.sh' remove
cronedit.sh '*/2 * * * *' 'sudo /opt/HBMonv2/sysinfo/cpu.sh' remove
cronedit.sh '* */24 * * *' 'sudo /opt/HBMonv2/updateTGIDS.sh >/dev/null 2>&1' remove

sudo cat > /bin/menu-fdmr <<- "EOF"
#!/bin/bash
while : ; do
choix=$(whiptail --title "Raspbian Proyect HP3ICC Menu FreeDMR" --menu "Suba o Baje con las flechas del teclado y seleccione el numero de opcion:" 23 56 13 \
1 " Editar FreeDMR Server " \
2 " Editar Interlink  " \
3 " Editar FDMR-Monitor  " \
4 " cambiar Puerto HTTP FDMR-Monitor " \
5 " Parrot on  " \
6 " Parrot off  " \
7 " Iniciar FreeDMR Server  " \
8 " Detener FreeDMR Server   " \
9 " Dashboard FDMR-Monitor on " \
10 " Dashboard FDMR-Monitor off  " \
11 " D-APRS Igate  " \
12 " Actualizar FreeDMR  " \
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
sudo nano /opt/FreeDMR/config/FreeDMR.cfg ;;
2)
sudo nano /opt/FreeDMR/config/rules.py ;;
3)
sudo nano /opt/FDMR-Monitor/fdmr-mon.cfg ;;
4)
sudo nano /lib/systemd/system/http.server-fmr.service && sudo systemctl daemon-reload ;;
5)
sudo systemctl stop fdmrparrot.service && sudo systemctl start fdmrparrot.service && sudo systemctl enable fdmrparrot.service ;;
6)
sudo systemctl stop fdmrparrot.service &&  sudo systemctl disable fdmrparrot.service ;;
7)
sudo systemctl stop proxy.service && sudo systemctl start proxy.service && sudo systemctl enable proxy.service && sudo systemctl stop freedmr.service && sudo systemctl start freedmr.service && sudo systemctl enable freedmr.service ;;
8)
sudo systemctl stop freedmr.service && sudo systemctl disable freedmr.service && sudo systemctl stop proxy.service && sudo systemctl disable proxy.service && rm /var/log/FreeDMR/* ;;
9)
echo 123> /opt/FDMR-Monitor/123.json && sudo systemctl stop fdmr_mon.service && sudo rm /opt/FDMR-Monitor/*.json && sudo rm /opt/FDMR-Monitor/sysinfo/*.rrd && sh /opt/FDMR-Monitor/sysinfo/rrd-db.sh && cronedit.sh '*/5 * * * *' 'sh /opt/FDMR-Monitor/sysinfo/graph.sh' add && cronedit.sh '*/2 * * * *' 'sh /opt/FDMR-Monitor/sysinfo/cpu.sh' add && sudo systemctl enable fdmr_mon.service && sudo systemctl start http.server-fmr.service && sudo systemctl enable http.server-fmr.service && sudo systemctl start fdmr_mon.service ;;
10)
sudo systemctl stop fdmr_mon.service && sudo systemctl disable fdmr_mon.service && sudo systemctl stop http.server-fmr.service && sudo systemctl disable http.server-fmr.service && cronedit.sh '*/5 * * * *' 'sh /opt/FDMR-Monitor/sysinfo/graph.sh' remove && cronedit.sh '*/2 * * * *' 'sh /opt/FDMR-Monitor/sysinfo/cpu.sh' remove ;;
11)
menu-igate ;;
12)
menu-up-fdm ;;
13)
break;
esac
done
exit 0
EOF
###
chmod +x /bin/menu-*
##
sudo cat > /lib/systemd/system/http.server-fmr.service <<- "EOF"
[Unit]
Description=Python3 http.server.fdmr
After=network.target

[Service]
User=root
Type=simple
Restart=always
RestartSec=3
StandardOutput=null
#ExecStartPre=/bin/sleep 30
# Modify for different location of Python3 or other port
ExecStart=php -S 0.0.0.0:80 -t /opt/FDMR-Monitor/html/


[Install]
WantedBy=multi-user.target


EOF
#m
sudo systemctl daemon-reload

sh -c "$(curl -fsSL https://raw.githubusercontent.com/hp3icc/emq-TE1ws/main/hbmon2-update.sh)"
echo 123> /opt/FDMR-Monitor/123.json
sudo systemctl stop fdmr_mon.service
sudo rm /opt/FDMR-Monitor/*.json
sudo rm /opt/FDMR-Monitor/sysinfo/*.rrd
sh /opt/FDMR-Monitor/sysinfo/rrd-db.sh
cronedit.sh '*/5 * * * *' 'sh /opt/FDMR-Monitor/sysinfo/graph.sh' add
cronedit.sh '*/2 * * * *' 'sh /opt/FDMR-Monitor/sysinfo/cpu.sh' add
sudo systemctl enable fdmr_mon.service
sudo systemctl start http.server-fmr.service
sudo systemctl enable http.server-fmr.service
sudo systemctl restart fdmr_mon.service


