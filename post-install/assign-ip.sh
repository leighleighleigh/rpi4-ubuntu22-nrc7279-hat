#!/usr/bin/env bash
address="${1:-172.16.0.1}"
echo "Assigning IP ${address} to wlan1"

sudo ip addr flush dev wlan1
sudo ip addr add "${address}/24" dev wlan1
