#!/bin/bash
#
# Filename: arrays_page_6.sh
# Author: Jonathan Heard
# Purpose: Using the total number of Arrays elements in an echo
#
#
# Declare and "fill" 2 arrays
#

Food=(apples beets carrots doughnuts eggplant)

Animals=(alpaca buffalo cat dog elephant fox giraffe)

# Start of Code

clear

FoodNum=${#Food[@]}

echo; echo "The array \"Food\" has $FoodNum elements."

echo "The array \"Animals\" has ${#Animals[@]} elements."

read -p "Paused, press Enter to continue..."

echo; echo

#
# End of file
#
