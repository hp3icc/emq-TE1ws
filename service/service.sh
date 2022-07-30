#!/bin/sh
 
sudo systemctl stop analog_bridge.service
sudo systemctl stop mmdvm_bridge.service
sudo systemctl stop ysfgateway.service
sudo systemctl stop ysfparrot.service
sudo systemctl stop nxdngateway.service
sudo systemctl stop nxdnparrot.service
sudo systemctl stop p25gateway.service
sudo systemctl stop p25parrot.service
sudo systemctl stop quantar_bridge.service
sudo systemctl stop ircddbgatewayd.service
sudo systemctl stop md380-emu.service
#
rm /lib/systemd/system/analog_bridge.service
rm /lib/systemd/system/mmdvm_bridge.service
rm /lib/systemd/system/ysfgateway.service
rm /lib/systemd/system/ysfparrot.service
rm /lib/systemd/system/nxdngateway.service
rm /lib/systemd/system/nxdnparrot.service
rm /lib/systemd/system/p25gateway.service
rm /lib/systemd/system/p25parrot.service
rm /lib/systemd/system/quantar_bridge.service
rm /lib/systemd/system/ircddbgatewayd.service
rm /lib/systemd/system/md380-emu.service
cd /lib/systemd/system/
wget https://raw.githubusercontent.com/hp3icc/emq-TE1ws/main/service/analog_bridge.service
wget https://raw.githubusercontent.com/hp3icc/emq-TE1ws/main/service/mmdvm_bridge.service
wget https://raw.githubusercontent.com/hp3icc/emq-TE1ws/main/service/ysfgateway.service
wget https://raw.githubusercontent.com/hp3icc/emq-TE1ws/main/service/ysfparrot.service
wget https://raw.githubusercontent.com/hp3icc/emq-TE1ws/main/service/nxdngateway.service
wget https://raw.githubusercontent.com/hp3icc/emq-TE1ws/main/service/nxdnparrot.service
wget https://raw.githubusercontent.com/hp3icc/emq-TE1ws/main/service/p25gateway.service
wget https://raw.githubusercontent.com/hp3icc/emq-TE1ws/main/service/p25parrot.service
wget https://raw.githubusercontent.com/hp3icc/emq-TE1ws/main/service/quantar_bridge.service
wget https://raw.githubusercontent.com/hp3icc/emq-TE1ws/main/service/ircddbgatewayd.service
wget https://raw.githubusercontent.com/hp3icc/emq-TE1ws/main/service/md380-emu.service
#
sudo systemctl daemon-reload
sudo systemctl start analog_bridge.service
sudo systemctl start mmdvm_bridge.service
sudo systemctl start ysfgateway.service
sudo systemctl start ysfparrot.service
sudo systemctl start nxdngateway.service
sudo systemctl start nxdnparrot.service
sudo systemctl start p25gateway.service
sudo systemctl start p25parrot.service
sudo systemctl start quantar_bridge.service
sudo systemctl start ircddbgatewayd.service
sudo systemctl start md380-emu.service
