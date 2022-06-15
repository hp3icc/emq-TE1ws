#!/bin/sh

sudo apt install mariadb-server php libapache2-mod-php php-zip php-mbstring php-cli php-common php-curl php-xml php-mysql -y


systemctl stop apache2
systemctl disable apache2


systemctl restart mariadb
systemctl enable mariadb
sudo mysql_secure_installation  --host=localhost --port=3306

