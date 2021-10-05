#!/bin/bash
#
# Filename: quote.sh
# Author: Jonathan Heard
# Purpose: Testing for 2 strings being equal
#
#

echo

s1="hi"
s2="hi"

echo "Single = sign [ $s1 = $s2 ] "

if [ $s1 = $s2 ]
then
	echo "Match!"
fi

echo "Double = sign [ $s1 == $s2 ] "

if [ $s1 == $s2 ]
then
	echo "Match!"
fi

#
# End of file
#
