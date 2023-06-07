#!/usr/bin/env bash
echo "Starting station on wlan1"
sudo wpa_supplicant -iwlan1 -c ./confs/sta_halow_open.conf
