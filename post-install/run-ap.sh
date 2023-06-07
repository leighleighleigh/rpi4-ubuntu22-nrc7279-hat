#!/usr/bin/env bash
echo "Starting open access point on wlan1"
sudo wpa_supplicant -iwlan1 -c ./confs/ap_halow_open.conf
