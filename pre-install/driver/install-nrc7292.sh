#!/usr/bin/env bash

# Alfa Networks NRC7292 RPi HAT
#
# The provided installation guides for the EVK are written for Raspbian,
# and they disable the wifi+bluetooth (which is quite frustrating, if you
# have no HDMI monitor).
# 
# Here is my Ubuntu Server 22 install script, which just clones+builds the
# driver package into the folder ~/nrc_pkg/, and nothing else.
# 
# Tested using a Raspberry Pi 4 (2GB), running
# Ubuntu Server 22.04 LTS (jammy), fresh install

# Get source, and hop into it's folder
cd
git clone --depth 1 https://github.com/newracom/nrc7292_sw_pkg
pushd nrc7292_sw_pkg/

###
# They have a 'update.sh' script in the path
# nrc7292_sw_pkg/package/host/evk/sw_pkg/update.sh
#
# ...but this script assumes we are running as user 'pi',
# and does a bunch of things I would rather do manually.
# 
# The important part is that it copies `sw_pkg/nrc_pkg` to `~/nrc_pkg`, 
# and sets some file permissions.
cp -vr package/host/evk/sw_pkg/nrc_pkg ~/nrc_pkg

# Move to home
pushd ~
chmod -R 755 ./nrc_pkg
chmod -R 777 ./nrc_pkg/script/*
chmod -R 777 ./nrc_pkg/sw/firmware/copy

# Return to the repo
popd

###
# Now we are encouraged to re-build the driver. 
# The docs were outdated, the proper path is this:
pushd package/host/src/nrc

# Make!
sudo apt --assume-yes install make gcc build-essential
make -j2

# Copy the compiled blob (and make backup of original)
# into the ~/nrc_pkg folder
cp -b nrc.ko ~/nrc_pkg/sw/driver/

popd


###
# rebuild the CLI app
pushd package/host/src/cli_app/
make clean
make
cp cli_app ~/nrc_pkg/script/cli_app

popd

# Now use the 'initialise-nrc7292.sh' script to continue.
# DO NOT USE `start.py` or the NRC-provided scripts,
# they are HARD-CODED FOR RASPBIAN


