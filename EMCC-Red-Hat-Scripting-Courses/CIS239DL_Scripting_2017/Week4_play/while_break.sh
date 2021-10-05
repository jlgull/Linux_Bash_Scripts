#!/bin/bash
#
# Filename: while_break.sh
# Author: Jonathan Heard
# Purpose: Using the break command in a while loop
#
#

clear; echo

i=0

while [ $i != 10 ]
do
	((i++))

	echo "i = $i"

	echo "i = "$i

	if [[ $i -eq 3 ]]

	then
		break
	fi

done

echo; echo "The final value of i is : $i"; echo

#
# End of file
#
