variable=$(grep "SERVER_ID:" /opt/FreeDMR/config/FreeDMR.cfg | tail -c 5)
rm -r /opt/FreeDMR
cd /opt
git clone https://gitlab.hacknix.net/hacknix/FreeDMR.git
cd FreeDMR
mkdir config
mkdir /var/log/FreeDMR
chmod +x /opt/FreeDMR/install.sh
./install.sh
sudo cat > /opt/conf.txt <<- "EOF"
 
[LINKS]
MODE: MASTER
ENABLED: True
REPEAT: True
MAX_PEERS: 1
EXPORT_AMBE: False
IP:
PORT: 54101
PASSPHRASE: passw@rd
GROUP_HANGTIME: 5
USE_ACL: True
REG_ACL: DENY:1
SUB_ACL: DENY:1
TGID_TS1_ACL: PERMIT:ALL
TGID_TS2_ACL: PERMIT:ALL
DEFAULT_UA_TIMER: 60
SINGLE_MODE: True
VOICE_IDENT: False
TS1_STATIC:
TS2_STATIC:
DEFAULT_REFLECTOR: 0
ANNOUNCEMENT_LANGUAGE: es_ES
GENERATOR: 10
ALLOW_UNREG_ID: True
PROXY_CONTROL: False

[EchoTest]
MODE: PEER
ENABLED: True
LOOSE: True
EXPORT_AMBE: False
IP: 
#127.0.0.1
PORT: 49060
MASTER_IP: 127.0.0.1
MASTER_PORT: 49061
PASSPHRASE: passw0rd
CALLSIGN: ECHOTEST
RADIO_ID: 9990
RX_FREQ: 449000000
TX_FREQ: 444000000
TX_POWER: 25
COLORCODE: 1
SLOTS: 3
LATITUDE: 38.0000
LONGITUDE: -095.0000
HEIGHT: 75
LOCATION: Local Parrot
DESCRIPTION: This is a cool repeater
URL: www.w1abc.org
SOFTWARE_ID: 20170620
PACKAGE_ID: MMDVM_HBlink
GROUP_HANGTIME: 3
OPTIONS:
#TS2=9990;DIAL=0;VOICE=0;TIMER=0
USE_ACL: True
SUB_ACL: DENY:1
TGID_TS1_ACL: DENY:ALL
TGID_TS2_ACL: PERMIT:9990
TS1_STATIC:
TS2_STATIC:9990
DEFAULT_REFLECTOR: 0
ANNOUNCEMENT_LANGUAGE: en_GB
GENERATOR: 0
DEFAULT_UA_TIMER: 999
SINGLE_MODE: True
VOICE_IDENT: False
EOF
##
sudo sed -i 's/ALLOW_NULL_PASSPHRASE: True/ALLOW_NULL_PASSPHRASE: False/' /opt/FreeDMR/FreeDMR-SAMPLE.cfg
sudo sed -i 's/PASSPHRASE:/PASSPHRASE: passw0rd/' /opt/FreeDMR/FreeDMR-SAMPLE.cfg
sudo sed -i 's/ALLOW_NULL_PASSPHRASE: passw0rd False/ALLOW_NULL_PASSPHRASE: False/' /opt/FreeDMR/FreeDMR-SAMPLE.cfg

cp /opt/FreeDMR/FreeDMR-SAMPLE.cfg /opt/
cd /opt/
cat FreeDMR-SAMPLE.cfg conf.txt obp.txt >> /opt/FreeDMR/config/FreeDMR.cfg
sudo sed -i 's/file-timed/console-timed/' /opt/FreeDMR/config/FreeDMR.cfg
sudo sed -i 's/INFO/DEBUG/' /opt/FreeDMR/config/FreeDMR.cfg
sudo sed -i 's/freedmr.log/\/var\/log\/FreeDMR\/FreeDMR.log/' /opt/FreeDMR/config/FreeDMR.cfg
sudo sed -i 's/ANNOUNCEMENT_LANGUAGE: en_GB/ANNOUNCEMENT_LANGUAGE: es_ES/' /opt/FreeDMR/config/FreeDMR.cfg
sudo sed -i 's/VOICE_IDENT: True/VOICE_IDENT: False/' /opt/FreeDMR/config/FreeDMR.cfg
sudo sed -i "s/SERVER_ID: 0000/SERVER_ID: $variable/g"  /opt/FreeDMR/config/FreeDMR.cfg
sudo sed -i 's/100/60/' /opt/FreeDMR/config/FreeDMR.cfg
sudo sed -i 's/54100/54060/' /opt/FreeDMR/hotspot_proxy_v2.py
#sudo sed -i 's/REPORT_CLIENTS: 127.0.0.1/REPORT_CLIENTS: */' /opt/FreeDMR/config/FreeDMR.cfg
rm /opt/conf.txt
#rm /opt/obp.txt
cd /opt/FreeDMR/
mv loro.cfg /opt/FreeDMR/playback.cfg
sudo sed -i 's/54915/49061/' /opt/FreeDMR/playback.cfg
######
sudo cat > /opt/FreeDMR/config/rules.py <<- "EOF"
'''
THIS EXAMPLE WILL NOT WORK AS IT IS - YOU MUST SPECIFY YOUR OWN VALUES!!!

In FreeDMR, the rules file should be *empty* unless you have static routing required. Please see the 
documentation for more details.

This file is organized around the "Conference Bridges" that you wish to use. If you're a c-Bridge
person, think of these as "bridge groups". You might also liken them to a "reflector". If a particular
system is "ACTIVE" on a particular conference bridge, any traffid from that system will be sent
to any other system that is active on the bridge as well. This is not an "end to end" method, because
each system must independently be activated on the bridge.

The first level (e.g. "WORLDWIDE" or "STATEWIDE" in the examples) is the name of the conference
bridge. This is any arbitrary ASCII text string you want to use. Under each conference bridge
definition are the following items -- one line for each HBSystem as defined in the main HBlink
configuration file.

    * SYSTEM - The name of the sytem as listed in the main hblink configuration file (e.g. hblink.cfg)
        This MUST be the exact same name as in the main config file!!!
    * TS - Timeslot used for matching traffic to this confernce bridge
        XLX connections should *ALWAYS* use TS 2 only.
    * TGID - Talkgroup ID used for matching traffic to this conference bridge
        XLX connections should *ALWAYS* use TG 9 only.
    * ON and OFF are LISTS of Talkgroup IDs used to trigger this system off and on. Even if you
        only want one (as shown in the ON example), it has to be in list format. None can be
        handled with an empty list, such as " 'ON': [] ".
    * TO_TYPE is timeout type. If you want to use timers, ON means when it's turned on, it will
        turn off afer the timout period and OFF means it will turn back on after the timout
        period. If you don't want to use timers, set it to anything else, but 'NONE' might be
        a good value for documentation!
    * TIMOUT is a value in minutes for the timout timer. No, I won't make it 'seconds', so don't
        ask. Timers are performance "expense".
    * RESET is a list of Talkgroup IDs that, in addition to the ON and OFF lists will cause a running
        timer to be reset. This is useful   if you are using different TGIDs for voice traffic than
        triggering. If you are not, there is NO NEED to use this feature.
'''

BRIDGES = {

 '9990': [ 
	{'SYSTEM': 'EchoTest', 		'TS': 2, 'TGID': 9990, 'ACTIVE':True, 'TIMEOUT': 0, 'TO_TYPE': 'NONE', 'ON': [], 'OFF': [], 'RESET': []}, 

	],


}
if __name__ == '__main__':
    from pprint import pprint
    pprint(BRIDGES)

EOF
###
sudo chmod +x /opt/FreeDMR/*.py
rm /opt/FreeDMR-SAMPLE.cfg 
sudo systemctl restart freedmr.service
sudo systemctl restart fdmrparrot.service
# ExecStart=/usr/bin/python3 /opt/FreeDMR/bridge_master.py -c /opt/FreeDMR/config/FreeDMR.cfg -r /opt/FreeDMR/config/rules.py

# ExecStart=/usr/bin/python3 /opt/FreeDMR/playback.py -c /opt/FreeDMR/playback.cfg

# sudo systemctl daemon-reload	 
