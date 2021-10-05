#!/bin/bash
#
# Filename: for_command.sh
# Author: Jonathan Heard
# Purpose: Using command substitution in a for loop
#
#

clear; echo

i=0
 
for FileName in $(ls /etc/apt/)
do
	((++i))
	echo "File number $i is: $FileName "
done

echo

i=0
 
for AdapterName in $(ifconfig | grep 'UP' | cut -f3 -d:)
do
	((++i))
	echo "Adapter number $i is: ($AdapterName) is UP"
done

echo

#
# End of file
#
