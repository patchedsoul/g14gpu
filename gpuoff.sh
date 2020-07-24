#!/bin/bash
sudo rmmod nvidia_drm
sudo rmmod nvidia_modeset
sudo rmmod nvidia
sudo tee /proc/acpi/bbswitch <<<OFF
echo $(cat /proc/acpi/bbswitch)
#sudo sh -c "echo 1 > /sys/bus/pci/devices/0000:01:00.0/remove; echo '\\_SB.PCI0.PEG0.PEGP._OFF' >     /proc/acpi/call"
