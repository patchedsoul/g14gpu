#!/bin/bash
asusctl profile ss
echo 0 | sudo tee /sys/devices/system/cpu/cpu8/online
echo 0 | sudo tee /sys/devices/system/cpu/cpu9/online
echo 0 | sudo tee /sys/devices/system/cpu/cpu10/online
echo 0 | sudo tee /sys/devices/system/cpu/cpu11/online
echo 0 | sudo tee /sys/devices/system/cpu/cpu12/online
echo 0 | sudo tee /sys/devices/system/cpu/cpu13/online
echo 0 | sudo tee /sys/devices/system/cpu/cpu14/online
echo 0 | sudo tee /sys/devices/system/cpu/cpu15/online
xrandr --output eDP --mode 1920x1080 --rate 60
sudo ryzenadj --max-gfxclk=800 --stapm-limit=5000
#sudo tlp start
#sudo sh -c 'echo "\\_SB.PCI0.GPP0.PG00._OFF" > /proc/acpi/call'
#./gpuoff.sh
sleep 0.5; echo "ON" | sudo tee /proc/acpi/bbswitch; sleep 1; echo "OFF" | sudo tee /proc/acpi/bbswitch
