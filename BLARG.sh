#!/bin/bash
###################################
#                                 #
# BLARG bluecasting shell script  #
#                                 #
# Usage: BLARG [filename]         #
#                                 # 
# If no argument given will give  #
# file selection dialog           #
#                                 #
# Disconnect requires sudo        #
###################################


while true; do
	#search for connected devices, edit output into usable addresses
	hcitool con | sed -e '1d' | sed 's/\(.\{7\}\)//' | sed 's/ .*//' > file
	
	#text showing if there are no connected devices	
	echo "Scaning for Connected Devices..."
	if [ "$(cat file)" = "" ]
	then echo "No Devices Found"
	fi
	sleep 2

#cat file for line by line loop
filename='file'
filelines=`cat $filename`

#loop for each line, send file and disconnect each divice
for line in $filelines ; do
	echo "Device Found: $line"
	echo "Sending file..."
	#send to device	
	bluetooth-sendto --device="$line" $1
	sleep 1	
	echo "Done"
	#disconnect device, hcitool dc requires root privilages	
	hcitool dc $line
	sleep 1	
	echo "Device Disconected"
done	
done
