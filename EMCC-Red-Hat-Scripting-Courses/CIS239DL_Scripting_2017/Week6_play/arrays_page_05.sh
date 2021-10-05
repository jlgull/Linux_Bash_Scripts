#!/bin/bash
#
# Filename: arrays_page_5.sh
# Author: Jonathan Heard
# Purpose: Introduction to basic Arrays
#
#
# Declare and "fill" 2 arrays
#

Food=(apples beets carrots doughnuts eggplant)

Animals=(alpaca buffalo cat dog elephant fox giraffe)

# Start of Code

clear

echo; echo "Here are the contents of the array \"Food\": ${Food[@]} "

echo "Here are the contents of the array \"Animals\": ${Animals[@]} "

read -p "Paused, press Enter to continue..."

echo; echo

#
# End of file
#
