This is a collection of scripts for managing the GPU in the Asus Zephyrus G14.

The setup originally involved using bumblebee, bbswitch, and GPU passthrough to a Windows 10 vm. bbswitch is unable to wake the GPU up at this time, so for now I'm not using it. I am now using optimus-manager with some acpi calls to fully depower and wake the GPU.

`startvm` unbinds from nvidia, binds to vfio-pci, runs the vm, then when you type 'stop' it shuts it down and gives the GPU back to the nvidia driver for use with bumblebee. 
