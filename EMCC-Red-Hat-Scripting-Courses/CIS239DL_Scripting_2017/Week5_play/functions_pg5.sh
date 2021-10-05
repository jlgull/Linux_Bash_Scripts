#!/bin/bash
#
# Filename: functions_pg5.sh
# Author: Jonathan Heard
# Purpose: Functions using Local and Global Variables
#
#

## Functions are defined (with their code) BEFORE
## the main part of the script.

function VariableTest
{
	local LocalVar="YES"
	GlobalVar="YES"

	echo; echo "Inside the Function !"
	echo; echo "Inside function: LocalVar? $LocalVar"
	echo; echo "Inside function: GlobalVar? $GlobalVar"
	echo
}

## Script starts HERE

clear

VariableTest

echo; echo "Outside the Function !"
echo; echo "Inside function: LocalVar? $LocalVar"
echo; echo "Inside function: GlobalVar? $GlobalVar"
echo

unset GlobalVar

echo; echo "After using unset !"
echo; echo "Inside function: LocalVar? $LocalVar"
echo; echo "Inside function: GlobalVar? $GlobalVar"
echo

#
# End of file
#
