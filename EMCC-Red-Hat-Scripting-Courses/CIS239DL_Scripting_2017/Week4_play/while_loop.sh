#!/bin/bash
#
# Filename: while_loop.sh
# Author: Jonathan Heard
# Purpose: Counting to 10 with a while loop
#
#

clear; echo

i=1

while [ $i != 11 ]
do
	echo "i = $i"

	((i++))

done

echo

#
# End of file
#
