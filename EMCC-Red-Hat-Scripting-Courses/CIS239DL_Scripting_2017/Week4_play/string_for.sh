#!/bin/bash
#
# Filename: for_string.sh
# Author: Jonathan Heard
# Purpose: Using strings in for loop
#
#

clear; echo

for i in ashley joe reese sara michael
do
	echo "i = $i"
done

echo

#
# Using list of letters
#

for i in {l..p}
do
	echo "i = $i"
done

echo


#
# End of file
#
