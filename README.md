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
Make sure your kernel and OS are up to date! (`apt update && apt upgrade`).

I recommend a kernel version of **`5.15.0-1029-raspi` or higher.**
```bash
ubuntu@piAB:~$ uname -a
Linux piAB 5.15.0-1029-raspi #31-Ubuntu SMP PREEMPT Sat Apr 22 12:26:40 UTC 2023 aarch64 aarch64 aarch64 GNU/Linux

ubuntu@piAB:~$ lsb_release -a
No LSB modules are available.
Distributor ID:	Ubuntu
Description:	Ubuntu 22.04.2 LTS
Release:	22.04
Codename:	jammy
```

I experienced **repeated segfaults** on the kernel version below, and the driver would **fail to load**.
```bash
Linux piAA 5.15.0-1024-raspi #26-Ubuntu SMP PREEMPT Wed Jan 18 15:29:53 UTC 2023 aarch64 aarch64 aarch64 GNU/Linux
```
