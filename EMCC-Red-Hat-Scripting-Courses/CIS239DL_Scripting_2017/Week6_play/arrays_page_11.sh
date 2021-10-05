#!/bin/bash
#
# Filename: arrays_page_11.sh
# Author: Jonathan Heard
# Purpose: Looping through 2 sets of array elements
#
# Declare and "fill" 2 arrays
#

Food=(apples beets carrots doughnuts eggplant)

Animals=(alpaca buffalo cat dog elephant fox giraffe)

# Start of Code

clear

echo

for i in ${Animals[@]}
do

	for j in ${Food[@]}
	do

		echo "Let's have $i cooked with $j!"

	done

	echo; read -p "Paused, press Enter to continue..."; echo

done

echo; echo

#
# End of file
#
