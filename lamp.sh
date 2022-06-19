#! /bin/bash

sudo apt install mariadb-server php libapache2-mod-php php-zip php-mbstring php-cli php-common php-curl php-xml php-mysql -y

sudo apt install apache2 -y

systemctl restart mariadb
systemctl enable mariadb
sudo mysql_secure_installation  --host=localhost --port=3306

newUser='emqte1'
newDbPassword=''
newDb='fdmrmon'
host=localhost
#host='%'

# MySQL 5.7 and earlier versions
#commands="CREATE DATABASE \`${newDb}\`;CREATE USER '${newUser}'@'${host}' IDENTIFIED BY '${newDbPassword}';GRANT USAGE ON *.* TO '${newUser}'@'${host}' IDENTIFIED BY '${newDbPassword}';GRANT ALL privileges ON \`${newDb}\`.* TO '${newUser}'@'${host}' IDENTIFIED BY '${newDbPassword}';FLUSH PRIVILEGES;"

# MySQL 8 and higher versions
commands="CREATE DATABASE \`${newDb}\`;CREATE USER '${newUser}'@'${host}' IDENTIFIED BY '${newDbPassword}';GRANT USAGE ON *.* TO '${newUser}'@'${host}';GRANT ALL ON \`${newDb}\`.* TO '${newUser}'@'${host}';FLUSH PRIVILEGES;"

echo "${commands}" | /usr/bin/mysql -u root -p

systemctl stop apache2
systemctl disable apache2
