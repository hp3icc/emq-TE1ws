#!/bin/sh
 
sytemctl stop analog_bridge.service
sytemctl stop system/mmdvm_bridge.service
sytemctl stop system/ysfgateway.service
sytemctl stop system/ysfparrot.service
sytemctl stop system/nxdngateway.service
sytemctl stop system/nxdnparrot.service
sytemctl stop system/p25gateway.service
sytemctl stop system/p25parrot.service
sytemctl stop system/quantar_bridge.service
sytemctl stop system/ircddbgatewayd.service
sytemctl stop system/md380-emu.service
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
sytemctl start analog_bridge.service
sytemctl start system/mmdvm_bridge.service
sytemctl start system/ysfgateway.service
sytemctl start system/ysfparrot.service
sytemctl start system/nxdngateway.service
sytemctl start system/nxdnparrot.service
sytemctl start system/p25gateway.service
sytemctl start system/p25parrot.service
sytemctl start system/quantar_bridge.service
sytemctl start system/ircddbgatewayd.service
sytemctl start system/md380-emu.service
