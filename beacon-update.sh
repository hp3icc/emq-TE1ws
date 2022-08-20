#!/bin/bash
sh -c "$(curl -fsSL https://raw.githubusercontent.com/hp3icc/shell-aprs/main/shell.sh)"
sh -c "$(curl -fsSL https://raw.githubusercontent.com/hp3icc/emq-TE1ws/main/menu.sh)"
variable22=$(grep "EMQ-VER:" /opt/emq-ver | tail -c 5)
sudo sed -i "s/R00ab/$variable22/g"  /bin/menu
