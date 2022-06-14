#!/bin/sh

sudo apt install -y apache2 apache2-utils
systemctl restart apache2
sudo systemctl enable apache2
sudo apt install mariadb-server mariadb-client -y
systemctl restart mariadb
systemctl enable mariadb
sudo mysql_secure_installation  --host=localhost --port=3306

