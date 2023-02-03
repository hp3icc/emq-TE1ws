if [ -d "/opt/D-APRS" ]
then
   rm -r /opt/D-APRS
 #echo "found file"

fi
if [ -d "/opt/kalibrate-rtl" ]
then
   rm -r /opt/kalibrate-rtl
 #echo "found file"

fi
if [ -d "/opt/YSF2DMRGW" ]
then
   rm -r /opt/YSF2DMRGW
 #echo "found file"

fi
if [ -d "/opt/YSF2DMR" ]
then
   rm -r /opt/YSF2DMR
 #echo "found file"

fi
if [ -d "/opt/direwolf" ]
then
   rm -r /opt/direwolf
 #echo "found file"

fi
if [ -d "/opt/FDMR-Monitor" ]
then
   rm -r /opt/FDMR-Monitor
 #echo "found file"

fi
if [ -d "/opt/MMDVM_CM" ]
then
   rm -r /opt/MMDVM_CM
 #echo "found file"

fi
if [ -d "/opt/YSFGateway2" ]
then
   rm -r /opt/YSFGateway2
 #echo "found file"

fi
if [ -d "/opt/shell-aprs" ]
then
   rm -r /opt/shell-aprs
 #echo "found file"

fi
if [ -d "/opt/rtl-sdr" ]
then
   rm -r /opt/rtl-sdr
 #echo "found file"

fi
if [ -d "/opt/direwolf_webstat" ]
then
   rm -r /opt/direwolf_webstat
 #echo "found file"

fi
if [ -d "/opt/FreeDMR" ]
then
   rm -r /opt/FreeDMR
 #echo "found file"

fi
if [ -d "/opt/MMDVMHost" ]
then
   rm -r /opt/MMDVMHost
 #echo "found file"

fi
if [ -d "/opt/pymultimonaprs" ]
then
   rm -r /opt/pymultimonaprs
 #echo "found file"

fi
if [ -d "/opt/WSYSFDash" ]
then
   rm -r /opt/WSYSFDash
 #echo "found file"

fi
if [ -d "/opt/DMRGateway" ]
then
   rm -r /opt/DMRGateway
 #echo "found file"

fi
if [ -d "/opt/MMDVMHost-Websocketboard" ]
then
   rm -r /opt/MMDVMHost-Websocketboard
 #echo "found file"

fi
if [ -d "/opt/pYSFReflector3" ]
then
   rm -r /opt/pYSFReflector3
 #echo "found file"

fi
if [ -d "/opt/ionsphere" ]
then
   rm -r /opt/ionsphere
 #echo "found file"

fi
if [ -d "/opt/multimon-ng" ]
then
   rm -r /opt/multimon-ng
 #echo "found file"

fi
if [ -d "/opt/noip" ]
then
   rm -r /opt/noip
 #echo "found file"

fi
if [ -d "/usr/local/bin/noip2" ]
then
   rm -r /usr/local/bin/noip2
   #echo "found file"

fi
if [ -f "/usr/local/etc/no-ip2.conf" ]
then
  rm /usr/local/etc/no-ip2.conf
  #echo "found file"

fi
if [ -f "/tmp/no-ip2.conf" ]
then
   rm /tmp/no-ip2.conf
 #echo "found file"

fi
if [ -f "/usr/local/dvs/dvs" ]
then
   rm /opt/buster
   apt remove dvswitch-monit -y
   apt remove dvswitch-server -y
   
   apt remove -y alsa-topology-conf alsa-ucm-conf analog-bridge bc dvswitch dvswitch-base dvswitch-dashboard dvswitch-menu fontconfig-config fonts-dejavu-core ircddbgateway
  javascript-common libasound2 libasound2-data libc-ares2 libc-dev-bin libc-devtools libc6-dev libcrypt-dev libdeflate0 libflac8 libfontconfig1 libgd3 libjbig0
  libjpeg62-turbo libjs-highlight.js libnode72 libnsl-dev libogg0 libopus0 libsndfile1 libsodium23 libtiff5 libtirpc-dev libvorbis0a libvorbisenc2 libwebp6 libwxbase3.0-0v5
  libwxbase3.0-dev libxpm4 lighttpd lighttpd-mod-deflate lighttpd-mod-openssl linux-libc-dev manpages-dev md380-emu mmdvm-bridge monit node-agent-base node-commander
  node-debug node-lru-cache node-ms node-mute-stream node-read node-semver node-tinycolor node-ws node-yallist nodejs nodejs-doc nxdngateway nxdnparrot p25gateway p25parrot
  php-cgi php-common php7.4-cgi php7.4-cli php7.4-common php7.4-json php7.4-opcache php7.4-readline python3-serial qemu-user-static quantar-bridge spawn-fcgi wx3.0-headers
  ysfgateway ysfparrot

 rm -r /var/log/dvswitch /var/log/mmdvm /var/lib/mmdvm
 rm /etc/apt/sources.list.d/dvswitch.list 
 #echo "found file"

fi
##############
