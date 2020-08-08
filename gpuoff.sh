#!/bin/bash
#sudo rmmod nvidia_drm
sudo rmmod nvidia_modeset
sudo rmmod nvidia
#sudo tee /proc/acpi/bbswitch <<<OFF
#echo $(cat /proc/acpi/bbswitch)
#sudo sh -c "echo 1 > /sys/bus/pci/devices/0000:01:00.0/remove; echo '\\_SB.PCI0.PEG0.PEGP._OFF' >     /proc/acpi/call"
#output=$(optimus-manager --print-mode)
#echo $output
if xrandr --listproviders | grep NVIDIA; then
	echo "GPU is in use for PRIME, keeping on"
else
	sudo sh -c 'echo "\\_SB.PCI0.GPP0.PG00._OFF" > /proc/acpi/call'
        echo "GPU powered off"
fi  
#if [ "$(optimus-manager --print-mode)" = "
#
#Current GPU mode : amd" ]; then
#	sudo sh -c 'echo "\\_SB.PCI0.GPP0.PG00._OFF" > /proc/acpi/call'
#	echo $(sudo cat /proc/acpi/call)
#	echo "GPU POWERED OFF"
#fi
#echo "script finished"
