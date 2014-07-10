#!/bin/sh
##################################
#                                #
# BLARG bluecasting shell script #
#                                #
# Usage: BLARG [filename]        #
##################################
bt-device -l > device
while true; do
#touch device
#bt-device -l > device
#loop until device is paired
#until [ "$(cat device | sed -e '1!d')" = "Added devices:" ];
while [ "$(cat device | sed -e '1!d')" = "No devices found" ];
do
	# command for finding device
        sleep 10
	bt-device -l > device
        cat device | sed -e '2!d' | sed 's/.*(//' | sed -e 's/)//' > address
	
done
sleep 5
	#if [ $(cat device | sed -e '1!d') = "No devices found"; then
	#	continue 

	# sed magic to make the device output usable, cuts the second line 
	# then removeal of device sent to to free up next device in list
	#cat device | sed -e '2!d' | sed 's/.*(//' | sed -e 's/)//' > address
bluetooth-sendto --device="$(< address)" $1
bt-device -r "$(< address)"
bluez-test-device remove "$(< address)"
bt-device -l > device
done
