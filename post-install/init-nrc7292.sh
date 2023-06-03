#!/usr/bin/env bash

# Alfa Networks NRC7292 RPi HAT
#
# This script inserts the driver module, with the proper
# parameters for AU STA usage.
# Does not do anything else! NAT, DHCP, WPA_CLI-setup is all
# up to you to handle (I recommend systemd-networkd).
#
# This script was 'reverse-engineered' from start.py, by creating a 
# fake 'os' python module, and just printing all the 'os.system' calls.

# Get a reference to the driver folder
NRC="/home/${SUDO_USER:-$USER}/nrc_pkg"

# Unload the module if it's loaded
sudo rmmod nrc

# Load required modules
sudo modprobe i2c-dev
sudo modprobe mac80211

# Copy the firmware files to /lib/firmware, the location
# that the nrc.ko driver expects to find them.
# Again, this script had to be un-pi'ed
#
# sudo ${NRC}/sw/firmware/copy 7292
# 
# I also had to find an alternative bd_dat file, since the Alfa HAT has a different ID to the NRC7292 EVK.
# https://github.com/newracom/nrc7292_sw_pkg/issues/60
cp -v "${NRC}/sw/firmware/nrc7292_cspi.bin" "${NRC}/sw/firmware/uni_s1g.bin"
sudo cp -v "${NRC}/sw/firmware/uni_s1g.bin" /lib/firmware
#sudo cp -v "${NRC}/sw/firmware/nrc7292_bd.dat" /lib/firmware
sudo cp -v "nrc7292_AHPI7292S_bd.dat" /lib/firmware/nrc7292_bd.dat
ls -al /lib/firmware/uni_s1g*


# Load the module with the huge list of parameters.
NRCPARAMS="hifspeed=20000000 spi_bus_num=0 spi_cs_num=0 spi_gpio_irq=5 spi_polling_interval=0 fw_name=uni_s1g.bin auto_ba=1 listen_interval=1000 debug_level_all=1"

# Finally, attempt to load the driver and start the WiFi HaLow device!
sudo insmod "${NRC}/sw/driver/nrc.ko" "${NRCPARAMS}"

# It takes a few seconds to load up
sleep 5

# Check the result of ip a - you should now have a 'wlan1' device!! Yay!!
ip -s -d link show wlan1



### Here is the dump of start.py system calls
# ubuntu@piAA:~/nrc_pkg/script$ python3 start.py 0 0 US
# Done.
# ------------------------------
# Model            : 7292
# STA Type         : STA
# Country          : US
# Security Mode    : OPEN
# AMPDU            : ON
# CQM              : ON
# Download FW      : uni_s1g.bin
# Max TX Power     : 24
# Power Save Type  : Always On
# Listen Interval  : 1000
# ------------------------------
# NRC STA setting for HaLow...
# [*] Set Max CPU Clock on RPi
# os.system(sudo /home/pi/nrc_pkg/script/conf/etc/clock_config.sh)
# [0] Clear
# os.system(sudo hostapd_cli disable 2>/dev/null)
# os.system(sudo wpa_cli disable wlan0 2>/dev/null )
# os.system(sudo wpa_cli disable wlan1 2>/dev/null)
# os.system(sudo killall -9 wpa_supplicant 2>/dev/null)
# os.system(sudo killall -9 hostapd 2>/dev/null)
# os.system(sudo killall -9 wireshark-gtk 2>/dev/null)
# os.system(sudo rmmod nrc 2>/dev/null)
# os.system(sudo rm /home/pi/nrc_pkg/script/conf/temp_self_config.conf 2>/dev/null)
# os.system(sudo rm /home/pi/nrc_pkg/script/conf/temp_hostapd_config.conf 2>/dev/null)
# os.system(sudo sh -c "echo 0 > /proc/sys/net/ipv4/ip_forward")
# os.system(sudo iptables -t nat --flush)
# os.system(sudo iptables --flush)
# os.system(sudo systemctl stop dhcpcd)
# os.system(sudo systemctl stop dnsmasq)
# [1] Copy and Set Module Parameters
# os.system(sudo /home/pi/nrc_pkg/sw/firmware/copy 7292)
# os.system(/home/pi/nrc_pkg/script/conf/etc/ip_config.sh STA 1 0)
# [2] Set Initial Country
# os.system(sudo iw reg set US)
# [3] Loading module
# sudo insmod /home/pi/nrc_pkg/sw/driver/nrc.ko  hifspeed=20000000 spi_bus_num=0 spi_cs_num=0 spi_gpio_irq=5 spi_polling_interval=0 fw_name=uni_s1g.bin auto_ba=1 listen_interval=1000
# os.system(sudo insmod /home/pi/nrc_pkg/sw/driver/nrc.ko  hifspeed=20000000 spi_bus_num=0 spi_cs_num=0 spi_gpio_irq=5 spi_polling_interval=0 fw_name=uni_s1g.bin auto_ba=1 listen_interval=1000)
# sudo: ifconfig: command not found
# [4] Transmission Power Control(TPC) is activated
# os.system(/home/pi/nrc_pkg/script/cli_app set txpwr 24)
# [5] Set guard interval
# os.system(/home/pi/nrc_pkg/script/cli_app set gi long)
# [*] Start DHCPCD and DNSMASQ
# os.system(sudo systemctl start dhcpcd)
# os.system(sudo systemctl start dnsmasq)
# os.system(sudo killall -9 wpa_supplicant)
# [6] Start wpa_supplicant on wlan0
# os.system(sudo wpa_supplicant -iwlan0 -c /home/pi/nrc_pkg/script/conf/US/sta_halow_open.conf  &)
# [7] Connect and DHCP
