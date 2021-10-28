#!/bin/bash
# apt-get update
# apt-get upgrade

## Install Git

apt-get install git git-core -y

## Install webserver with PHP5 support

apt-get install apache2 php5 -y

## Install g++ compiler

apt-get install build-essential -y
##(skip this step on Debian 8.x) 
apt-get install g++-4.7 -y


## After downloading and before compiling, please have a look at the main.h file

## nano /xlxd/src/main.h

## For YSF you need to define a default HotSpot frequency !!!

## Download and compile the XLX sources
cd /opt/
git clone https://github.com/LX3JL/xlxd.git
cd xlxd/src/
make clean
make
make install

## Copy startup script "xlxd" to /etc/init.d

cp /opt/xlxd/scripts/xlxd /etc/init.d/xlxd

## Adapt the default startup parameters to your needs

# pico /etc/init.d/xlxd

## Download the dmrid.dat from the XLXAPI server to your xlxd folder

wget -O /xlxd/dmrid.dat http://xlxapi.rlx.lu/api/exportdmr.php

## Check your FTDI driver and install the AMBE service according to the readme in AMBEd

 

## Last step is to declare the service for automatic startup and shutdown

update-rc.d xlxd defaults

## Start or stop the service with

# service xlxd start
# service xlxd stop

## Copy dashboard to /var/www

cp -r /opt/xlxd/dashboard /var/www/db

## Give the dashboard read access to the server log file

chmod +r /var/log/messages 

## Reboot server to see if the auto-start is working

# reboot

