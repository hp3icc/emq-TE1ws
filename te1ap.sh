cd /opt/
wget https://github.com/hp3icc/emq-TE1ws/raw/main/setup-network.sh
chmod +x setup-network.sh
sudo ./setup-network.sh --install --ap-ssid="emq-TE1-AP" --ap-password="Panama507" --ap-password-encrypt 
--ap-country-code="PA" --ap-ip-address="192.168.50.1" --wifi-interface="wlan0"
rm setup-network.sh
sudo sed -i 's/echo "Starting hostapd service..."/#echo "Starting hostapd service..."/' /opt/network-setup/bin/netStart
sudo sed -i 's/systemctl start hostapd.service/#systemctl start hostapd.service/' /opt/network-setup/bin/netStart
sudo sed -i 's/sleep 10/#sleep 10/' /opt/network-setup/bin/netStart
sudo sed -i 's/sudo systemctl disable hostapd/#sudo systemctl disable hostapd/' /opt/network-setup/bin/netStop.sh
sudo sed -i 's/sudo systemctl stop hostapd/#sudo systemctl stop hostapd/' /opt/network-setup/bin/netStop.sh
sudo systemctl enable hostapd.service
#
#menu-wifi-AP
cat > /bin/menu-wifi <<- "EOF"
#!/bin/bash
while : ; do
choix=$(whiptail --title "Raspbian Proyect HP3ICC Menu WiFi" --menu "Nota: al editar configuracion de redes Wifi conocidas, debe reiniciar el equipo, para aplicar cambios realizados." 20 75 11 \
1 " Editar redes WiFi conocidas" \
2 " Buscar redes wifi cercanas " \
3 " Ver intensidad de WIFI  " \
4 " Editar AP WiFi " \
5 " Encender AP WiFi " \
6 " Apagar AP WiFi " \
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
sudo nano /etc/wpa_supplicant/wpa_supplicant.conf ;;
2)
sudo iwlist wlan0 scan | grep ESSID | grep -o '"[^"]\+"' >> /tmp/ssid.txt && nano /tmp/ssid.txt && sudo rm /tmp/ssid.txt ;;
3)
sudo wavemon ;;
4)
sudo nano /etc/hostapd/hostapd.conf ;;
5)
sudo systemctl stop hostapd.service && sudo systemctl start hostapd.service && sudo systemctl enable hostapd.service ;;
6)
sudo systemctl stop hostapd.service && sudo systemctl disable hostapd.service ;;
7)
break;
esac
done
exit 0
EOF
#
history -c && history -w
/sbin/shutdown -r now
