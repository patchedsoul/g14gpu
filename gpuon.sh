#!/bin/bash
#sudo rmmod nvidia_drm
#sudo rmmod nvidia_modeset
#sudo rmmod nvidia
#sudo tee /proc/acpi/bbswitch <<<ON
#echo $(cat /proc/acpi/bbswitch)
sudo sh -c 'echo "\\_SB.PCI0.GPP0.PG00._ON" > /proc/acpi/call'
sleep 2
