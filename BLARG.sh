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

# BLARG Bluecasting
# Copyright (C) {2014} {mateosalta}
#
#    This program is free software; you can redistribute it and/or modify
#    it under the terms of the GNU General Public License as published by
#    the Free Software Foundation; either version 2 of the License, or
#    (at your option) any later version.
#
#    This program is distributed in the hope that it will be useful,
#    but WITHOUT ANY WARRANTY; without even the implied warranty of
#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
#    GNU General Public License for more details.
#
#    You should have received a copy of the GNU General Public License along
#    with this program; if not, write to the Free Software Foundation, Inc.,
#    51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.


echo -e "\033[01;31mBLARG version 2, Copyright (C) 2014 mateosalta"
echo -e "BLARG comes with ABSOLUTELY NO WARRANTY;"
echo -e "This is free software, and you are welcome"
echo -e "to redistribute it under certain conditions;"
sleep 2

#jobs? can't remember why... something to do with backgrouning and doing things at the same time, I think it works, just as long as it is not breaking something I'll leave it in.
function morejobs() {
    while [ $(jobs -p | wc -l) -ge $1 ]; do
        sleep 1
    done
}

while true; do
	
	#search for connected devices, edit output into usable addresses
	hcitool con | sed -e '1d' | sed 's/\(.\{7\}\)//' | sed 's/ .*//' > file
	echo -e "\033[00mScaning for Connected Devices..."
	
	#count how many connections open, remove devices that are currently sending
	v=`echo -n "$(pidof bluetooth-sendto)" | wc -w`
	if [ "$(pidof bluetooth-sendto)" ]
	then cat file | sed -e '1,'$v\d > file
	fi

	#report no new devices found
	if [ "$(cat file)" = "" ]
	then echo "No Devices Found"
	fi
	sleep 3

		#cat file for line by line loop
		filename='file'
		filelines=`cat $filename`

		#loop for each line, send file and disconnect each divice
		for line in $filelines ; do
			echo -e "\033[32mDevice Found: $line" && echo -e "\033[00mSending file..." && bluetooth-sendto --device="$line" $1 && wait && hcitool dc $line 19 && echo -e "\033[31mDevice Disconnected: $line" &
		morejobs 2 
 		done
		
	#if window is open for longer than 55 seconds (after send time out, or user rejected) kill
	if [ "$(pidof bluetooth-sendto)" ]
	then a=`pidof bluetooth-sendto | cut -d' ' -f1`
	     b=`ps -p $a -o etime | sed -e '2!d' | sed -e 's/^[ \t]*//' | cut -d':' -f2`
	     if [[ $b -gt 55 ]]
	     then kill -SIGKILL $a
	     fi
	fi

	done
		
done
