#!/bin/bash

xrandr --output eDP --mode 1920x1080 --rate 120
echo 1 | sudo tee /sys/devices/system/cpu/cpu8/online
echo 1 | sudo tee /sys/devices/system/cpu/cpu9/online
echo 1 | sudo tee /sys/devices/system/cpu/cpu10/online
echo 1 | sudo tee /sys/devices/system/cpu/cpu11/online
echo 1 | sudo tee /sys/devices/system/cpu/cpu12/online
echo 1 | sudo tee /sys/devices/system/cpu/cpu13/online
echo 1 | sudo tee /sys/devices/system/cpu/cpu14/online
echo 1 | sudo tee /sys/devices/system/cpu/cpu15/online
<<<<<<< HEAD
sudo systemctl restart auto-cpufreq
=======

>>>>>>> 4dbc103e37ed3440d42370c1b3251d5ee6faf3e4
sleep 0.5 
#sudo tlp start
asusctl profile normal
