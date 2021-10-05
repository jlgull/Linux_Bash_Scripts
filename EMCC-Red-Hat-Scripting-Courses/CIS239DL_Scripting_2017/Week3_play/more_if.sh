#!/bin/bash
#
# Filename: more_if.sh
# Author: Jonathan Heard
# Purpose: Expanding on the Basic if structure
#
#

clear

echo; read -p "Please enter a value for x : " x

if [[ $x -eq 1 ]]
then
	echo; echo "x is equal to $x"
else
	echo; echo "x is not equal to 1, it is equal to $x"
fi

echo

#
# End of file
#
