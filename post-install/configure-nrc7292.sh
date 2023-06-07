#!/usr/bin/env bash

# Alfa Networks NRC7292 RPi HAT
#
# Use this script after running 'init_nrc7292.sh'.
# It will set the txpower and guard interval.

# Get a reference to the driver folder
NRCCLI="/home/${SUDO_USER:-$USER}/nrc_pkg/script/cli_app"

# Check the result of ip a - you should now have a 'wlan1' device!! Yay!!
ip -s -d link show wlan1

# Turn on the device!
sudo ip link set wlan1 up

# Max power is 24?
$NRCCLI set txpwr 24 

# Guard interval is long (idk what that means!)
$NRCCLI set gi 'long'

#$NRCCLI
echo "Starting open access point on wlan1"
sudo wpa_supplicant -iwlan1 -c ./confs/sta_halow_open.conf
