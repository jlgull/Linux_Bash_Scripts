#!/bin/bash
#
# Filename: 1_date.sh
# Author: Jonathan Heard
# Purpose: Observe the impact of "", $() and $
#
#

clear

echo;echo "Example 1: This is today's date: " date

echo;echo "Example 2: This is today's date: " $(date)

date=$(date)

echo;echo "Example 3: This is today's date: " $date

echo; echo

#
# Clear the value of date; which is a system varialble.
# 

unset date


#
# End of file
#
