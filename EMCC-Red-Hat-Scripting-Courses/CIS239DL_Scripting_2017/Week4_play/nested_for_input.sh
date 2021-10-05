#!/bin/bash
#
# Filename: nested_for_input.sh
# Author: Jonathan Heard
# Purpose: Example of Nested for loops, with an input parameters
#
#

clear; echo

A=$1 ; B=$2

for (( i=1; i <= $1; i++ ))
do
	for (( j=1; j <= $2; j++ ))
	do
		echo "\$i\$j = $i.$j"
	done
	
	echo

done

echo

#
# End of file
#
