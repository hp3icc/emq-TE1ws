if [ -f "/opt/Analog_Bridge/Analog_Bridge.ini " ]
then
  echo "found file"
else
  sudo cat > /opt/Analog_Bridge/Analog_Bridge.ini  <<- "EOF"
; Analog_Bridge configuration file.
;   This file should be placed in either /etc or it can be
;   supplied as a path on the Analog_Bridge command line.

; The best way to think of this file is that there are two main sections, the USRP (analog audio) and
; AMBE_AUDIO (compressed audio).  Analog_Bridge will take everything sent to the USRP port and
; encode it for transmission on the AMBE_AUDIO port.  The encoder will use the format defined in ambeMode.
; As you might expect, the reverse direction is defined too.

; Analog_Bridge supports include files. More on this later...
include = dvsm.macro
; include = asl.macro

; General Section describes settings for Analog_Bridge itself.
[GENERAL]
logLevel = 2                            ; Show messages and above 0=No logging, 1=Debug, 2=Message, 3=Info, 4=Warning, 5=Error, 6=Fatal

; Metadata management
exportMetadata = true                   ; Export metadata to USRP partner (transcode setups require this)
transferRootDir = /tmp			; Export database files to USRP partner
subscriberFile = /var/lib/dvswitch/subscriber_ids.csv   ; DMR ID to callsign lookup data

; General vocoder setup information
decoderFallBack = true                  ; Allow software AMBE decoding if a hardware decoder is not found
useEmulator = false                     ; Use the MD380 AMBE emulator for AMBE72 (DMR/YSFN/NXDN)
emulatorAddress = 127.0.0.1:2470        ; IP address and port of the md380 server

pcmPort = 2222                          ; UDP port to send to the WebProxy

; Information for xx_Bridge (Where xx is MMDVM, Quantar, HB, IPSC)
[AMBE_AUDIO]
address = 127.0.0.1                     ; IP address of xx_Bridge
txPort = 31103                          ; Transmit TLV frames to partner on this port
rxPort = 31100                          ; Listen for TLV frames from partner on this port
ambeMode = DMR                          ; DMR, DMR_IPSC, DSTAR, NXDN, P25, YSFN, YSFW (encode PCM to this format)
minTxTimeMS = 2500                      ; Analog -> Digital Minimum time in MS for hang delay (0-10000)

; The metadata below is used when ASL is the source since it does not have any concept of digital modes
gatewayDmrId = 1234567                  ; ID to use when transmitting from Analog_Bridge 7 digit ID
repeaterID = 123456789                  ; ID of source repeater 7 digit ID plus 2 digit SSID 
txTg = 9                                ; TG to use for all frames sent from Analog_Bridge -> xx_Bridge
txTs = 2                                ; Slot to use for frames sent from Analog_Bridge -> xx_Bridge
colorCode = 1                           ; Color Code to assign DMR frames

; Information for USRP channel driver.  This interface uses PCM to transfer audio information
; There are two typical configurations, ASL and Transcode.  ASL (AllstarLink) is for analog clients connected
; to a digital network.  Transcode is when Analog_Bridge actually points its PCM interfaces back at itself, 
; causing a TLV <-- (pcm <--> pcm) --> TLV type of architecture.
;   When using ASL, this matches the rpt.conf ASL file with a setting like:
;   rxchannel = usrp/127.0.0.1:34001:32001
;   When Transcoding, make two ini files and set txPort equal to the other instance rxPort (crossover).  Launch
;   each instance with its own ini file.
[USRP]
address = 127.0.0.1                     ; IP address of USRP partner (Analog_Reflector, Allstar/Asterisk or another Analog_Bridge)
txPort = 31001                          ; Transmit USRP frames on this port
rxPort = 31001                          ; Listen for USRP frames on this port
usrpAudio = AUDIO_UNITY                 ; Digital -> Analog (AUDIO_UNITY, AUDIO_USE_GAIN, AUDIO_USE_AGC)
usrpGain = 1.10                         ; Gain factor when usrpAudio = AUDIO_USE_GAIN (0.0 to 5.0) (1.0 = AUDIO_UNITY)
usrpAGC = -20,10,100                    ; Set the agc threshold (db), slope (db) and decay (ms)
tlvAudio = AUDIO_UNITY                  ; Analog -> Digital (AUDIO_UNITY, AUDIO_USE_GAIN, AUDIO_BPF)
tlvGain = 0.35                          ; Gain factor when tlvAudio = AUDIO_USE_GAIN (0.0 to 5.0) (1.0 = AUDIO_UNITY)

[MACROS]

; Where the macros are
; xxxx=yyyy
; xxxx is the dial string to match
; yyyy is the command line to execute

; xxxx must be preceded by a *
; xxxx can be any string (alphanumeric)
; yyyy is the command to execute
; yyyy will replace xxxx in the dial string
; arguments follow the macro name with a # delimiter

; For example using macro "5678" above would look like:
; *5678#9876

; Which would invoke:
; echo 9876

; Information for DV3000 hardware decoder
;   There are two configuration modes: IP (AMBEServer) and serial (direct connect hardware)
;   Use top server and port if using AMBEServer
;   Use bottom server/port and serial = true if using the DV3000u (thumbdv)
;   Did you run AMBETest4.py before using this?
[DV3000]
address = 127.0.0.1                   ; IP address of AMBEServer
rxPort = 2460                         ; Port of AMBEServer
; address = /dev/ttyUSB0              ; Device of DV3000U on this machine
; baud = 460800                       ; Baud rate of the dongle (230400 or 460800)
; serial = true                       ; Use serial=true for direct connect or serial=false for AMBEServer
 
EOF
# 
fi
if [ -f "/opt/MMDVM_Bridge/MMDVM_Bridge.ini " ]
then
  echo "found file"
else
  sudo cat > /opt/MMDVM_Bridge/MMDVM_Bridge.ini  <<- "EOF"
[General]
Callsign=N0CALL
Id=1234567
Timeout=180
Duplex=0

[Info]
RXFrequency=222340000
TXFrequency=224940000
Power=1
Latitude=41.7333
Longitude=-50.3999
Height=0
Location=Iceberg, North Atlantic
Description=MMDVM_Bridge
URL=https://groups.io/g/DVSwitch

[Log]
# Logging levels, 0=No logging, 1=Debug, 2=Message, 3=Info, 4=Warning, 5=Error, 6=Fatal
DisplayLevel=1
FileLevel=2
FilePath=/var/log/mmdvm
FileRoot=MMDVM_Bridge

[DMR Id Lookup]
File=/var/lib/mmdvm/DMRIds.dat
Time=24

[NXDN Id Lookup]
File=/var/lib/mmdvm/NXDN.csv
Time=24

[Modem]
Port=/dev/null
RSSIMappingFile=/dev/null
Trace=0
Debug=0

[D-Star]
Enable=0
Module=B

[DMR]
Enable=0
ColorCode=1
EmbeddedLCOnly=1
DumpTAData=0

[System Fusion]
Enable=0

[P25]
Enable=0
NAC=293

[NXDN]
Enable=0
RAN=1
Id=12345

[D-Star Network]
Enable=0
GatewayAddress=127.0.0.1
GatewayPort=20010
LocalPort=20011
Debug=0

[DMR Network]
Enable=0
Address=hblink.dvswitch.org
Port=62031
Jitter=360
Local=62032
Password=passw0rd
# for DMR+ see https://github.com/DVSwitch/MMDVM_Bridge/blob/master/DOC/DMRplus_startup_options.md
# for XLX the syntax is: Options=XLX:4009
# Options=
Slot1=0
Slot2=1
Debug=0

[System Fusion Network]
Enable=0
LocalAddress=0
LocalPort=3200
GatewayAddress=127.0.0.1
GatewayPort=4200
Debug=0

[P25 Network]
Enable=0
GatewayAddress=127.0.0.1
GatewayPort=42020
LocalPort=32010
Debug=0

[NXDN Network]
Enable=0
#LocalAddress=127.0.0.1
Debug=0
LocalPort=14021
GatewayAddress=127.0.0.1
GatewayPort=14020
 
EOF
# 
fi
if [ -f "/opt/NXDNGateway/NXDNGateway.ini  " ]
then
  echo "found file"
else
  sudo cat > /opt/NXDNGateway/NXDNGateway.ini   <<- "EOF"
[General]
Callsign=N0CALL
Suffix=NXDN
# The next four lines are for a Kenwood repeater
# RptProtocol=Kenwood
# RptAddress=1.2.3.4
# RptPort=64000
# LocalPort=64000
# The next four lines are for an Icom repeater
# RptProtocol=Icom
# RptAddress=1.2.3.4
# RptPort=41300
# LocalPort=41300
# The next four lines are for an MMDVM
RptProtocol=Icom
RptAddress=127.0.0.1
RptPort=14021
LocalPort=14020
Debug=0
Daemon=0

[Info]
RXFrequency=223500000
TXFrequency=223500000
Power=1
Latitude=41.7333
Longitude=-50.3999
Height=0
Location=Iceberg
Description=DVSwitch
URL=https://groups.io/g/DVSwitch

[Voice]
Enabled=1
Language=en_US
Directory=./Audio

[aprs.fi]
Enable=0
# Server=noam.aprs2.net
Server=euro.aprs2.net
Port=14580
Password=9999
Description=APRS Description
Suffix=N

[Id Lookup]
Name=/var/lib/mmdvm/NXDN.csv
Time=24

[Log]
# Logging levels, 0=No logging, 1=Debug, 2=Message, 3=Info, 4=Warning, 5=Error, 6=Fatal
DisplayLevel=1
FileLevel=2
FilePath=/var/log/mmdvm
FileRoot=NXDNGateway

[Network]
Port=14050
HostsFile1=/var/lib/mmdvm/NXDNHosts.txt
HostsFile2=/var/lib/mmdvm/private_NXDNHosts.txt
ReloadTime=60
ParrotAddress=127.0.0.1
ParrotPort=42021
NXDN2DMRAddress=127.0.0.1
NXDN2DMRPort=42022
# Startup=10200
InactivityTimeout=0
Debug=0

[Mobile GPS]
Enable=0
Address=127.0.0.1
Port=7834

[Remote Commands]
Enable=1
Port=6075 
EOF
# 
fi
if [ -f "/opt/P25Gateway/P25Gateway.ini" ]
then
  echo "found file"
else
  sudo cat > /opt/P25Gateway/P25Gateway.ini <<- "EOF"
[General]
Callsign=N0CALL
RptAddress=127.0.0.1
RptPort=32010
LocalPort=42020
Daemon=0

[Id Lookup]
Name=/var/lib/mmdvm/DMRIds.dat
Time=24

[Voice]
Enabled=1
Language=en_US
Directory=./Audio

[Log]
# Logging levels, 0=No logging, 1=Debug, 2=Message, 3=Info, 4=Warning, 5=Error, 6=Fatal
DisplayLevel=1
FileLevel=2
FilePath=/var/log/mmdvm
FileRoot=P25Gateway

[Network]
Port=42010
HostsFile1=/var/lib/mmdvm/P25Hosts.txt
HostsFile2=/var/lib/mmdvm/private_P25Hosts.txt
ReloadTime=60
ParrotAddress=127.0.0.1
ParrotPort=42011
# Startup=10200
InactivityTimeout=0
Debug=0

[Remote Commands]
Enable=1
Port=6074
 
EOF
# 
fi
if [ -f "/opt/YSFGateway/YSFGateway.ini" ]
then
  echo "found file"
else
  sudo cat > /opt/YSFGateway/YSFGateway.ini <<- "EOF"
[General]
Callsign=N0CALL
Suffix=RPT
# Suffix=ND
Id=1234567
RptAddress=127.0.0.1
RptPort=3200
LocalAddress=127.0.0.1
LocalPort=4200
WiresXMakeUpper=1
WiresXCommandPassthrough=0
Daemon=0

[Info]
RXFrequency=223500000
TXFrequency=223500000
Power=1
Latitude=41.7333
Longitude=-50.3999
Height=0
Location=Iceberg
Description=DVSwitch
URL=https://groups.io/g/DVSwitch

[Log]
# Logging levels, 0=No logging, 1=Debug, 2=Message, 3=Info, 4=Warning, 5=Error, 6=Fatal
DisplayLevel=1
FileLevel=2
FilePath=/var/log/mmdvm
FileRoot=YSFGateway

[aprs.fi]
Enable=0
# Server=noam.aprs2.net
Server=euro.aprs2.net
Port=14580
Password=9999
Description=APRS Description
Suffix=Y

[Network]
# Startup=Alabama-Link
InactivityTimeout=0
Revert=0
Debug=0

[YSF Network]
Enable=1
Port=42000
Hosts=/var/lib/mmdvm/YSFHosts.txt
ReloadTime=60
ParrotAddress=127.0.0.1
ParrotPort=42012
# YSF2DMRAddress=127.0.0.1
# YSF2DMRPort=42013
# YSF2NXDNAddress=127.0.0.1
# YSF2NXDNPort=42014
# YSF2P25Address=127.0.0.1
# YSF2P25Port=42015

[FCS Network]
Enable=1
Rooms=/var/lib/mmdvm/FCSRooms.txt
Port=42001

[Mobile GPS]
Enable=0
Address=127.0.0.1
Port=7834

[Remote Commands]
Enable=1
Port=6073
 
EOF
# 
fi
if [ -f "/opt/Quantar_Bridge/Quantar_Bridge.ini  " ]
then
  echo "found file"
else
  sudo cat > /opt/Quantar_Bridge/Quantar_Bridge.ini  <<- "EOF"
; Configure the Quantar Repeater Partner
; Note that the TX and RX ports are already reversed for MB <--> Quantar bridges
[QUANTAR]
logFilePath = /var/log/dvswitch/Quantar_Bridge.log
logLevel = 2                    ; Logging levels, 0=No logging, 1=Debug, 2=Message, 3=Info, 4=Warning, 5=Error, 6=Fatal
debug = 0                       ; Debug 0 = off, 1 = on (adds lots of additional messages)
Address = 0.0.0.0               ; Address to send IMBE TLV frames to (export)
TXPort = 34103                  ; Port to send IMBE TLV frames to (export)
RXPort = 34100                  ; Port to listen for IMBE TLV frames on (import)
quantarPort = 1994              ; HDLC frames To/From the Quantar repeater
 
EOF
# 
fi
if [ -f "/etc/ircddbgateway " ]
then
  echo "found file"
else
  sudo cat > /etc/ircddbgateway  <<- "EOF"
gatewayType=0
gatewayCallsign=
gatewayAddress=0.0.0.0
icomAddress=172.16.0.20
icomPort=20000
hbAddress=127.0.0.1
hbPort=20010
latitude=
longitude=
description1=
description2=
url=
repeaterCall1=
repeaterBand1=B
repeaterType1=0
repeaterAddress1=127.0.0.1
repeaterPort1=20011
reflector1=
atStartup1=0
reconnect1=0
frequency1=434.00000
offset1=0.0000
rangeKms1=0.000
latitude1=0.000000
longitude1=0.000000
agl1=0.000
description1_1=
description1_2=
url1=
band1_1=0
band1_2=0
band1_3=0
repeaterCall2=
repeaterBand2= 
repeaterType2=0
repeaterAddress2=127.0.0.1
repeaterPort2=20012
reflector2=
atStartup2=0
reconnect2=0
frequency2=0.00000
offset2=0.0000
rangeKms2=0.000
latitude2=0.000000
longitude2=0.000000
agl2=0.000
description2_1=
description2_2=
url2=
band2_1=0
band2_2=0
band2_3=0
repeaterCall3=
repeaterBand3= 
repeaterType3=0
repeaterAddress3=127.0.0.1
repeaterPort3=20013
reflector3=
atStartup3=0
reconnect3=0
frequency3=0.00000
offset3=0.0000
rangeKms3=0.000
latitude3=0.000000
longitude3=0.000000
agl3=0.000
description3_1=
description3_2=
url3=
band3_1=0
band3_2=0
band3_3=0
repeaterCall4=
repeaterBand4= 
repeaterType4=0
repeaterAddress4=127.0.0.1
repeaterPort4=20014
reflector4=
atStartup4=0
reconnect4=0
frequency4=0.00000
offset4=0.0000
rangeKms4=0.000
latitude4=0.000000
longitude4=0.000000
agl4=0.000
description4_1=
description4_2=
url4=
band4_1=0
band4_2=0
band4_3=0
ircddbEnabled=1
ircddbHostname=rr.openquad.net
ircddbUsername=
ircddbPassword=
ircddbEnabled2=0
ircddbHostname2=rr.openquad.net
ircddbUsername2=
ircddbPassword2=
ircddbEnabled3=0
ircddbHostname3=
ircddbUsername3=
ircddbPassword3=
ircddbEnabled4=0
ircddbHostname4=
ircddbUsername4=
ircddbPassword4=
aprsEnabled=1
aprsHostname=rotate.aprs2.net
aprsPassword=
aprsPort=14580
dextraEnabled=1
dextraMaxDongles=5
dplusEnabled=0
dplusMaxDongles=5
dplusLogin=        
dcsEnabled=1
ccsEnabled=1
ccsHost=CCS704  
xlxEnabled=1
xlxHostsFileUrl=http://xlxapi.rlx.lu/api.php?do=GetReflectorHostname
starNetBand1=A
starNetCallsign1=        
starNetLogoff1=        
starNetInfo1=
starNetPermanent1=        
starNetUserTimeout1=300
starNetGroupTimeout1=300
starNetCallsignSwitch1=0
starNetTXMsgSwitch1=1
starNetReflector1=
starNetBand2=A
starNetCallsign2=        
starNetLogoff2=        
starNetInfo2=
starNetPermanent2=        
starNetUserTimeout2=300
starNetGroupTimeout2=300
starNetCallsignSwitch2=0
starNetTXMsgSwitch2=1
starNetReflector2=
starNetBand3=A
starNetCallsign3=        
starNetLogoff3=        
starNetInfo3=
starNetPermanent3=        
starNetUserTimeout3=300
starNetGroupTimeout3=300
starNetCallsignSwitch3=0
starNetTXMsgSwitch3=1
starNetReflector3=
starNetBand4=A
starNetCallsign4=        
starNetLogoff4=        
starNetInfo4=
starNetPermanent4=        
starNetUserTimeout4=300
starNetGroupTimeout4=300
starNetCallsignSwitch4=0
starNetTXMsgSwitch4=1
starNetReflector4=
starNetBand5=A
starNetCallsign5=        
starNetLogoff5=        
starNetInfo5=
starNetPermanent5=        
starNetUserTimeout5=300
starNetGroupTimeout5=300
starNetCallsignSwitch5=0
starNetTXMsgSwitch5=1
starNetReflector5=
remoteEnabled=1
remotePassword=
remotePort=54321
language=0
infoEnabled=1
echoEnabled=1
logEnabled=0
dratsEnabled=0
dtmfEnabled=1
windowX=-1
windowY=-1 
EOF
# 
fi
if [ -f "/opt/MMDVM_Bridge/DVSwitch.ini " ]
then
  echo "found file"
else
  sudo cat > /opt/MMDVM_Bridge/DVSwitch.ini  <<- "EOF"
; MMDVM_Bridge export / import configuration file.
;   This file should be placed along side of MMDVM_Bridge or you can supply
;   an absolute path in the DVSWITCH environment variable, e.g:
;   DVSWITCH=/etc/MMDVM_Bridge/DVSwitch.ini
;   before executing MMDVM_Bridge
;
; Another method to set the enviorment variable is to use the systemd unit file
; by adding:
; Environment=DVSWITCH=/etc/MMDVM_Bridge/DVSwitch.ini
; to /lib/systemd/system/mmdvm_bridge.service

; Configure the Quantar Repeater Partner
; Note that the TX and RX ports are already reversed for MMDVM_Bridge <--> Quantar_Bridge
[QUANTAR]
address = 0.0.0.0               ; Address to send IMBE TLV frames to (export)
txPort = 34103                  ; Port to send IMBE TLV frames to (export)
rxPort = 34100                  ; Port to listen for IMBE TLV frames on (import)
quantarPort = 1994              ; HDLC frames To/From the Quantar repeater
debug = 0                       ; Debug 0 = off, 1 = on (adds lots of additional messages)
logLevel = 2                    ; Logging levels, 0=No logging, 1=Debug, 2=Message, 3=Info, 4=Warning, 5=Error, 6=Fatal
logFilePath = /var/log/dvswitch/Quantar_Bridge.log

; Configure the DMR Partner
; Audio format is AMBE 72 bit
[DMR]
address = 127.0.0.1             ; Address to send AMBE TLV frames to (export)
txPort = 31100                  ; Port to send AMBE TLV frames to (export)
rxPort = 31103                  ; Port to listen on (import)
slot = 2                        ; Export slot
exportTG = 0                    ; Which TG to export 
hangTimerInFrames = 0		; Use 50 for 3 seconds of hang time (3000 / 60) 
talkerAlias = %callsign %location %description ; Get callsign location and description from MMDVM_Bridge.ini

; Configure the D-Star Partner
; Audio format is AMBE 48 bit (DSAMBE)
[DSTAR]
address = 127.0.0.1             ; Address to send AMBE TLV frames to (export)
txPort = 32100                  ; Port to send AMBE TLV frames to (export)
rxPort = 32103                  ; Port to listen on (import)
fallbackID = 1234567            ; In case we can not find a valid DMR id in the database, export this one
exportTG = 9                    ; Which TG to export
slot = 2                        ; Export slot
RemotePort = 54321		; Port to send Gateway commands to
message = %location %description ; Get location and description from MMDVM_Bridge.ini

; Configure the NXDN Partner
; Audio format is AMBE 72 bit
[NXDN]
address = 127.0.0.1             ; Address to send AMBE TLV frames to (export)
txPort = 33100                  ; Port to send AMBE TLV frames to (export)
rxPort = 33103                  ; Port to listen on (import)
fallbackID = 1234567            ; In case we can not find a valid DMR id in the database, export this one
nxdnFallbackID  = 12345         ; Use this ID when the input DMR ID is not found in the database
translate = 1234=4321           ; Translate NXDN TG < -- > DMR TG (bidirectional)
slot = 2                        ; Export slot
RemotePort = 6075		; Port to send Gateway commands to

; Configure the P25 Partner
; Audio format is IMBE 88 bit
[P25]
address = 127.0.0.1             ; Address to send AMBE TLV frames to (export)
txPort = 34100                  ; Port to send AMBE TLV frames to (export)
rxPort = 34103                  ; Port to listen on (import)
slot = 2                        ; Export slot
RemotePort = 6074		; Port to send Gateway commands to

; Configure the Yaesu Fusion Partner
; Audio format is AMBE 72 bit
; Audio format is IMBE 88 bit
[YSF]
address = 127.0.0.1             ; Address to send AMBE TLV frames to (export)
txPort = 35100                  ; Port to send AMBE TLV frames to (export)
rxPort = 35103                  ; Port to listen on (import)
txWidePort = 35105		; Port to send IMBE TLV frames to for YSFw (export)
fallbackID = 1234567            ; In case we can not find a valid DMR id in the database, export this one
exportTG = 9                    ; Which TG to export
slot = 2                        ; Export slot
RemotePort = 6073		; Port to send Gateway commands to

; Configure the BrandMeister connection
; Simple Terminal Feature Update
; Audio format is AMBE 72 bit
[STFU]                          ; Brandmeister Open DMR Terminal (ODMRT) Protocol
BMAddress = 3102.repeater.net   ; Brandmeister ODMRT server address
BMPort = 54006                  ; Brandmeister ODMRT port
BMPassword = passw0rd           ; Your Brandmeister password
Address = 127.0.0.1             ; Address to send AMBE TLV frames to (export)
txPort  = 36100                 ; Port to send AMBE TLV frames to (export)
rxPort  = 36103                 ; Port to listen on (import)
UserID  = 1234567               ; Your DMR ID
TalkerAlias = N0CALL Name City  ; Max 27 characters
StartTG = 3166                  ; Startup talk group
LogLevel = 3                    ; STFU log level (0=No logging, 1=Debug, 2=Message, 3=Info, 4=Warning, 5=Error)

[ASL]
address = 127.0.0.1
txPort = 30100
rxPort = 30103
 
EOF
# 
fi

