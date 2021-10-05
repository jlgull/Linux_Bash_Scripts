#!/bin/bash
#
# Filename: functions_pg4.sh
# Author: Jonathan Heard
# Purpose: Basic use of a Function
#
#

function print_variable
{
	echo
	echo "Hi $1, how are you doing today?"
	echo; echo "Your are on the system named: $(hostname)"
	echo; echo "------------------------------------------------"; echo
}

clear

## Sending the environmental variable $USER to the function

print_variable $USER

## Sending the string Jonathan to the function

print_variable Jonathan

echo

#
# End of file
#
