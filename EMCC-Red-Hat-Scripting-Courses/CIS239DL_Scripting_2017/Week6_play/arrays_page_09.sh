#!/bin/bash
#
# Filename: arrays_page_9.sh
# Author: Jonathan Heard
# Purpose: Replacing an element in an array.
#
# Declare and "fill" 2 arrays
#

Food=(apples beets carrots doughnuts eggplant)

Animals=(alpaca buffalo cat dog elephant fox giraffe)

# Start of Code

clear

echo; echo "Here is the original contents of the array \"Food\":
		 ${Food[@]}"

echo; echo "Replacing ${Food[2]} in \"Food\" with \"corn\"."

Food[2]='corn'

echo; echo "Here is the modified contents of the array \"Food\": 
		${Food[@]}"

echo

read -p "Paused, press Enter to continue..."

echo; echo

#
# End of file
#
