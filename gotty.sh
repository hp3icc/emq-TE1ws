#!/bin/bash
#TI4OP Oscar, [1/25/2022 12:51 PM]
if [ "$(uname -m | grep '64')" != "" ]; then
 # echo "ARCH: 64-bit"
wget -qO gotty.tar.gz https://github.com/yudai/gotty/releases/latest/download/gotty_linux_amd64.tar.gz
else
#  echo "ARCH: 32-bit"
wget -qO gotty.tar.gz https://github.com/yudai/gotty/releases/latest/download/gotty_linux_arm.tar.gz
fi

sudo tar xf gotty.tar.gz -C /usr/local/bin
sudo chmod a+x /usr/local/bin/gotty
rm gotty.tar.gz

