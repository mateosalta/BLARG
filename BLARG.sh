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
#                                 #
###################################
/*
BLARG Bluecasting
Copyright (C) {2014} {mateosalta}

    This program is free software; you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation; either version 2 of the License, or
    (at your option) any later version.

    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
    GNU General Public License for more details.

    You should have received a copy of the GNU General Public License along
    with this program; if not, write to the Free Software Foundation, Inc.,
    51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
*/

echo "BLARG version 2, Copyright (C) 2014 mateosalta
    Gnomovision comes with ABSOLUTELY NO WARRANTY;
    This is free software, and you are welcome to redistribute it
    under certain conditions;



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
