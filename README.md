# rpi4-ubuntu22-nrc7279-hat
A few scripts for use with the Alfa Networks AHPI7292S WiFi HaLow HAT, on Ubuntu 22

WORK IN PROGRESS! :)
 - [x] DT overlay to disable SPI working
 - [x] Driver builds successfully
 - [x] Firmware being loaded correctly for host-mode
 - [x] Hacky hard-coded `insmod` call working, `wlan1` device appearing
 - [x] STA/AP mode working
 - [ ] STA/AP mode working *reliably*
 - [ ] SNIFFER/MESH modes working
 - [x] iperf3 evaluation (1.5mbit ish)

# Tips
Make sure your kernel and **firmware** are up to date! (`apt update && apt upgrade`).
I recommend a kernel version of **`5.15.0-1029-raspi` or higher.**

Here is a pi firmware version which is working
```bash
ubuntu@piAB:~$ rpi-eeprom-update
*** UPDATE AVAILABLE ***
BOOTLOADER: update available
   CURRENT: Thu Apr 29 04:11:25 PM UTC 2021 (1619712685)
    LATEST: Tue Jan 25 02:30:41 PM UTC 2022 (1643121041)
   RELEASE: default (/lib/firmware/raspberrypi/bootloader/default)
            Use raspi-config to change the release.

  VL805_FW: Using bootloader EEPROM
     VL805: version unknown. Try sudo rpi-eeprom-update
   CURRENT: 
    LATEST: 
```
Compared to one which always segfaults.
```bash
*** UPDATE AVAILABLE ***
BOOTLOADER: update available
   CURRENT: Thu Sep  3 12:11:43 PM UTC 2020 (1599135103)
    LATEST: Tue Jan 25 02:30:41 PM UTC 2022 (1643121041)
   RELEASE: default (/lib/firmware/raspberrypi/bootloader/default)
            Use raspi-config to change the release.

  VL805_FW: Dedicated VL805 EEPROM
     VL805: version unknown. Try sudo rpi-eeprom-update
   CURRENT: 
    LATEST: 000138a1
```
