#! /bin/bash

# Install the required support programs
cd /opt/FDMR-Monitor/
apt install python3 python3-pip python3-dev libffi-dev libssl-dev cargo sed \
default-libmysqlclient-dev build-essential -y
pip3 install -r requirements.txt

cd /opt/FDMR-Monitor/
cp /opt/FDMR-Monitor/fdmr-mon_SAMPLE.cfg /opt/FDMR-Monitor/fdmr-mon.cfg
cd /opt/FreeDMR/
sudo systemctl stop proxy.service
#sudo rm /opt/FreeDMR/hotspot_proxy_v2.py
sudo rm /opt/FreeDMR/proxy_db.*
#cp /opt/FDMR-Monitor/proxy/* /opt/FreeDMR/ -r
cp /opt/FDMR-Monitor/proxy/hotspot_proxy_v2.py /opt/FreeDMR/hotspot_proxy_v2.py
cp /opt/FDMR-Monitor/proxy/proxy.cfg /opt/FreeDMR/proxy.cfg
cp /opt/FDMR-Monitor/proxy/proxy_db.py /opt/FreeDMR/proxy_db.py
      
cd /opt/FDMR-Monitor/
  
sudo rm -r /var/www/html/ 
cp -r /opt/FDMR-Monitor/html/ /var/www/ 
      
sudo chown www-data:www-data /var/www/html/ -R
     

cp /opt/FDMR-Monitor/utils/logrotate/fdmr_mon /etc/logrotate.d/
#cp /opt/FDMR-Monitor/utils/systemd/fdmr_mon.service /etc/systemd/system/
echo 123> /etc/systemd/system/fdmr_mon.service
sudo rm /etc/systemd/system/fdmr_mon.service
#
cat > /opt/FDMR-Monitor/templates/main_table.html  <<- "EOF"

<fieldset style="background-color:#b2b1b1;text-algin: lef; margin-left:15px;margin-right:15px;font-size:14px;border-top-left-radius: 10px; border-top-right-radius: 10px;border-bottom-left-radius: 10px; border-bottom-right-radius: 10px;">
<center><b> Server Activity </b></legend></center>
{% if _table['MASTERS']|length >0 %}
 <table style="table-layout:fixed;width:100%; font: 10pt arial, sans-serif;margin-top:5px;margin-bottom:5px;" width=100%>
    <tr style="background-color:#265b8a;" "height:30px;font: 10pt arial, sans-serif;{{ themec }}">
        <th style=color:#f1f1f1; 'width: 20%;'>Systems M&P</th>
        <th style=color:#f1f1f1; 'width: 40%;'>Source</th>
        <th style=color:#f1f1f1; 'width: 40%;'>Destination</th>        
    </tr>
    {% for _master in _table['MASTERS'] %}    
    {% for _client, _cdata in _table['MASTERS'][_master]['PEERS'].items() %}
    {% if _cdata[1]['TS'] == True or _cdata[2]['TS'] == True %}
    <tr style="background-color:#a1dcb5;">
        {% if _cdata[1]['TRX'] == "RX" %}
        <td style="font-weight:bold; padding-left: 20px; text-align:center;color:#464646;">M: {{_master}} </td>
        <td style="font: 9.5pt arial, sans-serif;font-weight: 600;color:#0d1a81;">{{ _cdata[1]['SUB']|safe }} [<span style="align-items: center;justify-content:center;font-size: 8pt;font-weight:600;color:brown;">TS {{ 1 if _cdata[1]['TS'] == True else 2 }}</span>]</td>
        <td style="font: 9.5pt arial, sans-serif;font-weight: 600;color:#b5651d;">{{ _cdata[1]['DEST']|safe }}</td>
        {% endif %}
        {% if _cdata[2]['TRX'] == "RX" %}
        <td style="font-weight:bold; padding-left: 20px; text-align:center;color:#464646"><b>M: {{_master}} </td>
        <td style="font: 9.5pt arial, sans-serif;font-weight: 600;color:#0d1a81;">{{ _cdata[2]['SUB']|safe }} [<span style="align-items: center;justify-content:center;font-size: 8pt;font-weight:600;color:brown;">TS {{ 1 if _cdata[1]['TS'] == True else 2 }}</span>]</td>
        <td style="font: 9.5pt arial, sans-serif;font-weight: 600;color:#b5651d;">{{ _cdata[2]['DEST']|safe }}</td>
        {% endif %}
    </tr>
    {% endif %}
    {% endfor %}
    {% endfor %}

{% else %}
         <table style='width:100%; font: 13pt arial, sans-serif; margin-top:8px;'>
             <tr style='border:none; background-color:#b2b1b1;'>
             <td style='border:none;height:60px;'><font color=brown><b><center>Waiting for Data from FreeDMR Server ...</center></b></td>
             </tr>
            </table>
 {% endif %}
    {% for _peer, _pdata  in _table['PEERS'].items() %}
    {% if _pdata[1]['TS'] == True or _pdata[2]['TS'] == True %}
    <tr style="background-color:#de8184;">
        {% if _pdata[1]['TRX'] == "RX" %}
        <td style="font-weight:bold; padding-left: 20px; text-align:center;color:#000000;">P: {{_peer}} </td>
        <td style="font: 9.5pt arial, sans-serif;font-weight: 600;color:#000000;">{{ _pdata[1]['SUB']|safe }} [<span style="align-items: center;justify-content:center;font-size: 8pt;font-weight:600;color:black;">TS {{ 1 if _pdata[1]['TS'] == True else 2 }}</span>]</td>
        <td style="font: 9.5pt arial, sans-serif;font-weight: 600;color:#000000;">{{ _cdata[1]['DEST']|safe }}</td>
        {% endif %}
        {% if _pdata[2]['TRX'] == "RX" %}
        <td style="font-weight:bold; padding-left: 20px; text-align:center;color:#000000;">P: {{_peer}} </td>
        <td style="font: 9.5pt arial, sans-serif;font-weight: 600;color:#000000;">{{ _pdata[2]['SUB']|safe }} [<span style="align-items: center;justify-content:center;font-size: 8pt;font-weight:600;color:black;">TS {{ 1 if _pdata[1]['TS'] == True else 2 }}</span>]</td>
        <td style="font: 9.5pt arial, sans-serif;font-weight: 600;color:#000000;">{{ _pdata[2]['DEST']|safe }}</td>
        {% endif %}
    </tr>
    {% endif %}
    {% endfor %}
    <tr style="background-color:#b2b1b1;"><td colspan=3 height=5pt><hr style="height:1px;border:none;color:#b2b1b1;background-color:#b2b1b1;"></hr></td></tr>

{% if _table['OPENBRIDGES']|length >0 %}
    <tr style="background-color:#265b8a;" "height:30px;width:100%; font: 10pt arial, sans-serif;{{ themec }}">
        <th style=color:#f1f1f1; 'width: 50%;'>Systems OpenBridge</th>
        <th colspan=2 style=color:#f1f1f1; 'width: 50%;'>Active Incoming Calls</th>
    </tr>
    {% for _openbridge in _table['OPENBRIDGES'] %}
    {% set rx = namespace(value=0) %}
    {% if _table['OPENBRIDGES'][_openbridge]['STREAMS']|length >0 %}
       {% for entry in _table['OPENBRIDGES'][_openbridge]['STREAMS'] if _table['OPENBRIDGES'][_openbridge]['STREAMS'][entry][0]=='RX' %}
         {% set rx.value=1 %}
       {% endfor %}
       {% if rx.value == 1 %}    
       <tr style="background-color:#de8184;">
         <td style="font-weight:bold; padding-left: 20px; text-align:center;"> {{ _openbridge}} </td>
         <td colspan=2 style="background-color:#a1dcb5; font: 9pt arial, sans-serif; font-weight: 600; color:#464646;">
         {% for entry in _table['OPENBRIDGES'][_openbridge]['STREAMS']  if _table['OPENBRIDGES'][_openbridge]['STREAMS'][entry][0] == 'RX' %}[<span style="color:#008000;">{{ _table['OPENBRIDGES'][_openbridge]['STREAMS'][entry][0] }}</span>: <font color=#0065ff> {{ _table['OPENBRIDGES'][_openbridge]['STREAMS'][entry][1] }}</font> >> <font color=#b5651d> {{ _table['OPENBRIDGES'][_openbridge]['STREAMS'][entry][2] }}</font>]&nbsp; {% endfor %}
        </td>
      </tr>
      {% endif %}
   {% endif %}
   {% endfor %}
{% endif %}
</table>
</fieldset>

{% if _table['SETUP']['LASTHEARD'] == True %}
<br><fieldset style="border-radius: 8px; background-color:#b2b1b1;margin-left:15px;margin-right:15px;font-size:14px;border-top-left-radius: 10px; border-top-right-radius: 10px;border-bottom-left-radius: 10px; border-bottom-right-radius: 10px;">
  <center><b> Lastheard </b></legend></center>
  <table style="table-layout:fixed;width:100%; font: 10pt arial, sans-serif;font-weight:600;margin-top:5px;margin-bottom:5px;border:none !important;border-collapse:collapse;border:none;" width=100%>
    <tr>
      <th>Date</th>
      <th>Time</th>
      <th>Callsign (DMR-Id)</th>
      <th>Name</th>
      <th>Talk Group</th>
      <th>TG Name</th>
      <th>TX (s)</th>
      <th>System</th>
    </tr>
  {% for itm in lastheard %}
    <tr>
      <td>{{ itm[0][:10] }}</td>
      <td>{{ itm[0][11:] }}</td>
    {% if not itm[7] %}
      <td class="txt-464646"><b>{{ itm[6] }}</b></td>
      <td></td>
    {% else %}
      <td><a target="_blank" href=https://qrz.com/db/{{itm[7][0]}}>{{ itm[7][0] }}</a></b><span class="fnt-7pt">&nbsp;({{ itm[6] }})</span></td>
      <td class="txt-002d62"><b>{{ itm[7][1] }}</b></td>
    {% endif %}
      <td class="txt-b5651d"><b>{{ itm[4] }}</b></td>
      <td class="txt-green"><b>{{ '' if not itm[5] else itm[5]|safe }}</b></td>
      <td {{ 'class="bkgnd-1d1"'|safe if not itm[1] else '' }}>{{ 'DATA' if not itm[1] else itm[1]|int }}</td>
      <td>{{ itm[3] }}</td>
    </tr>
  {% endfor %}
  </table>
</fieldset>
{% endif %}

<fieldset style="width:1070;background-color:#b2b1b1;text-algin: lef; margin-left:15px;margin-right:15px;font-size:14px;border-top-left-radius: 10px; border-top-right-radius: 10px;border-bottom-left-radius: 10px; border-bottom-right-radius: 10px;">
<center><b> Connected to Server System </b></legend></center>
<table style="table-layout:fixed;width:100%; font: 10pt arial, sans-serif;font-weight:600;margin-top:5px;margin-bottom:5px;" width=100%>
{% if _table['MASTERS']|length >0 %}
<tr style="background-color:#b2b1b1;"><td>
<br>
<div style="text-align:left;"><span style="color:#464646;font-weight:600;line-height:1.4;">&nbsp;&nbsp;LINKS:</span></div>
<div style="text-align:left;font:9.5pt arial, sans-serif;font-weight:bold;margin-left:25px; margin-right:25px;line-height:1.4;white-space:normal;">
    {% for _master in _table['MASTERS'] %}    
    {% if _table['MASTERS'][_master]['PEERS']|length >0 %}
    {% for _client, _cdata in _table['MASTERS'][_master]['PEERS'].items() %}
    <span class="tooltip" style="border-bottom: 0px dotted white;">
    <a style="border-bottom: 0px dotted white;font: 9.5pt arial,sans-serif;font-weight:bold;color:#0066ff;" target="_blank" href="http://www.qrz.com/db/{{_cdata['CALLSIGN']}}"><b>{{_cdata['CALLSIGN']}}</b></a>
    <span class="tooltiptext" style="left:115%;top:-10px;">
        <span style="font: 9pt arial,sans-serif;color:#FFFFFF">
        &nbsp;&nbsp;&nbsp;<b>DMR ID</b>: <b><font color=yellow>{{ _client }}</b></font><br>
        {% if _cdata['RX_FREQ'] == 'N/A' and _cdata['TX_FREQ'] == 'N/A' %}
             &nbsp;&nbsp;&nbsp;<b>Type: <font color=yellow>IP Network</font></b><br>
        {% else %} 
            &nbsp;&nbsp;&nbsp;<b>Type: <font color=yellow>Radio</font></b> ({{ _cdata['SLOTS'] }})<br>
        {% endif %}
        &nbsp;&nbsp;&nbsp;<b>Hardware</b>: {{_cdata['PACKAGE_ID'] }}
        <br>&nbsp;&nbsp;&nbsp;<b>Soft_Ver</b>: {{_cdata['SOFTWARE_ID'] }}
        <br>&nbsp;&nbsp;&nbsp;<b>Info</b>: {{_cdata['LOCATION']}}
         <br>&nbsp;&nbsp;&nbsp;<b>Master</b>: <font color=yellow>{{_master}}</font>
        </span></span></span>&nbsp;
    {% endfor %}
    {% endif %}
    {% endfor %}
</div>
{% endif %}
{% if _table['PEERS']|length >0 %}
<br>
<div style="text-align:left;"><span style="color:#464646;font-weight:600;line-height:1.4;">&nbsp;&nbsp;PEERS:</span></div>
<div style="text-align:left;font:9.5pt arial, sans-serif;font-weight:bold;margin-left:25px; margin-right:25px;line-height:1.6;white-space:normal;">
    {% for _peer, _pdata  in _table['PEERS'].items() %}
    <span class="tooltip" style="border-bottom: 1px dotted white;{{'background-color:#98FB98; color:#464646;' if _table['PEERS'][_peer]['STATS']['CONNECTION'] == 'YES' else 'background-color:#ff0000; color:white;'}}"><b>&nbsp;&nbsp;{{_pdata['CALLSIGN']}}&nbsp;&nbsp;</b>
    <span class="tooltiptext" style="top:120%;left:50%;margin-left:-160%;width:160px;">
    <center>&nbsp;&nbsp;<b>Peer</b>: <font color=yellow>{{_peer}}</font>&nbsp;&nbsp;</center>
    </span></span>&nbsp;
 {% endfor %}
</div>
{% endif %}
<br>
</td></tr></table>
</fieldset>

EOF
#
cat > /lib/systemd/system/fdmr_mon.service  <<- "EOF"
[Unit]
Description=FDMR Monitor
# To make the network-online.target available
# systemctl enable systemd-networkd-wait-online.service

#After=network-online.target syslog.target
#Wants=network-online.target

[Service]
User=root
Type=simple
Restart=always
RestartSec=3
StandardOutput=null
WorkingDirectory=/opt/FDMR-Monitor
ExecStartPre=/bin/sh -c 'until ping -c1 noip.com; do sleep 1; done;'
ExecStart=python3 /opt/FDMR-Monitor/monitor.py
Restart=on-abort

[Install]
WantedBy=multi-user.target


EOF
#
sudo sed -i "s/Copyright (c) 2016-.*/Copyright (c) <?php \$cdate=date(\"Y\"); if (\$cdate > \"2016\") {\$cdate=\"2016-\".date(\"Y\");} echo \$cdate; ?><br>/g" /var/www/html/*.php
sudo sed -i "s/All rights reserved.<br>.*/All rights reserved.<br><a title=\"Raspbian Proyect by HP3ICC © <?php \$cdate=date(\"Y\"); if (\$cdate > \"2018\") {\$cdate=\"2018-\".date(\"Y\");} echo \$cdate; ?>\" target=\"_blank\" href=https:\/\/github.com\/hp3icc\/emq-TE1ws\/>Proyect: emq-TE1ws<\/a><br>/g" /var/www/html/*.php
sudo sed -i '166 s/hotpink/#ad02fd/g'   /var/www/html/css/styles.php
sudo sed -i '217 s/color:white/color:black/'  /var/www/html/css/styles.php
sudo sed -i "251d" /var/www/html/css/styles.php
sed '250 a    <?php echo THEME_COLOR."\\n";?>' -i /var/www/html/css/styles.php

sed '21 a # For custom color, select: pro' -i /opt/FDMR-Monitor/fdmr-mon.cfg

sed '24 a COLOR_TEXT = #d2c564' -i /opt/FDMR-Monitor/fdmr-mon.cfg 
sed '25 a COLOR_1 = #c68034' -i /opt/FDMR-Monitor/fdmr-mon.cfg  
sed '26 a COLOR_2 = #7f5224' -i /opt/FDMR-Monitor/fdmr-mon.cfg
sed '27 a COLOR_BACKGROUND = 5a5958' -i /opt/FDMR-Monitor/fdmr-mon.cfg

sed '45 a   $cd1 = strtolower($config["GLOBAL"]["COLOR_1"]);' -i /var/www/html/include/config.php  
sed '46 a   $cd2 = strtolower($config["GLOBAL"]["COLOR_2"]);' -i /var/www/html/include/config.php  
sed '47 a   $cd3 = strtolower($config["GLOBAL"]["COLOR_TEXT"]);' -i /var/www/html/include/config.php 
sed '48 a   $cd3 = strtolower($config["GLOBAL"]["COLOR_TEXT"]);' -i /var/www/html/include/config.php
sed '49 a   $cd4 = strtolower($config["GLOBAL"]["COLOR_BACKGROUND"]);' -i /var/www/html/include/config.php 

sed '66 a   } elseif ($theme == "pro") {' -i /var/www/html/include/config.php  
sed '67 a     $tc = "background-image: linear-gradient(to bottom, $cd1 0%, $cd2 100%);color:$cd3;";' -i /var/www/html/include/config.php  



#
sudo systemctl daemon-reload
#systemctl enable fdmr_mon.service
#systemctl start fdmr_mon.service
    
python3 mon_db.py --create
python3 mon_db.py --update
