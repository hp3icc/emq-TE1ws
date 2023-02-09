cat > /bin/data-id <<- "EOF"
#!/bin/bash
# wget https://freedmr.cymru/talkgroups/talkgroup_ids_json.php -O /opt/FDMR-Monitor/data/talkgroup_ids.json
wget https://database.radioid.net/static/user.csv -O /opt/FDMR-Monitor/data/subscriber_ids.csv
wget https://database.radioid.net/static/rptrs.json -O /opt/FDMR-Monitor/data/peer_ids.json
# wget https://freedmr.cymru/talkgroups/talkgroup_ids_json.php -O /opt/FreeDMR/talkgroup_ids.json
# wget https://freedmr.cymru/talkgroups/users.json -O /opt/FreeDMR/subscriber_ids.csv
wget https://database.radioid.net/static/rptrs.json -O /opt/FreeDMR/peer_ids.json
EOF
#
chmod +x /bin/data-id

