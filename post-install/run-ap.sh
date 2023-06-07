#!/usr/bin/env bash
echo "Starting open access point on wlan1"
sudo hostapd ./confs/ap_halow_open.conf -dddd
