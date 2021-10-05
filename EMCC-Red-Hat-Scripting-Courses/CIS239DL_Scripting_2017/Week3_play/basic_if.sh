#!/bin/bash
#
# Filename: basic_if.sh
# Author: Jonathan Heard
# Purpose: Demonstrate the basic if concept
#
#
clear

echo; read -p "Please enter a value for x : " x

if [[ $x -eq 1 ]]
then
	echo; echo "x is equal to $x"
fi

echo; echo

#
# End of file
#
