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

function morejobs() {
    while [ $(jobs -p | wc -l) -ge $1 ]; do
        sleep 1
    done
}

while true; do
	
	#search for connected devices, edit output into usable addresses
	#hcitool con | sed -e '1d' | sed 's/\(.\{7\}\)//' | sed 's/ .*//' > file
	echo -e "\033[00mScaning for Connected Devices..."

	#if address in "list"(device allready trying connection) remove from "file"
	fgrep -v -f list file > new
	cat new > file
	
	exec ./connect.sh $1 &
	morejobs 7
		
	
	sleep 4
	#report no new devices found
	if [ "$(cat file)" = "" ]
	then echo -e "\033[00mNo Devices Found"
	fi

	#slowly clear the block list, so that it dosn't detect a recent disconnect...
	if [ -z "$(pidof bluetooth-sendto)" ] 
	then sed -i '1d' list
	fi
	
done
