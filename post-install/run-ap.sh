#!/usr/bin/env bash

./assign-ip.sh "172.16.0.1"

#sudo hostapd ./confs/ap_halow_open.conf -dddd
echo "Starting WPA2 access point on wlan1"
sudo hostapd ./confs/ap_halow_wpa2.conf -dddd
