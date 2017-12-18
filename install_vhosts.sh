#!/bin/bash
#ver 1.0
sed -i 's/#Include etc\/extra\/httpd-vhosts.conf/Include etc\/extra\/httpd-vhosts.conf/' /opt/lampp/etc/httpd.conf

sed -i 's/function startApache() {/function startApache() { \/opt\/lampp\/www\/add_vhosts.sh; /' /opt/lampp/xampp