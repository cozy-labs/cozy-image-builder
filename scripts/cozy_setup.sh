#!/bin/bash

apt-get update
apt-get install -y apt-transport-https ca-certificates wget

wget -O - http://ubuntu.cozycloud.cc/cozy.gpg.key 2>/dev/null | apt-key add -

echo 'deb [arch=amd64] http://ubuntu.cozycloud.cc/debian trusty cozy' > /etc/apt/sources.list.d/cozy.list

echo "postfix postfix/main_mailer_type string Internet Site" | debconf-set-selections

apt-get update \
	&& apt-get install -y python-cozy-management \
	&& cozy_management install_requirements \
	&& apt-get clean

mv /tmp/cozy-init.conf /etc/supervisor/conf.d/cozy-init.conf
mv /tmp/cozy-init /etc/init.d/cozy-init
mv /tmp/70-cozy /etc/update-motd.d/70-cozy

chmod +x /etc/update-motd.d/70-cozy /etc/init.d/cozy-init

ls -l /etc/supervisor/conf.d/cozy-init.conf /etc/init.d/cozy-init /etc/update-motd.d/70-cozy
