#!/usr/bin/env bash

echo "Compiling SPIDEV disable overlay"
dtc -I dts -O dtb -o disable-spidev.dtbo disable-spidev-overlay.dts


echo "Installing SPIDEV disable overlay"
sudo cp -v disable-spidev.dtbo /boot/firmware/overlays/disable-spidev.dtbo

echo "Please add the following to /boot/firmware/config.txt"
echo "dtoverlay=disable-spidev"

