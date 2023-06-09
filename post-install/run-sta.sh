#!/usr/bin/env bash

./assign-ip.sh "172.16.0.2"
echo "Starting WPA2 station on wlan1"
#sudo wpa_supplicant -iwlan1 -c ./confs/sta_halow_open.conf
sudo wpa_supplicant -iwlan1 -c ./confs/sta_halow_wpa2.conf -dddd
