#!/bin/bash
#
# Filename: arrays_page_10.sh
# Author: Jonathan Heard
# Purpose: Adding an array element, at the end of the array
#
# Declare and "fill" 2 arrays
#

Food=(apples beets carrots doughnuts eggplant)

Animals=(alpaca buffalo cat dog elephant fox giraffe)

# Start of Code

clear

echo; echo "Here is the original contents of the array \"Animals\":
		 ${Animals[@]}"

echo; echo "Adding \"hippo\" to the end of \"Animals\"."

Animals[$((${#Animals[@]}+1))]='hippo'

echo; echo "Here is the modified contents of the array \"Animals\": 
		${Animals[@]}"

echo

read -p "Paused, press Enter to continue..."

echo; echo

#
# End of file
#
