#!/usr/bin/fish
echo ""
while true
	printf "\033[1A"  # move cursor one line up
	printf "\033[K"
	echo (math (cat /sys/class/power_supply/BAT0/power_now) / 1000000)"w"
	sleep 2
end
