#!/bin/bash
#
# Filename: even_more_if.sh
# Author: Jonathan Heard
# Purpose: Expanding again the Basic if structure
#
#

clear

echo; read -p "Please enter a value for x : " x

if [[ $x -eq 1 ]]
then
	echo; echo "x is equal to $x"
elif [[ $x -eq 2 ]]
then
	echo; echo "x is equal to $x"
else
	echo; echo "x is neither 1 or 2, it is equal to $x"
fi

echo

#
# End of file
#
