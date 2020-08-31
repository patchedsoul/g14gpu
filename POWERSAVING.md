# Asus Zephyrus G14 GPU powersaving

*Please see the new, updated guide!*
https://asus-linux.org/wiki/g14-and-g15/troubleshooting/g14-nvidia-powersavings-workaround/

In order to get the best battery life, the dedicated GPU must be disabled. 

Simply unloading the driver or enabling powersaving feaures isn't enough.

In the future, the nvidia driver may allow for entering D3 (full power off) on it's own, but for now, there's another solution: acpi calls. This requires the `acpi_call` kernel module, on Arch this can be installed with the `acpi_call` or `acpi_call-dkms` package.

Thanks to /u/FailSpai on reddit for finding the correct ACPI call. The GPU can be powered off and on with the call "\\_SB.PCI0.GPP0.PG00". For example, to turn off the GPU completely, run `sudo sh -c 'echo "\\_SB.PCI0.GPP0.PG00._OFF" > /proc/acpi/call'`. Similarly, to turn it back on, `sudo sh -c 'echo "\\_SB.PCI0.GPP0.PG00._ON" > /proc/acpi/call'`. You can verify the state of the GPU by running `sudo sh -c 'echo "\\_SB.PCI0.GPP0.PEGP.SGST" > /proc/acpi/call'`, then running `sudo cat /proc/acpi/call`. 0x0 means off, and anything above 0 means on. Alternatively, just look at the total system power draw (must be unplugged from AC to get a number), `cat /sys/class/power_supply/BAT0/power_now` and if it's under 10-11w then it's off.

Note that you can really only power the GPU off when its not in use. For example, powering it off with a render offload setup will leave the GPU unusable until X is restarted, and may cause issues during shutdown/reboot. 
You must be in an X session that does not touch the GPU at all. See below for an optimus-manager configuration for an automated way to switch between powersaving and GPU active mode.

This allows for the same, or better, idle power draw than Windows, as long as you have done other tweaks (disable boost, change CPU governor, etc).

If the GPU is powered off during suspend, the system will hang. This can be solved by using a systemd hook to turn the GPU back on before suspend, then turning it back off after. For example, place this script in an executable file in `/usr/lib/systemd/system-sleep/`:

```
#!/bin/bash

if [ "${1}" == "pre" ]; then
    sudo sh -c 'echo "\\_SB.PCI0.GPP0.PG00._ON" > /proc/acpi/call'
    sleep 2 # The GPU needs a bit of time to ensure that it's on before suspend
elif [ "${1}" == "post" ]; then
    if xrandr --listproviders | grep NVIDIA; then
        echo "GPU is in use for PRIME, keeping on"
    else
        sudo sh -c 'echo "\\_SB.PCI0.GPP0.PG00._OFF" > /proc/acpi/call'
        echo "GPU powered off"
    fi  
fi
```
## Optimus Manager
As the script suggests, you can't power off the GPU while it's in use. I would recommend using optimus-manager-amd (available on the AUR as optimus-manager-amd-git) to automatically handle switching Xorg sessions and automatically depowering the GPU when it's not used. You can see my config files for optimus-manager-amd [here](https://git.deck.sh/shark/g14gpu/-/tree/master/etc/optimus-manager). When in `amd` mode, I only draw 5.5-6w on idle, and it bounces around up to 10w when using firefox with the second half of the cores disabled.

## Bumblebee
NEW: I've created a script that lets this work with bumblebee. Advantages of this setup includes allowing you to run applications on the GPU without having to restart X, and then as soon as there is nothing running on the GPU it reverts to full power off state. In order to set it up, install bumblebee-picasso-git from the AUR, and set up the configuration like [this](https://git.deck.sh/shark/g14gpu/-/blob/master/etc/bumblebee/bumblebee.conf). Optionally add `Option "NVreg_DynamicPowerManagement=0x02"` to xorg.conf.nvidia to enable powersaving while the GPU is in use as well.

Bumblebee removed support for acpi_call natively back in 2011 or so because of stability issue, but as long as you use the suspend script, you should be fine. Place [this executable](https://git.deck.sh/shark/g14gpu/-/blob/master/gpuapp) somewhere in your $PATH, and then use `gpuapp glxgears` for example to test. Requires primusrun. 

You may want to modify the suspend script a bit to use nvidia-smi instead of xrandr, because xrandr won't pick up bumblebee:

```
#!/bin/bash

if [ "${1}" == "pre" ]; then
    sudo sh -c 'echo "\\_SB.PCI0.GPP0.PG00._ON" > /proc/acpi/call'
    sleep 2 # The GPU needs a bit of time to ensure that it's on before suspend
elif [ "${1}" == "post" ]; then
    if nvidia-smi | grep "No running processes found"; then
        sudo sh -c 'echo "\\_SB.PCI0.GPP0.PG00._OFF" > /proc/acpi/call'
        echo "GPU powered off"
    else
        echo "GPU is in use with Bumblebee, keeping on"
    fi  
fi
```

Again, thanks to /u/FailSpai for digging through the ACPI tables to find the right call, you can find his comment about it [here](https://www.reddit.com/r/VFIO/comments/hx5j8q/success_with_laptop_gpu_passthrough_on_asus_rog/g0m3kvh/).
