#!/bin/bash

#cat file for line by line loop

line=`cat new | sed -e '1!d'`

#loop for each line, send file and disconnect each divice
if [ "$(cat file)" ]
then
	#echo "$line" >> list
	echo -e "\033[32mDevice Found: $line"
	echo -e "\033[00mSending file..."
	bluetooth-sendto --device="$line" $1 &
	echo "$line" >> list
	wait
	sed -i '/'$line'/d' ./file
	hcitool dc $line 19
	echo -e "\033[31mDevice Disconnected: $line"
fi

#if window is open for longer than 55 seconds (after send time out, or user rejected) kill
	if [ "$(pidof bluetooth-sendto)" ]
	then a=`pidof bluetooth-sendto | cut -d' ' -f1`
		b=`ps -p $a -o etime | sed -e '2!d' | sed -e 's/^[ \t]*//' | cut -d':' -f2`
		if [[ $b -gt 55 ]]
		then kill -SIGKILL $a
		fi
	fi
