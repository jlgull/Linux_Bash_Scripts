#!/bin/bash
#
# Filename: arrays_page_7.sh
# Author: Jonathan Heard
# Purpose: Displaying the content of a single array element,
#	 and its length. 
#
#
# Declare and "fill" 2 arrays
#

Food=(apples beets carrots doughnuts eggplant)

Animals=(alpaca buffalo cat dog elephant fox giraffe)

# Start of Code

clear

FoodThree=${#Food[2]}

echo; echo "The length of the third element ( ${Food[2]} ) in
	array \"Food\" is $FoodThree."

echo; echo "The length of the third element ( ${Animals[2]} ) in
	array \"Animals\" is ${#Animals[2]}."

echo

read -p "Paused, press Enter to continue..."

echo; echo

#
# End of file
#
