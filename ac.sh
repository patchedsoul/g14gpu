#!/bin/bash

echo 1 | sudo tee /sys/devices/system/cpu/cpu8/online
echo 1 | sudo tee /sys/devices/system/cpu/cpu9/online
echo 1 | sudo tee /sys/devices/system/cpu/cpu10/online
echo 1 | sudo tee /sys/devices/system/cpu/cpu11/online
echo 1 | sudo tee /sys/devices/system/cpu/cpu12/online
echo 1 | sudo tee /sys/devices/system/cpu/cpu13/online
echo 1 | sudo tee /sys/devices/system/cpu/cpu14/online
echo 1 | sudo tee /sys/devices/system/cpu/cpu15/online
sudo systemctl restart auto-cpufreq
xrandr --output eDP --mode 1920x1080 --rate 120
