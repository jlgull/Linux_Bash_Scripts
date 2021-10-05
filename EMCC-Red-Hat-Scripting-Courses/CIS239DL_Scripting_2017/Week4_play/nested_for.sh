#!/bin/bash
#
# Filename: nested_for.sh
# Author: Jonathan Heard
# Purpose: Example of Nested for loops
#
#

clear; echo

for i in {1..3}
do
	for j in {1..5}
	do
		echo "\$i\$j = $i$j"
	done
	
	echo

done

echo

#
# End of file
#
