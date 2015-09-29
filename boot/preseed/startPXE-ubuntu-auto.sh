#!/bin/bash
#uses the supplied preseed file to automatically install Ubuntu according to your desired settings
pixiecore -kernel=linux -initrd=initrd.gz -cmdline="auto=true priority=high vga=788 initrd=initrd.gz locale=en_US.UTF-8 kdb-chooser/method=us netcfg/choose_interface=auto url=tftp://192.168.0.28/servernokeys.preseed"
