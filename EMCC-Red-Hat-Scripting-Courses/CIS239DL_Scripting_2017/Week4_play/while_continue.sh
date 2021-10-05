#!/bin/bash
#
# Filename: while_continue.sh
# Author: Jonathan Heard
# Purpose: Using continue inside a while loop
#
#

clear; echo

i=0

while [ $i -ne 10 ]
do
	((i++))

	if [[ $i%2 -eq 0 ]]
	then
		continue
	fi

	echo "i is an odd number: $i"
done

echo; echo "The final value of i is: $i"; echo

#
# End of file
#
